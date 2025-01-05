//
//  ViewController.swift
//  Foodie
//
//  Created by heyji on 12/16/24.
//

import UIKit
import SnapKit
import AVFoundation
import VisionKit
import Vision
import GoogleGenerativeAI
import CoreLocation

final class ViewController: UIViewController {
    
    private let homeView = HomeView()
    private let settingLocationView = SettingLocationView()
    
    private lazy var locationManager = CLLocationManager()
    
//    let analyzer = ImageAnalyzer()
//    let interaction = ImageAnalysisInteraction()
    
//    var image: UIImage? {
//        didSet {
//            interaction.preferredInteractionTypes = []
//            interaction.analysis = nil
//            analyzeCurrentImage()
//        }
//    }
    
    private let cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 90 / 2
        button.backgroundColor = .lightGray
        button.tintColor = .black
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupNavigationBar()
//        print(ImageAnalyzer.isSupported) // 장치가 Live Text를 지원하는지 확인
        
        // 위치 권한 설정
        locationManager.delegate = self
        didChangeAuthorization()
        
    }
    
    private func setupView() {
        self.view.addSubview(settingLocationView)
        self.view.addSubview(cameraButton)
        
        settingLocationView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
            make.height.width.equalTo(90)
        }
        
        self.homeView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        self.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: nil)
        self.navigationItem.title = "맛잘알"
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func didChangeAuthorization() {
        switch self.locationManager.authorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print()
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    private func getAddress() {
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        let geocoder = CLGeocoder.init()
        
        let location = self.locationManager.location
        
        if location != nil {
            geocoder.reverseGeocodeLocation(location!) { placemarks, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let placemark = placemarks?.first {
                    var address: [String] = []
                    
                    if let administrativeArea = placemark.administrativeArea {
                        print("== [시/도] administrativeArea : \(administrativeArea)")  //서울특별시, 경기도
                        address.append(administrativeArea)
                    }
                    
                    if let locality = placemark.locality {
                        print("== [도시] locality : \(locality)") //서울특별시, 성남시, 수원시
                        address.append(locality)
                    }
                    
                    if let subLocality = placemark.subLocality {
                        print("== [추가 도시] subLocality : \(subLocality)") // 잠실동
                        address.append(subLocality)
                    }
                    
                    if let thoroughfare = placemark.thoroughfare {
                        print("== [상세주소] thoroughfare : \(thoroughfare)") // 올림픽로
                        address.append(thoroughfare)
                    }
                    
                    if let subThoroughfare = placemark.subThoroughfare {
                        print("== [추가 거리 정보] subThoroughfare : \(subThoroughfare)") // 272-13
                        address.append(subThoroughfare)
                    }
                    let addressString = address.reduce(into: " ") { result, element in
                        if !result.contains(element) {
                            result += " \(element)"
                        }
                    }
                    self.settingLocationView.settingLocationLabel.text = addressString
                    print("CLLocationManagerDelegate >> getAddress() - address : \(address)")  // 서울특별시 광진구 중곡동 272-13
                }
            }
        }
        
    }


    @objc private func cameraButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: false)
    }
    
//    func analyzeCurrentImage() {
//        if let image = imageView.image {
//            Task {
//                let configuration = ImageAnalyzer.Configuration([.text, .machineReadableCode])
//                do {
//                    let analysis = try await analyzer.analyze(image, configuration: configuration)
////                    if let analysis = analysis {
//                        interaction.analysis = analysis
//                        interaction.preferredInteractionTypes = .textSelection
////                    }
//                } catch {
//                    print()
//                }
//                
//            }
//        }
//    }
    
    // MARK: VisionKit을 이용한 OCR
    func visionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else { return }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: "\n")
            print("Vision OCR - \(text)")
        }
        
        let revision3 = VNRecognizeTextRequestRevision3
        request.revision = revision3
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        request.usesLanguageCorrection = true
        
//        print(try! request.supportedRecognitionLanguages())
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    // MARK: Gemini를 이용한 OCR
    func generateText(image: UIImage) {
        Task {
            let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: APIKey.default)
            
            let prompt = "이미지에서 제일 크게 보이는 텍스트만 추출해주고, 따로 덧붙이는 말은 하지마."
            
            let response = try await model.generateContent(prompt, image)
            if let text = response.text {
                print("Gemini OCR - \(text)")
                DispatchQueue.main.async {
                    self.homeView.infoLabel.text = "상호명 : \(text)"
                }
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.homeView.imageView.image = image
        
        guard let image else { return }
        self.visionRequest(image: image)
        self.generateText(image: image)
        
        // 사진 촬영 후 식당 데이터가 있으면
//        let resultViewController = ResultViewController()
//        self.navigationController?.pushViewController(resultViewController, animated: true)
        // 없으면 찾을 수 없습니다 알럿
        
        self.dismiss(animated: false)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getAddress()
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
}
