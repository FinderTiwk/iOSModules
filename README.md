#iOS移动端模块化实现思路

## 0x00 什么是模块化
![](images/image001.gif)
这就是模块化。

## 0x01 模块化有什么好处

- 合理分工,提高工作效率
- 减少合并代码时的冲突(具体怎么能减少一会看完代码后再解释)
- 针对单个模块更容易做单元测试和功能测试
- 模块的替换变的更容易(单独模块的替换修改不会影响其它模块)
- 减少各功能模块间的耦合
- 拥抱变化,提高逼格

## 0x02 具体实现思路

### 1. 主工程只是一个外壳,由这个外壳将各个模块包装起来
### 2. 通过CocoaPods创建本地私有仓库,来管理各个功能模块。

但我本身不是很喜欢用这个东西。有下面几个原因：
> 1. 用这个东西那些配置全都它帮你做了,一些东西你不知道具体是怎么做的.
> 2. 假如你要修改某个库，下次pod install又要重新修改。
> 3. 在引用的第三库很少(8个以内)的时候感觉没有必要
> 4. 工程平白无故多了一个workspace，不喜欢
> 5. 有时候会出现一些莫明其妙的问题和原工程的一些配置冲突

说了这么多缺点，为什么还要用？？目前业界实现模块化都是靠这个东西来实现的。相比模块化带给我们的好处，这些缺点还是能接受的。

我在搭建本地私有库的时候Cocoapods该踩的坑也踩的差不多了...遇到问题总能解决的。

还有一点，之前和洪涛探讨过把我们一些常用的第三方库直接做成.a或者framework，一方面怕我们有改第三方库源码的需求，别一方面使用的第三方库版本不太固定，要针对多个版本制做.a或者.framework有点麻烦。
但做成.a或者framework的好处就是能加快编译速度。

## 0x03具体实现要求

1. 设计模块时自顶向下设计（软件工程中的一个理论，多读书和学习一些理论知识还是很有用的）
2. 每个模块设计合理的Services层,暴露此模块的API
3. 每个模块用到的第三方库需要列一个清单,说明为什么使用这个库,这个库的使用率，能否不用此库
4. 每个模块用到的info.plist中的配置需要清楚明白的写清楚，为什么添加这项配置
5. 注释..
6. 每个模块尽量支持模拟器，有时候真机调试很麻烦。

## 0x04 “Talk is cheap. Show me the code.(没代码说个xx)


## 0x05 其它注意事项
1. 1像素的细线
2. 资源文件(图片,音频，storyboard,xib,plist等)的加载
3. storyboard masnory xib???
4. 单例的使用
