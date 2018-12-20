//
//  DetailVC.swift
//  DreamLister
//
//  Created by Rusheel  Sandri on 9/10/18.
//  Copyright © 2018 Rusheel  Sandri. All rights reserved.
//

import UIKit
import CoreData


class DetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var priceField : CustomTextField!
    @IBOutlet weak var titleField : CustomTextField!
    @IBOutlet weak var detailField : CustomTextField!
    
    var imagePicker : UIImagePickerController!

    @IBOutlet weak var imagePickerImage: UIImageView!
    var itemToEdit: Items?
    var numberofStore = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self


//        let store = Store(context: context)
//        store.name = "bestBuy"
//
//        let store2 = Store(context: context)
//        store2.name = "Target"
//
//        let store3 = Store(context: context)
//        store3.name = "Walmat"
//
//        let store4 = Store(context: context)
//        store4.name = "Amazon"
//
//        let store5 = Store(context: context)
//        store5.name = "Gmart"
//
//
        getStore()
        if itemToEdit != nil {
            print ("attempt load item data()")
            loadItemData()
        }
        

//        ad.saveContext()



        // Do any additional setup after loading the view.
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = numberofStore[row]
        return store.name
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberofStore.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //update when selected
    }

    func getStore () {

        let fetchRequest :NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.numberofStore = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let err = error as NSError
            print("\(err)")
        }
    }

    @IBAction func savePressed(_ sender: Any) {
       // let item = Items(context: context)

        // to replace the item insted on recreating again
        var item : Items!

        if itemToEdit == nil {
            item = Items(context: context)

        } else {
            item = itemToEdit
        }

        if let title = titleField.text {
            item.title = title
        }

        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
            //converting double to string
        }
        if let details = detailField.text {
            item.details = details
        }
        item.toStore = numberofStore[storePicker.selectedRow(inComponent: 0)]
 //dismiss(animated: true, completion: nil)
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    func loadItemData (){
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailField.text = item.details
            

            if let store = item.toStore {

                var index = 0
                repeat {

                    let s = numberofStore[index]
                    if s.name == store.name {

                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1

                } while (index < numberofStore.count)
            }
        }
    }

    @IBAction func deleteItem(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
                 }
        navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {


        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerImage.image = img
            navigationController?.popViewController(animated: true)

        }

    }
    
   
 

}
