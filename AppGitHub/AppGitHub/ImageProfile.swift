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
    
    func createPhoto(with url: String?, handlerSuccess:((_ image: UIImage?)->Void)?, handlerError:((_ description: ServerError)->Void)?) {
        
        removeChilds()
        createActivityView()
        
        requestImage.loadImage(url) { (response) in
            
            switch response {
            case .success(let model):
                guard let handlerSuccess = handlerSuccess else { return }
                handlerSuccess(model)
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
                self.createPhoto(with: url, handlerSuccess: handlerSuccess, handlerError: handlerError)
            case .invalidResponse:
                fatalError("Response invalido")
            }
        }
    }
    
    fileprivate func createActivityView()
    {
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
    
    fileprivate func removeChilds()
    {
        for view in self.subviews
        { view.removeFromSuperview() }
    }
}
