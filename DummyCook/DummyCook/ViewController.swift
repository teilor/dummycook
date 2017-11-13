//
//  ViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 09/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit
import CoreData

var myIndex = 0

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var receita: CDReceita!
    var receitasArray = [CDReceita]()
    var passosArray = [CDPasso]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // 1. pegou o delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. pegou o container (container seria o banco de dados)
        let container = appDelegate.persistentContainer
        
        // 5. Operacao de feth
        let request =  NSFetchRequest<NSFetchRequestResult>(entityName: "CDReceita")
        let request2 =  NSFetchRequest<NSFetchRequestResult>(entityName: "CDPasso")
        
        let results = try! container.viewContext.fetch(request) as! [CDReceita]
        let results2 = try! container.viewContext.fetch(request2) as! [CDPasso]
        
        // o objeto piloto recebe o primeiro dado do result
        self.receita = results.first
        
        // Se nao tiver nada cria os dados
        if(self.receita == nil){
            print("Criei as receitas")

            
            
            let receita1 = NSEntityDescription.insertNewObject(forEntityName: "CDReceita", into: container.viewContext) as! CDReceita
            let receita2 = NSEntityDescription.insertNewObject(forEntityName: "CDReceita", into: container.viewContext) as! CDReceita
            
            let passo1_1 = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
            let passo1_2 = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
            
            let passo2_1 = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
            let passo2_2 = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
            
            
            receita1.nome = "Double Layer Pumpkin Cheesecake"
            receita1.textoIngredientes = "blablalbablablabla"
            receita1.imagemReceita = "1"
            
            passo1_1.imagemPasso = "2"
            passo1_1.video = ""
            passo1_1.texto = "Misture os ingredientes"
            
            passo1_2.imagemPasso = "1"
            passo1_2.video = ""
            passo1_2.texto = "Aqueça até descolar da panela"
            
            
            receita1.addToRelationship(passo1_1)
            receita1.addToRelationship(passo1_2)
            
            //receita1.listaPassos.append(passo1_1)
            //receita1.listaPassos.append(passo1_2)
            
            receita2.nome = "Pumpkin Ginger Cupcakes"
            receita2.textoIngredientes = "blablalbablablabla"
            receita2.imagemReceita = "2"
            
            passo2_1.imagemPasso = "2"
            passo2_1.video = ""
            passo2_1.texto = "Misture os ingredientes"
            
            passo2_2.imagemPasso = "1"
            passo2_2.video = ""
            passo2_2.texto = "Aqueça até descolar da panela"
            
            
            receita2.addToRelationship(passo2_1)
            receita2.addToRelationship(passo2_2)
            
            
            //receita2.listaPassos.append(passo2_1)
            //receita2.listaPassos.append(passo2_2)
            
            
            
            
            receitasArray.append(receita1)
            receitasArray.append(receita2)
       
            
        }else{
            self.receitasArray = results
            self.passosArray = results2
            print("Carreguei as receitas")
        }
        
        try! container.viewContext.save()
        
        
        tableView.reloadData()
        
        
        /*
        dataArray.append(DataModel(recipeImage: UIImage(named: "1")!, title: "Double Layer Pumpkin Cheesecake", time: "4h10m", serves: "8", cost: "U$ 18.00"))
        dataArray.append(DataModel(recipeImage: UIImage(named: "2")!, title: "Pumpkin Ginger Cupcakes", time: "1h30m", serves: "24", cost: "U$ 23.00"))
        dataArray.append(DataModel(recipeImage: UIImage(named: "3")!, title: "Oven Baked Omelet", time: "49m", serves: "6", cost: "U$ 5,00"))*/
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receitasArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! DataCell
        cell.data = receitasArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "segue" ) {
            let dest = segue.destination as! DetailsViewController
            dest.data = receitasArray[myIndex]
        }
        
    }
    
    
}
