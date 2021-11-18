//
//  ViewController.swift
//  HeaderImageAutoAnimation
//
//  Created by YZ-LXH on 2021/11/11.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var listTableView: UITableView = {
        
        let listTableView = UITableView.init(frame: view.bounds, style: .plain)
        
        listTableView.delegate = self
        
        listTableView.dataSource = self
        
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(listTableView)
        
        return listTableView
        
    }()
    
    let dataArrays = ["点赞头像动画","光圈式头像动画"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listTableView.isHidden = false
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = dataArrays[indexPath.row]
        
        cell.textLabel?.textColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(CollapseAnimationVC(), animated: true)
        default:
            navigationController?.pushViewController(DynamicDisplayHideHeaderVC(), animated: true)
        }
        
    }
}
