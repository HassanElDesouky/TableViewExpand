//
//  ViewController.swift
//  TableViewExpand
//
//  Created by Hassan El Desouky on 1/3/20.
//  Copyright © 2020 Hassan El Desouky. All rights reserved.
//

import UIKit


struct ZoomTransitionManager {
  var cardView: UIView
  var cardViewFrame: CGRect
}

class ViewController: UIViewController {
  
  var zoomTransitionManager: ZoomTransitionManager!

  let colors = [UIColor.SUNSET_ORANGE, UIColor.SUNGLOW,
                UIColor.YELLOW_GREEN, UIColor.CYAN_CORNFLOWER_BLUE,
                UIColor.DARK_LAVENDER]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }

  private func setupTableView() {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ColorfulTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  private func handleNextViewController( from row: Int) {
    let vc = DetailsViewController()
    vc.delegate = self
    vc.selectedRow = row
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    present(vc, animated: true, completion: nil)
  }
}

extension ViewController: DetailsViewControllerDelegate {
  func didGoBack() {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.zoomTransitionManager.cardView.frame = self.zoomTransitionManager.cardViewFrame
      self.zoomTransitionManager.cardView.layer.cornerRadius = 12.0
    }) { (shrinked) in
      self.zoomTransitionManager.cardView.removeFromSuperview()
    }
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ColorfulTableViewCell
    cell.cardView.backgroundColor = colors[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? ColorfulTableViewCell else { return }
    let cardFrame = cell.cardView.superview?.convert(cell.cardView.frame, to: nil)
    let cardView = UIView(frame: cardFrame!)
    cardView.layer.cornerRadius = 12
    cardView.backgroundColor = colors[indexPath.row]
    view.addSubview(cardView)
    
    zoomTransitionManager = ZoomTransitionManager(cardView: cardView, cardViewFrame: cardFrame!)
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      cardView.layer.cornerRadius = 0
      cardView.frame = self.view.frame
    }) { (expanded) in
      self.handleNextViewController(from: indexPath.row)
    }
  }
}
