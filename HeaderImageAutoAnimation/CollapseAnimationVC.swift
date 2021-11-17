//
//  CollapseAnimationVC.swift
//  HeaderImageAutoAnimation
//
//  Created by YZ-LXH on 2021/11/11.
//

import UIKit
import SnapKit
import Kingfisher

private let defaultFourImageTag = 20000

private let defaultImageTag = 10000

private let generalDuration = 0.25

class CollapseAnimationVC: UIViewController {
    
    var currentIndex = 5
    
    lazy var headerImagesArrays = ["https://t7.baidu.com/it/u=1732966997,2981886582&fm=193&f=GIF","https://t7.baidu.com/it/u=1785207335,3397162108&fm=193&f=GIF","https://t7.baidu.com/it/u=2581522032,2615939966&fm=193&f=GIF","https://t7.baidu.com/it/u=245883932,1750720125&fm=193&f=GIF","https://t7.baidu.com/it/u=3423293041,3900166648&fm=193&f=GIF"]
    
    
    lazy var headerInfoArrays = [["id":"1","url":"https://t7.baidu.com/it/u=1732966997,2981886582&fm=193&f=GIF"],["id":"2","url":"https://t7.baidu.com/it/u=1785207335,3397162108&fm=193&f=GIF"],["id":"3","url":"https://t7.baidu.com/it/u=2581522032,2615939966&fm=193&f=GIF"],["id":"4","url":"https://t7.baidu.com/it/u=245883932,1750720125&fm=193&f=GIF"],["id":"5","url":"https://t7.baidu.com/it/u=3423293041,3900166648&fm=193&f=GIF"]]
  
    lazy var praisedImageBgView: UIView = {
        
        let praisedImageBgView = UIView()
        
        view.addSubview(praisedImageBgView)
        
        return praisedImageBgView
        
    }()
    
    lazy var praiseBtn: UIButton = {
        
        let praiseBtn = UIButton()
        
        praiseBtn.backgroundColor = .red
        
        praiseBtn.setTitle("点赞", for: .normal)
        
        praiseBtn.addTarget(self, action: #selector(praiseAction), for: .touchUpInside)
        
        view.addSubview(praiseBtn)
        
        return praiseBtn
        
    }()

    lazy var listTableView: UITableView = {
        
        let listTableView = UITableView.init(frame: .zero, style: .plain)
        
        listTableView.delegate = self
        
        listTableView.dataSource = self
        
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(listTableView)
        
        return listTableView
        
    }()
    
    @objc private func praiseAction() {
        
        currentIndex += 1
        
        let random = arc4random_uniform(5)
        
        let dict = ["id":"\(currentIndex)","url":headerImagesArrays[Int(random)]]

        headerInfoArrays.insert(dict, at: 0)
        
        listTableView.reloadData()
        
        listViewHeadImageAnimation()
    }
    
    private var userId = "3"

    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.backgroundColor = .white
        
        praisedImagesSetup()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let btnWidth:CGFloat = GKPage_Screen_Width - 40
        
        praisedImageBgView.snp_makeConstraints { make in
            
            make.top.equalTo(view).offset(100)
            
            make.left.equalTo(view).offset(20)
            
            make.right.equalTo(view).offset(-20)
            
            make.height.equalTo(50)
        }
        
        praiseBtn.snp_makeConstraints { make in
            
            make.top.equalTo(praisedImageBgView.snp_bottom).offset(20)
            
            make.left.equalTo(view).offset(20)
            
            make.width.equalTo(btnWidth)
            
            make.height.equalTo(50)
        }

        listTableView.snp_makeConstraints { make in
            
            make.left.right.bottom.equalTo(view)
            
            make.top.equalTo(praiseBtn.snp_bottom).offset(20)
        }
    }
    
        private func praisedImagesSetup() {
            
            praisedImageBgView.subviews.forEach { $0.removeFromSuperview() }

            let headImgArrays = headerInfoArrays.map { $0["url"] }

            let userIdArrays = headerInfoArrays.map { $0["id"] }

            let tempIndexCount = headImgArrays.count

            let imgWidth = 20

            let iconSpace: Int = imgWidth / 2

            var finalIconSpace:CGFloat = 0

            for index in 0..<tempIndexCount {

                let imgView = CommunityHeadSubImageView()
                
                imgView.kf.setImage(urlString: headImgArrays[index])

                imgView.contentMode = .scaleAspectFill

                imgView.tag = (tempIndexCount - index) + defaultFourImageTag

                imgView.userIdString = userIdArrays[index]

                praisedImageBgView.addSubview(imgView)

                imgView.snp_remakeConstraints { make in

                    finalIconSpace = CGFloat(iconSpace * index)
                    
                    make.left.equalTo(praisedImageBgView).offset(finalIconSpace)
                    
                    make.centerY.equalTo(praisedImageBgView)
                    
                    make.size.equalTo(CGSize(width: imgWidth, height: imgWidth))
                }

                BorderRadiusToView(view: imgView, radius: CGFloat(iconSpace), width: 1, color: .white)
            }
        }
    
