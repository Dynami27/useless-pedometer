//
//  uselessPedometerTableTableViewController.swift
//  useless pedometer
//
//  Created by Khalid Mohamed on 11/13/16.
//  Copyright © 2016 Khalid Mohamed. All rights reserved.
//

import UIKit
import CoreMotion



class uselessPedometerTableTableViewController: UITableViewController {
   
    var pedometer :CMPedometer!
    var numberOfSteps :[NSNumber]!

    
override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberOfSteps = [NSNumber]()
        self.pedometer = CMPedometer()
    
    gatherHistoricalData()
    
}
     func gatherHistoricalData() {
        
        for day in 1...7 {
            
            let calendar = Calendar.current
            guard let startDate = (calendar as NSCalendar).date(byAdding: .day, value: -1 * day, to: Date(), options: []) else {
                fatalError("Unable to get date")
            }
        
            self.pedometer.queryPedometerData(from: startDate, to: Date(), withHandler: { (data :CMPedometerData?, error :Error?) in
                if error == nil {
                    if let data = data {
                        if self.numberOfSteps.count > 0{
                            let previousSteps = self.numberOfSteps[self.numberOfSteps.count - 1]
                            
                            let currentSteps =  data.numberOfSteps.int32Value - previousSteps.int32Value
                            
                            self.numberOfSteps.append(currentSteps as NSNumber)
                            
                            if self.numberOfSteps.count == 7 {
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                            
                          
                            
                        
                        } else {
                                self.numberOfSteps.append(data.numberOfSteps)
                            }
                        
                    
                    }
                }
                
                })
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()

    }
   override func numberOfSections(in tableView: UITableView) -> Int {
  return 1
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return self.numberOfSteps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let steps = self.numberOfSteps[indexPath.row]
        cell.textLabel?.text = "\(steps)"
        return cell
    }
    
//
// override func tableView(_ tableView: UITableView, cellForRowAtindexPath: IndexPath) -> UITableViewCell {
//  
//    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
// let pedometer = self.days[indexPath.row]
//  cell.textLabel?.text =
//  
//  return cell
//    }
//// }


    
    // Override to support conditional editing of the table view.
   // override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
    //    return true
   // }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
