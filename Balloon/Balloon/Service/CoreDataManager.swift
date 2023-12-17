//
//  DataMeneger.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 15.12.2023.
//

import CoreData

class CoreDataManager : ObservableObject{
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DiabetNoteCoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveNote(note: DiabetNoteModel) {
        let diabetNote = DiabetNote(context: persistentContainer.viewContext)
        diabetNote.fill(note: note)
           do {
               try persistentContainer.viewContext.save()
               print("save")
           } catch {
               print("Failed to save movie \(error)")
           }     
       }
    func getAllNotes() -> [DiabetNote] {
            let fetchRequest: NSFetchRequest<DiabetNote> = DiabetNote.fetchRequest()
        // Создание дескриптора сортировки по полю date
           let sortDescriptor = NSSortDescriptor(key: "date", ascending: true) // Установите `ascending: false`, если нужна обратная сортировка
           
           // Применение дескриптора сортировки к fetchRequest
           fetchRequest.sortDescriptors = [sortDescriptor]
            do {
                return try persistentContainer.viewContext.fetch(fetchRequest)
            } catch {
                return []
            }
            
        }
    
    func deleteNote(note: DiabetNote) {
            persistentContainer.viewContext.delete(note)
            do {
                try persistentContainer.viewContext.save()
            } catch {
                persistentContainer.viewContext.rollback()
                print("Failed to save context \(error)")
            }
            
        }
    
    func updateNote() {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                persistentContainer.viewContext.rollback()
            }
            
        }
}

extension DiabetNote {
    func fill(note: DiabetNoteModel) {
        self.id = UUID()
        self.blood = note.Blood
        self.comment = note.Comment
        self.date = note.Date
        self.longInsulin = note.LongInsulin
        self.shortInsulin = note.ShortInsulin
        self.xe = note.XE
    }
}
