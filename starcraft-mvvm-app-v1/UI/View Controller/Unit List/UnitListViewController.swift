//
//  UnitListViewController.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class UnitListViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    
    var loadingService: LoadingService!
    var dialogueService: DialogueService!
    
    var navigation: UnitListNavigation?
    
    var viewModel: UnitListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTitle()
        setupTableView()
    }
    
    private func setupTitle() {
        title = "Select a Unit"
    }
    
    private func setupTableView() {
        tableView.register(UnitListCell.nib(), forCellReuseIdentifier: UnitListCell.reuseIdentifier())
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundColor = .lightGray
        
        tableView.reloadData()
    }
}

extension UnitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Dummy data
        // return viewModel.units.count
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UnitListCell.reuseIdentifier(), for: indexPath) as! UnitListCell
        // Dummy data
        // let unit = viewModel.units[indexPath.row]
        let unit = SCUnit(name: "Marine", hotkey: "A", unitType: "Biological", builtFrom: "Barracks", mineralCost: 50, gasCost: 0, supply: 1)
        let viewModel = UnitListCellViewModel(unit: unit)

        cell.update(with: viewModel)

        return cell
    }
}

extension UnitListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Dummy data
        // let unit = viewModel.units[indexPath.row]
        let unit = SCUnit(name: "Marine", hotkey: "A", unitType: "Biological", builtFrom: "Barracks", mineralCost: 50, gasCost: 0, supply: 1)
        
        navigation?.showUnitPage(with: unit)
    }
}

extension UnitListViewController: Storyboarded {
    static var storyboardName: String = "UnitList"
    static var storyboardId: String = "UnitListViewController"
}
