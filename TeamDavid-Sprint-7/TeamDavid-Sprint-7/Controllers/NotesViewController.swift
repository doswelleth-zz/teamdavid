//
//  NotesViewController.swift
//  TeamDavid-Sprint-7
//
//  Created by David Doswell on 12/25/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"
private let navigationTitle = String.notesVCTitle

class NotesViewController: UIViewController {
    
    let noteController = NoteController()
    var sortedNotes: [Note] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sortedNotes = self.noteController.notes.sorted(by: {$0.date > $1.date})
        self.noteController.decode()
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        navigationController?.navigationBar.isHidden = false
        setUpNavBar()
        
        self.title = navigationTitle
        
        self.sortedNotes = self.noteController.notes.sorted(by: {$0.date > $1.date})
        self.noteController.decode()
        self.collectionView.reloadData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = Appearance.customBackground
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        hideKeyboardWhenTapped()
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let noteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        noteCollectionView.alwaysBounceVertical = true
        noteCollectionView.showsVerticalScrollIndicator = false
        return noteCollectionView
    }()
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    private func setUpNavBar() {
        let left = UIButton(type: .custom)
        left.setTitle(String.backButton, for: .normal)
        left.setTitleColor(.white, for: .normal)
        left.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        left.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.adjustsImageWhenHighlighted = false
        left.addTarget(self, action: #selector(leftBarButtonTapped(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
        
        let right = UIButton(type: .custom)
        right.setTitle(String.forwardButton, for: .normal)
        right.setTitleColor(.white, for: .normal)
        right.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        right.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        right.adjustsImageWhenHighlighted = false
        right.addTarget(self, action: #selector(rightBarButtonTapped(sender:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
    }
    
    @objc private func leftBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func rightBarButtonTapped(sender: UIButton) {
        showNotesDetail()
    }
    
    private func showNotesDetail() {
        let vc = NotesDetailViewController()
        vc.noteController = noteController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NotesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sortedNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NoteCell
        
        let note = sortedNotes[indexPath.item]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.dateLabel.text = formatter.string(from: note.date)
        cell.titleTextLabel.text = note.title
        cell.descriptionLabel.text = note.description
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let note = sortedNotes[indexPath.item]
        
        let alert = UIAlertController(title: "Delete", message: "Permanently delete this note?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            DispatchQueue.main.async {
                self.noteController.delete(note: note)
                self.sortedNotes = self.noteController.notes.sorted(by: { $0.date > $1.date })
                self.collectionView.reloadData()
            }
        }
        
        let no = UIAlertAction(title: "No", style: .default) { (action) in }
        
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
}

extension NotesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20.0
    }
}
