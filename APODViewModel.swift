//
//  APODViewModel.swift
//  NASA_APOD
//
//  Created by Shrikrishna Thodsare on 15/12/25.
//

import Foundation

class APODViewModel {
    
    var apod: APOD?
    
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
   
    
    
    func fetchAPOD(for date: String?) {
        APIService.shared.fetchAPOD(date: date) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let apod):
                        self?.apod = apod
                        self?.onSuccess?()
                        
                    case .failure(let error):
                        self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
