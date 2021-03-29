//
//  MultiChoiceViewController.swift
//  multiChoice2021
//
//  Created by Betty Pan on 2021/3/28.
//

import UIKit
import AVFoundation

class MultiChoiceViewController: UIViewController {
    @IBOutlet weak var questionNumberSlider: UISlider!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var speakBtn: UIButton!
    @IBOutlet var Btns: [UIButton]!
    
    var index = 0 //題數
    var questions = [Question]() //題庫
    var options = [Question]() //選擇題選項
    var score = 0
    let player = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestion()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.speak()
        }
        setOptions()
        setSliderValue()
    }
    //翻牌效果
    func optionsTransition() {
        for i in Btns {
            UIView.transition(with: i, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
        UIView.transition(with: questionLabel, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    //說出題目
    func speak() {
        let utterance = AVSpeechUtterance(string: questions[index].animal.rawValue)
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    //設題目
    func setQuestion() {
        index = 0
        questions = [
            Question(animalImage: UIImage(named: "fox"), animal: .Fox),
            Question(animalImage: UIImage(named: "giraffe"), animal: .Giraffe),
            Question(animalImage: UIImage(named: "horse"), animal: .Horse),
            Question(animalImage: UIImage(named: "koala"), animal: .Koala),
            Question(animalImage: UIImage(named: "lion"), animal: .Lion),
            Question(animalImage: UIImage(named: "monkey"), animal: .Monkey),
            Question(animalImage: UIImage(named: "mouse"), animal: .Mouse),
            Question(animalImage: UIImage(named: "pig"), animal: .Pig),
            Question(animalImage: UIImage(named: "rhino"), animal: .Rhino),
            Question(animalImage: UIImage(named: "tiger"), animal: .Tiger),
            Question(animalImage: UIImage(named: "zebra"), animal: .Zebra)
        ]
        questions.shuffle()
        questionLabel.text = "\(questions[index].animal)"
    }
    //設選項
    func setOptions() {
        let o1 = Int.random(in: 0...3)
        let o2 = Int.random(in: 4...6)
        let o3 = Int.random(in: 7...9)
        
        options = [
            questions[o2],
            questions[o3],
            questions[o1],
            questions[index]
        ]
        options.shuffle()
        
        for (i,_) in Btns.enumerated() {
            Btns[i].setImage(options[i].animalImage, for: .normal)
        }
    }
    //設slider值
    func setSliderValue() {
        questionNumberSlider.maximumValue = Float(9)
        questionNumberSlider.value = Float(index)
        questionNumberLabel.text = "\(index+1)/10"
    }
    //下一題
    func nextQuestion() {
        index += 1
        questionLabel.text = "\(questions[index].animal)"
        setSliderValue()
        setOptions()
        optionsTransition()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
            self.speak()
        }
    }
    //enable按鍵
    func enableBtns( _ Bool:Bool) {
        for i in Btns {
            i.isEnabled = Bool
        }
    }
    
    @IBAction func speakAnimal(_ sender: Any) {
        speak()
    }
    @IBAction func pressBtn(_ sender: UIButton) {
        if sender.currentImage == questions[index].animalImage {
            score+=10
        }
        if index == 9 {
            performSegue(withIdentifier: "segueID", sender: nil)
            enableBtns(false)
        }else{
            nextQuestion()
        }
    }
    @IBAction func resetGame(_ sender: Any) {
        let controller = UIAlertController(title: "Restart?", message: "", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.setQuestion()
            self.setOptions()
            self.setSliderValue()
            self.enableBtns(true)
            self.score = 0
        }
        controller.addAction(yesAction)
        controller.addAction(noAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBSegueAction func transScore(_ coder: NSCoder) -> ResultViewController? {
        ResultViewController.init(coder: coder, score: score)
    
    
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
