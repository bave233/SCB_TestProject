//
//  SCBTestHomeViewController.swift
//  SCB
//
//  Created by Dev on 10/1/2562 BE.
//  Copyright (c) 2562 Chiabro. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol SCBTestHomeDisplayLogic: class {
    func displaySCBTestHomeData(viewModel: SCBTestHome.GetSCBTestHome.ViewModel)
}

class SCBTestHomeViewController: UIViewController, SCBTestHomeDisplayLogic ,UITableViewDataSource,UITableViewDelegate,UITabBarDelegate,UITabBarControllerDelegate{
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = SCBTestHomeInteractor()
        let presenter = SCBTestHomePresenter()
        let router = SCBTestHomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    var interactor: SCBTestHomeBusinessLogic?
    var router: (NSObjectProtocol & SCBTestHomeRoutingLogic & SCBTestHomeDataPassing)?
    
    var SCBTestModel: [SCBTestModel] = []
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var tabBarItem2: UITabBarItem!
    @IBOutlet weak var tabBarItem1: UITabBarItem!
    @IBOutlet var tableView: UITableView!
    
    let scbObjectIdentifier = "SCBObjectCell"
    var likedSCBTestModel : [likedSCBTestModel] = []
    var offsets = [IndexPath: CGFloat]()
    var isAllToggle : Bool = false
    var progressView = JGProgressHUD(style: .dark)
    
    var toggleAvartarView: UIView? = nil
    
    // MARK: View lifecycle
    func setupOnViewFirstLoad() {
        definedAccessibilityIdentifierComponents()
        registerTableView()
        getSCBTestHomeData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnViewFirstLoad()
        tabBar.delegate = self
        tabBar.selectedItem = tabBarItem1
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    fileprivate func definedAccessibilityIdentifierComponents() {
        tableView.accessibilityIdentifier = "SCBTestHomePageTableView"
    }
    
    //MARK: - Function
 
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        if item.tag == 0 {
            item.badgeColor = #colorLiteral(red: 0.7843137255, green: 0.1843137255, blue: 0.3921568627, alpha: 1)
            isAllToggle = false
            tableView.reloadData()
        } else if item.tag == 1  {
            item.badgeColor = #colorLiteral(red: 0.9843137255, green: 0.003921568627, blue: 0.3764705882, alpha: 1)
            isAllToggle = true
            tableView.reloadData()
        }
    }
    //MARK: - Request
    func getSCBTestHomeData() {
        progressView.show(in: self.view, animated: true)
        interactor?.getSCBTestHomeData(request: SCBTestHome.GetSCBTestHome.Request())
    }
    
    //MARK: - Display
    func displaySCBTestHomeData(viewModel: SCBTestHome.GetSCBTestHome.ViewModel) {
        progressView.dismiss()
        
        switch viewModel.result {
        case .success(let data):
            SCBTestModel = data
            tableView.reloadData()
        case .failure:
            break
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !(segue.identifier?.isEmpty)! {
            router?.routeToViewController(segue: segue, for: sender)
        }
    }
    
    
 
  
    @IBAction func sortingAction(_ sender: UIBarButtonItem) {
        // create the alert
        if !isAllToggle {
            let alert = UIAlertController(title: "Sort", message: "SortingProducts", preferredStyle: UIAlertController.Style.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Price Low to High", style: UIAlertAction.Style.default, handler: { action in
               self.SCBTestModel  = self.SCBTestModel.sorted(by: { Int($0.price!) < Int($1.price!) })
               
            }))
            alert.addAction(UIAlertAction(title: "Price High to low", style: UIAlertAction.Style.cancel, handler: { action in
                self.SCBTestModel = self.SCBTestModel.sorted(by: { Int($0.price ?? 0) > Int($1.price ?? 0) })
                
            }))
            alert.addAction(UIAlertAction(title: "Rating", style: UIAlertAction.Style.destructive, handler: { action in
                 self.SCBTestModel  = self.SCBTestModel.sorted(by: { Int($0.rating ?? 0 ) > Int($1.rating ?? 0) })
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { action in
                 self.dismiss(animated: true, completion: nil)
            }))
             self.tableView.reloadData()
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        
     
    }
    
    //TableView
    
    //Remove
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.likedSCBTestModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func registerTableView() {
        tableView.register(UINib(nibName: scbObjectIdentifier, bundle: nil), forCellReuseIdentifier: scbObjectIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SCBTestModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let ratio: CGFloat = 95.0 / 375.0
        return (screenWidth * ratio) + 5.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isAllToggle {
            
             let cell = tableView.dequeueReusableCell(withIdentifier: scbObjectIdentifier, for: indexPath) as! SCBObjectCell
            cell.likeButton.isHidden = true
            cell.likeButton.isEnabled = false
            if likedSCBTestModel.count != 0 {
                if let mUrl = URL(string: likedSCBTestModel[indexPath.section].likethumbImageURL! ) {
                    let url = mUrl
                    let data = try? Data(contentsOf: url)
                    cell.SCBObjectImageView.image = UIImage(data: data!)
                }
                
               
                
                cell.lbTitle.text = likedSCBTestModel[indexPath.section].name
                cell.lbDescp.text = likedSCBTestModel[indexPath.section].description
                
                cell.lbRating.text = "\(likedSCBTestModel[indexPath.section].rating ?? 0)"
                cell.lbPrice.text = "\(likedSCBTestModel[indexPath.section].price ?? 0)"
                return cell
            }
            tableView.reloadData()
        } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: scbObjectIdentifier, for: indexPath) as! SCBObjectCell
            
            if let mUrl = URL(string: SCBTestModel[indexPath.section].thumbImageURL! ) {
                let url = mUrl
                let data = try? Data(contentsOf: url)
                cell.SCBObjectImageView.image = UIImage(data: data!)
            }
            
                cell.lbTitle.text = SCBTestModel[indexPath.section].name
                cell.lbDescp.text = SCBTestModel[indexPath.section].description

                cell.likeCLick = {
                    let indexPathTapped = tableView.indexPath(for: cell)
                    let hasFav = self.SCBTestModel[(indexPathTapped?.section)!].hasFav
                    var favFlag : String = ""
                    if  self.likedSCBTestModel[indexPath.section].likeFlag !=  nil {
                        self.SCBTestModel[(indexPathTapped?.section)!].hasFav = false
                    }
                    if hasFav! {
                        self.SCBTestModel[(indexPathTapped?.section)!].hasFav = false
                        favFlag = "unlike"
                    } else {
                        self.SCBTestModel[(indexPathTapped?.section)!].hasFav = true
                        favFlag = "like"
                    }
                    cell.likeButton.tintColor = self.SCBTestModel[(indexPathTapped?.section)!].hasFav! ? UIColor.red : UIColor.white
                    
                    if favFlag == "like" {
                        self.likedSCBTestModel[indexPath.section] = self.SCBTestModel[indexPath.section] as! likedSCBTestModel
                        self.likedSCBTestModel[indexPath.section].likeFlag = true
                    } else if favFlag == "unlike" {
                        self.likedSCBTestModel[indexPath.section].likeFlag = false
                        self.likedSCBTestModel = self.likedSCBTestModel.filter{ $0.likeFlag == true}
                    }
                }
                cell.lbRating.text = "\(SCBTestModel[indexPath.section].rating ?? 0)"
                cell.lbPrice.text = "\(SCBTestModel[indexPath.section].price ?? 0)"
                cell.bannerClick = {
                    self.interactor?.SCBTestModel = self.SCBTestModel[indexPath.section]
                    self.router?.navigateToSCBObjectDetail()
                }
                return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: nil)

    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
}
