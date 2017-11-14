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
var recipeTitle: String = ""

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
        
        // 5. Operacao de fetch
        let requestReceita =  NSFetchRequest<NSFetchRequestResult>(entityName: "CDReceita")
        let requestPassos =  NSFetchRequest<NSFetchRequestResult>(entityName: "CDPasso")
        
        let resultsReceita = try! container.viewContext.fetch(requestReceita) as! [CDReceita]
        let resultsPassos = try! container.viewContext.fetch(requestPassos) as! [CDPasso]
        
        // O objeto receita recebe a primeira receita salva
        self.receita = resultsReceita.first
        
        // Se nao tiver nada, cria os dados
        if(self.receita == nil){

            let receita1 = NSEntityDescription.insertNewObject(forEntityName: "CDReceita", into: container.viewContext) as! CDReceita
            let receita2 = NSEntityDescription.insertNewObject(forEntityName: "CDReceita", into: container.viewContext) as! CDReceita
            let receita3 = NSEntityDescription.insertNewObject(forEntityName: "CDReceita", into: container.viewContext) as! CDReceita
            
            receita1.nome = "Brazilian Flan"
            receita1.textoIngredientes = ["1 cup sugar", "2 cans sweetened condensed milk", "1 can whole milk", "3 eggs"] as NSArray
            receita1.time = "6h"
            receita1.serves = "8"
            receita1.textoRequirements = "Oven, Pan, Cake Tin and Stoven"
            receita1.imagemReceita = "brflan"
            receita1.cost = "R$16,00"
            
            var passosReceita: [String] = []
            var contArray = 0

            //Estrutura do array: [0]Texto do passo, [1]Se tem imagem,[2]Se tem video,[3]Se tem timer
            passosReceita += ["Melt the sugar in a pan over low heat, stiring constantly, until the sugar becomes a golden brown syrup.", "","step1.mov",""] //Passo 1 com video
            passosReceita += ["Once the sugar becomes a golden brown syrup, it`s ready. Switch the stove off.", "step2","",""] //Passo 2 com foto
            passosReceita += ["Place all other ingredients into a blender, blend it for 5 minutes.", "", "step3.mov", ""] //Passo 3 com video
            passosReceita += ["Pour mixture into the pan. The pan is now with the sugar caramelized", "step4", "", ""] //Passo 4 com foto
            passosReceita += ["Place water into a cake tin. Then, place the pan with the mixture and the caramelized sugar inside", "step5", "", ""] //Passo 5 com foto
            passosReceita += ["Turn on the oven at 200 degrees and put the  cake tin inside. Let it cook for 2 hours.", "step6","",""] //Passo 6 com foto
            passosReceita += ["Carefully remove your pan from the oven, watch out as the water will be very hot", "step7", "", ""] //Passo 7
            passosReceita += ["The flan must cool for a few hours, better if you let it rest on the refrigerator overnight", "", "", ""] //Passo 8
            passosReceita += ["To take if off the pan, heat the pan over low heat for 20 seconds, then invert into a serving plate. Pick a proper plate as it needs to be large enough for the flan and some of the caramel", "step9", "", ""] //Passo 9
            passosReceita += ["Enjoy your brazilian flan!", "step10", "", ""]
            
            //For pra cadastrar os elementos do Array em cada atributo correto do passo
            for indice in 0...passosReceita.count-1 {
                
                let passo = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
                
                switch contArray{
                case 0:
                    passo.texto = passosReceita[indice]
                case 1:
                    passo.imagemPasso = passosReceita[indice]
                case 2:
                    passo.video = passosReceita[indice]
                case 3:
                    passo.timer = passosReceita[indice]
                default:
                    print("Placeholder")
                }
                
                contArray += 1
                
                if(contArray == 4){
                    contArray = 0
                    receita1.addToRelationship(passo)
                }
            }
            
            passosReceita = [""]
            
            receita2.nome = "Double Layer Pumpkin Cheesecake"
            receita2.textoIngredientes = ["2 (8 ounce) packages cream cheese, softened", "1/2 cup white sugar", "1/2 teaspoon vanilla extract", "2 eggs", "1 (9 inch) prepared graham cracker crust", "1/2 pumpkin puree", "1/2 teaspoon ground cinnamon", "1 pinch ground cloves","1 pinch ground nutmeg", "1/2 cup frozen whipped topping thawed"] as NSArray
            receita2.time = "4h10"
            receita2.serves = "8"
            receita2.textoRequirements = "1 beater"
            receita2.imagemReceita = "1"
            receita2.cost = "R$ 24,00"
            
            //Estrutura do array: [0]Texto do passo, [1]Se tem imagem,[2]Se tem video,[3]Se tem timer
            passosReceita += ["Turn on your oven to 325 degrees F (165 degrees C) and let it preheat", "preheat","",""] //Passo 1
            passosReceita += ["In a large bowl, combine cream cheese, sugar and vanilla and beat until smooth","mixing","",""] //Passo 2
            passosReceita += ["Blend in eggs, one at a time", "blendeggs", "", ""] //Passo 3
            
            
            //For pra cadastrar os elementos do Array em cada atributo correto do passo
            for indice in 0...passosReceita.count-1 {
                
                let passo = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
                
                    switch contArray{
                    case 0:
                        passo.texto = passosReceita[indice]
                    case 1:
                        passo.imagemPasso = passosReceita[indice]
                    case 2:
                        passo.video = passosReceita[indice]
                    case 3:
                        passo.timer = passosReceita[indice]
                    default:
                        print("Placeholder")
                    }
                
                contArray += 1
                
                if(contArray == 4){
                    contArray = 0
                    receita2.addToRelationship(passo)
                }
            }
            passosReceita = [""]

            receita3.nome = "Pumpkin Ginger Cupcakes"
            receita3.textoIngredientes = [""] as NSArray
            receita3.time = "1h 20min"
            receita3.serves = "2 pratos"
            receita3.textoRequirements = "1 beater"
            receita3.imagemReceita = "2"
            receita3.cost = "R$ 24,00"
         
            //Estrutura do array: [0]Texto do passo, [1]Se tem imagem,[2]Se tem video,[3]Se tem timer
            passosReceita += ["Turn on your oven to 325 degrees F (165 degrees C) and let it preheat", "preheat","",""] //Passo 1
            passosReceita += ["In a large bowl, combine cream cheese, sugar and vanilla and beat until smooth","mixing","",""] //Passo 2
            passosReceita += ["Blend in eggs, one at a time", "blendeggs", "", ""] //Passo 3
            
            for indice in 0...passosReceita.count-1 {
                
                let passo = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
                
                switch contArray{
                case 0:
                    passo.texto = passosReceita[indice]
                case 1:
                    passo.imagemPasso = passosReceita[indice]
                case 2:
                    passo.video = passosReceita[indice]
                case 3:
                    passo.timer = passosReceita[indice]
                default:
                    print("Placeholder")
                }
                
                contArray += 1
                
                if(contArray == 4){
                    contArray = 0
                    receita3.addToRelationship(passo)
                }
            }
            
            receitasArray.append(receita1)
            receitasArray.append(receita2)
            receitasArray.append(receita3)
            
            print("Receitas criadas")
            
        }else{
            self.receitasArray = resultsReceita
            self.passosArray = resultsPassos
            print("Receitas retornadas")
        }
        
        try! container.viewContext.save()
        
        tableView.reloadData()
        
        
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
    
    
    
    // Quando for mudar de view vai mandar a receita selecionada para proxima view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "segue" ) {
            let dest = segue.destination as! DetailsViewController
            dest.data = receitasArray[myIndex]
        }
        
    }
    
    
}
