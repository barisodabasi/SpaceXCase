//
//  ViewController.swift
//  SpaceXLaunchCase
//
//  Created by BarisOdabasi on 7.02.2022.
//

import UIKit
import Kingfisher

class LaunchViewController: UIViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    
    //MARK: - Properties
    var networkModel = [NetworkLaunchModel]()
    var spinner: UIActivityIndicatorView?
    var spinnerContainer: UIView?
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      getLaunchData()
    }
    
    //MARK: - Functions
    func getLaunchData() {
    DispatchQueue.main.async { [self] in
        showIndicator()
        NetworkLaunchResponse.getLaunch { result, error in
            hideIndicator()
            if error == nil {
                self.networkModel.append(result!)
                self.updateUI()
                print("NetworkModel: \(self.networkModel)")
            }
        }
    }
}
    
    func updateUI() {
            let x = networkModel[0].links?.patch?.large
                imageView.kf.setImage(with: x)
            let model = networkModel[0]
            
            nameLabel.text = model.name?.uppercased()
            flightNumberLabel.text = String(model.flight_number!)
        
        if model.success == true {
                successLabel.text = "Successful"
            } else {
                successLabel.text = "Fail"
            }
            
        if model.details == nil {
                detailsLabel.text = "Details Not Found."
            } else {
                detailsLabel.text = model.details
            }
    }
    
    func showIndicator(){
        spinnerContainer = UIView.init(frame: self.view.frame)
        spinnerContainer!.center = self.view.center
        spinnerContainer!.backgroundColor = .init(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        self.view.addSubview(spinnerContainer!)
        
        spinner = UIActivityIndicatorView.init(style: .large)
        spinner!.center = spinnerContainer!.center
        spinner?.color = .white
        spinnerContainer!.addSubview(spinner!)
        
        spinner!.startAnimating()
    }
    
    func hideIndicator(){
        spinner?.removeFromSuperview()
        spinnerContainer?.removeFromSuperview()
    }
}

