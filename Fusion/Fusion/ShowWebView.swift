//
//  ShowWebView.swift
//  Fusion
//
//  Created by Abhishek Jaykrishna Khapare on 8/14/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

class ShowWebView: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    var urlString : String?
    
    //stop spinner
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
    //show spinner
    func webViewDidStartLoad(_ webView: UIWebView) {
        spinner.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: urlString!)
        
        webView.loadRequest(URLRequest(url: url!))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
