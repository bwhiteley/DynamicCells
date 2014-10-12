//
//  ViewController.swift
//  DynamicCells
//
//  Created by Bart Whiteley on 10/9/14.
//  Copyright (c) 2014 Bart Whiteley. All rights reserved.
//

import UIKit


class LabelCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
}

class TextViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var data:[String]
    var labelTemplateCell:LabelCell?
    var textViewTemplateCell:TextViewCell?
    

    required init(coder aDecoder: NSCoder) {
        self.data = ["foo", "bar", "fish\nbang", "mary\nhad\na\nlittle\nlamb", "http://slashdot.org"]
        self.data += ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.frame
        self.labelTemplateCell = self.tableView.dequeueReusableCellWithIdentifier("labelCell") as? LabelCell
        self.textViewTemplateCell = self.tableView.dequeueReusableCellWithIdentifier("textViewCell") as? TextViewCell
        if let contentView = self.textViewTemplateCell?.contentView {
            let constraint = NSLayoutConstraint(item: contentView, attribute:.Width, relatedBy:.Equal, toItem: nil, attribute:.NotAnAttribute, multiplier: 1, constant: self.view.frame.size.width)
            contentView.addConstraint(constraint)
        }
        if let contentView = self.labelTemplateCell?.contentView {
            let constraint = NSLayoutConstraint(item: contentView, attribute:.Width, relatedBy:.Equal, toItem: nil, attribute:.NotAnAttribute, multiplier: 1, constant: self.view.frame.size.width)
            contentView.addConstraint(constraint)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = "TableView"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CollectionView", style: .Plain, target: self, action: "viewCollection")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var h:CGFloat = 44
        if (indexPath.section == 0) {
            if let template = self.labelTemplateCell {
                let text = self.data[indexPath.row]
                template.label.text = text
                //template.layoutIfNeeded()
    //            var frame = template.label.frame
    //            let sz = template.label.contentSize
    //            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: sz.height)
    //            template.label.frame = frame
                //h = template.systemLayoutSizeFittingSize(CGSize(width: self.view.frame.size.width, height: 70)).height
                println("label intrinsic: \(template.label.intrinsicContentSize())")
                let size = template.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
                println("template vert constraints: \(template.label.constraintsAffectingLayoutForAxis(.Vertical) )")
                println("template constraints: \(template.contentView.constraints())")
                println("fitting size: \(size)")
                println("template autoconstraints: \(template.label.translatesAutoresizingMaskIntoConstraints())")
                h = template.contentView.jbw_systemLayoutSizeFittingSize(CGSize(width: self.view.frame.size.width, height: h)).height + 5
            }
        }
        else {
            if let template = self.textViewTemplateCell {
                let text = self.data[indexPath.row]
                template.textView.text = text
                let size = template.contentView.jbw_systemLayoutSizeFittingSize(CGSize(width: self.view.frame.size.width, height: h))
                h = size.height + 5
            }
        }
        return h


    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("labelCell", forIndexPath: indexPath) as LabelCell
            cell.label.text = self.data[indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("textViewCell", forIndexPath: indexPath) as TextViewCell
            cell.textView.text = self.data[indexPath.row]
            return cell
        }
    }
    
    func viewCollection() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("collection") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

