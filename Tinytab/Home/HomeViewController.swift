//
//  HomeViewController.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import UIKit
import EFQRCode

class HomeViewController: UIViewController {
  
  let qrSize: CGFloat = UIScreen.main.bounds.width / .infinity
  var dataSource: HomeTableDataSource
  
  var tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.translatesAutoresizingMaskIntoConstraints = false
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
    setup()
  }
  
  private func setup() {
    configureTableView()
    configureRightBarButton()
    applyLayouts()
  }
  
  private func configureTableView() {
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeTableCell")
  }
  
  private func configureRightBarButton() {
    let image = UIImage(systemName: "qrcode")
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(rightBarButtonTapped(_:)))
  }
  
  @objc private func rightBarButtonTapped(_ sender: UIBarButtonItem) {
    print("Tapped")
    createQRCode(for: "https://sandbox.square.link/u/VVIYwNG8", with: nil)
  }
  
  func createQRCode(for url: String, with watermark: CGImage?) {
    if let image = EFQRCode.generate(for: url,
                                     watermark: watermark,
                                     iconSize: EFIntSize(size: CGSize(width: qrSize, height: qrSize))) {
      presentQRCode(image)
    } else {
      print("Error generating code")
    }
  }
  
  func presentQRCode(_ codeImage: CGImage) {
    let viewController = UIViewController()
    let imageView = UIImageView(image: UIImage(cgImage: codeImage))
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    viewController.view.addSubview(imageView)
    viewController.view.backgroundColor = .primaryBackground
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
      imageView.heightAnchor.constraint(equalToConstant: qrSize),
      imageView.widthAnchor.constraint(equalToConstant: qrSize),
    ])
    
    present(viewController, animated: true)
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
  
  
}

extension HomeViewController {
  
  func applyLayouts() {
    layoutTable()
  }
  
  func layoutTable() {
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
}
