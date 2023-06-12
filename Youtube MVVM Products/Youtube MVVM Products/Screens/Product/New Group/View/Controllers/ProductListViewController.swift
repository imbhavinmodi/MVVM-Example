//
//  ProductListViewController.swift
//  Youtube MVVM Products
//
//  Created by Bhavin's on 07/06/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var productTableView: UITableView!
    
    // MARK: - Variables
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
}

extension ProductListViewController {
    
    func configuration() {
        productTableView.dataSource = self
        productTableView.delegate = self
        
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProduct()
    }
    
    // Data Binding event observe yaha karega - (communication)
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                // Show indicator
                print("Product loading....")
            case .stopLoading:
                // Hide indicator
                print("Product loading....")
            case .dataLoaded:
                print("Product loading....")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
                break
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}
