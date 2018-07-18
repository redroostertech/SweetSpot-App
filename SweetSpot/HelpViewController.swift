//
//  HelpViewController.swift
//  SweetSpot
//
//  Created by Michael Westbrooks on 7/4/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

var help_categories_test_data = [
    ["topic" : "Location Search"], ["topic" : "Wine Recommendations"], ["topic" :"Profile"], ["topic" :"SweetSpot App"], ["topic" :"Other"]
]
let help_cell_identifier = "HelpCell"

class HelpViewController: UIViewController, HelpDataSourceDelegate {

    @IBOutlet var navigationViewContainer: UIView!
    @IBOutlet var sectionContainer: UIView!
    @IBOutlet var btn_Cancel: UIButton!
    @IBOutlet var btn_Submit: UIButton!
    @IBOutlet var text_TypeMessage: UITextView!
    @IBOutlet var text_Category: UITextField!
    @IBOutlet var lbl_Title: UILabel!
    
    var user: User!
    var navigation: SecondaryNavigationViewController!
    var helpDataSource: HelpTopicsViewDataSource!
    var helpDataTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main",
                              bundle: nil)
        guard
            let vc = sb.instantiateViewController(withIdentifier: "ResendPasswordPopOverViewController") as? ResendPasswordPopOverViewController
            else
        {
            return
        }
        //vc.user = self.user
        vc.text = help_popover_text
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }
    
}

extension HelpViewController {
    func setupInterface() {
        text_Category.delegate = self
        text_Category.textColor = UIColor.AppColors.beige
        text_TypeMessage.delegate = self
        
        setVCBackgroundImageToView(image: dashboard_background_image)
        
        navigation = SecondaryNavigationViewController()
        addChildViewController(navigation)
        navigationViewContainer.addSubview(navigation.view)
        didMove(toParentViewController: navigation)
        navigation.delegate = self
        navigation.titleForView = "HELP"
        
        helpDataSource = HelpTopicsViewDataSource()
        helpDataSource.delegate = self
        helpDataSource.dataCheck()
        
        lbl_Title.textColor = UIColor.AppColors.beige
        lbl_Title.text = String(format: "How can we help you, %@?", "Mike"/*user.firstName*/)
        
        sectionContainer.backgroundColor = UIColor.AppColors.purple
        
        btn_Cancel.layer.cornerRadius = CGFloat(btn_radius)
        btn_Cancel.layer.borderColor = UIColor.AppColors.beige.cgColor
        btn_Cancel.layer.borderWidth = CGFloat(btn_border_width)
        btn_Cancel.backgroundColor = UIColor.clear
        btn_Cancel.setTitleColor(UIColor.AppColors.beige,
                                 for: .normal)
        btn_Cancel.setTitle(registration_cancel.uppercased(),
                            for: .normal)
        
        btn_Submit.layer.cornerRadius = CGFloat(btn_radius)
        btn_Submit.layer.borderColor = UIColor.AppColors.black.cgColor
        btn_Submit.layer.borderWidth = CGFloat(btn_border_width)
        btn_Submit.backgroundColor = UIColor.AppColors.beige
        btn_Submit.setTitleColor(UIColor.AppColors.black,
                                 for: .normal)
        btn_Submit.setTitle(registration_submit.uppercased(),
                            for: .normal)
        
        let rightInputImage = UIImage(named: "dropDownArrow")
        let rightInputImageView = UIImageView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 32,
                                                            height: self.text_Category.frame.height))
        rightInputImageView.image = rightInputImage
        rightInputImageView.contentMode = .center
        self.text_Category.rightViewMode = .always
        self.text_Category.rightView = rightInputImageView
    }
    
    func showTable(belowField field: UITextField) {
        if let helpTable = self.helpDataTableView {
            self.view.addSubview(helpTable)
            print("Already")
        } else {
            print("Not initialized")
            self.helpDataTableView = UITableView(frame: CGRect(x: field.frame.origin.x,
                                                               y: field.frame.origin.y,
                                                               width: field.frame.width,
                                                               height: 200.0))
            self.helpDataTableView?.dataSource = self.helpDataSource
            self.helpDataTableView?.delegate = self.helpDataSource
            self.helpDataTableView?.register(UITableViewCell.self, forCellReuseIdentifier: help_cell_identifier)
            self.view.addSubview(helpDataTableView!)
            self.helpDataTableView?.reloadData()
        }
    }
    
    func dismissTable(andKeyboard field: UITextField?) {
        self.helpDataTableView?.removeFromSuperview()
        if let field = field {
            field.resignFirstResponder()
        }
    }
    
    func send(response: HelpTopic) {
        text_Category.text = self.helpDataSource.helpDataSource.select(topic: response)
        dismissTable(andKeyboard: self.text_Category)
    }
}

