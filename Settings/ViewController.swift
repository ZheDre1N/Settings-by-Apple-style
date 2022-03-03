//
//  ViewController.swift
//  Settings
//
//  Created by Eugene Dudkin on 02.03.2022.
//

import UIKit

struct Section {
    let title: String?
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)?
    let isOn: Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)?
}


class ViewController: UIViewController {
    
    private var tableView: UITableView = .init()
    
    
    var models = [Section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)

        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    private func configure() {
        models.append(Section(title: nil, options: [
            .switchCell(model:SettingsSwitchOption(title: "Airplane mode", icon: UIImage(systemName: "airplane"), iconBackgroundColor: .systemPink, handler: nil, isOn: true))
        ]))
        
        models.append(Section(title: "General", options: [
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemBlue, handler: nil)),
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "star"), iconBackgroundColor: .systemPink, handler: nil)),
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "moon"), iconBackgroundColor: .systemCyan, handler: nil)),
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemOrange, handler: nil))
        ]))
        
        models.append(Section(title: "Support", options: [
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemBlue, handler: nil)),
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "star"), iconBackgroundColor: .systemPink, handler: nil)),
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "moon"), iconBackgroundColor: .systemCyan, handler: nil)),
            .staticCell(model:SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemOrange, handler: nil))
        ]))
        
        models.append(Section(title: nil, options: [
            .staticCell(model:SettingsOption(title: "Clear Translation History", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemRed, handler: nil)),
        ]))
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
            cell.configure(with: model)
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = models[indexPath.section].options[indexPath.row]

        
        switch type.self {
        case .staticCell(let model):
            if let handler = model.handler {
                handler()
            }
        case .switchCell(let model):
            if let handler = model.handler {
                handler()
            }
        }
        
        
        
        

    }
}
