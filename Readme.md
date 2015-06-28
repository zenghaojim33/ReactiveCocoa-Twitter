### 前言

#### MVC
***

![image](http://img.objccn.io/issue-13/mvvm1.png)

我们都熟悉MVC. 它意思是Model View Controller, Model 呈现数据，View 呈现用户界面，而 View Controller 调节它两者之间的交互.


稍微考虑一下，虽然 View 和 View Controller 是技术上不同的组件，但它们几乎总是手牵手在一起，成对的。你什么时候看到一个 View 能够与不同 View Controller 配对？所以实际上它们的连接是这样的：

![image](http://img.objccn.io//issue-13/intermediate.png)

许多逻辑被放在 View Controller 里，它的重量日益增长，而一般应用最需要测试的偏偏就是View Controller内的各种逻辑。

#### MVVM
***

事实上，这些逻辑中的一些确实属于 View Controller，但更多的是所谓的“表示逻辑（presentation logic）”，以 MVVM 属术语来说，就是那些将 Model 数据转换为 View 可以呈现的东西的事情，例如将一个 NSDate 转换为一个格式化过的 NSString。

这个表示层我们将其称为 “View Model” —— 它位于 View/Controller 与 Model 之间：

![image](http://img.objccn.io//issue-13/mvvm.png)

看起好多了！这个图解准确地描述了什么是 MVVM：一个 MVC 的增强版，我们正式连接了视图和控制器，并将表示逻辑从 Controller 移出放到一个新的对象里，即 View Model。MVVM 听起来很复杂，但它本质上就是一个精心优化的 MVC 架构，而 MVC 你早已熟悉。

总结MVVM的好处：

* MVVM 可以兼容当下使用的 MVC 架构
* MVVM 可以给ViewController瘦身
* MVVM 增强应用的可测试性
* MVVM 配合一个绑定机制效果最好


### MVVM在项目中的规范
*** 

#### Xcode目录

继续保持目前的结构

```
| - app/
  | - controllers/
  | - views/  
  | - models/
  | - modules/
```  

而View Model跟随具体的View Controller、View、Cell等

比如说一个收藏列表的View Controller，可以如下安排目录

```
| - app/
  | - controllers/
     | - Favorite/
        | - FavoriteViewController.h
        | - FavoriteViewController.m
        | - FavoriteViewController.storyboard
        | - FavoriteViewModel.h
        | - FavoriteViewModel.m                                
  | - views/        
     | - Favorite/
        | - FavoriteCell.h
        | - FavoriteCell.m
        | - FavoriteCell.xib
        | - FavoriteCellViewModel.h
        | - FavoriteCellViewModel.m                                  
  | - models/
  | - modules/
```  

#### MVVM基本原则

**Views层 (包含View、ViewController)**

* View层可以访问View层和View Model层
* View层**不应该**发起网络调用、校验数据或者存储数据等操作
* View层**不应该**管理网络请求、数据库请求返回的Model数据，也**不应该**控制翻页
* View层**不应该**访问Model层

**View Model层**

* View Model负责将Model层对象，逻辑运算成合适View层显示的格式
* View Model负责发起网络调用、校验数据或者存储数据等操作
* View Model负责管理网络请求、数据库请求返回的Model数据，控制翻页
* View Model**不能**访问View层
* View Model可以访问其它View Model层、Model层、发起网络请求等
* View Model接受来自View层或者其它View Model的发起调用
* View Model仅需暴漏View层所必需的最小量信息, View层实际上并不在乎View Model是如何获得这些信息的，所以View Model的共有属性都是readonly的



### MVVM伸延

#### 常见场景分析
***
我们可以传入Model对象来初始化View Model，Views层获取View Model校验运算后的共有属性来显示，而当Model中数据变化时，怎样更新Views层呢？

MVVM基本原则不允许View Model访问View层，所以我们不能将View层暴露给View Model, 相关数据变化或类似事件时调用View层的 “updateUI” 方法

正确做法是:

1. Model数据更新，回调通知Views层
2. Views层收到回调，访问View Model的共有属性来刷新UI
3. View Model以现在Model的最新数据来运算返回给Views层使用

#### [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
*** 
以上场景我们还可以使用ReactiveCocoa来绑定属性，这样View Model就能在背后的Model改变时更新自身的属性。Model的改变就能通过这种绑定机制，级联向下通过View Model更新Views层。更加简化代码结构。

而[ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)需要一定的学习成本，暂时先不推广使用，有兴趣的同学，建议去学习一下



