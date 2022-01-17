//
//  Home.swift
//  ImpactBiosystemsAlgorithm
//
//  Created by KanoaMatton on 1/17/22.
//

import UIKit

class Home: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: VARIABLES
    
    private lazy var searchCityTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Enter Text:"
        textField.borderStyle = .none
        textField.backgroundColor =  UIColor.systemGray6
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()
    private lazy var textView: CustomTextView = {
        let textView = CustomTextView()
        textView.layer.cornerRadius = 15
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    private var dictionary = [String: Int]()
    private var currentMax = 0
    private var array = [String]()

    // MARK: VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // MARK: FUNCTIONS
    
    private func setUpUI() {
        view.backgroundColor = .systemGray4
        
        view.addSubview(searchCityTextField)
        view.addSubview(textView)
        
        
        NSLayoutConstraint.activate([
        
            searchCityTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            searchCityTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 20),
            searchCityTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchCityTextField.heightAnchor.constraint(equalToConstant: 40),
            
            textView.topAnchor.constraint(equalTo: searchCityTextField.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        
        ])
        
    }
    
    
    private func sortByFrequency(_ input: String) -> [String]{
        
        // Base case
        guard input.count > 0 else { return [] }
        
        // Get array of strings using utility function
        let inputArray = input.splitString()
        
        // Loop through each word in input string - O(n)
        for word in inputArray {
            
            // Check if word (key) is in dictionary
            if dictionary.keys.contains(word) {
                
                // increment it's value by 1
                dictionary[word] = (dictionary[word] ?? 1) + 1
            
                // Check if that value is the max
                // if maxValue is true, delete that word, then add the word to FRONT of array
                if isMaxValue(dictionary[word]!) {
                    if let index = array.firstIndex(of: word) {
                        array.remove(at: index)
                    }
                    array.insert(word, at: 0) // - O(n)
                } else {
                    
                    // takes into account sorting values in the "middle" of the array that arent the max
                    for i in 0..<array.count {
                        // if the current word comes up in the array before checking values, then logically we do not have to check behind it because there is no reason to place a word behind where it currently is.
                        // only need to check the words before it
                        if word == array[i] {
                            break
                        }
                    
                        // compare current word's value to all previous values to essentially find local maximum
                        if (dictionary[word]! > dictionary[array[i]]!){
                            if let index = array.firstIndex(of: word) {
                                array.remove(at: index)
                            }
                            array.insert(word, at: i)
                            break
                        }
                    }
                }
                 
            }
            else {
                // add it to dictionary with initial value of 1
                dictionary[word] = 1
                // Add it to array
                array.append(word)
                
            }
            
        }
        
        return array
        
    }
    
    
    // Separate function just to make code a bit cleaner
    private func isMaxValue(_ value: Int) -> Bool{
        if value > currentMax  {
            currentMax = value
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resign the keyboard
        textField.resignFirstResponder()
        
        // Guard the text field
        guard let input = textField.text else {return false}
        
        // Clear the text view
        textView.text = ""
        
        // Get the sorted array
        let sorted = sortByFrequency(input)
        
        // Loop through sorted array
        for word in sorted {
            // Display word with its value
            self.textView.text += "\(word + " - " + "\(dictionary[word] ?? 0)")\n"
        }
        // Reset array and dictionary
        array.removeAll()
        dictionary.removeAll()
        
        return true
    }


}


