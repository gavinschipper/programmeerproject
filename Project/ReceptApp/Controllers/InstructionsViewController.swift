//
//  InstructionsViewController.swift
//  ReceptApp
//
//  The instructionsViewController shows the website/blog where the recipe originally came from in a webview.
//
//  Created by Gavin Schipper on 22-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import WebKit

class InstructionsViewController: UIViewController {
    
    // MARK: Properties
    var recipeURL = ""
    
    // MARK: Outlets
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: Actions
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Functions
    
    /// Loads the URL in the webview
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Xcode 9 does not like 'http'. Therefore every occurrence of 'http' has to be changed into 'https'
        let newUrlString = recipeURL.replacingOccurrences(of: "http://", with: "https://")
        let url = URL(string: newUrlString)
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }
}
