//
//  UnitTestingAssignmentTests.swift
//  UnitTestingAssignmentTests
//
//  Created by Keto Nioradze on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class UnitTestForCartClassTests: XCTestCase {
    
    var cartViewModel: CartViewModel!

    override func setUpWithError() throws {
        cartViewModel = CartViewModel()
    }

    override func tearDownWithError() throws {
        cartViewModel = nil
    }

    func testAddProductWithDescription() {
        let testProduct = Product(id: 1, title: "Test Product", description: "Description Of Test Product", price: 50.0, selectedQuantity: 1)
        cartViewModel.addProduct(product: testProduct)
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1)
    }

    func testSelectedItemsQuantity() {
        let testProduct1 = Product(id: 1, title: "Test Product 1", description: "Description Of Test Product 1", price: 50.0, selectedQuantity: 3)
        let testProduct2 = Product(id: 2, title: "Test Product 2", description: "Description Of Test Product 2", price: 50.0, selectedQuantity: 2)
        
        cartViewModel.addProduct(product: testProduct1)
        cartViewModel.addProduct(product: testProduct2)
        let totalQuantity = cartViewModel.selectedItemsQuantity
        
        XCTAssertEqual(totalQuantity, 5)
    }
    
    func testTotalPrice() {
        let testProduct1 = Product(id: 1, title: "Test Product 1", description: "Description Of Test Product 1", price: 50.0, selectedQuantity: 1)
        let testProduct2 = Product(id: 2, title: "Test Product 2", description: "Description Of Test Product 2", price: 60.0, selectedQuantity: 1)
        
        cartViewModel.addProduct(product: testProduct1)
        cartViewModel.addProduct(product: testProduct2)
        
        let totalPrice = cartViewModel.totalPrice
        
        XCTAssertEqual(cartViewModel.totalPrice, 110)
    }
    
    func testAddProductsWithID()  {
        let testProduct = Product(id: 1, title: "Test Product", description: "Description Of Test Product", price: 50.0, selectedQuantity: 1)
        
        cartViewModel.allproducts = [testProduct]
        cartViewModel.addProduct(withID: 1)
        
        XCTAssertEqual(cartViewModel.selectedProducts.first?.id, 1)
    }
    
    func testAddRandomProduct() {
        let testProduct1 = Product(id: 1, title: "Test Product 1", description: "Description Of Test Product 1", price: 50.0, selectedQuantity: 1)
        let testProduct2 = Product(id: 2, title: "Test Product 2", description: "Description Of Test Product 2", price: 50.0, selectedQuantity: 1)
        let testProduct3 = Product(id: 3, title: "Test Product 3", description: "Description Of Test Product 3", price: 50.0, selectedQuantity: 1)
        
        cartViewModel.allproducts = [testProduct1, testProduct2, testProduct3]
        
        cartViewModel.addRandomProduct()
        let testID = cartViewModel.selectedProducts.first?.id
        XCTAssert(testID == 1 || testID == 2 || testID == 3 )
    }
    
    func testRemoveProduct() {
        let testProduct1 = Product(id: 1, title: "Test Product 1", description: "Description Of Test Product 1", price: 50.0, selectedQuantity: 1)
        
        cartViewModel.addProduct(withID: 1)
        cartViewModel.removeProduct(withID: 1)
        XCTAssertEqual(cartViewModel.selectedProducts.count, 0)
    }

    func testClearCart() {
        let testProduct1 = Product(id: 1, title: "Test Product 1", description: "Description Of Test Product 1", price: 50.0, selectedQuantity: 1)
        let testProduct2 = Product(id: 2, title: "Test Product 2", description: "Description Of Test Product 2", price: 50.0, selectedQuantity: 1)
        let testProduct3 = Product(id: 3, title: "Test Product 3", description: "Description Of Test Product 3", price: 50.0, selectedQuantity: 1)
        
        cartViewModel.allproducts = [testProduct1, testProduct2, testProduct3]
        cartViewModel.clearCart()
        
        XCTAssertEqual(cartViewModel.selectedProducts.count, 0)
    }
    
    func testFetchProducts() {
        let expectation = self.expectation(description: "fetchProducts")
        cartViewModel.fetchProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    XCTAssertNotNil(self.cartViewModel.allproducts)
                    XCTAssertFalse(self.cartViewModel.allproducts!.isEmpty)
                    expectation.fulfill()
                }
                
                waitForExpectations(timeout: 10)
    }
    
}
