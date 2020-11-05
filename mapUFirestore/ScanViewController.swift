//
//  ScanViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/5.
//

import UIKit
import AVFoundation


class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var camView: UIView!
    
    
    var captureSession:AVCaptureSession?
    var PreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
              
        
        
    }
    
    
    //掃QRCode的動作
    func setQRCodeScan(){
            
            //實體化一個AVCaptureSession物件
            captureSesion = AVCaptureSession()
            
            //AVCaptureDevice可以抓到相機和其屬性
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {return}
            let videoInput:AVCaptureDeviceInput
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            }catch let error {
                print(error)
                return
            }
            if (captureSesion?.canAddInput(videoInput) ?? false ){
                captureSesion?.addInput(videoInput)
            }else{
                return
            }
            
            //AVCaptureMetaDataOutput輸出影音資料，先實體化AVCaptureMetaDataOutput物件
            let metaDataOutput = AVCaptureMetadataOutput()
            if (captureSesion?.canAddOutput(metaDataOutput) ?? false){
                captureSesion?.addOutput(metaDataOutput)
                
                //關鍵！執行緒處理QRCode
                metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                //metadataOutput.metadataObjectTypes表示要處理哪些類型的資料，處理QRCODE
                metaDataOutput.metadataObjectTypes = [.qr, .ean8 , .ean13 , .pdf417]
                
            }else{
                return
            }
            
            //用AVCaptureVideoPreviewLayer來呈現Session上的資料
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSesion!)
            //顯示size
            previewLayer.videoGravity = .resizeAspectFill
            //呈現在camView上面
            previewLayer.frame = camView.layer.frame
            //加入畫面
            view.layer.addSublayer(previewLayer)
            //開始影像擷取呈現鏡頭的畫面
            captureSesion?.startRunning()
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
