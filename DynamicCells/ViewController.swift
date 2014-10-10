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
    
    @IBOutlet weak var label: UITextView!
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var data:[String]
    var templateCell:TextViewCell?
    

    required init(coder aDecoder: NSCoder) {
        self.data = ["foo", "bar", "fish\nbang", "mary\nhad\na\nlittle\nlamb", "http://slashdot.org"]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.templateCell = self.tableView.dequeueReusableCellWithIdentifier("textViewCell") as? TextViewCell
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        if let template = self.templateCell {
            template.label.text = self.data[indexPath.row]
//            var frame = template.label.frame
//            let sz = template.label.contentSize
//            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: sz.height)
//            template.label.frame = frame
        //    h = template.systemLayoutSizeFittingSize(CGSize(width: self.view.frame.size.width, height: 70)).height
            h = template.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        }
        return h


    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("textViewCell", forIndexPath: indexPath) as TextViewCell
        cell.label.text = self.data[indexPath.row]
        return cell
    }
    

}

