//
//  ViewController.swift
//  Router
//
//  Created by iAllenC on 2020/3/13.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit
import SwiftyURLRouter

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var urls: [(String, String, RouteParameter?)] = [
        ("Route","router://module_a/?value=passed_value(module_a)", nil),//this routes to a first level layer
        ("Route","router://module_a/module_a_sub1?value=passed_value(module_a_sub1)", nil),//this routes to a second level layer
        ("Route","router://module_a/module_a_sub2?value=passed_value(module_a_sub2)", nil),//this routes to a second level layer
        ("Route","router://module_a/module_a_sub1/module_a_sub1_sub1?value=passed_value(module_a_sub1_sub1)", nil), //this routes to a third level layer
        ("Route","router://module_b/?value=passed_value(module_b)", ["image": UIImage(named: "image")]),//this routes to a VC with parameter that are hard to transfer to the target
        ("Fetch","router://module_a/?value=passed_value(module_a)", nil),//this fetches a VC(or other result)
        ("Route","router://module_c", nil),//this routes to a OC VC(but the Router should be a swift)
        ("Route","router://module_tool/alert/?title=Alert from Route&message=This is an alert from Route&sure=确定", nil)//this routes to a custom action(alert)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Router"
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        table.estimatedRowHeight = 66
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = urls[indexPath.row].0 + "(" + urls[indexPath.row].1 + ")"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlTuple = urls[indexPath.row]
        if urlTuple.0 == "Route" {
            Route(urlTuple.1, parameter: urlTuple.2)
        } else {
            if let vc = Fetch(urlTuple.1) as? UIViewController {
                Transfer.present(vc, animated: true, completion: nil)
            }
        }
    }

}
