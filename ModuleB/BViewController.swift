//
//  BViewController.swift
//  URLHandler
//
//  Created by iAllenC on 2020/3/12.
//  Copyright © 2020 iAllenC. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    var value: String?

    @IBOutlet weak var valueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        valueLabel.text = value
        title = "BVC"
    }

    @IBAction func btnAction(_ sender: UIButton) {
        if let navi = navigationController {
            navi.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
