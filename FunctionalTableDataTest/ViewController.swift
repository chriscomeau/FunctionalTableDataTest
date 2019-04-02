//
//  ViewController.swift
//  FunctionalTableDataTest
//
//  Created by Chris Comeau on 2019-02-15.
//  Copyright © 2019 Skyriser Media. All rights reserved.
//

import UIKit
import FunctionalTableData

class ViewController: UIViewController {

  private let functionalData = FunctionalTableData()
  private var items: [String] = [] {
    didSet {
      render()
    }
  }
  private var tableView: UITableView!
  private let cellId = "Cell"

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //tint
    navigationController?.navigationBar.tintColor = UIColor.appTintColor
    
    title = "FunctionalTableDataTest"
    
    //setup view
    view.backgroundColor = UIColor.white
    
    //nav
    navigationController?.setNavigationBarHidden(false, animated: false)
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionNew(sender:)))
    self.navigationItem.rightBarButtonItem = button

    //setup table
    tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    view.addSubview(tableView)
    
    //tabledata
    functionalData.tableView = tableView
    
    //test data
    items = ["Cell 1", "Cell 2"]

    //autolayout
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      ])
  }
}

extension ViewController {
  
  @objc func actionNew(sender: UIBarButtonItem) {
    //add
    let count = items.count
    items.append("Cell \(count + 1)")
  }
}

extension ViewController {
  
  private func render() {
    print("*** render")

    let rows: [CellConfigType] = items.enumerated().map { index, item in
      return LabelCell(
        key: "id-\(index)",
        style: CellStyle(backgroundColor: .clear),
        actions: CellActions(
          selectionAction: { _ in
            print("\(item) selected")
            return .selected
        },
          deselectionAction: { _ in
            print("\(item) deselected")
            return .deselected
        }),
        state: LabelState(text: item),
        cellUpdater: LabelState.updateView)
    }
    
    let section = TableSection(key: "section", rows: rows)

    functionalData.renderAndDiff([section])
  }
}
