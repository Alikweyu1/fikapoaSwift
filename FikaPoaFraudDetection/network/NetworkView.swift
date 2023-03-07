//
//  NetworkView.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 04/03/2023.
//

import UIKit

class NetworkView: UIView{
    let progressView = UIProgressView(progressViewStyle: .default)
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    func setUpView(){
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 20 )
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            //label.leadingAnchor.constraint(equalTo: leadingAnchor),
            //label.trailingAnchor.constraint(equalTo: trailingAnchor),
            //label.topAnchor.constraint(equalTo: progressView.bottomAnchor,constant: 4),
            //label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
       
        backgroundColor = .systemRed
        alpha = 0
        
    }
    func setProgress(_ progress:Float,animated:Bool){
        progressView.setProgress(progress, animated: animated)
        if progress == 1{
            hide()
        }
        else{
            show()
        }
    }
    func showMessage(_ message:String){
        label.text = message
        show()
    }
    
    func hide(){
        UIView.animate(withDuration: 0.3){
            self.alpha = 0
        }
    }
    
    func show(){
        guard alpha == 0 else{return}
        UIView.animate(withDuration: 0.3){
            self.alpha = 1
        }
    }
}
