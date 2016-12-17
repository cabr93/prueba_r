//
//  VCDetalleiPhone.swift
//  rappi
//
//  Created by Carlos Buitrago on 14/12/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit

class VCDetalleiPhone: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var categoria: UILabel!
    @IBOutlet weak var descripcion: UITextView!
    @IBOutlet weak var icono: UIImageView!

    
    var nom:String = ""
    var aut:String = ""
    var cat:String = ""
    var des:String = ""
    var ico:UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        nombre.text = nom
        autor.text = "by " + aut
        categoria.text = cat
        descripcion.text = des
        descripcion.layer.cornerRadius = 8.0
        descripcion.layer.masksToBounds = true
        icono.layer.cornerRadius = 8.0
        icono.layer.masksToBounds = true
        icono.image = ico
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
