//
//  ResultViewController.swift
//  Foodie
//
//  Created by heyji on 1/5/25.
//

import UIKit
import SnapKit

final class ResultViewController: UIViewController {
    
    private let resultView = ResultView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.view.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}
