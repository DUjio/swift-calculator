//
//  ViewController.swift
//  swift-calculator
//
//  Created by XX on 17/5/4.
//  Copyright © 2017年 XX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let width:CGFloat = UIScreen.mainScreen().bounds.width/4;
    let top:CGFloat = UIScreen.mainScreen().bounds.height-UIScreen.mainScreen().bounds.width;
    
    var number1:String?
    var number2:String?
    var operators:String?
    var operated:Bool?
    var shouldClear:Bool?
    
    var content:UILabel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        initUI()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        number1 = ""
        number2 = ""
        operators = ""
        operated = false
        
    }

    func initUI() {
        // 显示板
        content = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: top))
        content!.backgroundColor = UIColor.blackColor()
        content!.textColor = UIColor.whiteColor()
        content!.text = ""
        view.addSubview(content!)
        
        // 数字
        for row in 0 ..< 3 {
            for col in 0 ..< 3 {
                let frame:CGRect = CGRect(x: CGFloat(col)*width, y: top+CGFloat(row)*width, width: width, height: width)
                let title:String = String(row*3+col+1)
                createButton(frame, title: title)
            }
        }
        
        // 运算符
        let operators = ["+","-","x","÷"];
        for row in 0 ..< 4 {
            for _ in 0 ..< 1 {
                let frame:CGRect = CGRect(x: 3*width, y: top+CGFloat(row)*width, width: width, height: width)
                let title:String = operators[row]
                createButton(frame, title: title)
            }
        }
        
        // 其他
        // 小数点
        createButton(CGRect(x: 0, y: top+3*width, width: width, height: width), title: ".")
        
        // 0
        createButton(CGRect(x: width, y: top+3*width, width: width, height: width), title: "0")
        
        // =
        createButton(CGRect(x: 2*width, y: top+3*width, width: width, height: width), title: "=")
    }
    
    func createButton(frame:CGRect, title:String) -> UIButton {
        let selector:Selector = #selector(self.OnClick(_:))
        let button:UIButton = UIButton.init(frame: frame)
        button.backgroundColor = UIColor.lightGrayColor()
        button.titleLabel!.textColor = UIColor.whiteColor()
        button.setTitle(title, forState: UIControlState.Normal)
        button.layer.borderColor = UIColor.whiteColor().CGColor;
        button.layer.borderWidth = 1;
        button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        return button;
    }
    
    func OnClick(button:UIButton) {
        
        if (shouldClear == true){
            content!.text = ""
            shouldClear = false
        }
        
        let text:String = (button.titleLabel?.text)!
        NSLog("%@",text)
        
        content!.text = content!.text?.stringByAppendingString((text))
        
        if ((text >= "0" && text <= "9")){
            if (operated == false){
                number1 = number1?.stringByAppendingString(text)
            }
            else {
                number2 = number2?.stringByAppendingString(text)
            }
        }
        else if (text == "+" || text == "-" || text == "x" || text == "÷"){
            if (operators != ""){
                number1 = doCal()
                number2 = ""
            }
            
            operators = text
            operated = true
        }
        else if (text == "="){
            content!.text = content!.text?.stringByAppendingString(doCal())
            initData()
            shouldClear = true
        }
        else if (text == "."){
            if (operated == false){
                if (number1?.containsString(".") == false && number1 != ""){
                    number1 = number1?.stringByAppendingString(text)
                }
                else {
                    content?.text?.removeAtIndex((content?.text?.endIndex.predecessor())!)
                }
            }
            else {
                if (number2?.containsString(".") == false && number2 != ""){
                    number2 = number2?.stringByAppendingString(text)
                }
                else {
                    content?.text?.removeAtIndex((content?.text?.endIndex.predecessor())!)
                }
            }
        }
    }
    
    func doCal() -> String {
        let x:CGFloat = StringToFloat(number1!)
        let y:CGFloat = StringToFloat(number2!)
        if (operators == "+"){
            return String(x+y)
        }
        else if (operators == "-"){
            return String(x-y)
        }
        else if (operators == "x"){
            return String(x*y)
        }
        else {
            return String(x/y)
        }
    }
    
    func StringToFloat(str:String)->(CGFloat){
        let string = str
        var cgFloat: CGFloat = 0
        
        if let doubleValue = Double(string) {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
}