    //列表页头像动画
    private func listViewHeadImageAnimation(isFabulous: Bool = true) {

        let headImgArrays = headerInfoArrays.map { $0["url"] }

        let userIdArrays = headerInfoArrays.map { $0["id"] }

        let imgWidth = 20

        let iconSpace: CGFloat = CGFloat(imgWidth / 2)

        var tagNumbers = [Int]()

        praisedImageBgView.subviews.forEach {
            
            if $0 is CommunityHeadSubImageView {
                
                tagNumbers.append($0.tag)
            }
        }
        
        let maxTag = tagNumbers.max() ?? defaultFourImageTag
        
        let minTag = tagNumbers.min() ?? defaultFourImageTag

        if isFabulous {

            let lastImageViewTag = maxTag + 1

            let imgView = CommunityHeadSubImageView()
            
            imgView.kf.setImage(urlString: headImgArrays[0])

            imgView.contentMode = .scaleAspectFill

            imgView.tag = lastImageViewTag

            imgView.userIdString = userIdArrays[0]

            praisedImageBgView.insertSubview(imgView, at: 0)
            
            imgView.snp_remakeConstraints { make in

                make.left.centerY.equalTo(praisedImageBgView)
                
                make.size.equalTo(CGSize(width: imgWidth, height: imgWidth))
            }

            BorderRadiusToView(view: imgView, radius: CGFloat(imgWidth / 2), width: 1, color: .white)

            imgView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)

            UIView.animate(withDuration: generalDuration, animations: { [weak self] in
                
                self?.praisedImageBgView.subviews.forEach {
                    
                    if $0 is CommunityHeadSubImageView {
                        
                        $0.transform = CGAffineTransform(translationX: iconSpace, y: 0).concatenating($0.transform)
                    }
                }

                imgView.transform = CGAffineTransform(scaleX: 1, y: 1)

            }) { finished in

            }

        }else{

            var currentNeedRemoveTag = -defaultImageTag
            
            praisedImageBgView.subviews.forEach {
                
                if $0 is CommunityHeadSubImageView {
                    
                    if ($0 as! CommunityHeadSubImageView).userIdString == userId {
                        
                        currentNeedRemoveTag = $0.tag
                    }
                }
            }
            
            switch currentNeedRemoveTag {
            case -defaultImageTag:
                print("未曾点赞过")
            case maxTag://最左
                UIView.animate(withDuration: generalDuration, animations: { [weak self] in
                    
                    self?.praisedImageBgView.subviews.forEach {
                        
                        if $0 is CommunityHeadSubImageView {
                            
                            $0.transform = CGAffineTransform(translationX: -iconSpace, y: 0).concatenating($0.transform)
                        }
                    }
                }) { [weak self] finished in

                    if let mostLeftImageV = self?.praisedImageBgView.viewWithTag(maxTag) {

                        mostLeftImageV.removeFromSuperview()
                    }
                    
                    self?.reloadListTableView()
                }
            case minTag://最右
                if let mostLeftImageV = self.praisedImageBgView.viewWithTag(currentNeedRemoveTag) {

                    UIView.animate(withDuration: generalDuration) {
                        
                        mostLeftImageV.transform = CGAffineTransform(translationX: -iconSpace, y: 0).concatenating(mostLeftImageV.transform)
                        
                    } completion: { [weak self] finished in
                        
                        mostLeftImageV.removeFromSuperview()
                        self?.reloadListTableView()
                    }
                }
            default://中间
                if let mostLeftImageV = self.praisedImageBgView.viewWithTag(currentNeedRemoveTag) {
                    
                    UIView.animate(withDuration: generalDuration, animations: { [weak self] in
                        
                        self?.praisedImageBgView.subviews.forEach {
                            
                            if $0 is CommunityHeadSubImageView {

                                if $0.tag <= currentNeedRemoveTag {

                                    $0.transform = CGAffineTransform(translationX: -iconSpace, y: 0).concatenating($0.transform)
                                }
                            }
                        }
                    
                    }) { [weak self] finished in
                        
                        mostLeftImageV.removeFromSuperview()

                        self?.reloadListTableView()
                    }

                }
            }
        }
    }
    
    private func reloadListTableView() {
        
        for (index,value) in headerInfoArrays.enumerated() {
            
            if value["id"] == userId {
                
                headerInfoArrays.remove(at: index)
                
                break
            }
        }
        
        listTableView.reloadData()
    }
}

extension CollapseAnimationVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        headerInfoArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userIdArrays = headerInfoArrays.map { $0["id"] }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "取消点赞:\(userIdArrays[indexPath.row] ?? "")"
        
        cell.textLabel?.textColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userIdArrays = headerInfoArrays.map { $0["id"] }
        
        userId = userIdArrays[indexPath.row] ?? ""
        
        listViewHeadImageAnimation(isFabulous: false)
    }
}


//MARK: Kingfisher
extension Kingfisher where Base: ImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "ic_mine_head_teachingassist")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeholder,
                        options:[.transition(.fade(0.5))])
    }
}

class CommunityHeadSubImageView: UIImageView {
    
    var userIdString:String?
}
