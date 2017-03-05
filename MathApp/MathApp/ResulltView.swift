//
//  ResulltView.swift
//  MathApp
//
//  Created by Anantharamu, Akshatha Madapura on 11/20/16.
//  Copyright © 2016 Anantharamu, Akshatha Madapura. All rights reserved.
//

import UIKit

class ResultView : UIView{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        UINib.init(nibName: "ResultView", bundle: nil).instantiate(withOwner: self, options: nil)
    }
}
