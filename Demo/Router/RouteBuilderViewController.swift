//
//  RouteBuilderViewController.swift
//  Router
//
//  Created by Dsee.Lab on 2021/2/19.
//  Copyright © 2021 iAllenC. All rights reserved.
//

import UIKit
import SwiftyURLRouter

class RouteBuilderViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BuilderDemo"
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        table.estimatedRowHeight = 66
    }
    

}

extension RouteBuilderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "RouteBuilder_\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            Route {
                Scheme("router")
                Module("module_a")
                Query(key: "value", value: "passed_value(module_a)")
            }
        case 1:
            Route {
                Scheme("router")
                Module("module_a")
                Module("module_a_sub1")
                Query(key: "value", value: "passed_value(module_a_sub1)")
            }
        case 2:
            Route {
                Scheme("router")
                Module("module_b")
                Query(key: "value", value: "passed_value(module_b)")
                Parameter(key: "image", value: UIImage(named: "image"))
                Callback {
                    guard let message = $0 as? String else { return }
                    Route {
                        Scheme("router")
                        Module("module_tool")
                        Module("alert")
                        Query(key: "title", value: "Alert from Route")
                        Query(key: "message", value: message)
                        Query(key: "sure", value: "确定")
                    }
                }
            }
        default:
            break
        }
    }

}
