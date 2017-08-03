//
//  ViewController.swift
//  SocialModul
//
//  Created by XCODE on 2017/5/8.
//  Copyright © 2017年 Gjun. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    enum ButtonTag: Int {
        case fb = 1, twitter, wechat
    }
    
    let handler = { (result: SLComposeViewControllerResult) in
        switch result {
        case .cancelled:
            print("取消發送")
        case .done:
            print("發送成功")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        func button(frame: CGRect, title: String, tag: ButtonTag) -> UIButton {
            let button = UIButton(frame: frame)
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.layer.cornerRadius = 8.0
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.darkGray.cgColor
            button.addTarget(self, action: #selector(self.onButtonAction(_:)), for: .touchUpInside)
            button.tag = tag.rawValue
            return button
        }
        
        let fbButton = button(
            frame: CGRect(x: 40, y: 200, width: UIScreen.main.bounds.width - 80, height: 40),
            title: "Facebook",
            tag: .fb
        )
        self.view.addSubview(fbButton)
        
        let twitterButton = button(
            frame: CGRect(x: 40, y: 250, width: UIScreen.main.bounds.width - 80, height: 40),
            title: "Twitter",
            tag: .twitter
        )
        self.view.addSubview(twitterButton)
        
        let wechatButton = button(
            frame: CGRect(x: 40, y: 300, width: UIScreen.main.bounds.width - 80, height: 40),
            title: "WeChat",
            tag: .wechat
        )
        self.view.addSubview(wechatButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onButtonAction(_ sender: UIButton) {
        guard let tag = ButtonTag(rawValue: sender.tag) else { return }
        var type: String
        switch tag {
        case .fb:
            type = SLServiceTypeFacebook
        case .twitter:
            type = SLServiceTypeTwitter
        case .wechat:
            type = "com.tencent.xin.sharetimeline"
        }
        if !SLComposeViewController.isAvailable(forServiceType: type) {
            print("無法啟用")
            return
        }
        let slComposeVC = SLComposeViewController(forServiceType: type)
        slComposeVC?.setInitialText("太狂啦~~~")
        if let image = UIImage(named: "ocean") {
            slComposeVC?.add(image)
        }
        if let url = URL(string: "http://www.pcschool.com.tw") {
            slComposeVC?.add(url)
        }
        slComposeVC?.completionHandler = self.handler
        self.present(slComposeVC!, animated: true, completion: nil)
    }

}
















