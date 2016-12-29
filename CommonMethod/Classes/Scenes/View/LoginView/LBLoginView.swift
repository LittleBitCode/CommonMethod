//
//  LBLoginView.swift
//  CommonMethod
//
//  Created by littleBit on 2016/12/28.
//  Copyright © 2016年 littleBit. All rights reserved.
//

import UIKit

typealias clickBlock = (String?,String?) -> ()
enum LoginShowType:NSInteger {
    case LoginShowType_NONE,LoginShowType_USER,LoginShowType_PASS
}
class LBLoginView: UIView ,UITextFieldDelegate{
    var myBlock :clickBlock?
    var nameTF = UITextField()
    var pswdTF = UITextField()
    var loginBtn = UIButton()
    var titleLabel = UILabel()
    var showType:LoginShowType?
    var smallView = UIVisualEffectView()
    var imageLeftHand = UIImageView()
    var imageRightHand = UIImageView()
    var imageLeftHandGone = UIImageView()
    var imageRightHandGone = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        createVisulBG()
        createSubView()
        self.nameTF.delegate = self
        self.pswdTF.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createVisulBG(){
        let imageView = UIImageView.init(image: UIImage.init(named: "bg.jpeg"))
        addSubview(imageView)
        imageView.snp.makeConstraints { (mark) in
            mark.top.left.bottom.right.equalTo(self)
        }
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        let effect = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .light))
        imageView.addSubview(effect)
        effect.snp.makeConstraints { (mark) in
            mark.top.left.bottom.right.equalTo(imageView)
        }
    }
    func createSubView() {
        //猫头
       let imgLogin = UIImageView.init(image: UIImage.init(named: "owl-login"))
        addSubview(imgLogin)
        imgLogin.snp.makeConstraints { (mark) in
            mark.centerX.equalTo(self)
            mark.top.equalTo(self).offset(50)
            mark.width.equalTo(211)
            mark.height.equalTo(108)
        }
        //捂眼的左爪
        imgLogin.addSubview(self.imageLeftHand)
        self.imageLeftHand.image = UIImage.init(named: "owl-login-arm-left")
        imageLeftHand.snp.makeConstraints({ (mark) in
            mark.left.equalTo(imgLogin).offset(1)
            mark.top.equalTo(imgLogin).offset(90)
            mark.height.equalTo(65)
            mark.width.equalTo(40)
        })
        //捂眼的右爪
        imgLogin.addSubview(self.imageRightHand)
        self.imageRightHand.image = UIImage.init(named: "owl-login-arm-right")
        imageRightHand.snp.makeConstraints({ (mark) in
            mark.right.equalTo(imgLogin).inset(1)
            mark.top.equalTo(imgLogin).offset(90)
            mark.height.equalTo(65)
            mark.width.equalTo(40)
        })
        //展开的左爪
        addSubview(self.imageLeftHandGone)
        self.imageLeftHandGone.image = UIImage.init(named: "icon_hand")
        self.imageLeftHandGone.snp.makeConstraints { (mark) in
            mark.left.equalTo(self.snp.centerX).offset(-100)
            mark.top.equalTo(128)
            mark.width.height.equalTo(40)
        }
        //展开的右爪
        addSubview(self.imageRightHandGone)
        self.imageRightHandGone.image = UIImage.init(named: "icon_hand")
        self.imageRightHandGone.snp.makeConstraints { (mark) in
            mark.right.equalTo(self.snp.centerX).offset(100)
            mark.top.equalTo(128)
            mark.width.height.equalTo(40)
        }
        //账号密码背景
        self.smallView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .light))
        addSubview(self.smallView)
        self.smallView.snp.makeConstraints { (mark) in
            mark.top.equalTo(imgLogin.snp.bottom).offset(-9)
            mark.leading.trailing.equalToSuperview().inset(20)
            mark.height.equalTo(self.frame.size.width-40)
        }
        self.smallView.layer.cornerRadius = 5
        self.smallView.layer.masksToBounds = true
        
        self.smallView.addSubview(self.titleLabel)
        self.titleLabel.textColor = UIColor.lightGray
        self.titleLabel.textAlignment = .center
        self.titleLabel.snp.makeConstraints { (mark) in
            mark.top.equalTo(15)
            mark.left.right.equalTo(self.smallView).inset(10)
            mark.height.equalTo(40)
        }
        
        self.nameTF.layer.cornerRadius = 5
        self.nameTF.layer.borderWidth = 0.5
        self.nameTF.layer.borderColor = UIColor.gray.cgColor
        self.nameTF.clearButtonMode = .whileEditing
        self.nameTF.placeholder = "请输入账号"
        self.nameTF.leftViewMode = .always
        let imgUser = UIImageView.init(image: UIImage.init(named: "iconfont-user"))
        self.nameTF.leftView?.addSubview(imgUser)
        self.smallView.addSubview(self.nameTF)
        self.nameTF.snp.makeConstraints { (mark) in
            mark.left.right.equalToSuperview().inset(20)
            mark.top.equalTo(self.titleLabel.snp.bottom).offset(15)
            mark.height.equalTo(40)
        }
        self.nameTF.leftView?.snp.makeConstraints({ (mark) in
            mark.left.top.equalToSuperview()
            mark.height.width.equalTo(self.nameTF.frame.size.height)
        })
        if let leftView = self.nameTF.leftView {
                imgUser.snp.makeConstraints({ (mark) in
                mark.left.top.equalTo(leftView).inset(9)
                mark.width.height.equalTo(22)
            })
        }
        
        self.pswdTF.layer.cornerRadius = 5
        self.pswdTF.layer.borderWidth = 0.5
        self.pswdTF.layer.borderColor = UIColor.gray.cgColor
        self.pswdTF.clearButtonMode = .whileEditing
        self.pswdTF.placeholder = "请输入密码"
        self.pswdTF.isSecureTextEntry = true
        self.pswdTF.leftViewMode = .always
        let imgPswd = UIImageView.init(image: UIImage.init(named: "iconfont-password"))
        self.pswdTF.leftView?.addSubview(imgPswd)
        self.smallView.addSubview(self.pswdTF)
        self.pswdTF.snp.makeConstraints { (mark) in
            mark.left.right.equalToSuperview().inset(20)
            mark.top.equalTo(self.nameTF.snp.bottom).offset(10)
            mark.height.equalTo(40)
        }
        self.pswdTF.leftView?.snp.makeConstraints({ (mark) in
            mark.left.top.equalToSuperview()
            mark.height.width.equalTo(self.pswdTF.frame.size.height)
        })
        if let leftView = self.pswdTF.leftView {
            imgUser.snp.makeConstraints({ (mark) in
                mark.left.top.equalTo(leftView).inset(9)
                mark.width.height.equalTo(22)
            })
        }
        self.loginBtn = UIButton.init(type: .system)
        addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (mark) in
            mark.top.equalTo(self.pswdTF.snp.bottom).offset(20)
            mark.left.equalTo(self.pswdTF.snp.left)
            mark.right.equalTo(self.pswdTF.snp.right)
            mark.height.equalTo(40)
        }
        self.loginBtn.backgroundColor = UIColor.init(colorLiteralRed: 83/255, green: 149/255, blue: 232/255, alpha: 0.8)
        self.loginBtn.setTitle("登        录", for: .normal)
        self.loginBtn.tintColor = UIColor.lightGray
        self.loginBtn.layer.cornerRadius = 5
        self.loginBtn.bk_addEventHandler({ (sender : Any?) in
            self.myBlock!(self.nameTF.text,self.pswdTF.text)
        }, for: .touchUpInside)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension LBLoginView {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(self.nameTF) {
            if self.showType != LoginShowType.LoginShowType_PASS {
                showType = LoginShowType.LoginShowType_USER
                return;
            }
            self.showType = LoginShowType.LoginShowType_USER
            UIView.animate(withDuration: 0.5, animations: { 
                self.imageLeftHand.frame = CGRect.init(x: self.imageLeftHand.frame.origin.x - 60, y: self.imageLeftHand.frame.origin.y + 30, width: self.imageLeftHand.frame.size.width, height: self.imageLeftHand.frame.size.height)
                self.imageRightHand.frame = CGRect.init(x: self.imageRightHand.frame.origin.x + 53, y: self.imageRightHand.frame.origin.y + 30, width: self.imageRightHand.frame.size.width, height: self.imageRightHand.frame.size.height)
                self.imageLeftHandGone.frame = CGRect.init(x: self.imageLeftHandGone.frame.origin.x - 70, y: self.imageLeftHandGone.frame.origin.y , width: 40, height: 40)
                self.imageRightHandGone.frame = CGRect.init(x: self.imageRightHandGone.frame.origin.x + 30, y: self.imageRightHandGone.frame.origin.y , width: 40, height: 40)
                
            })
        }else {
            if textField.isEqual(self.pswdTF) {
                if self.showType == LoginShowType.LoginShowType_PASS {
                    showType = LoginShowType.LoginShowType_PASS
                    return;
                }
                self.showType = LoginShowType.LoginShowType_PASS
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageLeftHand.frame = CGRect.init(x: self.imageLeftHand.frame.origin.x + 60, y: self.imageLeftHand.frame.origin.y - 30, width: self.imageLeftHand.frame.size.width, height: self.imageLeftHand.frame.size.height)
                    self.imageRightHand.frame = CGRect.init(x: self.imageRightHand.frame.origin.x - 53, y: self.imageRightHand.frame.origin.y - 30, width: self.imageRightHand.frame.size.width, height: self.imageRightHand.frame.size.height)
                    self.imageLeftHandGone.frame = CGRect.init(x: self.imageLeftHandGone.frame.origin.x + 70, y: self.imageLeftHandGone.frame.origin.y , width: 0, height: 0)
                    self.imageRightHandGone.frame = CGRect.init(x: self.imageRightHandGone.frame.origin.x - 30, y: self.imageRightHandGone.frame.origin.y , width: 0, height: 0)
                })
     
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.isEqual(self.pswdTF) {
            if showType == LoginShowType.LoginShowType_PASS {
                showType = LoginShowType.LoginShowType_USER
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageLeftHand.frame = CGRect.init(x: self.imageLeftHand.frame.origin.x - 60, y: self.imageLeftHand.frame.origin.y + 30, width: self.imageLeftHand.frame.size.width, height: self.imageLeftHand.frame.size.height)
                    self.imageRightHand.frame = CGRect.init(x: self.imageRightHand.frame.origin.x + 53, y: self.imageRightHand.frame.origin.y + 30, width: self.imageRightHand.frame.size.width, height: self.imageRightHand.frame.size.height)
                    self.imageLeftHandGone.frame = CGRect.init(x: self.imageLeftHandGone.frame.origin.x - 70, y: self.imageLeftHandGone.frame.origin.y , width: 40, height: 40)
                    self.imageRightHandGone.frame = CGRect.init(x: self.imageRightHandGone.frame.origin.x + 30, y: self.imageRightHandGone.frame.origin.y , width: 40, height: 40)
                })
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.window?.resignFirstResponder()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameTF.resignFirstResponder()
        self.pswdTF.resignFirstResponder()
    }
}
