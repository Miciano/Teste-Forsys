//
//  ImageProfile.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import UIKit

class ImageProfile: UIView, ConstraintsProtocol {
    
    lazy var requestImage = {
        return RequestImageService()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createActivityView()
        createCircleImage()
    }
    
    func createPhoto(with url: String?, handlerError:((_ description: ServerError)->Void)?) {
        
        removeChilds()
        createActivityView()
        
        requestImage.loadImage(url) { (response) in
            
            switch response {
            case .success(let model):
                self.insertPhoto(model)
            case .serverErro(let description):
                guard let handlerError = handlerError else { return }
                handlerError(description)
            case .missingURL(let description):
                guard let handlerError = handlerError else { return }
                handlerError(description)
            case .timeOut(let description):
                guard let handlerError = handlerError else { return }
                handlerError(description)
            case .noConnection(let description):
                guard let handlerError = handlerError else { return }
                handlerError(description)
            case .downloadCanceled( _):
                self.createPhoto(with: url, handlerError: handlerError)
            case .invalidResponse:
                fatalError("Response invalido")
            }
        }
    }
    
    fileprivate func createActivityView()
    {
        self.backgroundColor = UIColor.lightGray
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        self.addSubview(activity)
        activity.startAnimating()
        addConstraints(activity, toItem: self, attributes: [.centerX, .centerY], constants: [0,0])
    }
    
    fileprivate func createCircleImage()
    {
        //verifica se tem uma constraint de largura
        let constraintWidth = self.constraints.filter { (constraint) -> Bool in
            return constraint.firstAttribute == .width ? true : false
        }
        
        //Se tiver constraint usa ela para o calculo de arredondamento, se nao usa o tamanho do frame
        self.layer.cornerRadius =  constraintWidth.count > 0 ? constraintWidth[0].constant * 0.5  : self.frame.size.width * 0.5
        self.clipsToBounds = true
    }
    
    fileprivate func insertPhoto(_ image:UIImage?)
    {
        removeActivityView()
        
        let imageView = UIImageView(image: image)
        self.insertSubview(imageView, at: 0)
        addConstraints(imageView, toItem: self, attributes: [.top, .leading, .trailing, .bottom], constants: [0,0,0,0])
    }
    
    
    fileprivate func removeChilds()
    {
        for view in self.subviews
        { view.removeFromSuperview() }
    }
    
    fileprivate func removeActivityView() {
        
        
        self.backgroundColor = UIColor.clear
        let activity = self.subviews.filter { $0 is UIActivityIndicatorView }
        activity.first?.removeFromSuperview()
    }
}
