CYHMultiRevealViewController
============================

A view controller which can slide in and out by side and push with unlimited views.

Features
============================

- Easy to use
- Unlimited view controllers

Exapmles
============================
You can set 4 directions for the view controller to slide in.

Direction Left
![screen-shot](https://rawgithub.com/yuhua-chen/CYHMultiRevealViewController/master/README/screen-shot-left.gif)

----------------------------

Direction Top
![screen-shot](https://rawgithub.com/yuhua-chen/CYHMultiRevealViewController/master/README/screen-shot-top.gif)

Usage
============================
```objective-c
UIViewController *aViewController = [[UIViewController alloc] init];
UIViewController *bViewController = [[UIViewController alloc] init];
UIViewController *cViewController = [[UIViewController alloc] init];

self.revealViewController = [[CYHMultiRevealViewController alloc] initWithView:self.view andViewControllers:@[aViewController,bViewController,cViewController]];
```

License
============================
MIT