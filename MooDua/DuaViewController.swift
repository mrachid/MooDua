//
//  DuaViewController.swift
//  MooDua
//
//  Created by Rachid on 24/10/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import UIKit

class DuaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backgroundImageDuasView: UIImageView!
    @IBOutlet weak var duasTableView: UITableView!
    
    private struct StoryBoard{
        static let cellIdentifierDuas = "cellDua"
        static let showDetailsDua = "showDetailDua"
    }
    
    var duas : Duas?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lightBlur = UIBlurEffect(style: UIBlurEffectStyle.light )
        
        let blurView = UIVisualEffectView(effect: lightBlur)
        blurView.alpha = 0.8
        
        blurView.frame = backgroundImageDuasView.bounds
        backgroundImageDuasView.addSubview(blurView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (duas?.chapName.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.cellIdentifierDuas, for: indexPath)
        cell.textLabel?.text = duas?.chapName[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.showDetailsDua{
            if let ddvc = segue.destination as? DetailsDuaViewController{
                ddvc.title = (sender as? UITableViewCell)?.textLabel?.text
                ddvc.duaInfo = duas?.duaInfos[(duasTableView.indexPathForSelectedRow?.last)!]
            }
        }
        
    }
 

}
