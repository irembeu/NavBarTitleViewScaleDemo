//
//  LGJTransparentBarVC.swift
//  ScaleNavBarSwiftDemo
//
//  Created by 劉光軍 on 16/4/27.
//

import UIKit


//闭包
typealias AlphaClosure = (String)->Void

class LGJTransparentBarVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var myAlphaClosure:AlphaClosure?
    
    var tableView:UITableView?
    var topImageView:UIImageView?
    let topContentInset:CGFloat = 100
    var statusBarStyleControl:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        statusBarStyleControl = false
        
        createTableView()

        createScaleImageView()
        
        createHeadView()
        
        // Do any additional setup after loading the view.
    }
        
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (myAlphaClosure != nil) {
            myAlphaClosure!("hhahha")
        }
    }
    
    
    //MARK:-tableView
    func createTableView() -> () {
        
        if (tableView == nil) {
            tableView = UITableView(frame: UIScreen .mainScreen().bounds, style: .Plain)
            tableView?.contentInset = UIEdgeInsetsMake(topContentInset, 0, 0, 0)
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.backgroundColor = UIColor.clearColor()
            tableView?.separatorStyle = .SingleLine
            self.view.addSubview(tableView!)
        }
        
    }
    

    //MARK:-创建顶部背景视图
    func createScaleImageView() -> Void {
        
        topImageView = UIImageView(frame: CGRectMake(0, 0, UIScreen .mainScreen().bounds.width, UIScreen .mainScreen().bounds.width*435.5/313.0))
        topImageView?.backgroundColor = UIColor.whiteColor()
        topImageView?.image = UIImage(named: "backImage")
        self.view.insertSubview(topImageView!, belowSubview: tableView!)
    }
    
    
    
    //MARK:-创建头像视图
    func createHeadView() -> Void {
        
//        topContentInset = 136;//136+64 = 200
        let headBkView:UIView = UIView(frame: CGRectMake(0, 0, UIScreen .mainScreen().bounds.width, topContentInset))
        headBkView.backgroundColor = UIColor.clearColor()
        tableView?.tableHeaderView = headBkView
        
        let headImageView = UIImageView()
        headImageView.bounds = CGRectMake(0, 0, 64, 64)
        headImageView.center = CGPointMake(UIScreen .mainScreen().bounds.width/2.0, (topContentInset - 64)/2.0)
        headImageView.backgroundColor = UIColor.whiteColor()
        headImageView.layer.cornerRadius = headImageView.bounds.size.width / 2.0
        headImageView.layer.masksToBounds = true
        headImageView.image = UIImage(named: "head")
        headBkView.addSubview(headImageView)
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
    
    //MARK:-滑动代理
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y + (tableView?.contentInset.top)!
        
        print("\(offsetY)")
        
        if offsetY > topContentInset && offsetY <= topContentInset*2 {
            
            statusBarStyleControl = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
            
        }
        else if (offsetY <= topContentInset && offsetY >= 0) {
            
            statusBarStyleControl = false
            if (self.respondsToSelector(#selector(UIViewController.setNeedsStatusBarAppearanceUpdate))) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
        }
        else if offsetY > topContentInset * 2 {

            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
            
        }
        else if offsetY < 0 {
            topImageView?.transform = CGAffineTransformMakeScale(1 + offsetY/(-500), 1 + offsetY/(-500))
        }
        var frame:CGRect = (topImageView?.frame)!
        frame.origin.y = 0
        topImageView?.frame = frame
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
