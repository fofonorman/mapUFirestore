//
//  ViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/10/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var GenQRcode: UIButton!
    @IBOutlet weak var QRCodePic: UIImageView!
    @IBOutlet weak var URLInput: UITextField!
    var qrcodeImage: CIImage!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
   

    }


    @IBAction func genQRCodeBtn(_ sender: UIButton) {
        
        if qrcodeImage == nil {
                if URLInput.text == "" {
                    URLInput.text = "Please input URL"
                }
        }
        
        let data = URLInput.text!.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)

                let filter = CIFilter(name: "CIQRCodeGenerator")

                filter?.setValue(data, forKey: "inputMessage")
                filter?.setValue("Q", forKey: "inputCorrectionLevel")

        qrcodeImage = filter?.outputImage
        QRCodePic.image = UIImage(ciImage: qrcodeImage)

        URLInput.resignFirstResponder()
    }
    
    
}

