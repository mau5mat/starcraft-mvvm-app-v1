//
//  UnitPageViewController.swift
//  starcraft-mvvm-app-v1
//
//  Created by Matthew Roberts on 10/01/2023.
//

import UIKit

class UnitPageViewController: UIViewController {
    @IBAction private func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak private var blurView: UIView!
    @IBOutlet weak private var cardView: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var unitTypeLabel: UILabel!
    @IBOutlet weak private var builtFromLabel: UILabel!
    @IBOutlet weak private var mineralCostLabel: UILabel!
    @IBOutlet weak private var gasCostLabel: UILabel!
    @IBOutlet weak private var supplyLabel: UILabel!
    @IBOutlet weak private var hotkeyLabel: UILabel!
    
    var loadingService: Loadable?
    var dialogueService: Dialogued?
    
    var viewModel: UnitPageViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupBlurView()
        setupLabels()
    }
    
    private func setupBlurView() {
        blurView.applyBlurEffect(with: .systemUltraThinMaterialDark)
    }
    
    private func setupLabels() {
        nameLabel.text = viewModel.unitName()
        unitTypeLabel.text = viewModel.unitType()
        builtFromLabel.text = viewModel.unitBuiltFrom()
        mineralCostLabel.text = viewModel.unitMineralCost()
        gasCostLabel.text = viewModel.unitGasCost()
        supplyLabel.text = viewModel.unitSupply()
        hotkeyLabel.text = viewModel.unitHotkey()
    }
}

extension UnitPageViewController: Storyboarded {
    static var storyboardName: String = "UnitPage"
    static var storyboardId: String = "UnitPageViewController"
}
