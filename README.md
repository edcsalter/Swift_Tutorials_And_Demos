<h1 style="color:orange;text-align:center;font-family:Exo-Thin"><u>Swift iOS Demos</u></h1>
<a href="https://coderwall.com/madarkitekt">Endorse</a>

The following apps demo Swift, as well as the expanded capabilities of Xcode 11

# SwiftUI
## Build Sheets
### BullsEye
* Uses SwiftUI w/UIKit

### MacBullsEye
* SwiftUI on macOS and iPadOS

### Packages
* Swift Packages of the game thus far

### RGBullsEye
* SwiftUI demo app
* Original app's capabilities then expanded upon
* Uses UIKit w/SwiftUI 

### TVBullsEye
* SwiftUI on AppleTV

### Notes
* Declarative app development
    * declare how views should look and what data they depend on
    * declare how view's state affects its appearance & how SwiftUI should react to change in data dependencies 
* Essentially a *reactive* UI
* Help speed up app development
    * **Views**
        * Declarative UI doesn't need stringly-typed identifiers to stay in sync with code
        * use views 4 layout and navigation and encapsulate presentation logic for a specific piece of data
        * API consistent across platforms
        * Controls describe their role not appearance - same control looks appropriate for every platform 
    * **Data**
        * Declarative data dependencies update views upon data change - the framework recomputes the views and all their children, then renders what has changed
        * View's state depends on its data => declare *how* view uses data, how view reacts to data changes, or how data affects the view
        * Declare possible states for view and how view appears in each state 
    * **Navigation**
        * Conditional subviews *can* replace navigation
    * **Integration**
        * Easy to integrate SwiftUI into UIKit app and vice versa
    * SwiftUI manages dependencies to keep views consistent with their state => don't have to worry about doing things in the right order or forgetting to update a UI object
    * Canvas means no need for storyboard 
    * Subviews keep selves updated means no need for view controller
    * Live preview means not as much a need for simulator

<h3 style="font-family:Exo-Thin">AdaptiveWeather</h3>
AdaptiveWeather’s two views are truly universal, scaling to any device and transitioning from a vertical stack, to horizontal row depending on orientation. No code alteration necessary, results were achieved purely  through Storyboard.

* Adaptive Layout

* Adaptive Font

* Device-Dependent Images (Including Retina HD images for iPhone 6 Plus)

 
### CoreDataTest
* Username & Password storage and retrieval


### Audio Session / EZAudio / CocoaPods Code is Up - Tutorial in Progress

* Measuring incoming audio levels using AVAudioSession while simultaneously drawing a waveform using [EZAudio](https://github.com/MadArkitekt/EZAudio)

  * _A tutorial explaining the previous will be available at [techEd](http://edsaltertech.com)_
</div>

## Data Structures & Algorithms
### Data Structures:
### Stack
* **LIFO** 
* Essential operations
    - **push**
    - **pop**

### Linked List
* Linear & unidirectional
* O(1) time complexity for head-first insertion (Arrays have O(n) time complexity for head-first insertions)
* Conforming to collection protocols, Sequence and Collection, affords host of methods for fairly small set of requirements
* **Copy-on-write** (value semantics)

### Queues
* **FIFO**
* **Enqueue** inserts at end of queue
* **Dequeue** removes from front of queue
* Elements *not* stored in contiguous memory blocks like Array. This scattered storage has potential for cache misses.
* **Ring-buffer-queue** good for queues of fixed size
* Leveraging two stacks improves ```dequeue(_:)``` time complexity to amortized O(1)
* Double-stack beats out Linked List in spacial locality
