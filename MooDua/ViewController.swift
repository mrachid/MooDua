//
//  ViewController.swift
//  MooDua
//
//  Created by Rachid on 24/10/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class ViewController: UIViewController {
    
    
    private var duas : Duas?{
        didSet{
            duas?.parseDuaInfo()
            performSegue(withIdentifier: StoryBoard.showDuasSegue, sender: UIButton())
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    private struct StoryBoard{
        static let showDuasSegue = "show Duas"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lightBlur = UIBlurEffect(style: UIBlurEffectStyle.light )
        let blurView = UIVisualEffectView(effect: lightBlur)
        blurView.alpha = 0.8
        blurView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.showDuasSegue{
            if let dvc = segue.destination as? DuaViewController{
                dvc.title = (sender as? UIButton)?.currentTitle
                dvc.duas = self.duas
            }
        }
    }
    
    @IBAction func showDuas(_ sender: UIButton) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        if let titleDua = sender.restorationIdentifier{
            ref.child(titleDua).observeSingleEvent(of: .value, with: { (snapshot) in
                let data = JSON(snapshot.value)
                self.duas = Duas(dua: data)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
}

