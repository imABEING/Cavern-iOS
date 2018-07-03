//
//  ViewController.swift
//  Cavern
//
//  Created by Kamilah Mitchell on 6/18/18.
//  Copyright © 2018 TekRecords. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, CsoundObjListener, SFSafariViewControllerDelegate {
    
    //MARK: Declarations
    var csound: CsoundObj!
    var csoundUI: CsoundUI!
    
    
    // MARK: IBOutlets
    @IBOutlet weak var reverbSlider: UISlider!
    @IBOutlet weak var drySlider: UISlider!
    @IBOutlet weak var cutoffSlider: UISlider!
    
    
    

    override func viewDidLoad() {
        title = "Cavern"
        super.viewDidLoad()
        
        // Initialize operative CsoundObj and CsoundUI objects
 //       csound.stop()
        csound = CsoundObj()
        csoundUI = CsoundUI.init(csoundObj: csound)
        //self.csound.useAudioInput = YES
        csound.useAudioInput = true
        csound.add(self) // add listener
        csoundUI.add(reverbSlider, forChannelName:"reverb") // Bind to a UISlider
        csoundUI.add(drySlider, forChannelName:"dry") // Bind to a UISlider
        csoundUI.add(cutoffSlider, forChannelName:"cutoff") // Bind to a UISlider
        csound.play(Bundle.main.path(forResource:"Cavern", ofType: "csd")) // Play Csound
        
       // self.levelChange(reverbSlider) // Initialize slider properties
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Buttons
    
    // MARK: Slider
    
    
    
    @IBAction func showSite(_ sender: UIButton) {
        let csoundURL = URL(string: "http://soundcloud.com/rolexalexx")
        let SafariVC = SFSafariViewController(url: csoundURL!)
        self.present(SafariVC, animated: true, completion: nil)
    }
    
    
    // SFSafariViewController delegate method
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    
    }
}

