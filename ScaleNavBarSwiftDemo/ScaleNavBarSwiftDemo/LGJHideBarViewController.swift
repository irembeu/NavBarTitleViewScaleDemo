//
//  LGJHideBarViewController.swift
//  ScaleNavBarSwiftDemo
//
//  Created by 劉光軍 on 16/4/27.
//

import UIKit

class LGJHideBarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTableView()
        
        // Do any additional setup after loading the view.
    }

    //MARK:-tableView
    func createTableView() -> () {
        
        if (tableView == nil) {
            tableView = UITableView(frame: UIScreen .mainScreen().bounds, style: .Plain)
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.backgroundColor = UIColor.whiteColor()
            tableView?.separatorStyle = .SingleLine
            self.view.addSubview(tableView!)
        }
        
    }
    
    
    //MARK:-tableView代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "myCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
        }
        cell?.backgroundColor = randomColor()
        return cell!
    }
    
    func randomColor() -> UIColor {
        
        let r = CGFloat(arc4random() % 255)
        let g = CGFloat(arc4random() % 255)
        let b = CGFloat(arc4random() % 255)
        
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetY:CGFloat = scrollView.contentOffset.y + (tableView?.contentInset.top)!
        let panTranslationY = scrollView.panGestureRecognizer.translationInView(tableView).y
        print("panTranslationY", panTranslationY);
        
        if offsetY > 0 {
            if panTranslationY > 0 {
                //下滑趋势 显示
                [self.navigationController?.setNavigationBarHidden(false, animated: true)]
            } else {
                //上滑趋势 隐藏
                [self.navigationController?.setNavigationBarHidden(true, animated: true)]
            }
        } else {
            [self.navigationController?.setNavigationBarHidden(false, animated: true)]
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
