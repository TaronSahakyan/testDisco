//
//  ViewController.swift
//  TestDisco
//
//  Created by Taron on 19.09.22.
//

import UIKit

class TagsViewController: UIViewController {
    
    let kCellID = "CellID"
    var dataProvider:BaseDataProvider<TagsResponse>
    var tableView:UITableView!
            
    required init?(coder: NSCoder) {
        dataProvider = .init(with:URL.init(string:"https://api.stackexchange.com/2.3/tags?order=desc&sort=popular&site=stackoverflow")!)
        tableView = .init()
        super.init(coder: coder)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: 0).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0).isActive = true
        
        dataProvider.addListener { [weak self] type, error in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()

            }
        }
        
        dataProvider.initialRequest()

    }
    
}

extension TagsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tag = dataProvider.data[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: kCellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: kCellID)
        }
        cell!.textLabel?.text = tag.name
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.data.count ?? 0
    }

}

extension TagsViewController: UITableViewDelegate {
    
}
