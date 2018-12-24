//
//  RandomUserTableViewController.swift
//  TeamDavid-Sprint-5
//
//  Created by David Doswell on 12/23/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

struct RandomUsers: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
    var users: [RandomUser]
}

struct RandomUser: Decodable {
    
    enum Images: String {
        case thumbnail
        case large
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone"
        case emailAddress = "email"
        case imageURLs = "picture"
        
        enum NameCodingKeys: String, CodingKey {
            case first
            case last
        }
        
        enum ImageCodingKeys: String, CodingKey {
            case thumbnail
            case large
        }
    }
    
    var name: String
    var phoneNumber: String?
    var emailAddress: String?
    var largeURL: URL?
    var thumbnailURL: URL?
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        let first = try nameContainer.decodeIfPresent(String.self, forKey: .first)
        let last = try nameContainer.decodeIfPresent(String.self, forKey: .last)
        
        var name = ""
        if let first = first, let last = last {
            name = "\(first) \(last)"
        } else if let first = first {
            name = first
        } else if let last = last {
            name = last
        }
        
        let phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        let emailAddress = try container.decodeIfPresent(String.self, forKey: .emailAddress)
        
        let imageContainer = try container.nestedContainer(keyedBy: CodingKeys.ImageCodingKeys.self, forKey: .imageURLs)
        let largeURLString = try imageContainer.decodeIfPresent(String.self, forKey: .large)
        let thumbnailURLString = try imageContainer.decodeIfPresent(String.self, forKey: .thumbnail)
        
        var largeURL: URL?
        if let string = largeURLString {
            largeURL = URL(string: string)
        }
        var thumbnailURL: URL?
        if let string = thumbnailURLString {
            thumbnailURL = URL(string: string)
        }
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.largeURL = largeURL
        self.thumbnailURL = thumbnailURL
    }
}

class RandomUserClient {
    
    let url = BaseURL().string
    
    func fetchUsers(completion: @escaping ([RandomUser]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching users: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else { completion(nil, NSError()); return }
            
            do {
                let randomUsersModel = try JSONDecoder().decode(RandomUsers.self, from: data)
                let randomUsers = randomUsersModel.users
                completion(randomUsers, nil)
                return
            } catch {
                NSLog("Error decoding users: \(error)")
                completion(nil, error)
                return
            }
            }.resume()
    }
    
}

class RandomUserTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomUserClient.fetchUsers { (randomUsers, error) in
            if let error = error {
                NSLog("Error fetching users: \(error)")
                return
            }
            self.randomUsers = randomUsers
        }
    }
    
    let randomUserClient = RandomUserClient()
    var randomUsers: [RandomUser]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var thumbnailCache: Cache<String, UIImage> = Cache()
    var userFetchQueue = OperationQueue()
    var fetchRequests: [String: FetchImageOperation] = [:]
    
    
    private func loadImage(forCell cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        guard let randomUser = randomUsers?[indexPath.row], let phoneNumber = randomUser.phoneNumber else { return }
        
        if let phoneNumber = randomUser.phoneNumber, let image = thumbnailCache.value(for: phoneNumber) {
            cell.imageView?.image = image
            
        } else {
            
            let fetchOperation = FetchImageOperation(randomUser: randomUser, imageType: .thumbnail)
            
            let blockOperation = BlockOperation {
                guard let image = fetchOperation.image else { return }
                self.thumbnailCache.cache(value: image, for: phoneNumber)
            }
            blockOperation.addDependency(fetchOperation)
            
            let op3 = BlockOperation {
                guard let image = fetchOperation.image else { return }
                if indexPath == self.tableView.indexPath(for: cell) {
                    cell.imageView?.image = image
                }
            }
            op3.addDependency(fetchOperation)
            
            userFetchQueue.addOperations([fetchOperation, blockOperation], waitUntilFinished: false)
            OperationQueue.main.addOperation(op3)
            fetchRequests[phoneNumber] = fetchOperation
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomUsers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let randomUser = randomUsers?[indexPath.row]
        cell.textLabel?.text = randomUser?.name
        loadImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let randomUser = randomUsers?[indexPath.row], let phoneNumber = randomUser.phoneNumber else { return }
        let op = fetchRequests[phoneNumber]
        op?.cancel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as! RandomUserDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let randomUser = randomUsers?[indexPath.row]
            vc.randomUser = randomUser
            vc.title = randomUser?.name
        }
    }
}

