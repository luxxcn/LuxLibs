//
//  XXPopoverMenu.swift
//  BillMaster2
//
//  Created by 星 鲁 on 2017/4/4.
//  Copyright © 2017年 xxing. All rights reserved.
//

import UIKit

class XXPopoverAction: NSObject {
    
    let title:String
    let tag:Int
    let action:Selector?
    let target:Any?
    
    init(title:String, tag: Int, target:Any?, action: Selector?) {
        
        self.title = title
        self.tag = tag
        self.action = action
        self.target = target
    }
    
    func performAction() {
        
        if (target != nil) && ((target as? NSObject)?.responds(to: action))! {
            
            (target as! NSObject).performSelector(onMainThread: action!, with: self, waitUntilDone: true)
        }
    }
}

class XXPopoverMenu: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var sourceController:UIViewController?
    var menus:[XXPopoverAction]?
    
    init(with sourceViewController: UIViewController) {
        super.init(style: .plain)
        
        tableView.separatorInset.left = 15
        tableView.separatorInset.right = 15
        //tableView.selection
        
        sourceController = sourceViewController
        self.modalPresentationStyle = .popover
        let popover = self.popoverPresentationController
        self.preferredContentSize = CGSize(width: 100, height: 150)
        popover?.permittedArrowDirections = .up
        popover?.delegate = self
        popover?.sourceView = sourceViewController.view
        popover?.sourceRect = CGRect(x: self.view.frame.width - 10, y: 5, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func show() {
        
        self.sourceController?.present(self, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate methods
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.menus == nil ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.menus == nil ? 0 : (self.menus?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        let menu = self.menus?[indexPath.row]
        // Configure the cell...
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightUltraLight)
        cell.textLabel?.text = menu?.title
        cell.tag = (menu?.tag)!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menu = self.menus?[indexPath.row]
        menu?.performAction()
        self.dismiss(animated: true, completion: nil)
    }

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
