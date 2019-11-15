# SwiftUIAppArchitecture

SwiftUI app architecture we use.

MVVM-F = MVVM architecture + Factory;

SOLID principles are the core of our architecture.


## 1. For assembling project we use DI pattern with [Swinject](https://github.com/Swinject/Swinject) library.

App has shared [Container](https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md) where we register all shared dependencies we need to use across the whole app.

## 2. Every View Module for [example](https://github.com/techpro-studio/SwiftUIAppArchitecture/tree/master/SwiftUIAppArchitecture/Main) has the following structure:

### Factory 
  Abstraction for creation View. Factory is very important part of this architecture, because it injects dependencies. 
 [BaseFactory](https://github.com/techpro-studio/RCKit/blob/master/Sources/RCKit/BaseFactory.swift) contains Container we use to inject dependencies that we need.
 We can inject factories in other views via DI and it gives us a lot of flexibility. We use type erased AnyView for more flexibility.
  
```swift
  protocol <Name>ViewFactory {
    func make()-> AnyView
  } 
```

### ViewModel
  It contains a logic of the presentation. It has the bindings for input and output.
  The biggest problem here that ObservableObject has Self requirement and can't be used as an Abstraction like a protocol and even as 
  an abstract class. If you try to use ConcreteViewModel as a child of a base abstract ViewModel class with properties and abstract methods, 
  then @Published properties  will not update view. And this is a huge fail for flexibility,
   because we can't use viewModel as an abstraction.
 
 ```swift
 
 // for example
 class <Name>ViewModel : ObservableObject {
 
     private let reachabillityManager:  ReachabilityManager
 
     init(reachabillityManager: ReachabilityManager) {
         self.reachabillityManager = reachabillityManager
         super.init()
         self.computePublishers()
     }
 
     @Published  var input: String = ""
     @Published  var isButtonEnabled = false
 
 
     func computePublishers() {
 
         self.reachabillityManager.reachable.combineLatest($input).map { (reachable, input) -> Bool in
             if !reachable{
                 return false
             }
             return input.count >= 5
         }.receive(on: RunLoop.main)
         .assign(to: \MainViewModel.isButtonEnabled, on: self)
         .store(in: &cancellableBag)
 
     }
 
 
 }
  ```
  
### View 
Just simple SwiftUI view.   
It contains viewModel and child view factories.
  
  ```swift
    struct <Name>View: View {
    
        @ObservedObject var viewModel: <Name>ViewModel
        let otherViewFactory: <Other>ViewFactory
    
        @State private var isActiveDetail = false
    
        var body: some View {
            NavigationView {
                VStack {
                    TextField("Input", text: $viewModel.input).frame(height: 50.0)
                    NavigationLink(destination: otherViewFactory.make(value: viewModel.input), isActive: $isActiveDetail, label: {Text("GO!")}).disabled(!viewModel.isButtonEnabled)
                }.frame(width: 200.0).navigationBarTitle("Main")
            }
        }
    }
  ```
  

  
  
  
  
  
  





