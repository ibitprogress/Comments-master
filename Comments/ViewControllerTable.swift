//
//  ViewControllerTable.swift
//  Comments
//
//  Created by Horbach on 6/23/19.
//  Copyright © 2019 Horbach. All rights reserved.
//

import UIKit

class ViewControllerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var textofFieldTop: Int?
    var textofFieldLow: Int?
    
    
    var comments = [Comments]()
    var myTableView = UITableView()
    var indentifire = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Comments"
        fetchJson()
        createTable()
        
    }
    
    func createTable() {
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: indentifire)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
      //  self.myTableView.rowHeight = UITableView.automaticDimension автоматичне розтягування комірки під текст
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(myTableView)
        
    }
    
    // MARK: - UiTableViewDataSoure
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (comments.count) - (textofFieldLow! - 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = comments[indexPath.row + ((textofFieldLow!) - 1 )]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = comment.name
        return cell
    }
     //MARK: - UiTableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0 //height Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = comments[indexPath.row]
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        print(data.name) // data consol
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    //MARK: - CreateJsonData
    func fetchJson() {
        let urlString = "http://jsonplaceholder.typicode.com/comments"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {(data , _ ,err ) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from url:", err)
                    return
                }
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    self.comments = try decoder.decode([Comments].self, from: data)
                    self.myTableView.reloadData()
                } catch let jsonErr {
                    print("Failed to decode:",jsonErr)
                }
            }
        }.resume()
    }

}

