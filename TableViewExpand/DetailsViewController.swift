//
//  DetailsViewController.swift
//  TableViewExpand
//
//  Created by Hassan El Desouky on 1/3/20.
//  Copyright © 2020 Hassan El Desouky. All rights reserved.
//

import UIKit

protocol DetailsViewControllerDelegate: class {
  func didGoBack()
}

class DetailsViewController: UIViewController {

  var selectedRow = 0

  weak var delegate: DetailsViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    setup()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleBackAction(_ :)))
    view.addGestureRecognizer(tap)
  }
  
  @objc private func handleBackAction(_ sender: UITapGestureRecognizer) {
    guard let delegate = delegate else { return }
    delegate.didGoBack()
    dismiss(animated: true, completion: nil)
  }
  
  private func setup() {
    let lbl = UILabel()
    lbl.numberOfLines = 0
    lbl.font = .boldSystemFont(ofSize: 40)
    lbl.textColor = .white
    lbl.textAlignment = .center
    lbl.text = "zoomed\nfrom row\n\(selectedRow)"
    lbl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(lbl)
    NSLayoutConstraint.activate([
      lbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
      lbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
      lbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64.0),
      lbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
    ])
  }
}
