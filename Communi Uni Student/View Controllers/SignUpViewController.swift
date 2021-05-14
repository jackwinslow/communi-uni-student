//
//  SignUpViewController.swift
//  Communi Uni Student
//
//  Created by BC Swift Student Loan 1 on 5/8/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var studentFirstNameTextField: UITextField!
    @IBOutlet weak var studentErrorLabel: UILabel!
    @IBOutlet weak var studentPasswordTextField: UITextField!
    @IBOutlet weak var studentSignUpButton: UIButton!
    @IBOutlet weak var studentLastNameTextField: UITextField!
    @IBOutlet weak var selectSchoolButton: UIButton!
    @IBOutlet weak var studentEmailTextField: UITextField!
    @IBOutlet weak var studentBackButton: UIButton!
    
    var db = Firestore.firestore()
    var studentCount = 0
    var location = ""
    
    
    
    // setup for dropdown selector
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dropDownOptions = [String]()
    var tableViewHeight = CGFloat(50)
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    
    
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup for dropdown selector
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropDownCell.self, forCellReuseIdentifier: "DropDownCell")
        tableView.backgroundColor = UIColor(named: "PrimaryColor")

        setUpElements()
        
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func setUpElements() {
        
        // Hide the error label
        studentErrorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(studentFirstNameTextField)
        Utilities.styleTextField(studentLastNameTextField)
        Utilities.styleHollowButton(selectSchoolButton)
        Utilities.styleTextField(studentEmailTextField)
        Utilities.styleTextField(studentPasswordTextField)
        Utilities.styleFilledButton(studentSignUpButton)
        Utilities.styleHollowButton(studentBackButton)
        
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if studentFirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || studentLastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || studentEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || studentPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = studentPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters and contains a special character and a number."
        }
        
        return nil
    }
    
    func showError(_ message:String) {
        studentErrorLabel.text = message
        studentErrorLabel.alpha = 1
    }
    
    func transitionToHome() {
                
        let homeTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeTabBarController) as? HomeTabBarController
        
        view.window?.rootViewController = homeTabBarController
        view.window?.makeKeyAndVisible()
        
    }
    
    // setup for dropdown selector
    func addTransparentView(frames: CGRect) {
        let window = keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x + 40, y: frames.origin.y + (frames.height*2) + 40, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 25.0
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x + 40, y: frames.origin.y + (frames.height*2) + 40, width: frames.width, height: self.tableViewHeight)
        }, completion: nil)

    }
    
    func loadSchoolData(collegeName: String,completed: @escaping () -> ()) {
        db.collection("schools").document(collegeName).getDocument { document, error in
            if let document = document, document.exists {
                let school = School(dictionary: document.data()!)
                school.documentID = document.documentID
                self.studentCount = school.studentCount
                self.location = school.location
            } else {
                print("Document does not exist")
            }
            completed()
        }
    }
    
    // setup for dropdown selector
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x + 40, y: frames.origin.y + (frames.height*2) + 40, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
    @IBAction func studentSignUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
            
        } else {
            
            // Create cleaned versions of the data
            let firstName = studentFirstNameTextField.text!.trimmingCharacters(in:.whitespacesAndNewlines)
            let lastName = studentLastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let school = selectedButton.titleLabel?.text!
            let email = studentEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = studentPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                
                // Check for errors
                if let err = err {
                    
                    // There was an error creating the user
                    self.showError(err.localizedDescription)
                    
                } else {
                    
                    // User was created successfully, now store in firebase
                    let db = Firestore.firestore()
                    
                    // Save student in schools collection
                    db.collection("schools").document(school!).collection("students").document().setData(["firstname": firstName, "lastname": lastName, "school": school!, "date": Date().timeIntervalSince1970, "uid": result!.user.uid]) { error in
                        
                        if error != nil {
                            
                            // Show error message
                            self.showError("Error saving user data")
                            
                        }
                    }
                    
                    // Increment studentCount in school document in firebase
                    self.loadSchoolData(collegeName: school!) {
                        let count = self.studentCount + 1
                        db.collection("schools").document(school!).setData(["name" : "\(school!)", "location" : self.location, "studentCount" : count])
                    }
                    
                    // Save user data locally
                    self.userDefault.set(school!, forKey: "userSchool")
                    self.userDefault.set(email, forKey: "userEmail")
                    self.userDefault.set(password, forKey: "userPassword")
                    self.userDefault.synchronize()
                    
                    // Transition to the home screen
                    self.transitionToHome()
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    @IBAction func studentBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectSchoolButtonPressed(_ sender: Any) {
        dropDownOptions = ["Boston College", "University of Pittsburgh"]
        selectedButton = selectSchoolButton
        tableViewHeight = CGFloat(100)
        addTransparentView(frames: selectSchoolButton.frame)
    }
}

// setup for dropdown selector
class DropDownCell: UITableViewCell {
    
}

// setup for dropdown selector
extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath)
        cell.backgroundColor = UIColor(named: "PrimaryColor")
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "System Semibold", size: 15)
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dropDownOptions[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
