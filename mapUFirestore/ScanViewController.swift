//
//  ScanViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/5.
//

import UIKit
import AVFoundation


class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession:AVCaptureSession?
    var PreviewLayer:AVCaptureVideoPreviewLayer?
    var camWindow:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return}
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                        
        }catch let error {
            print(error)
            return
        }
        
        if captureSession?.canAddInput(videoInput) ?? false {
            captureSession?.addInput(videoInput)
        }else{
            return
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
