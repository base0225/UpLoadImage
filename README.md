# UpLoadImage
一个类似于豆瓣的图片、视频上传功能，基于photoKit.

功能：

![image](https://github.com/base0225/images/blob/master/uploadImage.png)



依赖框架：
pureLayout


photoKit：

2014年WWDC推出photoKit，适用于iOS8.0及以上版本，以前用ALAssetLibrary.
简单介绍下photoKit:

1、phAsset:存在照片资源，我理解为一张照片或视频的数据。

2、PHFetchOptions: 用于获取phAsset、PHCollection、PHCollectionList数据的一些选项。

3、PHFetchResult：当获取一张照片、或者PHCollectionList 都用PHFetchResult 来接受，我理解是一个数据集合，有序的。

4、PHAssetCollection：存在多个Asset的集合，是一个相册，比如说：Camera Roll

5、PHImageManager：用于处理资源的加载，加载图片的过程带有缓存处理，可以通过传入一个 PHImageRequestOptions 控制资源的输出尺寸等规格

6、PHImageRequestOptions：控制加载图片时的一系列参数

![image](https://github.com/base0225/images/blob/master/asset.png)




