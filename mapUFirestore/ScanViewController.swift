//
//  ScanViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/5.
//

import UIKit
import AVFoundation


class ScanViewController: UIViewController, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate {

    
//    @IBOutlet weak var camView: UIView!
//    @IBOutlet weak var codeTextLabel: UILabel!
//    @IBOutlet weak var QRCodeString: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    var captureSession: AVCaptureSession?
    var previewLayer:AVCaptureVideoPreviewLayer?
    var frameView: UIView?
//    var qrCodeFrameView:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession?.addInput(input )
            
        } catch {
            
            print("no camera!!!")
        }
          captureSession?.startRunning()

          previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
          previewLayer?.frame = view.frame
          view.layer.addSublayer(previewLayer!)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
//        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
                
        messageLabel.isHidden = true
        view.bringSubviewToFront(messageLabel)
        
        frameView = UIView()
        
        if let detectView = frameView {
            
            detectView.layer.borderColor = UIColor.green.cgColor
            detectView.layer.borderWidth = 2.0
            view.addSubview(detectView)
            view.bringSubviewToFront(detectView)
            
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 {
            
            frameView?.frame = CGRect.zero
            messageLabel.isHidden = true
            
            return
            
        }
        
        if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
            
            if let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObj){
                frameView?.frame = barCodeObject.bounds
            
            }
            
            if let linkage = metadataObj.stringValue {
                
                messageLabel.isHidden = false
                messageLabel.text = linkage
            } else {
                
                messageLabel.text = "scanning"
            }
            
        }
    }
    
 
    
    
//    //掃QRCode的動作
//    func setQRCodeScan(){
//
//            //實體化一個AVCaptureSession物件
//            captureSession = AVCaptureSession()
//
//            //AVCaptureDevice可以抓到相機和其屬性
//            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {return}
//            let videoInput:AVCaptureDeviceInput
//            do {
//                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
//            }catch let error {
//                print(error)
//                return
//            }
//            if (captureSession?.canAddInput(videoInput) ?? false ){
//                captureSession?.addInput(videoInput)
//            }else{
//                return
//            }
//
//            //AVCaptureMetaDataOutput輸出影音資料，先實體化AVCaptureMetaDataOutput物件
//            let metaDataOutput = AVCaptureMetadataOutput()
//            if (captureSession?.canAddOutput(metaDataOutput) ?? false){
//                captureSession?.addOutput(metaDataOutput)
//
//                //關鍵！執行緒處理QRCode
//                metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//                //metadataOutput.metadataObjectTypes表示要處理哪些類型的資料，處理QRCODE
//                metaDataOutput.metadataObjectTypes = [.qr, .ean8 , .ean13 , .pdf417]
//
//            }else{
//                return
//            }
//
//            //用AVCaptureVideoPreviewLayer來呈現Session上的資料
//            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//            //顯示size
//        previewLayer?.videoGravity = .resizeAspectFill
//            //呈現在camView上面
//        previewLayer?.frame = camView.layer.frame
//            //加入畫面
//        view.layer.addSublayer(previewLayer!)
//            //開始影像擷取呈現鏡頭的畫面
//        captureSession?.startRunning()
//        }
//
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutputmetadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//
//        captureSession?.startRunning()
//
//            if let metadataObject = didOutputmetadataObjects.first{
//
//                //AVMetadataMachineReadableCodeObject是從OutPut擷取到barcode內容
//                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
//                //將讀取到的內容轉成string
//                guard let stringValue = readableObject.stringValue else {return}
//                //掃到QRCode後的震動提示
//                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//                //將string資料放到label元件上
//                codeTextLabel.text = stringValue
//                //存取QRcodeURL
//                QRCodeString.text = stringValue
//
//            }
//
//        }
//
//    //顯示scan Area window 框框
//    let size = 300
//    let sWidth = Int(view.frame.size.width)
//    let xPos = (sWidth/2)-(size/2)
//    let scanRect = CGRect(x: CGFloat(xPos), y: 100 , width: CGFloat(size) , height: CGFloat(size))
//    //設定scan Area window 框框
//    let scanAreaView = UIView()
//    scanAreaView.layer.borderColor = UIColor.gray.cgColor
//    scanAreaView.layer.borderWidth = 2
//    scanAreaView.frame = scanRect
//    view.addSubview(scanAreaView)
//    view.bringSubviewToFront(scanAreaView)
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
