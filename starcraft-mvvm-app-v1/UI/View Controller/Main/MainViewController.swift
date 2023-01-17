//
//  MainViewController.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 09/01/2023.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    
    weak var navigation: MainNavigation?
    
    var loadingService: Loadable?
    var dialogueService: Dialogued?
    
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleState()
        fetchAllUnits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func fetchAllUnits() {
        Task {
            await viewModel.fetchAllUnits()
        }
    }
    
    private func setupUI() {
        setupTitle()
        setupTableView()
    }
    
    private func setupTitle() {
        title = "Select a Building"
    }
    
    private func setupTableView() {
        tableView.register(MainCell.nib(), forCellReuseIdentifier: MainCell.reuseIdentifier())
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundColor = .lightGray
        
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.buildingData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.reuseIdentifier(), for: indexPath) as! MainCell
        
        let buildingData = viewModel.buildingData()[indexPath.row]
        let cellViewModel = MainCellViewModel(buildingData: buildingData)
        
        cell.update(with: cellViewModel)
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buildingData = viewModel.buildingData()[indexPath.row]
        
        switch buildingData.type {
        case .barracks:
            navigation?.showUnitListPage(with: viewModel.barracksUnits)
            break
        case .factory:
            navigation?.showUnitListPage(with: viewModel.factoryUnits)
            break
        case .starport:
            navigation?.showUnitListPage(with: viewModel.starportUnits)
            break
        case .none:
            break
        }
    }
}

extension MainViewController {
    private func handleState() {
        viewModel.$loadingState.sink { [weak self] state in
            switch state {
            case .idle:
                self?.view.alpha = 0.0
                break
            case .loading:
                self?.view.alpha = 0.3
                self?.loadingService?.showLoading(on: self!)
                break
            case .loaded:
                self?.view.alpha = 1.0
                self?.loadingService?.hideLoading(on: self!, completion: nil)
                break
            case .failed(let error):
                self?.view.alpha = 0.0
                self?.loadingService?.hideLoading(on: self!) {
                    let dialogueData = DialogueData(type: .error, title: "Error", message: "\(error.localizedDescription)")
                    self?.dialogueService?.showDialogue(on: self!, data: dialogueData, buttonActionClosure: nil)
                    self?.view.alpha = 1.0
                }
                break
            case .noInternet:
                self?.view.alpha = 1.0
                let dialogueData = DialogueData(type: .alert, title: "No Internet", message: "You aren't connected to the internet!")
                self?.dialogueService?.showDialogue(on: self!, data: dialogueData) {
                    self!.navigationController?.popViewController(animated: true)
                }
                break
            }
        }.store(in: &viewModel.cancellables)
    }
}

extension MainViewController: Storyboarded {
    static var storyboardName: String = "Main"
    static var storyboardId: String = "MainViewController"
}

