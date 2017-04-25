//
//  BMTKeyboard.swift
//  BillMaster2
//
//  Created by 星 鲁 on 2016/12/26.
//  Copyright © 2016年 xxing. All rights reserved.
//

import UIKit

let HEADER_HEIGHT: Int = 35
let KEYBOARD_HEIGHT: CGFloat = 216

class BMTKeyboard: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let textField: UITextField?
    
    init(textField: UITextField) {
        let mainFrame = UIScreen.main.bounds
        var frame = mainFrame
        frame = CGRect(x: 0, y: mainFrame.height - KEYBOARD_HEIGHT,
                       width: mainFrame.width, height: KEYBOARD_HEIGHT)
        self.textField = textField
        super.init(frame: frame)
        
        textField.inputAccessoryView = BMTKeyboardHeader(textField: textField)
    }
    
    func hideKyeboard() {
        if textField != nil {
            textField?.resignFirstResponder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class BMTKeyboardHeader: UIView {
    
    var textField: UITextField?
    var searchBar: UISearchBar?
    var btnChangeNumber:UIButton?
    var keyboardType = UIKeyboardType.default
    var showNumButton:Bool {
        
        set(value) {
            btnChangeNumber?.isHidden = !value
        }
        get {
            return !(btnChangeNumber?.isHidden)!
        }
    }
    
    init(textField: UITextField, showNumButton: Bool = false) {
        
        var frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: HEADER_HEIGHT)
        frame.origin.x = 0
        frame.origin.y = -CGFloat(HEADER_HEIGHT)
        frame.size.height = CGFloat(HEADER_HEIGHT)
        super.init(frame: frame)
        
        doInit()
        
        self.textField = textField
        self.keyboardType = textField.keyboardType
        self.showNumButton = showNumButton
    }
    
    func doInit() {
        
        self.backgroundColor = sColorHelper.colorFrom(hex: 0xd1d5db)
        var setFrame = CGRect(x: Int(frame.width - 75), y: 0, width: 75,
                       height: HEADER_HEIGHT)
        let btnHide = UIButton(frame: setFrame)
        btnHide.setTitle("隐藏键盘", for: .normal)
        btnHide.setTitleColor(sColorHelper.colorFrom(hex: 0x007aff), for: .normal)
        btnHide.titleLabel?.font = UIFont.systemFont(
            ofSize: 14, weight: UIFontWeightUltraLight)
        btnHide.addTarget(
            self,
            action: #selector(BMTKeyboardHeader.hideButtonClicked(_:)),
            for: .touchUpInside)
        addSubview(btnHide)
        
        // 切换数字键盘
        setFrame.origin.x -= 75
        btnChangeNumber = UIButton(frame: setFrame)
        btnChangeNumber?.setTitle("数字", for: .normal)
        btnChangeNumber?.setTitleColor(sColorHelper.colorFrom(hex: 0x007aff), for: .normal)
        btnChangeNumber?.titleLabel?.font = UIFont.systemFont(
            ofSize: 14, weight: UIFontWeightUltraLight)
        btnChangeNumber?.addTarget(self,
                                  action: #selector(self.changeKeyboard(_:)),
                                  for: .touchUpInside)
        //btnChangeNumber?.isHidden = true
        addSubview(btnChangeNumber!)

    }
    
    init(searchBar: UISearchBar, showNumButton: Bool = false) {
        
        var frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: HEADER_HEIGHT)
        frame.origin.x = 0
        frame.origin.y = -CGFloat(HEADER_HEIGHT)
        frame.size.height = CGFloat(HEADER_HEIGHT)
        super.init(frame: frame)
        
        doInit()
        
        self.searchBar = searchBar
        self.keyboardType = searchBar.keyboardType
        self.showNumButton = showNumButton
    }
    
    func changeKeyboard(_ seander: UIButton) {
        
        if searchBar != nil {
            
            searchBar?.resignFirstResponder()
            if searchBar?.keyboardType == self.keyboardType {
                
                self.btnChangeNumber?.setTitle("字符", for: .normal)
                searchBar?.keyboardType = .numberPad
            } else {
                
                self.btnChangeNumber?.setTitle("数字", for: .normal)
                searchBar?.keyboardType = self.keyboardType
            }
            searchBar?.becomeFirstResponder()
        }
    }
    
    func hideButtonClicked(_ sender: UIButton) {
        if textField != nil {
            textField?.resignFirstResponder()
        } else if searchBar != nil {
            searchBar?.resignFirstResponder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 键盘区域 view  /// TODO: 重新完善
class BMTKeyboardAreaView: UIView {
    
    init() {
        
        let frame = CGRect(x: 0, y: 0,
                           width: Int(UIScreen.main.bounds.width),
                           height: 210)
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 键盘按钮样式
class BMTKeyboardButton: UIButton {
    
    init(frame: CGRect, font: UIFont, title: String) {
        
        super.init(frame: frame)
        
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
        self.backgroundColor = sColorHelper.colorFrom(hex: 0xe6e6e6)
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.setBackgroundImage(
            sColorHelper.imageFrom(color: UIColor.gray), for: .highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
