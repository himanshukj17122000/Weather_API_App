//
//  details.swift
//  hw3
//
//  Created by himanshu on 28/02/20.
//  Copyright © 2020 himanshu. All rights reserved.
//

import UIKit

class details: UIViewController {
    
   
    var cityNa:String = ""

    var cityWeath:String = ""

    @IBOutlet weak var cityWeather: UILabel!

    @IBOutlet weak var cityName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.text = cityNa
        cityWeather.text = cityWeath
       let backgroundImage = UIImage.init(named: "holidaypic.jpg")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)

        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.2

        self.view.insertSubview(backgroundImageView, at: 0)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

