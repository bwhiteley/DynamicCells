//
//  CollectionViewController.swift
//  DynamicCells
//
//  Created by Bart Whiteley on 10/9/14.
//  Copyright (c) 2014 Bart Whiteley. All rights reserved.
//


class LabelCCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!

}

class TextViewCCell: UICollectionViewCell {
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.scrollEnabled = false
        textView.dataDetectorTypes = .Link
        textView.userInteractionEnabled = true
        textView.editable = false
    }
}


import UIKit

let labelReuseIdentifier = "labelCell"
let textViewReuseIdentifier = "textViewCell"

class CollectionViewController: UICollectionViewController {
    
    var data:[String]
    
    var labelTemplate:LabelCCell?
    var textViewTemplate:TextViewCCell?
    
    required init(coder aDecoder: NSCoder) {
        self.data = ["foo", "bar", "foo\nbar", "mary\nhad\na\nlittle\nlamb", "http://slashdot.org"]
        self.data += ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."]
  super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelTemplate = self.collectionView.dequeueReusableCellWithReuseIdentifier(labelReuseIdentifier, forIndexPath: nil) as? LabelCCell
        self.textViewTemplate = self.collectionView.dequeueReusableCellWithReuseIdentifier(textViewReuseIdentifier, forIndexPath: nil) as? TextViewCCell

        self.title = "CollectionView"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let ident = indexPath.section == 0 ? labelReuseIdentifier: textViewReuseIdentifier
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ident, forIndexPath: indexPath) as UICollectionViewCell
    
        if (indexPath.section == 0) {
            let sell = cell as LabelCCell
            sell.label.text = self.data[indexPath.row]
        }
        else {
            let sell = cell as TextViewCCell
            sell.textView.text = self.data[indexPath.row]
        }
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var sz = CGSize(width: self.view.frame.size.width, height: 50)
        
        if (indexPath.section == 0) {
            if let template = self.labelTemplate {
                template.label.text = self.data[indexPath.row]
                let hp:UILayoutPriority = 1000 // linker errors if we use the symbolic name UILayoutPriorityRequired
                let vp:UILayoutPriority = 50  // linker errors if we use the symbolic name UILayoutPriorityFittingSizeLevel
                sz.height = template.contentView.jbw_systemLayoutSizeFittingSize(sz, withHorizontalFittingPriority: hp, verticalFittingPriority: vp).height
                //println("template vert constraints: \(template.constraintsAffectingLayoutForAxis(.Vertical) )")
            }
        }
        else {
            if let template = self.textViewTemplate {
                template.textView.text = self.data[indexPath.row]
                let hp:UILayoutPriority = 1000 // linker errors if we use the symbolic name UILayoutPriorityRequired
                let vp:UILayoutPriority = 50  // linker errors if we use the symbolic name UILayoutPriorityFittingSizeLevel
                sz.height = template.contentView.jbw_systemLayoutSizeFittingSize(sz, withHorizontalFittingPriority: hp, verticalFittingPriority: vp).height + 5
                //println("template vert constraints: \(template.constraintsAffectingLayoutForAxis(.Vertical) )")
            }
        }
        
        return sz
            
        
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
