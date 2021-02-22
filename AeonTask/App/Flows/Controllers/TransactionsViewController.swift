//
//  TransactionsViewController.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import UIKit

class TransactionsViewController: UITableViewController {
    
    var allTransactions: ResponseResult?
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        let service = AeonService()
        service.getTransactionDetails { response in
            self.allTransactions = response
            self.tableView.reloadData()
        }
        
        setupNavBar()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTransactions?.response.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CustomViewCell
        let itemList = allTransactions?.response
        
        cell.descriptionLabel.text = itemList?[indexPath.row].desc ?? ""
        cell.curLabel.text = "Валюта (\(itemList?[indexPath.row].currency ?? "unknown"))"
        cell.dateLabel.text = getCellDateText(forIndexPath: indexPath, andTimestamp: Double((itemList?[indexPath.row].created)!))
        cell.amountLabel.text = "Сумма платежа: " + (itemList?[indexPath.row].amount.stringValue ?? "")
        return cell
    }

    //MARK:- Supporting Actions
    
    private func getCellDateText(forIndexPath indexPath: IndexPath, andTimestamp timestamp: Double) -> String {
            let date = Date(timeIntervalSince1970: timestamp)
            let stringDate = dateFormatter.string(from: date)
            return stringDate
    }
    
    @objc func logoutPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupNavBar() {
        let logoutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(self.logoutPressed))
        self.navigationItem.rightBarButtonItem  = logoutButton
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "История платежей"
    }
}
