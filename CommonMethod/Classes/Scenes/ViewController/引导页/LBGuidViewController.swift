//
//  LBGuidViewController.swift
//  CommonMethod
//
//  Created by littleBit on 2016/12/7.
//  Copyright © 2016年 littleBit. All rights reserved.
//

import UIKit

class LBGuidViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!

    private var scrollView:UIScrollView!
    let numOfPages = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = String.init(format: "%@%@", kMainUrlString,"appInfo/checkIosVersion.do")
        let parameters:Dictionary <String,String> = ["version":LBMethods.getAppVersion(),"versionType":String.init(format: "%i", 1)]
        
        //Alamofire
        AFNSwiftRequest.shareInstance.getRequest(urlString: urlString, params: parameters, success: { response in
//            print(response)
        }, failture: { error in
            print(error)
        })
        
        //AFNetworking
        AFNSwiftRequest.shareInstance.request(Request_Type: .Post, url: urlString, parameters: parameters, succeed: { (response) in
            if let response = response {
//                print(response as [String : Any])
            }
        }) { (error) in
            guard let error = error else {
                return
            }
            print(error)
        }
        let frame = self.view.bounds
        scrollView = UIScrollView(frame:frame)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint(x:0,y:0)
        scrollView.contentSize = CGSize(width:frame.size.width * CGFloat(numOfPages),height:frame.size.height)
        scrollView.delegate = self
        
        for index in 0..<numOfPages {
            let imageView = UIImageView(image:UIImage(named:"GuideImage\(index+1).JPG"))
            imageView.frame = CGRect(x:frame.size.width * CGFloat(index),y:0,width:frame.size.width,height:frame.size.height)
            scrollView.addSubview(imageView)
        }
        self.view.insertSubview(scrollView, at:0)
        
        //给开始设置圆角
        startButton.layer.cornerRadius = 15.0
        //隐藏开始按钮
        startButton.alpha = 0.0
        //隐藏状态栏
        func prefersStatusBarHidden() -> Bool {
            return true
        }
        // Do any additional setup after loading the view.
    }

    //点击  立即体验
    @IBAction func rightNow(_ sender: Any) {
//        let vc:BaseTabBarController! = BaseTabBarController.init()
//        CYLPlusButtonSubclass.register()
//        UIApplication.shared.keyWindow?.rootViewController = vc.tabBarController
        let vc:LoginAndRegisterController! = LoginAndRegisterController.init()
        UIApplication.shared.keyWindow?.rootViewController = vc
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

extension LBGuidViewController :UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        //随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.frame.size.width)
        //因为currentPage 是从0开始的  所以 numOfpages 减1
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.5, animations: { 
                self.startButton.alpha = 1.0
            })
        }else {
            UIView.animate(withDuration: 0.2, animations: { 
                self.startButton.alpha = 0.0
            })
        }
    }
}



