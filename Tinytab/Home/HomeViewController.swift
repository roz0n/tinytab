//
//  HomeViewController.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import UIKit

class HomeViewController: UIViewController {
  
  var dataSource: HomeTableDataSource
  
  var tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .grouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.backgroundColor = .systemBlue
    return table
  }()
  
  convenience init() {
    self.init(dataSource: HomeTableDataSource())
  }
  
  init(dataSource: HomeTableDataSource) {
    self.dataSource = dataSource
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray
  }
  
  private func setup() {
    configureTableView()
  }
  
  private func configureTableView() {
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeTableCell")
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
  
  
}
