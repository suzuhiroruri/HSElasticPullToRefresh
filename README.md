# HSElasticPullToRefresh
Elastic pull to refresh compontent developed in Swift

Tutorial on how this bounce effect was achieved can be found [here](https://medium.com/@gontovnik/elastic-view-animation-or-how-i-built-dgelasticpulltorefresh-269a3ba8636e#.9dioekqv6).

![](https://raw.githubusercontent.com/gontovnik/DGElasticPullToRefresh/master/DGElasticPullToRefreshPreview1.gif)
![](https://raw.githubusercontent.com/gontovnik/DGElasticPullToRefresh/master/DGElasticPullToRefreshPreview2.gif)

## Requirements
* Xcode 10.2 or higher
* iOS 8.0 or higher (may work on previous versions, just did not test it)
* ARC
* Swift 5.0

## Demo

Open and run the HSElasticPullToRefreshExample project in Xcode to see HSElasticPullToRefresh in action.

## Installation

### CocoaPods

``` ruby
pod 'HSElasticPullToRefresh'
```

### Manual

Add HSElasticPullToRefresh folder into your project.

## Example usage

``` swift
// Initialize tableView
let loadingView = HSElasticPullToRefreshLoadingViewCircle()
loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
tableView.hs_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
    // Add your logic here
    // Do not forget to call hs_stopLoading() at the end
    self?.tableView.hs_stopLoading()
}, loadingView: loadingView)
tableView.hs_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
tableView.hs_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
```

Do not forget to remove pull to refresh on view controller deinit. It is a temporary solution.

``` swift
deinit {
    tableView.hs_removePullToRefresh()
}
```

### Description

Add pull to refresh without loading view:

``` swift
func hs_addPullToRefreshWithActionHandler(_ actionHandler: @escaping () -> Void)
```

Add pull to refresh with loading view:

``` swift
func hs_addPullToRefreshWithActionHandler(_ actionHandler: @escaping () -> Void, loadingView: HSElasticPullToRefreshLoadingView?)
```

You can use built-in *HSElasticPullToRefreshLoadingViewCircle* or create your own by subclassing **HSElasticPullToRefreshLoadingView** and implementing these methods:

``` swift
func setPullProgress(_ progress: CGFloat)
func startAnimating()
func stopLoading()
```

Remove pull to refresh:

``` swift
func hs_removePullToRefresh()
```

Set auto start loading:

``` swift
func hs_startLoading()
```

Change pull to refresh background color:

``` swift
func hs_setPullToRefreshBackgroundColor(_ color: UIColor)
```

Change pull to refresh fill color:

``` swift
func hs_setPullToRefreshFillColor(_ color: UIColor)
```

## Contribution

Please feel free to submit pull requests. Cannot wait to see your custom loading views for this pull to refresh.

## License

The MIT License (MIT)

Copyright (c) 2019 Hiromasa Suzuki

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
