//
//  PAMediaManager.swift
//  PasicCash
//
//  Created by apple on 2024/7/5.
//

import UIKit
import AVFoundation
import Photos

class PAMediaManager: NSObject {
    
    static let shared = PAMediaManager()
    
    private override init() {
        super.init()
    }
    
    func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .restricted, .denied:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    func checkPhotoLibraryPermissions(completion: @escaping (Bool) -> Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized, .limited:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized)
                }
            }
        case .restricted, .denied:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    func presentCamera(from viewController: UIViewController) {
        checkCameraPermissions { [weak self] granted in
            guard granted else {
                self?.showSettingsAlert(from: viewController, for: "相机")
                return
            }
            self?.showImagePicker(from: viewController, sourceType: .camera)
        }
    }
    
    func presentPhotoLibrary(from viewController: UIViewController) {
        checkPhotoLibraryPermissions { [weak self] granted in
            guard granted else {
                self?.showSettingsAlert(from: viewController, for: "相册")
                return
            }
            self?.showImagePicker(from: viewController, sourceType: .photoLibrary)
        }
    }
    
    private func showImagePicker(from viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    private func showSettingsAlert(from viewController: UIViewController, for feature: String) {
        let alert = UIAlertController(
            title: "\(feature) 权限已关闭",
            message: "请在设置中启用 \(feature) 权限以使用此功能。",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "设置", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
