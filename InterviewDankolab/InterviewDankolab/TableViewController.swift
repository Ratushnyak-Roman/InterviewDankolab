//
//  TableViewController.swift
//  InterviewDankolab
//
//  Created by mac on 16.01.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var books = [
        Book(bookName: "New book", bookDate: "25.01.22"),
        Book(bookName: "Test book", bookDate: "24.01.22"),
        Book(bookName: "best book", bookDate: "23.01.22")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    @IBAction func openSortOptions(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "SortVC")
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindSegue (segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        
        let sorceVC = segue.source as! BookManagementViewController
        let book = sorceVC.book
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            books[selectedIndexPath.row] = book
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: books.count, section: 0)
            books.append(book)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        
    }
    
    @IBAction func unwindSegueFromSort (segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "sortByNameSegue":
            sortByName()
        case "sortByDateSegue":
            sortByDate()
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editBook" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let book = books[indexPath.row]
        let bookManagerVC = segue.destination as! BookManagementViewController
        bookManagerVC.book = book
    }
    
    func setupNavigationBar () {
        self.title = "Books list"
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        if #available(iOS 11, *){
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        guard books.count == 0 else { return }
        self.tableView.setEmptyMessage("Empty list")
        
    }
    
    func sortByName() {
        let newArray = books.sorted { (book1, book2) -> Bool in
            return book1.bookName.lowercased().compare(book2.bookName.lowercased()) == ComparisonResult.orderedAscending
        }
        books = newArray
        tableView.reloadData()
    }
    
    func sortByDate() {
        let newArray = books.sorted { (book1, book2) -> Bool in
            return book1.bookDate.compare(book2.bookDate) == ComparisonResult.orderedAscending
//            book1.bookDate < book2.bookDate
        }
        books = newArray
        tableView.reloadData()
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        
        let book = books[indexPath.row]
        cell.setup(book: book)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 25)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
