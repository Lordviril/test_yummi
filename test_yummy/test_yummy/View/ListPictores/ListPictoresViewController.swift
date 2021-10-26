//
//  ListPictoresViewController.swift
//  test_yummy
//
//  Created by Pedro Alonso Daza B on 6/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

import UIKit

class ListPictoresViewController: UIViewController {

    
    @IBOutlet weak var dateSelectedView: DateSelectedView!
    @IBOutlet weak var apodCollectionView: UICollectionView!
    
    var listPictoresViewModel: ListPictoresViewModel?
    var nasaPictores = [NASAPictore]()
    var nasaPictore: NASAPictore?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        dateSelectedView.delegate = self
        
        listPictoresViewModel = ListPictoresViewModel(informationHealthyLifeViewToViewModel: self)
        listPictoresViewModel?.getListLastPictores(controller: self, dateInit: Date())
        self.tabBarController?.tabBar.isHidden = true
        
        apodCollectionView.delegate = self
        apodCollectionView.dataSource = self

        apodCollectionView.register(UINib(nibName: Constants.APOD_CELL, bundle: nil), forCellWithReuseIdentifier: ApodCollectionViewCell.identifier)
        
        dateSelectedView.textList = listPictoresViewModel?.getLastTenDates().textList ?? []
        dateSelectedView.loadViews()
    }

    @IBAction func openDatePickerPressed(_ sender: UIButton) {
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SHOW_DETAIL{
            if let detailPictoreViewController = segue.destination as? DetailPictoreViewController {
                detailPictoreViewController.nasaPictore = self.nasaPictore
            }
        }
    }
    // MARK: - Actions
    @IBAction func showDatePicker(_ sender: UIButton) {

    }
}
// MARK: - CollectionView
extension ListPictoresViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nasaPictores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApodCollectionViewCell.identifier, for: indexPath) as? ApodCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(nasaPictore: nasaPictores[indexPath.row])
        //cell.productToshow = productsForCollectionView[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.nasaPictore = self.nasaPictores[indexPath.row]
        performSegue(withIdentifier: Constants.SHOW_DETAIL, sender: nil)
    }
    
    
}

// MARK: -UICollectionViewDelegateFlowLayout
extension ListPictoresViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (apodCollectionView.frame.width / 2) - 18
        
        return CGSize(width: itemSize, height: 200)

    }
}
// MARK: - ListPictoresViewModel
extension ListPictoresViewController: InformationHealthyLifeViewToViewModel {
    func succesGetListPictores(nasaPictores: [NASAPictore]) {
        self.nasaPictores = nasaPictores
        apodCollectionView.reloadData()
        
    }
    
    func succesGetPictores(nasaPictore: NASAPictore) {
        self.nasaPictore = nasaPictore
        performSegue(withIdentifier: Constants.SHOW_DETAIL, sender: nil)
        
    }
    
    func showError(error: String) {
        shoeAlertWithMessagge(controller: self, messagge: error)
    }
    
    
}

// MARK: - DateSelectedViewDelegate
extension ListPictoresViewController: DateSelectedViewDelegate {
    func dateSelectedView(didSelectIndex index: Int, text: String) {
        listPictoresViewModel?.getListLastPictores(controller: self, dateInit: listPictoresViewModel?.getLastTenDates().dates[index] ?? Date())
    }
    
    
}
