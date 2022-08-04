//
//  HomeTableDataSource.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/4/22.
//

import UIKit

class HomeTableDataSource: NSObject, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath)
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
  
}
