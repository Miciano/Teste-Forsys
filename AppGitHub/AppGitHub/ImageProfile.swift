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
    
    //Função faz o request para carregar a imagem
    func createPhoto(with url: String?, handlerError:((_ description: ServerError)->Void)?) {
        
        //Removo todos os filhos da View
        removeChilds()
        //Crio o activityView para mostrar para usuário que está em processo de load
        createActivityView()
        
        //Faço o request e seus tratamentos de erro
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
    
    //PRAGMA MARK: -- FUNÇÕES PRIVADAS --
    //Função cria um activityView para mostrar para usuário que a imagem está em processo de load
    fileprivate func createActivityView()
    {
        //Mudo a cor do background
        self.backgroundColor = UIColor.lightGray
        //Crio o activityView setando o seu estilo para branco
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        self.addSubview(activity)
        activity.startAnimating()
        //Adiciono constraints nele para que ele fique centralizado na celula
        addConstraints(activity, toItem: self, attributes: [.centerX, .centerY], constants: [0,0])
    }
    
    //Função faz com que a View fique circular
    fileprivate func createCircleImage()
    {
        //Verifica se tem uma constraint de largura
        let constraintWidth = self.constraints.filter { (constraint) -> Bool in
            return constraint.firstAttribute == .width ? true : false
        }
        
        //Se tiver constraint usa ela para o calculo de arredondamento, se nao usa o tamanho do frame
        self.layer.cornerRadius =  constraintWidth.count > 0 ? constraintWidth[0].constant * 0.5  : self.frame.size.width * 0.5
        self.clipsToBounds = true
    }
    
    //Função insere a foto na View
    fileprivate func insertPhoto(_ image:UIImage?)
    {
        //Removo o ActivityView
        removeActivityView()
        
        let imageView = UIImageView(image: image)
        //Insiro a imagem como primeiro filho da view
        self.insertSubview(imageView, at: 0)
        //Adiciono constraints pra que a imagem fique do mesmo tamanho da view
        addConstraints(imageView, toItem: self, attributes: [.top, .leading, .trailing, .bottom], constants: [0,0,0,0])
    }
    
    //Função remove todos os vilhos da View
    fileprivate func removeChilds()
    {
        for view in self.subviews
        { view.removeFromSuperview() }
    }
    
    //Função remove o activity View
    fileprivate func removeActivityView() {
        
        //Mudo a cor do backgorund para transparente
        self.backgroundColor = UIColor.clear
        let activity = self.subviews.filter { $0 is UIActivityIndicatorView }
        activity.first?.removeFromSuperview()
    }
}
