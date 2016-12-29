//
//  LoginAndRegisterController.swift
//  CommonMethod
//
//  Created by littleBit on 2016/12/28.
//  Copyright © 2016年 littleBit. All rights reserved.
//

import UIKit
class LoginAndRegisterController: UIViewController ,UIAlertViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        let LoginView:LBLoginView = LBLoginView.init(frame:CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        self.view.addSubview(LoginView)
        LoginView.titleLabel.text = "我是一只猫头鹰"
        LoginView.myBlock = {(name,pswd) in   //闭包
                print(name!,pswd!)
            if name == "123" && pswd == "456" {
                let vc:BaseTabBarController! = BaseTabBarController.init()
                CYLPlusButtonSubclass.register()
                UIApplication.shared.keyWindow?.rootViewController = vc.tabBarController
            }else {
            let alert = UIAlertView.init(title: "登录错误", message: "账号或密码错误,请重新登录 !", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
                alert.show()
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoginAndRegisterController {
    func alertViewCancel(_ alertView: UIAlertView) {
        
    }
}

