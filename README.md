### 使用到的链接整理

[像素画在线绘制工具](https://www.pixilart.com)
[矢量元素重制](https://zhuanlan.zhihu.com/p/90759425)
[在线玩NFS](http://www.mojotv.cn/misc/games#57G75Yir5ZKM5qCH562+)
[兵蜂NES下载](https://www.mamecn.com/moniqiyouxi/FCyouxi/6713.html)
[NFS图形提取工具](https://pan.baidu.com/s/1i4WuCqL?_at_=1678159121967)
[NES模拟器](https://www.mamecn.com/game/5401832/)
[导出到网页端](https://indienova.com/indie-game-development/godot-export-html5/)
[官方导出H5教程](https://docs.godotengine.org/en/stable/tutorials/platform/web/customizing_html5_shell.html)
[游戏发布平台itch.io](https://itch.io/)

### 信息检索：
[Github搜索结果](https://github.com/search?q=TwinBee):  只有一个用QT写的
 [itch.io网站搜索结果](https://kanedafr.itch.io/twinbee),兵蜂重制版已下架,在2021年有人做过，有点迷茫了。
![在这里插入图片描述](https://blog-1257904201.cos.ap-shanghai.myqcloud.com/img3509e75e3ba44fa59ab63421255127b7.png)

# Godot导出：

### Canvas、WebGL、WebAssembly

现如今如果要在以浏览器内核运行游戏，你就会频繁听到以上这些概念。他们都与 JavaScript 有点关系，但彼此又不太相同。Canvas 其实是 HTML5 的一部分，可以用脚本去控制一些 2D 元素的渲染。而 WebGL 则脱胎于 OpenGL，是一套图形的 API 标准，可以在 Web 端渲染 3D 的图像。WebGL 是 OpenGL 的 web 实现，主要用于在浏览器上展示 3D 图形的底层图形技术
### H5导出文件里包含:
**hmtl**：默认的网页，可以自定义模板文件 官方模板在[这](https://github.com/godotengine/godot/blob/master/misc/dist/html/full-size.html)
JS:自动生成的脚本程序，用于导入engine类
**pck** :pck 文件中会包含场景（.tscn）、脚本（.gd），还有资源（.jpg, .ttf）等。
 **wasm**  默认导出的 wasm 大概有 18M 左右（可能随版本会有差异），里面包含了整个引擎的所有功能。换句话说，哪怕只是做了一个空的项目，导出的 wasm 也是一样的，因为 wasm 就相当于一个 exe 执行文件。其实并非所有的引擎功能都是需要的，例如只是做个 2D 游戏的话，3D 部分的代码就不需要了。

### 参考官方教程安装Git插件



[Git 插件 v3 ·godotengine/godot-git-plugin Wiki (github.com)](https://github.com/godotengine/godot-git-plugin/wiki/Git-plugin-v3#set-up-from-source)



最终配置失败，让填写的ssh密码到底是什么东西。

### 坑

实例化到根节点的碰撞节点不能是Area2D，不会产生碰撞效果，得用rigidBody2D或者characterBody2D





## 进度：

实现飞机移动，云生成铃铛，铃铛变色，升级子弹（双子弹、分身），背景音乐+部分音乐

目前的BUG：分身的子弹会检测碰撞消失，但无法被铃铛检测到，

![image-20230317173656000](https://blog-1257904201.cos.ap-shanghai.myqcloud.com/imgimage-20230317173656000.png)