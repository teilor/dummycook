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
            
            struct DescricaoPasso {
                var text: String
                var titulo : String
                var imagemPasso: String
                var video: String
                var timer: String
                var indice: Int16
                
                init(text: String, imagemPasso: String, video: String, timer: String, indice: Int16, titulo: String) {
                    self.text = text
                    self.imagemPasso = imagemPasso
                    self.video = video
                    self.timer = timer
                    self.titulo = timer
                    self.indice = indice
                    self.titulo = titulo
                }
                
            }
            
            var passosReceita: [DescricaoPasso] = []

            passosReceita += [DescricaoPasso.init(text:"Melt the sugar in a pan over low heat, stiring constantly, until the sugar becomes a golden brown syrup.", imagemPasso: "", video: "step1.mov",timer: "20", indice: 1, titulo: "Melt the sugar")] //Passo 1 com video
            passosReceita += [DescricaoPasso.init(text: "Once the sugar becomes a golden brown syrup, it`s ready. Switch the stove off.", imagemPasso: "step2",video: "", timer: "20", indice: 2, titulo: "Turning off the stove")] //Passo 2 com foto
            passosReceita += [DescricaoPasso.init(text:"Place all other ingredients into a blender, blend it for 5 minutes.", imagemPasso: "", video: "step3.mov", timer: "20", indice: 3, titulo: "Blend the ingredients")] //Passo 3 com video
            passosReceita += [DescricaoPasso.init(text:"Pour mixture into the pan. The pan is now with the sugar caramelized", imagemPasso: "step4", video: "", timer: "20", indice: 4, titulo: "Pour the mixture into the pan")] //Passo 4 com foto
            passosReceita += [DescricaoPasso.init(text:"Place water into a cake tin. Then, place the pan with the mixture and the caramelized sugar inside", imagemPasso: "step5", video: "", timer: "20", indice: 5, titulo: "Place water into a cake tin")] //Passo 5 com foto
            passosReceita += [DescricaoPasso.init(text:"Turn on the oven at 200 degrees and put the  cake tin inside. Let it cook for 2 hours.", imagemPasso: "step6",video: "",timer: "20", indice: 6, titulo: "Put the cake tin into the oven")] //Passo 6 com foto
            passosReceita += [DescricaoPasso.init(text:"Carefully remove your pan from the oven, watch out as the water will be very hot", imagemPasso: "step7", video: "", timer: "20", indice: 7, titulo: "Remove from the oven")] //Passo 7
            passosReceita += [DescricaoPasso.init(text:"The flan must cool for a few hours, better if you let it rest on the refrigerator overnight", imagemPasso: "", video: "", timer: "20", indice: 8, titulo: "Let it cool")] //Passo 8
            passosReceita += [DescricaoPasso.init(text:"To take if off the pan, heat the pan over low heat for 20 seconds, then invert into a serving plate. Pick a proper plate as it needs to be large enough for the flan and some of the caramel", imagemPasso: "step9", video: "", timer: "20", indice: 9, titulo: "Transfer to a plate")] //Passo 9
            passosReceita += [DescricaoPasso.init(text:"Enjoy your brazilian flan!", imagemPasso: "step10", video: "", timer: "20", indice: 10, titulo: "Enjoy your flan! 😊")]
            
            //For pra cadastrar os elementos do Array em cada atributo correto do passo
            for indice in 0...passosReceita.count-1 {
            
                let passo = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso

                passo.texto = passosReceita[indice].text
                passo.imagemPasso = passosReceita[indice].imagemPasso
                passo.video = passosReceita[indice].video
                passo.timer = passosReceita[indice].timer
                
                receita1.addToRelationship(passo)
                
            }
            
            passosReceita = []
            
            receita2.nome = "Double Layer Pumpkin Cheesecake"
            receita2.textoIngredientes = ["2 (8 ounce) packages cream cheese, softened", "1/2 cup white sugar", "1/2 teaspoon vanilla extract", "2 eggs", "1 (9 inch) prepared graham cracker crust", "1/2 pumpkin puree", "1/2 teaspoon ground cinnamon", "1 pinch ground cloves","1 pinch ground nutmeg", "1/2 cup frozen whipped topping thawed"] as NSArray
            receita2.time = "4h10"
            receita2.serves = "8"
            receita2.textoRequirements = "1 beater"
            receita2.imagemReceita = "1"
            receita2.cost = "R$ 24,00"
            
            //Estrutura do array: [0]Texto do passo, [1]Se tem imagem,[2]Se tem video,[3]Se tem timer
            passosReceita += [DescricaoPasso.init(text: "Turn on your oven to 325 degrees F (165 degrees C) and let it preheat", imagemPasso: "preheat",video: "", timer: "", indice: 1, titulo: "Turn on your oven")] //Passo 1
            passosReceita += [DescricaoPasso.init(text: "In a large bowl, combine cream cheese, sugar and vanilla and beat until smooth", imagemPasso: "mixing", video: "", timer: "", indice: 2, titulo: "Turn on your oven")] //Passo 2
            passosReceita += [DescricaoPasso.init(text: "Blend in eggs, one at a time", imagemPasso: "blendeggs", video:  "", timer:  "", indice: 3, titulo: "Turn on your oven")] //Passo 3
            
            
            //For pra cadastrar os elementos do Array em cada atributo correto do passo
            for indice in 0...passosReceita.count-1 {
                
                let passo = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
                
                passo.texto = passosReceita[indice].text
                passo.imagemPasso = passosReceita[indice].imagemPasso
                passo.video = passosReceita[indice].video
                passo.timer = passosReceita[indice].timer
            }
            
            passosReceita = []
            
            receita3.nome = "Pumpkin Ginger Cupcakes"
            receita3.textoIngredientes = [""] as NSArray
            receita3.time = "1h 20min"
            receita3.serves = "2 pratos"
            receita3.textoRequirements = "1 beater"
            receita3.imagemReceita = "2"
            receita3.cost = "R$ 24,00"
            
            //Estrutura do array: [0]Texto do passo, [1]Se tem imagem,[2]Se tem video,[3]Se tem timer
            passosReceita += [DescricaoPasso.init(text: "Turn on your oven to 325 degrees F (165 degrees C) and let it preheat", imagemPasso: "preheat", video: "", timer: "", indice: 1, titulo: "Turn on your oven")] //Passo 1
            passosReceita += [DescricaoPasso.init(text: "In a large bowl, combine cream cheese, sugar and vanilla and beat until smooth", imagemPasso: "mixing", video: "", timer: "", indice: 2, titulo: "Turn on your oven")] //Passo 2
            passosReceita += [DescricaoPasso.init(text: "Blend in eggs, one at a time", imagemPasso: "blendeggs", video: "", timer: "", indice: 3, titulo: "Turn on your oven")] //Passo 3
            
            for indice in 0...passosReceita.count-1 {
                
                let passo = NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: container.viewContext) as! CDPasso
                
                passo.texto = passosReceita[indice].text
                passo.imagemPasso = passosReceita[indice].imagemPasso
                passo.video = passosReceita[indice].video
                passo.timer = passosReceita[indice].timer

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
