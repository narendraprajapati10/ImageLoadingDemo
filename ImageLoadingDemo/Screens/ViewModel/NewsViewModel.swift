//
//  NewsViewModel.swift
//  ImageLoadingDemo
//
//  Created by WhyQ on 15/04/24.
//

import Foundation

protocol NewsServices: AnyObject {
    func reloadData() // Data Binding - PROTOCOL (View and ViewModel Communication)
}

class NewsViewModel {

    var newsList: [NewsModel] = [] {
        didSet {
            self.delegate?.reloadData()
        }
    }
    private let manager = APIManager()
    weak var delegate: NewsServices?

    // @MainActor -> DispatchQueue.Main.async
    @MainActor func fetchUsers() {
        Task { 
            do {
                let newsResponseArray: [NewsModel] = try await manager.request(url: newsURL)
                    self.newsList = newsResponseArray
            }catch {
                print(error)
            }
        }

    }
}
