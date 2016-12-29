//
//  MySwiftController.swift
//  CommonMethod
//
//  Created by littleBit on 2016/12/7.
//  Copyright © 2016年 littleBit. All rights reserved.
//

import UIKit
import Masonry
import BlocksKit
import SnapKit
class MySwiftController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "swift"
        self.view.backgroundColor = UIColor.white
        let btn:UIButton? = UIButton(type:.system)
//        btn!.frame = CGRect(x:100,y:100,width:100,height:30)
        self.view.addSubview(btn!)
        //Masonry
//        btn!.mas_makeConstraints { (make:MASConstraintMaker?) in
//            make?.top.equalTo()(self.view)?.setOffset(100)
//            make?.left.equalTo()(self.view)?.setOffset(100)
//            make?.right.equalTo()(self.view)?.setOffset(-100)
//            make?.height.mas_equalTo()(50)
//        }
        
        //Snapkit
        btn?.snp.makeConstraints{ (make) in
            make.top.left.equalTo(self.view).offset(100)
            make.right.equalTo(self.view).inset(100)
            make.height.equalTo(50)
        }
        
        btn?.layer.borderWidth = 1
        btn?.layer.borderColor = UIColor.lightGray.cgColor
        btn?.layer.cornerRadius = 5
        btn?.setTitle("返回", for: .normal)
        btn?.setTitleColor(UIColor.lightGray, for: .normal)
        
        //BlocksKit
        btn?.bk_addEventHandler({ (btnRes:Any?) in
            self.tapped()
        }, for: .touchUpInside)
    }

    func tapped ()  {
        self.navigationController!.popViewController(animated: true)
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
