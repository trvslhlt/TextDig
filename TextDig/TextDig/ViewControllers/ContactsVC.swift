//
//  ContactsVC.swift
//  TextDig
//
//  Created by trvslhlt on 1/24/15.
//  Copyright (c) 2015 travis holt. All rights reserved.
//

import UIKit

class ContactsVC: TDVC, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView! { didSet {
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)} }
  let cellReuseID = "cell"
  var contacts: [Contact] { get{ return self.dao.contacts } }
  
  required init() {
    super.init(nibName: "ContactsVC", bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: UITableViewDataCource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as UITableViewCell
    
    let contact = contacts[indexPath.row]
    cell.textLabel?.text = contact.firstName
    cell.detailTextLabel?.text = contact.uniqueID
    
    return cell
  }
  
}












