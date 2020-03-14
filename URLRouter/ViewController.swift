//
//  ViewController.swift
//  URLRouter
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit
import URLRouter

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "URLRouter"
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
            cell.textLabel?.text = "route-urlrouter://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 1:
            cell.textLabel?.text = "route-urlrouter://moduleA/moduleA_sub1?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 2:
            cell.textLabel?.text = "route-urlrouter://moduleA/moduleA_sub2?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 3:
            cell.textLabel?.text = "route-urlrouter://moduleB,parameter: \(["value": "passed_value(\(indexPath.section)-\(indexPath.row))"]))"
        case 4:
            cell.textLabel?.text = "fetch-urlrouter://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))"
        case 5:
            cell.textLabel?.text = "route-urlrouter://moduleC"
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            Route("urlrouter://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))")
        case 1:
            Route("urlrouter://moduleA/moduleA_sub1?value=passed_value(\(indexPath.section)-\(indexPath.row))")
        case 2:
            Route("urlrouter://moduleA/moduleA_sub2?value=passed_value(\(indexPath.section)-\(indexPath.row))")
        case 3:
            Route("urlrouter://moduleB", parameter: ["value": "passed_value(\(indexPath.section)-\(indexPath.row))"])
        case 4:
            if let avc = Fetch("urlrouter://moduleA/?value=passed_value(\(indexPath.section)-\(indexPath.row))") as? UIViewController {
                self.present(avc, animated: true, completion: nil)
            }
        case 5:
            Route("urlrouter://moduleC")
        default:
            break
        }
    }

}
