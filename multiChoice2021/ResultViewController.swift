//
//  ResultViewController.swift
//  multiChoice2021
//
//  Created by Betty Pan on 2021/3/28.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    let score:Int
    init?(coder:NSCoder, score:Int) {
        self.score = score
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    func updateUI() {
        scoreLabel.text = String(score)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
