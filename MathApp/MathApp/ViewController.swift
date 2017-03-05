//
//  ViewController.swift
//  MathApp
//
//  Created by Anantharamu, Akshatha Madapura on 11/19/16.
//  Copyright © 2016 Anantharamu, Akshatha Madapura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Addition"){
            let view = segue.destination as! QuizView;
            view.Oper = "+";
        }else if(segue.identifier == "Subtraction"){
            let view = segue.destination as! QuizView;
            view.Oper = "-";
        }else if(segue.identifier == "Production"){
            let view = segue.destination as! QuizView;
            view.Oper = "X";
        }
    }
    
    @IBAction func unwindToHome(segue : UIStoryboardSegue){
        
    }

    
}