extension HelpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showTable(belowField: textField)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissTable(andKeyboard: textField)
        return true
    }
}

extension HelpViewController: UITextViewDelegate {
    
}

extension HelpViewController: NavDelegate {
    func doDismiss() {
        dismiss(animated: true,
                completion: nil)
    }
    
    func doGoToProfile() {
        
        if !(self is ProfileContainerViewController) {
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "ProfileContainerViewController") as? ProfileContainerViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
        }
    }
    
    func doGoToHelp() {
        if !(self is HelpViewController) {
            let sb = UIStoryboard(name: "Main",
                                  bundle: nil)
            guard
                let vc = sb.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController
                else
            {
                return
            }
            //vc.user = self.user
            present(vc,
                    animated: true,
                    completion: nil)
        }
    }
}

struct HelpTopic {
    var topic: String?
    init(data: [String: Any]) {
        self.topic = data["topic"] as? String ?? nil
    }
}

protocol HelpDataSourceDelegate {
    func send(response: HelpTopic)
}

class HelpDataSource {
    
    var helpTopics: [HelpTopic]?
    var selectedTopic: HelpTopic?
    
    func fetchHelpTopics(completion: @escaping() -> Void) {
        self.checkInit()
        for i in help_categories_test_data {
            let topic = HelpTopic(data: i)
            self.helpTopics?.append(topic)
        }
        completion()
    }
    
    func checkInit() {
        if let _ = self.helpTopics {
            self.helpTopics!.removeAll()
        } else {
            self.helpTopics = [HelpTopic]()
        }
    }
    
    func select(topic: HelpTopic) -> String {
        print("Selected topic ", topic.topic ?? "Unavailable")
        self.selectedTopic = topic
        return topic.topic ?? ""
    }
    
    func searchTopic(usingText text: String) -> [HelpTopic]? {
        let filteredArray = self.helpTopics?.filter({
            (object) -> Bool in
            return object.topic?.contains(text) ?? false
        })
        return filteredArray ?? nil
    }
}

class HelpTopicsViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var helpDataSource: HelpDataSource!
    var delegate: HelpDataSourceDelegate?
    override init() {
        helpDataSource = HelpDataSource()
        helpDataSource.fetchHelpTopics {
            print("Done fetching data for Help TableView")
        }
    }
    
    func dataCheck() {
        print(helpDataSource.helpTopics)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let topicsArray = self.helpDataSource.helpTopics else {
            print("No topics")
            return 0
        }
        return topicsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: help_cell_identifier,
                                                       for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        
        guard let topicsArray = self.helpDataSource.helpTopics else {
            print("No topics")
            return cell
        }
        
        cell.backgroundColor = UIColor.AppColors.beige
        let topic = topicsArray[indexPath.row]
        cell.textLabel?.text = topic.topic
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let topicsArray = self.helpDataSource.helpTopics else {
            return
        }
        let topic = topicsArray[indexPath.row]
        self.delegate?.send(response: topic)
    }
    
}
