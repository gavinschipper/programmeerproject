//
//  InstructionsViewController.swift
//  ReceptApp
//
//  Created by Gavin Schipper on 22-01-18.
//  Copyright © 2018 Gavin Schipper. All rights reserved.
//

import UIKit
import WebKit

class InstructionsViewController: UIViewController {
    
    var recipeURL = ""

    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newUrlString = recipeURL.replacingOccurrences(of: "http://", with: "https://")
        let url = URL(string: newUrlString)
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
