//
//  ViewController.swift
//  ScaleNavBarSwiftDemo
//
//  Created by 劉光軍 on 16/4/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView?
    var topImageView:UIImageView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTableView()
        
        createScaleHeadView()
        
        createNavButton()
        
        // Do any additional setup after loading the view, typically from a nib.
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
    
    //MARK:-headView
    func createScaleHeadView() -> Void {
        
        let headBackView:UIView = UIView(frame: CGRectMake(0, 0, 60, 30))
        headBackView.backgroundColor = UIColor.clearColor()
        topImageView = UIImageView(frame: CGRectMake(0, 0, 60, 60))
        topImageView?.backgroundColor = UIColor.whiteColor()
        topImageView?.layer.cornerRadius = (topImageView?.bounds.size.width)! / 2
        topImageView?.layer.masksToBounds = true
        topImageView?.image = UIImage(named: "head")
        headBackView.addSubview(topImageView!)
        
        self.navigationItem.titleView = headBackView
    }
    
    //MARK:-navigationBarButton
    func createNavButton() -> Void {
        
        let leftNavBtn = UIBarButtonItem(title: "HideNavBar", style: .Done, target: self, action: #selector(ViewController.hideNavBtnClick))
        self.navigationItem.leftBarButtonItem = leftNavBtn
        
        let rignhtNavBtn = UIBarButtonItem(title: "NextPage", style: .Done, target: self, action: #selector(ViewController.nextBtnClick))
        self.navigationItem.rightBarButtonItem = rignhtNavBtn
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
    //滑动代理方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetY:CGFloat = scrollView.contentOffset.y + (tableView?.contentInset.top)!
        print("offsetY = %f contentOffset.y = %f contentInset.top = %f", offsetY, scrollView.contentOffset.y, tableView?.contentInset.top)
        if offsetY < 0 && offsetY >= -150 {
            topImageView?.transform = CGAffineTransformMakeScale(1 - offsetY/300, 1 - offsetY/300)
        } else if (offsetY >= 0 && offsetY <= 150) {
            topImageView?.transform = CGAffineTransformMakeScale(1 - offsetY/300, 1 - offsetY/300)
        } else if (offsetY > 150) {
            topImageView?.transform = CGAffineTransformMakeScale(0.45, 0.45)
        } else if(offsetY < -150) {
            topImageView?.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }
        var frame:CGRect = (topImageView?.frame)!
        frame.origin.y = 5;
        topImageView?.frame = frame
        
    }
    
    //MARK:-ButtonClickMethod
    func hideNavBtnClick() -> () {
        
        let hideVC = LGJHideBarViewController()
        self.navigationController?.pushViewController(hideVC, animated: true)
    }
    
    func nextBtnClick() -> () {
        
        let transparentBarVC = LGJTransparentBarVC()
        transparentBarVC.myAlphaClosure = {(a: String) in
            
            let alertView:UIAlertView = UIAlertView(title: a , message: "No message", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()

        }
        
        self.navigationController?.pushViewController(transparentBarVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

