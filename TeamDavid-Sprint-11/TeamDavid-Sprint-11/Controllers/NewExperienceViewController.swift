//
//  NewExperienceViewController.swift
//  TeamDavid-Sprint-11
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AVFoundation

class NewExperienceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate {
    
    private let filter = CIFilter(name: "CISepiaTone")!
    private let context = CIContext(options: nil)
    
    private var player: AVAudioPlayer?
    private var recorder: AVAudioRecorder?
    private var audioURL: URL?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var recordStopButton: UIButton!
    @IBOutlet weak var playbackButton: UIButton!
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        let isRecording = recorder?.isRecording ?? false
        let recordButtonTitle = isRecording ? "Stop" : "Record"
        recordStopButton.setTitle(recordButtonTitle, for: .normal)
        
        let isPlaying = player?.isPlaying ?? false
        let playButtonTitle = isPlaying ? "Pause" : "Play Back"
        playbackButton.setTitle(playButtonTitle, for: .normal)
    }
    
    private func newRecordingURL() -> URL {
        let fm = FileManager.default
        let documentsDir = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentsDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("caf")
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            NSLog("Photo library is unavailable")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func toggleRecord(_ sender: Any) {
        let isRecording = recorder?.isRecording ?? false
        if isRecording {
            recorder?.stop()
            if let url = recorder?.url {
                audioURL = url
                player = try! AVAudioPlayer(contentsOf: url)
                player?.delegate = self
            }
        } else {
            let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 1)!
            recorder = try! AVAudioRecorder(url: newRecordingURL(), format: format)
            recorder?.record()
        }
        updateViews()
    }
    
    @IBAction func playBack(_ sender: Any) {
        let isPlaying = player?.isPlaying ?? false
        if isPlaying {
            player?.pause()
        } else {
            if player == nil {
                return
            }
            player?.play()
        }
        updateViews()
    }
    
    @IBAction func showAddVideo(_ sender: Any) {
        guard let _ = titleTextField.text,
            let _ = imageView.image,
            let _ = audioURL else { NSLog("Make sure you've added a title, image, and audio recording"); return }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[.originalImage] as? UIImage
//        filter.setValue(image, forKey: kCIInputImageKey)
//        filter.setValue(1, forKey: kCIInputIntensityKey)
        
//        guard let outputCIImage = filter.outputImage,
//            let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return }
        
//        imageView.image = UIImage(cgImage: outputCGImage)
        imageView.image = image

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVideo" {
            guard let vc = segue.destination as? VideoViewController else { return }
            vc.titleString = titleTextField.text
            vc.image = imageView.image
            vc.audioURL = audioURL
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
