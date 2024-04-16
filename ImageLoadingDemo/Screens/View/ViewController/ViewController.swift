//
//  ViewController.swift
//  ImageLoadingDemo
//
//  Created by WhyQ on 15/04/24.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = NewsViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    private let spacing:CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout

    }

    func initViewModel() {
        viewModel.delegate = self
        viewModel.fetchUsers()
    }

}

extension ViewController: NewsServices {

    func reloadData() {
       self.collectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        cell.setupImage(data: viewModel.newsList[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numberOfItemsPerRow:CGFloat = 3
            let spacingBetweenCells:CGFloat = 5
            
            let totalSpacing = (3 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
            
            if let collection = self.collectionView{
                let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                return CGSize(width: width, height: width)
            }else{
                return CGSize(width: 0, height: 0)
            }
        }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.newsList[indexPath.row].coverageURL)
    }
}

