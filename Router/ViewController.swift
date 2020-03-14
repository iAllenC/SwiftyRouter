//
//  ViewController.swift
//  Router
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Router"
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        table.rowHeight = 66
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "route-router://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 1:
            cell.textLabel?.text = "route-router://moduleA/moduleA_sub1?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 2:
            cell.textLabel?.text = "route-router://moduleA/moduleA_sub2?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 3:
            cell.textLabel?.text = "route-router://moduleB,parameter: \(["value": "passed_value(\(indexPath.section)-\(indexPath.row))"]))"
        case 4:
            cell.textLabel?.text = "fetch-router://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 5:
            cell.textLabel?.text = "route-router://moduleC"
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            Route("router://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))")
        case 1:
            Route("router://moduleA/moduleA_sub1?value=passed_value(\(indexPath.section)-\(indexPath.row))")
        case 2:
            Route("router://moduleA/moduleA_sub2?value=passed_value(\(indexPath.section)-\(indexPath.row))")
        case 3:
            Route("router://moduleB", parameter: ["value": "passed_value(\(indexPath.section)-\(indexPath.row))"])
        case 4:
            if let avc = Fetch("router://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))") as? UIViewController {
                self.present(avc, animated: true, completion: nil)
            }
        case 5:
            Route("router://moduleC")
        default:
            break
        }
    }

}
