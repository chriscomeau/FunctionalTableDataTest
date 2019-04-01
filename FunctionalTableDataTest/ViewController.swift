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
    
    //tableView.dataSource = self
    tableView.delegate = self
    
    //tabledata
    functionalData.tableView = tableView
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //reloadData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
}

extension ViewController {
  
  @objc func actionNew(sender: UIBarButtonItem) {
    //add
    let count = items.count
    items.append("Cell \(count + 1)")
    
    //reload
    //reloadData()
    
    //vibrate
    //Utils.haptic1()
    
    
    /*
     let dateFormatter : DateFormatter = DateFormatter()
     //dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
     dateFormatter.dateFormat = "HH:mm:ss"
     let date = Date()
     let dateString = dateFormatter.string(from: date)
     
     let item = ToDoItem()
     item.title = "test (\(dateString))"
     appDelegate!.data.insert(item, at: 0)
     
     appDelegate!.savePrefs()
     
     reload()
     */
  }
  
  /*func reloadData() {
    self.tableView.reloadData()
  }*/
}

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}

extension ViewController: UIScrollViewDelegate {
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //vibrate
    //Haptics.hapticScroll()
    
  }
}

/*
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
        return UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
      }
      return cell
    }()
    
    cell.textLabel?.text = ""
    cell.detailTextLabel?.text = ""
    //cell.detailTextLabel?.textColor = UIColor.subtitleColor
    
    
    let row = items[indexPath.row]
      
    cell.textLabel?.text = row
    
    //cell.detailTextLabel?.text = "-"
  
    
    return cell
  }
  
}
*/

extension ViewController {
  
  private func render() {
    print("*** render")

    let rows: [CellConfigType] = items.enumerated().map { index, item in
      return LabelCell(
        key: "id-\(index)",
        style: CellStyle(backgroundColor: .white),
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
    
    functionalData.renderAndDiff([
      TableSection(key: "section", rows: rows)
      ])
  }

}
