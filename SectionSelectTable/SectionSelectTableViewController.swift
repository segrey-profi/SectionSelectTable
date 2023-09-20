//
//  HighlightableTableViewCell.swift
//  SectionSelectTable
//
//  Created by Sergey Markin on 28.04.2018.
//  Copyright © 2018 Profi.RU. All rights reserved.
//

import UIKit

private struct TableSection {
    
    let rows: [String]
    
}

class SectionSelectTableViewController: UITableViewController {
    
    private let model: [TableSection] = [
        TableSection(rows: [
            "A",
            "B",
            "C",
            "D",
            "E",
            "F"
            ]),
        TableSection(rows: [
            "V",
            "W",
            "X",
            "Y",
            "Z"
            ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParentViewController {
            print("\(self) IS MOVING FROM PARENT")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParentViewController {
            print("\(self) HAS MOVED FROM PARENT")
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
        if parent == nil {
            print("NOW \(self) HAS REALLY MOVED FROM PARENT")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HighlightableTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.text = model[indexPath.section].rows[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showFoo", sender: nil)
    }
    
}

extension SectionSelectTableViewController: MyTableViewCellDelegate {
    
    func didToggle(highlighted: Bool, animated: Bool, in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        for rowIndex in self.model[indexPath.section].rows.indices {
            let pathToSelect: IndexPath = [indexPath.section, rowIndex]
            if highlighted {
                tableView.selectRow(at: pathToSelect, animated: animated, scrollPosition: .none)
            }
            else {
                tableView.deselectRow(at: pathToSelect, animated: animated)
            }
        }
    }
    
}

extension UITableView {
    
    func dequeueReusableCell<C: UITableViewCell>(for indexPath: IndexPath) -> C {
        let cellId = String(describing: C.self)
        let cell: UITableViewCell = dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell as! C
    }
    
}
