//
//  ProfileMenuViewController.swift
//  Fusion
//
//  Created by Mohammad Irteza Khan on 8/13/17.
//  Copyright © 2017 Mohammad Irteza Khan. All rights reserved.
//

import UIKit

class ProfileMenuViewController: UITableViewController {
    
    let menuItem = ["Watchlist", "Log out"]
    
//    override init(style: UITableViewStyle) {
//        super.init(style: style)
////        NSInteger rowsCount = [_colorNames count];
////        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
////            heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
////        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
////
////        //Calculate how wide the view should be by finding how
////        //wide each string is expected to be
////        CGFloat largestLabelWidth = 0;
////        for (NSString *colorName in _colorNames) {
////            //Checks size of text using the default font for UITableViewCell's textLabel.
////            CGSize labelSize = [colorName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
////            if (labelSize.width > largestLabelWidth) {
////                largestLabelWidth = labelSize.width;
////            }
////        }
////
////        //Add a little padding to the width
////        CGFloat popoverWidth = largestLabelWidth + 100;
////
////        //Set the property to tell the popover container how big this view will be.
////        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
////
////        let rowsCount = menuItem.count
////        let popoverWidth = 200
////        self.popover
//        //Calculate how wide the view should be by finding how
//        //wide each string is expected to be
//        
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItem.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
