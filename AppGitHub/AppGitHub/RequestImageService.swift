//
//  RequestImageService.swift
//  AppGitHub
//
//  Created by Fabio Miciano on 15/02/17.
//  Copyright © 2017 Fabio Miciano. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class RequestImageService {
    
    init() {
        //Seto os tipos de imagem que serão feitas os downloads
        Alamofire.DataRequest.addAcceptableImageContentTypes(["image/jpg", "image/png", "image/jpeg"])
    }
    
    //Função faz o download de imagem por url ou carrega a imagem que está em cache
    func loadImage(_ url: String?, completion:@escaping (_ response: ImageResponse)-> Void) {
        
        //Faço unwrap da url
        guard let url = url, url != "",
            let urlRequest = URL(string: url) else {
                let erro = ServerError(statusCode: 100, description: "URL Vazia")
                completion(.missingURL(description: erro))
                return
        }
        
        let imgView = UIImageView()
        //Faço o request da imagem passando uma url e faço seus tratamentos de erro e sucesso
        imgView.af_setImage(withURL: urlRequest, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false) { (response) in
            
            switch response.result
            {
            case .success(let value):
                completion(.success(model: value))
            case .failure(let error):
                switch error._code {
                case -1009:
                    let erro = ServerError(statusCode: -1009, description: "Sem conexão com a internet no momento")
                    completion(.noConnection(description: erro))
                case -1001:
                    let erro = ServerError(statusCode: -1001, description: "TimeOut, atualize a tela")
                    completion(.timeOut(description: erro))
                case -999, 0:
                    let erro = ServerError(statusCode: error._code, description: response.result.error.debugDescription)
                    completion(.downloadCanceled(description: erro))
                default:
                    completion(.invalidResponse)
                }
            }
        }
    }
}
