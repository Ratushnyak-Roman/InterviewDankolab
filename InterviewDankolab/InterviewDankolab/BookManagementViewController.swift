//
//  BookManagementViewController.swift
//  InterviewDankolab
//
//  Created by mac on 18.01.2022.
//

import UIKit

class BookManagementViewController: UIViewController {
    
    var book = Book(bookName: "", bookDate: "")

    @IBOutlet weak var bookNameTF: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let minPickerDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let maxPickerDate = Calendar.current.date(byAdding: .day, value: 90, to: Date())
        datePicker.minimumDate = minPickerDate
        datePicker.maximumDate = maxPickerDate
        updateInfo()
        setupUI()
        updateDoneButtonState()
    }
    
    func updateDoneButtonState() {
        guard bookNameTF.text?.first != " " else { return }
        let bookName = bookNameTF.text ?? ""
        doneButton.isEnabled = !bookName.isEmpty
    }
    
    func updateInfo() {
        bookNameTF.text = book.bookName
    }
    
    func setupUI() {
        if bookNameTF.text == "" {
            self.title = "Add new book"
            doneButton.setTitle("Add", for: .normal)
        } else {
            self.title = "Edit info"
            doneButton.setTitle("Edit", for: .normal)
        }
        doneButton.layer.cornerRadius = 6
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateDoneButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let book = bookNameTF.text ?? ""
        let date = getDateFromPicker()
        
        self.book = Book(bookName: book, bookDate: date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getDateFromPicker() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: datePicker.date)
    }
}
