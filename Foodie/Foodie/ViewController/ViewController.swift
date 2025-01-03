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

final class ViewController: UIViewController {
    
    private let homeView = HomeView()
    private let settingLocationView = SettingLocationView()
    
//    let analyzer = ImageAnalyzer()
//    let interaction = ImageAnalysisInteraction()
    
//    var image: UIImage? {
//        didSet {
//            interaction.preferredInteractionTypes = []
//            interaction.analysis = nil
//            analyzeCurrentImage()
//        }
//    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupNavigationBar()
//        print(ImageAnalyzer.isSupported) // 장치가 Live Text를 지원하는지 확인
        
    }
    
    private func setupView() {
        self.view.addSubview(settingLocationView)
        settingLocationView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        self.homeView.cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: nil)
        self.navigationItem.title = "맛잘알"
        self.navigationController?.navigationBar.tintColor = .black
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
        
        self.dismiss(animated: false)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false)
    }
}
