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
    private var restaurantName: String = ""
    private let settingLocationView = SettingLocationView()
    
    private lazy var locationManager = CLLocationManager()
    
    private let resentSearchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "최근 검색 기록"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        return collectionView
    }()
    
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
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
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
        self.view.addSubview(resentSearchLabel)
        self.view.addSubview(collectionView)
        self.view.addSubview(cameraButton)
        
        settingLocationView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        resentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(settingLocationView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(resentSearchLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        collectionView.register(ResentSearchCell.self, forCellWithReuseIdentifier: ResentSearchCell.identifier)
        collectionView.alwaysBounceVertical = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
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
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(10)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }


    @objc private func cameraButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: false)
//        let resultViewController = ResultViewController()
//        self.navigationController?.pushViewController(resultViewController, animated: true)
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
    func generateText(image: UIImage) async throws -> String {
        let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: APIKey.default)
        
        let prompt = """
                    너는 사진을 보고 사진에 있는 식당 이름을 추출할 수 있는 지능적인 AI야.
                    
                    사진을 보고 간판에 있는 식당 이름을 추출해줘. 사진에 있는 글씨들 중에서
                    가장 큰 것을 찾으면 돼.
                    
                    1. 영어로 되어있다면 한글로 읽어줘.
                    2. 너의 답변에는 식당 이름 외에 다른 어떤 것도 포함시키지 말아줘.
                    3. 식당이름을 찾지 못하겠다면 '인식불가'라고 답변해줘.
                    """
        
        let response = try await model.generateContent(prompt, image)
        if let text = response.text {
            print("Gemini OCR - \(text)")
            DispatchQueue.main.async {
                //                    self.homeView.infoLabel.text = "상호명 : \(text)"
                self.restaurantName = text
            }
            return text
        } else {
            throw NSError(domain: "OCRError", code: -1, userInfo: [NSLocalizedDescriptionKey: "텍스트를 추출할 수 없습니다."])
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        guard let image else { return }
//        self.generateText(image: image)
//        self.visionRequest(image: image)
        
        Task {
            do {
                let extractedText = try await generateText(image: image)
                self.dismiss(animated: false) {
                    print(extractedText)
                    if extractedText == "인식불가" {
                        // MARK: 없으면 찾을 수 없습니다 알럿
                        let viewController = CustomAlertViewController(title: "식당을 찾을 수 없습니다.", greenColorButtonTitle: "취소", grayColorButtonTitle: "다시 촬영하기", customAlertType: .doneAndCancel, alertHeight: 200)
                        viewController.delegate = self
                        viewController.modalTransitionStyle = .crossDissolve
                        viewController.modalPresentationStyle = .overFullScreen
                        self.present(viewController, animated: false)
                    } else {
                        // MARK: 사진 촬영 후 식당 데이터가 있으면
                        let resultViewController = ResultViewController()
                        resultViewController.image = image
                        resultViewController.restaurantName = extractedText
                        self.navigationController?.pushViewController(resultViewController, animated: true)
                    }
                }
            } catch {
                print("에러 발생: \(error.localizedDescription)")
                self.dismiss(animated: false)
            }
        }
        
//        self.dismiss(animated: false) {
//            
//            if self.restaurantName != "" {
//                // MARK: 사진 촬영 후 식당 데이터가 있으면
//                let resultViewController = ResultViewController()
//                resultViewController.image = image
//                resultViewController.restaurantName = self.restaurantName
//                self.navigationController?.pushViewController(resultViewController, animated: true)
//            } else {
//                // MARK: 없으면 찾을 수 없습니다 알럿
//                let viewController = CustomAlertViewController(title: "식당을 찾을 수 없습니다.", greenColorButtonTitle: "취소", grayColorButtonTitle: "다시 촬영하기", customAlertType: .doneAndCancel, alertHeight: 200)
//                viewController.delegate = self
//                viewController.modalTransitionStyle = .crossDissolve
//                viewController.modalPresentationStyle = .overFullScreen
//                self.present(viewController, animated: false)
//            }
//        }
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResentSearchCell.identifier, for: indexPath) as! ResentSearchCell
        return cell
    }
    
    
}

extension ViewController: CustomAlertDelegate {
    func action() {
        
    }
    
    func exit() {
        
    }
}
