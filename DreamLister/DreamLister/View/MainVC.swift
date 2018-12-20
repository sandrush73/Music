//
//  MainVC.swift
//  DreamLister
//
//  Created by Rusheel  Sandri on 9/6/18.
//  Copyright © 2018 Rusheel  Sandri. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate  {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var controller : NSFetchedResultsController<Items>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        //generateTestData()
        attemptFetch()

        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)

        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = controller.fetchedObjects, obj.count > 0 {
            let item = obj[indexPath.row]

            performSegue(withIdentifier: "DetailVC", sender: item)
        }


    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            if let destination = segue.destination as? DetailVC{
                if let item = sender as? Items {
                    destination.itemToEdit = item

                }
            }
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        //update cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configCell(item: item)

    }
    ///setting up fetchrequest
    func attemptFetch() {
        let fetchRequest : NSFetchRequest<Items> = Items.fetchRequest()
        // creted controller

        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        //  how to sort things
        // to sort items based on timestamp

        fetchRequest.sortDescriptors = [dateSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath:nil, cacheName: nil)
        self.controller = controller
        controller.delegate = self
        //perfroming actual fetch
        do {
            try controller.performFetch()
        } catch {
            let error = error as? NSError
            print("\(error)")

        }
    }
    // when table view about to update it will start to listen to changes and handle things

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.beginUpdates()

    }

    //once contedt did change it updates
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.endUpdates()
    }


    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch (type) {

        case.insert:
            if let indexPath = newIndexPath {
                tableView?.insertRows(at: [indexPath], with: .fade)
            }
            break

        case.delete:
            if let indexPath = indexPath {
                tableView?.deleteRows(at: [indexPath], with: .fade)

            }
            break

        case.update:
            if let indexPath = indexPath{
                /// goes through config cell and updates
                let cell = tableView?.cellForRow(at: indexPath) as? ItemCell
                configureCell(cell: cell!, indexPath: indexPath as NSIndexPath)
                /// TODO update cell data.
            }
            break

        case.move:
            if let indexPath = indexPath{
                tableView?.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView?.insertRows(at: [indexPath], with:.fade)
            }
            break

        }

    }
    func generateTestData() {
        let item = Items(context: context)
        item.title = "AKG HeadPhones"
        item.price = 399
        item.details = "Wanna Buy them as soon as possible"

        let item2 = Items(context: context)
        item2.title = "New HeadPhones"
        item2.price = 399
        item2.details = "Wanna Buy them as soon as possible"

        let item3 = Items(context: context)
        item3.title = "Bose HeadPhones"
        item3.price = 399
        item3.details = "Wanna Buy them as soon as possible"
        ad.saveContext()
    }


}

