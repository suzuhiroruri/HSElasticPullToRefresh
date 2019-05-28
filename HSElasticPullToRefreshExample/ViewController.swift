//
//  ViewController.swift
//  HSElasticPullToRefreshExample
//
//  Created by Hiromasa Suzuki on 2019/05/28.
//  Copyright © 2019 Hiromasa Suzuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: -
    // MARK: Vars
    
    fileprivate var tableView: UITableView!
    
    // MARK: -
    
    override func loadView() {
        super.loadView()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 231/255.0, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 251/255.0, alpha: 1.0)
        view.addSubview(tableView)
        
        let loadingView = HSElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.hs_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self?.tableView.hs_stopLoading()
            })
        }, loadingView: loadingView)
        tableView.hs_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.hs_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    deinit {
        tableView.hs_removePullToRefresh()
    }
    
}

// MARK: -
// MARK: UITableView Data Source

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell!.contentView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 251/255.0, alpha: 1.0)
        }
        
        if let cell = cell {
            cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
            return cell
        }
        
        return UITableViewCell()
    }
    
}

// MARK: -
// MARK: UITableView Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
