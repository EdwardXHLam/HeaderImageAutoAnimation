//
//  DynamicDisplayHideHeaderVC.swift
//  HeaderImageAutoAnimation
//
//  Created by YZ-LXH on 2021/11/17.
//

import UIKit
import SnapKit
import Kingfisher

private let defaultTagIndex = 120

class DynamicDisplayHideHeaderVC: UIViewController {
    
    lazy var headerImagesArrays = ["https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb.zol-img.com.cn%2Fdesk%2Fbizhi%2Fimage%2F2%2F960x600%2F1364440542803.jpg&refer=http%3A%2F%2Fb.zol-img.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639724513&t=e0ca0bedeeaf116c3869bd36480c0ec6","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic144.nipic.com%2Ffile%2F20171015%2F15519538_130240708000_2.jpg&refer=http%3A%2F%2Fpic144.nipic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639724513&t=4e0bcf399cde84f990fc7e9812c2f7e3","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F1f%2F9a%2F72%2F1f9a72bea555a3ee5efb8aab2948a9e3.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639724513&t=ae4b98f0d3617c6c29167cf532cc40fb","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F53%2F0a%2Fda%2F530adad966630fce548cd408237ff200.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639724513&t=8d1815e1ecf5218472a7bb6b46b62734","https://t7.baidu.com/it/u=1732966997,2981886582&fm=193&f=GIF","https://t7.baidu.com/it/u=1785207335,3397162108&fm=193&f=GIF","https://t7.baidu.com/it/u=2581522032,2615939966&fm=193&f=GIF","https://t7.baidu.com/it/u=245883932,1750720125&fm=193&f=GIF","https://t7.baidu.com/it/u=3423293041,3900166648&fm=193&f=GIF"]

    lazy var bgImageBgView: UIView = {
        
        let bgImageBgView = UIView()

        view.addSubview(bgImageBgView)
        
        return bgImageBgView
        
    }()
    
    //用于遮盖移动过去的头像视图
    lazy var whiteView: UIView = {
        
        let whiteView = UIView()
        
        whiteView.backgroundColor = .white

        view.addSubview(whiteView)
        
        return whiteView
        
    }()
    
    private var customRect = CGRect.zero
    
    lazy var lineShapeLayer: CAShapeLayer = {
        
        let lineShapeLayer = CAShapeLayer()
        
        let path = CGMutablePath()
        
        lineShapeLayer.fillColor = UIColor.clear.cgColor
        
        lineShapeLayer.strokeColor = UIColor.red.cgColor
        
        lineShapeLayer.lineWidth = 2
        
        path.addEllipse(in: customRect)
        
        lineShapeLayer.path = path
        
        lineShapeLayer.lineDashPhase = 1
        
        lineShapeLayer.lineDashPattern = [1,5]
        
        let dashAnimation = CABasicAnimation(keyPath: "lineDashPhase")
        
        dashAnimation.fromValue = 300
        
        dashAnimation.toValue = 0
        
        dashAnimation.duration = 4
        
        dashAnimation.isCumulative = true
        
        dashAnimation.repeatCount = Float(Int.max)
        
        dashAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        
        lineShapeLayer.add(dashAnimation, forKey: "linePhase")
        
        bgImageBgView.layer.addSublayer(lineShapeLayer)
        
        return lineShapeLayer
        
    }()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupImagesBgView()
        
        animationAction(imgTag: 125)
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        bgImageBgView.snp_makeConstraints { make in
            
            make.top.equalTo(view).offset(100)
            
            make.width.equalTo(204)
            
            make.height.equalTo(50)
            
            make.centerX.equalTo(view)
        }
        
        whiteView.snp_makeConstraints { make in
            
            make.top.equalTo(bgImageBgView)
            
            make.left.equalTo(bgImageBgView.snp_right).offset(5)
            
            make.right.equalTo(view)
            
            make.bottom.equalTo(bgImageBgView)
        }
    }
    
    //初始化头像
    private func setupImagesBgView() {
        
        let imgWidth: CGFloat = 24
        
        let imgHeight: CGFloat = 24
        
        for index in 0..<6 {
            
            let imgView = UIImageView()
            
            imgView.kf.setImage(urlString: headerImagesArrays[index])
            
            imgView.contentMode = .scaleAspectFill
            
            imgView.tag = index + defaultTagIndex
            
            bgImageBgView.addSubview(imgView)
            
            imgView.snp_makeConstraints { make in
                
                let offset = -(CGFloat(index) * (imgWidth + (index == 5 ? 7 : 5)))
                
                make.right.equalTo(bgImageBgView).offset(offset)
                
                make.centerY.equalTo(bgImageBgView)
                
                make.size.equalTo(CGSize(width: imgWidth, height: imgHeight))
            }
            
            RadiusToView(view: imgView, radius: imgHeight / 2)
            
            if index == 5 {
                
                imgView.alpha = 0
                
                imgView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }
        }
        
    }
    
    
    private func animationAction(imgTag: Int) {
        
        if let imgView = bgImageBgView.viewWithTag(imgTag) {
            
            let imgWidth:CGFloat = 24
            
            UIView.animate(withDuration: 1) {
                imgView.alpha = 1
                imgView.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { [weak self] finished in
                
                if self?.customRect == CGRect.zero {
                    
                    self?.customRect = CGRect(x: imgView.frame.origin.x-5, y: imgView.frame.origin.y-5, width: imgView.frame.size.width+10, height: imgView.frame.height+10)
                }
                
                self?.lineShapeLayer.isHidden = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    self?.lineShapeLayer.isHidden = true
                    
                    UIView.animate(withDuration: 1) {
                        
                        imgView.transform = CGAffineTransform(translationX: 10, y: 0)
                        
                        
                    } completion: { finished in
                        
                        UIView.animate(withDuration: 1) {
                            
                            self?.bgImageBgView.subviews.forEach({
                                
                                if $0 is UIImageView {
                                    
                                    $0.transform = CGAffineTransform(translationX: imgWidth + 5, y: 0).concatenating($0.transform)
                                }
                            })
                        } completion: { finished in
                            
                            if let lastImageView = self?.bgImageBgView.viewWithTag(imgTag - 5) {
                                
                                lastImageView.removeFromSuperview()
                                
                                self?.reNewLastImageView(imgTag: imgTag + 1)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {

                                    self?.animationAction(imgTag: imgTag + 1)
                                }
                            }
                        }
                    }

                }
 
            }
        }
    }
    
    
    private func reNewLastImageView(imgTag: Int) {
        
        let imgWidth:CGFloat = 24
        
        let imgHeight:CGFloat = 24
        
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFill
        
        imgView.tag = imgTag
        
        let random = arc4random_uniform(9)
        
        imgView.kf.setImage(urlString: headerImagesArrays[Int(random)])
        
        bgImageBgView.addSubview(imgView)
        
        imgView.snp_makeConstraints { make in
            
            make.right.equalTo(bgImageBgView).offset(-CGFloat(5) * (imgWidth + 7))
            
            make.centerY.equalTo(bgImageBgView)
            
            make.size.equalTo(CGSize(width: imgWidth, height: imgHeight))
        }
        
        imgView.alpha = 0
        
        imgView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        RadiusToView(view: imgView, radius: imgHeight/2)
    }
    
}
