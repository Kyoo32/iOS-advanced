//
//  FlickrPhotosViewController.swift
//  FlickrSearch
//
//  Created by Lee Kyu-Won on 7/3/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FlickrCell"
private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)


extension FlickrPhotosViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        flickr.searchFlickrForTerm(textField.text!) { (results, error) in
            activityIndicator.removeFromSuperview()
            if error != nil{
                print("Error searching: \(error)")
            }
            
            if results != nil {
                print("Found \(results!.searchResults.count) matching \(results!.searchTerm)")
                self.searches.insert(results!, atIndex: 0)
                
                self.collectionView?.reloadData()
            }
        }
        textField.text = nil
        textField.resignFirstResponder()
        
        return true
    }
}


//layout 잡는 역할
extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let flickrPhoto = photoForIndexPath(indexPath)
        
        //when tapping
        if indexPath == largePhotoIndexPath {
            var size = collectionView.bounds.size
            size.height -= topLayoutGuide.length
            size.height -= (sectionInsets.top + sectionInsets.right)
            size.width -= (sectionInsets.left + sectionInsets.right)
            return flickrPhoto.sizeToFillWidthOfSize(size)
        }
        
        //normal state
        if var size = flickrPhoto.thumbnail?.size {
            size.width += 10
            size.height += 10
            return size
        }
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                                 insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return sectionInsets
    }
}



class FlickrPhotosViewController: UICollectionViewController {
    
    private var searches = [FlickrSearchResults]()
    private let flickr = Flickr()
    
    //for sharing
    private var selectedPhotos = [FlickrPhoto]()
    private let shareTextLabel = UILabel()
    
    func updateSharedPhotoCount() {
        shareTextLabel.textColor = themeColor
        shareTextLabel.text = "\(selectedPhotos.count) photos selected"
        shareTextLabel.sizeToFit()
    }
    
    var sharing : Bool = false {
        didSet {
            collectionView?.allowsMultipleSelection = sharing
            collectionView?.selectItemAtIndexPath(nil, animated: true, scrollPosition: .None)
            selectedPhotos.removeAll(keepCapacity: false)
            if sharing && largePhotoIndexPath != nil {
                largePhotoIndexPath = nil
            }

            let shareButton =
                self.navigationItem.rightBarButtonItems!.first
            if sharing {
                updateSharedPhotoCount()
                let sharingDetailItem = UIBarButtonItem(customView: shareTextLabel)
                navigationItem.setRightBarButtonItems([shareButton!,sharingDetailItem], animated: true)
            }
            else {
                navigationItem.setRightBarButtonItems([shareButton!], animated: true)
            }
        }
    }
    
    @IBAction func share(sender: AnyObject) {
        if searches.isEmpty {
            return
        }
        
        if !selectedPhotos.isEmpty {
           
        }
        
        sharing = !sharing
    }
    
    
    //for tapping a photo
    var largePhotoIndexPath : NSIndexPath? { //use when user taps a photo
        didSet {
            var indexPaths = [NSIndexPath]()
            if largePhotoIndexPath != nil {
                indexPaths.append(largePhotoIndexPath!)
            }
            if oldValue != nil {
                indexPaths.append(oldValue!)
            }
            collectionView?.performBatchUpdates({
                self.collectionView?.reloadItemsAtIndexPaths(indexPaths)
                return
            }){
                completed in
                if self.largePhotoIndexPath != nil {
                    self.collectionView?.scrollToItemAtIndexPath(
                        self.largePhotoIndexPath!,
                        atScrollPosition: .CenteredVertically,
                        animated: true)
                }
            }
        }
    }
    
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // 커스텀 셀 사용을 위해 지워주세요.
        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return searches[section].searchResults.count
    }
    
    override func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell :FlickrPhotoCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlickrPhotoCell
        let flickrPhoto = photoForIndexPath(indexPath)
        
        //셀을 재사용하기 위해, 전 행동의 애니메이션을 기본값(멈춤)으롤 바꾼다
        cell.activityIndicator.stopAnimating()
        
        //normal state
        if indexPath != largePhotoIndexPath {
            cell.imageView.image = flickrPhoto.thumbnail
            return cell
        }
        
        //탭해서 큰 사진 본 적이 있는 혹은 큰 사이즈가 로딩된 사진이라면, 큰 사진으로 보여준다
        if flickrPhoto.largeImage != nil {
            cell.imageView.image = flickrPhoto.largeImage
            return cell
        }
        
        //큰 사이즈가 로딩되기 전일때, 기본 섬네일 보여주기
        cell.imageView.image = flickrPhoto.thumbnail
        cell.activityIndicator.startAnimating()
        
        //탭하는 과정
        flickrPhoto.loadLargeImage {
            loadedFlickrPhoto, error in
            //로딩이 완료됐을 때
            cell.activityIndicator.stopAnimating()
            
            if error != nil {
                return
            }
            if loadedFlickrPhoto.largeImage == nil {
                return
            }
            if indexPath == self.largePhotoIndexPath {
                if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? FlickrPhotoCell {
                    cell.imageView.image = loadedFlickrPhoto.largeImage
                }
            }
        }
        cell.backgroundColor = UIColor.blackColor()
        cell.imageView.image = flickrPhoto.thumbnail
        return cell
        
    }

    //for header - similar to cellForItemAtIndexPath!
    override func collectionView(collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                                                   atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                      withReuseIdentifier: "FlickrPhotoHeaderView",
                                                                      forIndexPath: indexPath)
                    as! FlickrPhotoHeaderView
            headerView.label.text = searches[indexPath.section].searchTerm
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView,
                                 shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if sharing {
            return true
        }
        
        if largePhotoIndexPath == indexPath {
            largePhotoIndexPath = nil
        }
        else {
            largePhotoIndexPath = indexPath
        }
        return false
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if sharing {
            let photo = photoForIndexPath(indexPath)
            selectedPhotos.append(photo)
            updateSharedPhotoCount()
        }
    }
    
    override func collectionView(collectionView: (UICollectionView!),
                                 didDeselectItemAtIndexPath indexPath: (NSIndexPath!)) {
        if sharing {
            
            /*
             - find 사용할 수 없습니다.
              let index = find(tempBundleList, themeBundleEntity!)
             - 아래와 같이 바꿔 쓰세요. 
              let index = tempBundleList.indexOf(themeBundleEntity!)
             */
            if let foundIndex = selectedPhotos.indexOf(photoForIndexPath(indexPath)) {
                selectedPhotos.removeAtIndex(foundIndex)
                updateSharedPhotoCount()
            }
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
