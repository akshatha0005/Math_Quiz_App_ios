//
//  QuizView.swift
//  MathApp
//
//  Created by Anantharamu, Akshatha Madapura on 11/19/16.
//  Copyright © 2016 Anantharamu, Akshatha Madapura. All rights reserved.
//
import UIKit

class QuizView: UIViewController {
    
    @IBOutlet var Number1: UILabel!
    @IBOutlet var Number2: UILabel!
    @IBOutlet var Operator: UILabel!
    @IBOutlet var Result: UILabel!
    @IBOutlet var Qnumber: UILabel!
    @IBOutlet var timeDisplay: UILabel!
    @IBOutlet weak var timerIcon: UIImageView!
    @IBOutlet weak var btnEight: UIButton!
   
    @IBOutlet weak var btnSeven: UIButton!
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnZero: UIButton!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnNine: UIButton!
    @IBOutlet weak var btnSix: UIButton!
    
    var Oper : String?
    var num1 : Int?
    var num2 : Int?
    var Qnum : Int = 1;
    var Score = 0;
    var hasText = false;
    var currentChar = ""
    var second = 5;
    var counter = Timer()
    var labelTimer = Timer()
    var alert: UIAlertController!
   
    @IBAction func backBtnPressed(_ sender: Any) {
        counter.invalidate()
        let exitAlert = UIAlertController(title: "Quit", message: "Are You Sure you want to quit the game? ", preferredStyle: UIAlertControllerStyle.alert)
        
        exitAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "unwindToHome", sender: self)
        }))
        
        exitAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            
            exitAlert .dismiss(animated: true, completion: nil)
            self.startTimer()
            
        }))
        
        present(exitAlert, animated: true, completion: nil)
    }
    
        
       override func viewDidLoad() {

        super.viewDidLoad();
        fixOrientation();
        Result?.layer.borderColor = UIColor.black.cgColor;
        Result?.layer.borderWidth = 2;
        Qnumber?.text = String(Qnum);
        self.startTimer()
        self.randomNumberGen();
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func numPad(_ sender: UIButton) {
        if(sender.currentTitle != "Enter"){
            if(hasText){
                let btnValue = sender.currentTitle!;
                Result?.text! += btnValue
                currentChar += btnValue
                if((Result?.text) != nil){
                    if(self.calculate() == currentChar){
                        Score = Score + 1;
                        showCorrect()
                        reload()
                        labelTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(QuizView.updateLabel)), userInfo: nil, repeats: false)
                        hasText = false
                        currentChar = ""
                    }else{
                        showWrong()
                        reload()
                        labelTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(QuizView.updateLabel)), userInfo: nil, repeats: false)
                        hasText = false
                        currentChar = ""
                    }
                }
            }else{
                let btnValue = sender.currentTitle!;
                Result?.text! = btnValue
                if((Result?.text) != nil){
                    if(self.calculate().characters.count > 1){
                        hasText = true;
                        currentChar = btnValue
                    }else{
                        if(self.calculate() == btnValue){
                            Score = Score + 1;
                            showCorrect()
                            reload()
                            labelTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(QuizView.updateLabel)), userInfo: nil, repeats: false)
                        }else{
                            showWrong()
                            reload()
                            labelTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(QuizView.updateLabel)), userInfo: nil, repeats: false)
                        }
                    }
                }
            }
        }else{
            showSkip()
            reload()
        }
    }
  
    
    func randomNumberGen() {
       let  n1 = arc4random_uniform(10) + 1;
       let n2 = arc4random_uniform(n1) + 1;
        
        num1 = Int(n1);
        num2 = Int(n2);
    
        
        Number1?.text = String(describing: n1);
        Number2?.text = String(describing: n2);
        Operator?.text = Oper;
    }
    
    func calculate() -> String {
    
        switch Oper {
        case "+"?:
        let res = num1! + num2!;
        return String(res) ;
        case "-"?:
            let res = num1! - num2!;
            return String(res) ;
        case "X"?:
            let res = num1! * num2!;
            return String(res) ;
        default:
            return String(0);
        }
    }
    
    func reload() {
        counter.invalidate()
        if(Qnum < 10) {
        self.randomNumberGen()
        Qnum = Qnum + 1;
        Qnumber?.text = String(Qnum);
        second = 5;
        timeDisplay?.text = "\(second)"
        startTimer()
        }else{
            showResult(score: Score)
        }
    }
    
    func showResult(score: Int){
        let resultAlert = UIAlertController(title: "Total Score", message: "You have scored \(score) out of 10 ", preferredStyle: UIAlertControllerStyle.alert)
        
        resultAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "unwindToHome", sender: self)
        }))
        
      present(resultAlert, animated: true, completion: nil)
    }
    
    func startTimer()  {
        counter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(QuizView.updateSecond)), userInfo: nil, repeats: true)
    }
    
    func updateSecond(){
        if(second > 0){
            second -= 1
            timeDisplay?.text = "\(second)"
        }else {
            updateLabel()
            reload()
        }
    }
    
    func showCorrect(){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height/2 - 150, width:300, height: 35))
        toastLabel.backgroundColor = UIColor.green
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(toastLabel)
        toastLabel.text = "Correct"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 4.0, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            toastLabel.alpha = 0.0
            
        });
    }
    
    func showWrong(){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height/2 - 150, width:300, height: 35))
        toastLabel.backgroundColor = UIColor.red
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(toastLabel)
        toastLabel.text = "In Correct"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 4.0, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            toastLabel.alpha = 0.0
            
        });
    }
    
    func updateLabel()  {
        labelTimer.invalidate()
        Result?.text! = ""
    }
    
    func showSkip(){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height/2 - 150, width:300, height: 35))
        toastLabel.backgroundColor = UIColor.yellow
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(toastLabel)
        toastLabel.text = "You skipped question"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 4.0, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
    
        toastLabel.alpha = 0.0
    
        });
    }
    /*
     
     @IBOutlet var Number1: UILabel!
     @IBOutlet var Number2: UILabel!
     @IBOutlet var Operator: UILabel!
     @IBOutlet var Result: UILabel!
     @IBOutlet var Qnumber: UILabel!
     @IBOutlet var timeDisplay: UILabel!
     @IBOutlet weak var timerIcon: UIImageView!
     @IBOutlet weak var btnEight: UIButton!
     @IBOutlet weak var btnSeven: UIButton!
     @IBOutlet weak var btnOne: UIButton!
     @IBOutlet weak var btnThree: UIButton!
     @IBOutlet weak var btnFour: UIButton!
     @IBOutlet weak var btnFive: UIButton!
     @IBOutlet weak var btnZero: UIButton!
     @IBOutlet weak var btnEnter: UIButton!
     @IBOutlet weak var btnTwo: UIButton!
     @IBOutlet weak var btnNine: UIButton!
     @IBOutlet weak var btnSix: UIButton!

 */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation.isLandscape)

        if(UIDevice.current.orientation.isLandscape){
            timerIcon.frame.origin = CGPoint(x:615,y:65)
            timeDisplay.frame.origin = CGPoint(x:640,y:65)
            Number1.frame.origin = CGPoint(x:144,y:165)
            Number2.frame.origin = CGPoint(x:144,y:227)
            Operator.frame.origin = CGPoint(x:60,y:227)
            Result.frame.origin = CGPoint(x:37,y:261)
            btnSeven.frame.origin = CGPoint(x:384,y:141)
            btnEight.frame.origin = CGPoint(x:442,y:141)
            btnNine.frame.origin = CGPoint(x:500,y:141)
            btnFour.frame.origin = CGPoint(x:384,y:199)
            btnFive.frame.origin = CGPoint(x:442,y:199)
            btnSix.frame.origin = CGPoint(x:500,y:199)
            btnOne.frame.origin = CGPoint(x:384,y:257)
            btnTwo.frame.origin = CGPoint(x:442,y:257)
            btnThree.frame.origin = CGPoint(x:500,y:257)
            btnZero.frame.origin = CGPoint(x:384,y:315)
            btnEnter.frame.origin = CGPoint(x:442,y:315)

            
        }else{
            timerIcon.frame.origin = CGPoint(x:294,y:63)
            timeDisplay.frame.origin = CGPoint(x:326,y:67)
            Number1.frame.origin = CGPoint(x:209,y:251)
            Number2.frame.origin = CGPoint(x:209,y:313)
            Operator.frame.origin = CGPoint(x:125,y:313)
            Result.frame.origin = CGPoint(x:106,y:373)
            btnSeven.frame.origin = CGPoint(x:106,y:423)
            btnEight.frame.origin = CGPoint(x:164,y:423)
            btnNine.frame.origin = CGPoint(x:222,y:423)
            btnFour.frame.origin = CGPoint(x:106,y:481)
            btnFive.frame.origin = CGPoint(x:164,y:481)
            btnSix.frame.origin = CGPoint(x:222,y:481)
            btnOne.frame.origin = CGPoint(x:106,y:539)
            btnTwo.frame.origin = CGPoint(x:164,y:539)
            btnThree.frame.origin = CGPoint(x:222,y:539)
            btnZero.frame.origin = CGPoint(x:106,y:597)
            btnEnter.frame.origin = CGPoint(x:164,y:597)

        }
    }
    func fixOrientation() {
        if(UIDevice.current.orientation.isLandscape){
            timerIcon.frame.origin = CGPoint(x:615,y:65)
            timeDisplay.frame.origin = CGPoint(x:640,y:65)
            Number1.frame.origin = CGPoint(x:144,y:165)
            Number2.frame.origin = CGPoint(x:144,y:227)
            Operator.frame.origin = CGPoint(x:60,y:227)
            Result.frame.origin = CGPoint(x:37,y:261)
            btnSeven.frame.origin = CGPoint(x:384,y:141)
            btnEight.frame.origin = CGPoint(x:442,y:141)
            btnNine.frame.origin = CGPoint(x:500,y:141)
            btnFour.frame.origin = CGPoint(x:384,y:199)
            btnFive.frame.origin = CGPoint(x:442,y:199)
            btnSix.frame.origin = CGPoint(x:500,y:199)
            btnOne.frame.origin = CGPoint(x:384,y:257)
            btnTwo.frame.origin = CGPoint(x:442,y:257)
            btnThree.frame.origin = CGPoint(x:500,y:257)
            btnZero.frame.origin = CGPoint(x:384,y:315)
            btnEnter.frame.origin = CGPoint(x:442,y:315)
            
            
        }else{
            timerIcon.frame.origin = CGPoint(x:294,y:63)
            timeDisplay.frame.origin = CGPoint(x:326,y:67)
            Number1.frame.origin = CGPoint(x:209,y:251)
            Number2.frame.origin = CGPoint(x:209,y:313)
            Operator.frame.origin = CGPoint(x:125,y:313)
            Result.frame.origin = CGPoint(x:106,y:373)
            btnSeven.frame.origin = CGPoint(x:106,y:423)
            btnEight.frame.origin = CGPoint(x:164,y:423)
            btnNine.frame.origin = CGPoint(x:222,y:423)
            btnFour.frame.origin = CGPoint(x:106,y:481)
            btnFive.frame.origin = CGPoint(x:164,y:481)
            btnSix.frame.origin = CGPoint(x:222,y:481)
            btnOne.frame.origin = CGPoint(x:106,y:539)
            btnTwo.frame.origin = CGPoint(x:164,y:539)
            btnThree.frame.origin = CGPoint(x:222,y:539)
            btnZero.frame.origin = CGPoint(x:106,y:597)
            btnEnter.frame.origin = CGPoint(x:164,y:597)
            
        }
    }
    
}
