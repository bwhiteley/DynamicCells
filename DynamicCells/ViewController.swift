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
        self.data = ["foo", "bar", "foo\nbar", "mary\nhad\na\nlittle\nlamb", "http://slashdot.org"]
        self.data += ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.frame
        self.labelTemplateCell = self.tableView.dequeueReusableCellWithIdentifier("labelCell") as? LabelCell
        self.textViewTemplateCell = self.tableView.dequeueReusableCellWithIdentifier("textViewCell") as? TextViewCell
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
                let text = NSAttributedString(string: self.data[indexPath.row])
                template.label.attributedText = text
                //template.layoutIfNeeded()
    //            var frame = template.label.frame
    //            let sz = template.label.contentSize
    //            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: sz.height)
    //            template.label.frame = frame
                //h = template.systemLayoutSizeFittingSize(CGSize(width: self.view.frame.size.width, height: 70)).height
//                println("label intrinsic: \(template.label.intrinsicContentSize())")
//                let size = template.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//                println("template vert constraints: \(template.label.constraintsAffectingLayoutForAxis(.Vertical) )")
//                println("template constraints: \(template.contentView.constraints())")
//                println("fitting size: \(size)")
//                println("template autoconstraints: \(template.label.translatesAutoresizingMaskIntoConstraints())")
                let hp:UILayoutPriority = 1000 // linker errors if we use the symbolic name UILayoutPriorityRequired
                let vp:UILayoutPriority = 50  // linker errors if we use the symbolic name UILayoutPriorityFittingSizeLevel
                h = template.contentView.jbw_systemLayoutSizeFittingSize(CGSize(width: self.view.frame.size.width, height: h), withHorizontalFittingPriority: hp, verticalFittingPriority: vp).height + 5
            }
        }
        else {
            if let template = self.textViewTemplateCell {
                let text = NSAttributedString(string: self.data[indexPath.row])
                template.textView.attributedText = text
                let hp:UILayoutPriority = 1000 // linker errors if we use the symbolic name UILayoutPriorityRequired
                let vp:UILayoutPriority = 50  // linker errors if we use the symbolic name UILayoutPriorityFittingSizeLevel
                let size = template.contentView.jbw_systemLayoutSizeFittingSize(CGSize(width: self.view.frame.size.width, height: h), withHorizontalFittingPriority: hp, verticalFittingPriority: vp)
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
            let text = NSAttributedString(string: self.data[indexPath.row])
            cell.label.attributedText = text

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("textViewCell", forIndexPath: indexPath) as TextViewCell
            let text = NSAttributedString(string: self.data[indexPath.row])
            cell.textView.attributedText = text

            return cell
        }
    }
    
    func viewCollection() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("collection") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

