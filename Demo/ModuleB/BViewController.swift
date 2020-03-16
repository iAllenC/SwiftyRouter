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
    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BVC"
        valueLabel.text = value
        imageView.image = image
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
