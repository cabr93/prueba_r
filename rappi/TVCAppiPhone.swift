//
//  TVCAppiPhone.swift
//  rappi
//
//  Created by Carlos Buitrago on 13/12/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit
import RealmSwift

class TVCAppiPhone: UITableViewController {
    
    var categorias = ["negocios", "clima", "utilidades", "viaje", "deportes" ,"redes sociales" ,"referencia", "productividad", "foto y video", "noticias", "navegación", "música", "estilo de vida", "salud y belleza", "juegos", "finanzas", "entretenimiento", "educación", "Libros", "todo", "medical", "revista", "catalogo", "comidas y bebidas"]
    let urls = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/genre="
    var urls2 = ""
    var nombre:Array<String> = Array<String>()
    var descripcion:Array<String> = Array<String>()
    var categoria:Array<String> = Array<String>()
    var autor:Array<String> = Array<String>()
    var posicion: Array<Int> = Array<Int>()
    var imagenes: Array<UIImage> = Array<UIImage>()
    var imagenes2: Array<UIImage> = Array<UIImage>()
    var tipo:Int = 19
    var flag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categorias[tipo]
        switch flag {
        case 0:
            borrar()
            query()
            let realm = try! Realm()
            let todasaplicaciones = realm.objects(aplicaciones.self)
            let filter = todasaplicaciones.filter("tipo == \(tipo)")
            for rest in filter{
                nombre.append(rest.nombre)
                descripcion.append(rest.descripcion)
                categoria.append(rest.categorias)
                autor.append(rest.autor)
                let pr = UIImage(data:rest.logo_path)!
                imagenes.append(pr)
            }
        case 1:
            var realm = try! Realm()
            var todasaplicaciones = realm.objects(aplicaciones.self)
            var filter = todasaplicaciones.filter("tipo == \(tipo)")
            if filter.count != 0{
                for rest in filter{
                    nombre.append(rest.nombre)
                    descripcion.append(rest.descripcion)
                    categoria.append(rest.categorias)
                    autor.append(rest.autor)
                    let pr = UIImage(data:rest.logo_path)!
                    imagenes.append(pr)
                }
            }
            else{
                query()
                realm = try! Realm()
                todasaplicaciones = realm.objects(aplicaciones.self)
                filter = todasaplicaciones.filter("tipo == \(tipo)")
                for rest in filter{
                    nombre.append(rest.nombre)
                    descripcion.append(rest.descripcion)
                    categoria.append(rest.categorias)
                    autor.append(rest.autor)
                    let pr = UIImage(data:rest.logo_path)!
                    imagenes.append(pr)
                }
            }
        default:
            query()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.nombre.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda2", for: indexPath) as! CustomCell
        
        // Configure the cell...
        
        cell.nombre.text = self.nombre[(indexPath as NSIndexPath).row]
        cell.foto.image = self.imagenes[(indexPath as NSIndexPath).row]
        cell.foto.layer.cornerRadius = 8.0
        cell.foto.layer.masksToBounds = true
        cell.categoria.text = self.categoria[(indexPath as NSIndexPath).row]
        cell.numero.text = String((indexPath as NSIndexPath).row + 1)
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let ip = self.tableView.indexPathForSelectedRow
        if ((ip as NSIndexPath?)?.row != nil){
            let cc = segue.destination as! VCDetalleiPhone
            cc.nom = self.nombre[(ip! as NSIndexPath).row]
            cc.aut = self.autor[(ip! as NSIndexPath).row]
            cc.cat = self.categoria[(ip! as NSIndexPath).row]
            cc.des = self.descripcion[(ip! as NSIndexPath).row]
            cc.ico = self.imagenes[(ip! as NSIndexPath).row]
            
        }
    }
    func query (){
        urls2 = urls + "\(6000 + tipo)" + "/json"
        let url = URL(string: urls2)
        let datos:Data? = try? Data(contentsOf: url!)
        if datos == nil{
            let alert = UIAlertController(title:"Error", message: "No hay conexion a Internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else{
            do{
                let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                let dico1 = json as! NSDictionary
                let dico2 = dico1["feed"] as! NSDictionary
                let dico3 = dico2["entry"] as! [NSDictionary]
                var n = 0
                for i in dico3{
                    let aplicacion = aplicaciones()
                    n = n + 1
                    let apl = i["im:name"] as! NSDictionary
                    let app = apl["label"] as! NSString as String
                    aplicacion.nombre = app
                    let desc = i["summary"] as! NSDictionary
                    let desc2 = desc["label"] as! NSString as String
                    aplicacion.descripcion = desc2
                    let cat = i["category"] as! NSDictionary
                    let cat2 = cat["attributes"] as! NSDictionary
                    let cat3 = cat2["label"] as! NSString as String
                    aplicacion.categorias = cat3
                    let aut = i["im:artist"] as! NSDictionary
                    let aut2 = aut["label"] as! NSString as String
                    aplicacion.autor = aut2
                    aplicacion.tipo = tipo
                    let foto = i["im:image"] as! [NSDictionary]
                    var count = 0
                    for j in foto{
                        if count > 1 {
                            let foto2 = j["label"] as! NSString as String
                            let fot = URL(string: foto2)
                            let dat = try? Data(contentsOf: fot!)
                            aplicacion.logo_path = dat!
                        }
                        count += 1
                    }
                    let realm = try! Realm()
                    try! realm.write{
                        realm.add(aplicacion)
                    }
                    if n == 20{
                        break
                    }
                }
            }
            catch _ {
            }
        }
    }
    func borrar(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
