//
//  AdminDashBoard.swift
//  Mundus_ios
//
//  Created by Stephan on 04/01/2017.
//  Copyright (c) 2017 Stephan. All rights reserved.
//
import Aldo 
import UIKit

class AdminDashBoard: UIViewController, Callback {
    var items = NSDictionary()

    @IBOutlet weak var adminToken: UILabel!
    @IBOutlet weak var userJoinToken: UILabel!
    @IBOutlet weak var username: UILabel!
    var usname = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("lolol")
        print(items.object(forKey: "userToken"))
        print(items)
        username.text = usname
        userJoinToken.text = items.object(forKey: "userToken") as! String
        adminToken.text = items.object(forKey: "modToken") as! String
        // Do any additional setup after loading the view.
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "dashboard"), tag: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func deleteClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: {});

//        Aldo.deleteSession(callback: self)
    }
    
    func onResponse(responseCode: Int, response: NSDictionary) {
        print("jaja")
        print(responseCode)
        if(responseCode == 200) {
            print("meeeh")
            print(response)
            self.dismiss(animated: true, completion: {});

        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
