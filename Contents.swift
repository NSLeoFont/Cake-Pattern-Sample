
import UIKit

/*:
 
 Based on the concept that “one should only inject via an interface (protocol), not concrete class”.
 The Cake pattern comes from the Scala world
 
 */

struct Product {
    var name: String
    var price: Double
}


//: We create a protocol that will define our repository. This protocol will have a method that will fetch all of our products for us.
protocol ProductsRepository {
    func fetchProducts() -> [Product]
}

struct ProductsRepositoryImplementation: ProductsRepository {
    func fetchProducts() -> [Product] {
        return [Product(name: "iPhone X", price: 1320.0),Product(name: "Macbook Pro", price: 3400.0), Product(name: "Monitor 27", price: 740.30)]
    }
}

protocol ProductsRepositoryInjectable {
    var products: ProductsRepository { get }
}

extension ProductsRepositoryInjectable {
    
    var products: ProductsRepository {
        return ProductsRepositoryImplementation()
    }
}

struct ProductViewModel: ProductsRepositoryInjectable {
    
    init() {
        self.products.fetchProducts().forEach {
            print("This \($0.name) costs R\($0.price)")
        }
    }
}

class CakeVC: UIViewController {
    
    let viewModel: ProductsRepositoryInjectable!
    
    init(viewModel: ProductsRepositoryInjectable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
}

let injectedViewModel = ProductViewModel()
let leoVc = CakeVC(viewModel: injectedViewModel)


