CYHMultiRevealViewController
============================

A view controller which can slide in and out by side and push with unlimited views.

Features
============================

- Easy to use
- Unlimited view controllers
- Multi-Directions to slide in

Exapmles
============================
You can set 4 directions for the view controller to slide in.

Direction Left

---
![screen-shot](https://rawgithub.com/yuhua-chen/CYHMultiRevealViewController/master/README/screen-shot-left.gif)

----------------------------

Direction Top

---
![screen-shot](https://rawgithub.com/yuhua-chen/CYHMultiRevealViewController/master/README/screen-shot-top.gif)

Usage
============================
To Initialize `CYHMultiRevealViewController`
```objective-c
UIViewController *aViewController = [[UIViewController alloc] init];
UIViewController *bViewController = [[UIViewController alloc] init];
UIViewController *cViewController = [[UIViewController alloc] init];

CYHMultiRevealViewController *revealViewController = [[CYHMultiRevealViewController alloc] initWithView:self.view andViewControllers:@[aViewController,bViewController,cViewController]];
//set up the direction(default is CYHRevealDirectionLeft)
revealViewController.direction = CYHRevealDirectionTop;
```
simply to use like `push` or `pop`, even push new view controller dynmaically
```objective-c
//to push next view
[revealViewController push];

//to pop out view
[revealViewController pop];

UIViewController *newViewController = [[UIViewController alloc] init];
[revealViewController pushViewController:newViewController];

```

License
============================
MIT