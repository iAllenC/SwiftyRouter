//
//  ViewController.swift
//  URLRouter
//
//  Created by Dsee.Lab on 2020/3/13.
//  Copyright © 2020 Dsee.Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        table.rowHeight = 44
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section)" + "-" + "\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let module = indexPath.row % 2 == 0 ? "moduleA" : "moduleB"
        if indexPath.row < 3 {
            Route(URL(string: "urlrouter://\(module)/?value=fuck(\(indexPath.section)-\(indexPath.row))")!)
        } else {
            if let vc = Fetch(URL(string: "urlrouter://\(module)/?value=fuck(\(indexPath.section)-\(indexPath.row))")!) {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

}
