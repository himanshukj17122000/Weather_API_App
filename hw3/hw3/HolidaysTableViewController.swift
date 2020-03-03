//
//  HolidaysTableViewController.swift
//  hw3
//
//  Created by himanshu on 28/02/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit
//import SystemConfiguration
//import Foundation

class HolidaysTableViewController: UITableViewController {
   enum HolidayError:Error{
        case noDataAvailable
        case canNotProcessData
    }
    var listOfHolidays = [HolidayDetail](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays Found"
            }
        }
    }
    
    let URL1="https://calendarific.com/api/v2/holidays?api_key=4d6d6d35d4dce107d7dbc9b003016d07a00f1eaf&country=US&year=2019"
    var resourceURL = URL(string:"https://calendarific.com/api/v2/holidays?api_key=4d6d6d35d4dce107d7dbc9b003016d07a00f1eaf&country=US&year=2019")
    let API_KEY="4d6d6d35d4dce107d7dbc9b003016d07a00f1eaf"


    
    func getData(countryCode:String){
        listOfHolidays=[]
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyy"
            let currentYear = format.string(from: date)
            let resourceString="https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
            guard let resourceURL = URL(string: resourceString) else {fatalError()}
            //self.resourceURL = resourceURL
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else{
                
               DispatchQueue.main.async{
                    let alert1 = UIAlertController(title: "Error", message: "Internet Error", preferredStyle: .alert)
                    alert1.addAction(UIAlertAction(title:"OK", style:.default,handler:nil))
                    self.present(alert1, animated: true)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                self.listOfHolidays = holidaysResponse.response.holidays
               
                
            } catch{
                DispatchQueue.main.async{
                    let alert1 = UIAlertController(title: "Error", message: "Data Cannot be Found", preferredStyle: .alert)
                    alert1.addAction(UIAlertAction(title:"OK", style:.default,handler:nil))
                    self.present(alert1, animated: true)
                }
            }
        }
        dataTask.resume()
    }
    
//    struct HolidayRequest{
//        let resourceURL:URL
//        let API_KEY="4d6d6d35d4dce107d7dbc9b003016d07a00f1eaf"
//
//        init (countryCode:String){
//            let date = Date()
//            let format = DateFormatter()
//            format.dateFormat = "yyyy"
//            let currentYear = format.string(from: date)
//
//
//            let resourceString="https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
//            guard let resourceURL = URL(string: resourceString) else {fatalError()}
//            self.resourceURL = resourceURL
//        }
        
           
//      func getHolidays (completion: @escaping(Result<[HolidayDetail],HolidayError>)-> Void){
//                let dataTask = URLSession.shared.dataTask(with: resourceURL!) {data, _, _ in
//                    guard let jsonData = data else{
//
//                        DispatchQueue.main.async{
//                            let alert1 = UIAlertController(title: "Hello", message: "Hello", preferredStyle: .alert)
//                            alert1.addAction(UIAlertAction(title:"OK", style:.default,handler:nil))
//                            self.present(alert1, animated: true)
//                        }
//
//                        print("NO DATA")
//                        completion(.failure(.noDataAvailable))
//                        return
//                    }
//                    do {
//                        let decoder = JSONDecoder()
//                        let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
//                        let holidayDetails = holidaysResponse.response.holidays
//                        print(holidayDetails)
//                        completion(.success(holidayDetails))
//                    } catch{
//                        completion(.failure(.canNotProcessData))
//                    }
//                }
//                 dataTask.resume()
//            }

       
    

    var activateAlert=false
    @IBOutlet weak var searchBar: UISearchBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
         let backgroundImage = UIImage(named: "nationalholidays.jpg")
         let imageView = UIImageView(image: backgroundImage)
        
         self.tableView.backgroundView = imageView
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func setActivate(alert:Bool){
        activateAlert=alert
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfHolidays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
        let holiday = listOfHolidays[indexPath.row]
        
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
    
        // Configure the cell...

        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! details
              
              // Pass the selected object to the new view controller.
              let myRow = tableView!.indexPathForSelectedRow
              let myCurrCell = tableView!.cellForRow(at: myRow!) as! CustomCell
              
              // set the destVC variables from the selected row
        destVC.cityWeath = (myCurrCell.cellTemp!.text)!
        destVC.cityNa=(myCurrCell.cellName!.text)!
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension HolidaysTableViewController : UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchBartext = searchBar.text else {return}
           getData(countryCode: searchBartext)
           
//            //holidayRequest.getHolidays{[weak self] result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let holidays):
//                    self?.listOfHolidays = holidays
//                }
//            }
        }
    }


