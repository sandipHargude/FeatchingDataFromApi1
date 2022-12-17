//
//  ViewController.swift
//  CompanyTask2
//
//  Created by Mac on 17/12/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var users : [User] = []
    
    @IBOutlet weak var userCollectionTable: UICollectionView!
    @IBOutlet weak var userTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateAndDatasource()
        xibRegistration()
        dataFromApi()
        
        // Do any additional setup after loading the view.
    }
    
    func delegateAndDatasource(){
        userTable.dataSource = self
        userTable.delegate = self
        userCollectionTable.dataSource = self
        userCollectionTable.delegate = self
    }
    func xibRegistration(){
        let uinib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.userTable.register(uinib, forCellReuseIdentifier: "UserCell")
        let nib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        self.userCollectionTable.register(nib, forCellWithReuseIdentifier: "userCell2")
    }
    
    func dataFromApi(){
        let stringUrl = "https://reqres.in/api/users?page=1"
        
        let url =  URL(string: stringUrl)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request){ data,responce,error  in
            print("Data\(data)")
            print("error \(responce)")
        
            let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String:Any]
            
             var dataArray = NSArray()
            dataArray = jsonObject["data"] as! NSArray
            
            
            for dictionary in dataArray{
                let eachdictionary = dictionary as! [String:Any]
                let userFirstName = eachdictionary["first_name"] as! String
                let userLastName = eachdictionary["last_name"] as! String
                let avatar = eachdictionary["avatar"] as! String
                
                let newPost = User(image: avatar, first_Name: userFirstName, last_Name: userLastName)
                
                self.users.append(newPost)
            }
            DispatchQueue.main.async {
                self.userTable.reloadData()
            }
        }
        dataTask.resume()
        
    }


}
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.userTable.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        cell.firstNameLabel.text = users[indexPath.row].first_Name
        cell.lastNameLabel.text = users[indexPath.row].last_Name
        return cell
    }
    
    
}
extension ViewController:UICollectionViewDelegate{
    
    
}
extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.userCollectionTable.dequeueReusableCell(withReuseIdentifier: "userCell2", for: indexPath) as! UserCollectionViewCell
        //let img = NSURL(string: users[indexPath.row].image)
        cell.userImage.sd_setImage(with: URL(string: users[indexPath.row].image))
        return cell
    }
    
    
}

