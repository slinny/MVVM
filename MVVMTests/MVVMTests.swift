import XCTest
import UIKit
@testable import MVVM


final class MVVMTests: XCTestCase {
    var testItunesViewController: ItunesViewController!
    var testItunesViewModel: ItunesViewModel!
    var ituneTable: UITableView!
    var searchBar: UISearchBar!
    let endpoint = "search?term=a"
    
    override func setUpWithError() throws {
        super.setUp()
        testItunesViewController = ItunesViewController()
        testItunesViewModel = ItunesViewModel()
        testItunesViewController.ituneViewModel = ItunesViewModel()
        
        ituneTable = UITableView()
        testItunesViewController.ituneTable = ituneTable
        testItunesViewController.ituneTable.register(UINib(nibName: "ItunesTableViewCell", bundle: nil), forCellReuseIdentifier: "ItunesTableViewCell")
        testItunesViewController.ituneTable.dataSource = testItunesViewController
        
        searchBar = UISearchBar()
        testItunesViewController.searchBar = searchBar
        testItunesViewController.searchBar.delegate = testItunesViewController
    }
    
    override func tearDownWithError() throws {
        testItunesViewController = nil
        testItunesViewModel = nil
        ituneTable = nil
        searchBar = nil
        super.tearDown()
    }
    
    func testViewModelFetchData() throws {
        let expectation = XCTestExpectation(description: "ViewModel fetch data expectation")
        testItunesViewController.ituneViewModel.fetchData(from: Constants.baseURL.rawValue + endpoint) {
            XCTAssertFalse(self.testItunesViewController.ituneViewModel.getData().isEmpty, "Data should be fetched and not empty")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testViewModelClearData() throws {
        let expectation = XCTestExpectation(description: "ViewModel fetch data expectation")
        testItunesViewController.ituneViewModel.fetchData(from: Constants.baseURL.rawValue + endpoint) {
            self.testItunesViewController.ituneViewModel.clearData()
            XCTAssertTrue(self.testItunesViewController.ituneViewModel.getData().isEmpty, "Data should be empty")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testTableViewNumberOfRows() throws {
        guard let tableView = testItunesViewController.ituneTable else {
            XCTFail("tableView should not be nil")
            return
        }
        
        let expectation = XCTestExpectation(description: "Data fetched")
        
        testItunesViewController.ituneViewModel.fetchData(from: Constants.baseURL.rawValue + endpoint) {
            DispatchQueue.main.async {
                tableView.reloadData()
                XCTAssertEqual(tableView.numberOfRows(inSection: 0), self.testItunesViewController.ituneViewModel.getData().count, "Number of rows should match data count")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testTableCellForRowAt() throws {
        guard let tableView = testItunesViewController.ituneTable else {
            XCTFail("tableView should not be nil")
            return
        }
        
        let expectation = XCTestExpectation(description: "Data fetched")
        
        testItunesViewController.ituneViewModel.fetchData(from: Constants.baseURL.rawValue + endpoint) {
            self.testItunesViewController.ituneTable.reloadData()
            
            for i in 0..<self.testItunesViewController.ituneViewModel.getData().count {
                if let cell = self.testItunesViewController.tableView(tableView, cellForRowAt: IndexPath(row: i, section: 0)) as? ItunesTableViewCell {
                    XCTAssertNotNil(cell, "Cell should not be nil")
                } else {
                    XCTFail("TableView should not be nil")
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPIManagerFetchData() throws {
        let expectation = XCTestExpectation(description: "API fetch data expectation")
        
        APIManager.shared.fetchData(from: Constants.baseURL.rawValue + endpoint) { (data: Results?) in
            XCTAssertNotNil(data, "API should return non-nil data")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPIManagerFetchImage() throws {
        let imageUrl = "https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/52/ea/03/52ea0399-bfa9-4b0a-5b9f-a3b8a2ce07a8/9780062562982.jpg/60x60bb.jpg"
        let expectation = XCTestExpectation(description: "API fetch image expectation")
        
        APIManager.shared.fetchImage(from: imageUrl) { image in
            XCTAssertNotNil(image, "Image should be fetched and not nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

