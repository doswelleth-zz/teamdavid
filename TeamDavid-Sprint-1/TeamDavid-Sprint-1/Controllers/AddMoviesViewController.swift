//
//  AddMoviesViewController.swift
//  TeamDavid-Sprint-1
//
//  Created by David Doswell on 12/15/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class AddMoviesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addMovieTextfield: UITextField!
    
    @IBOutlet weak var addMovie: UIButton!
    
    let movieController = MovieController.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        addMovieTextfield.delegate = self
    }
    
    @IBAction func addMovie(_ sender: Any) {
        movieController.saveNewMovie(name: addMovieTextfield.text!, hasSeen: false)
        addMovieTextfield.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addMovieTextfield.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
