# 关于iOS代码风格管理的两三事儿
<div align=center>
<img src="http://images.bookuu.com/book/C/01400/97871113854482294829-fm.jpg" width = "300" height = "400" alt="代码风格的两三事儿" />
</div>


前一阵一直在做单元测试相关的内容，想来终于把自动化测试的一整套方案弄的差不多了，于是在想还有没有其他可以提升代码质量的事儿可做。


记得去年在某度的时候,每次苦逼地搬完砖提交代码的时候，都会有一个代码风格校验的审查，如果没有通过规则的话是提交不上去的，并且还会给出相应的警告。比如下面代码

```
@property(nonatomic,strong)MGJAwesomeCommand *awesomeCMD;
if(sth.){xxx;return;}

// Unrelated comment
void someFunction() {
    doWork(); // Does something
    doMoreWork(); // Does something else
}

```

那么对于追求More Free［和吴悠无关🐦］ 的程序员这个有意义么？


其实我认为是有意义的，第一、由于现在我们都是团队作战，如果团队内部可以做到代码风格统一, 采用同一个代码规范，让不同人写出来的程序可读性基本一致或者接近，这样对于新人来说, 做过一个模块后，在接触别人代码，别的模块代码的时候，无论开发还是维护都会更快上手, 他的精力可以更多放在其他方面。同时, 好的代码规范，编程习惯也可以减少bug的产生，减少开发人员和测试人员的的时间成本；第二 、工具化程度是衡量一个公司技术水准很重要的一个考量.例如跑Unit Test,代码风格检测,持续化集成都自动化的时候,这些东西都是可以极大的节省时间精力的东西。

那么如何来做到这些，使团队内部代码风格趋于统一呢？有下面几种方案。

## 1.使用插件

比如[ClangFormat-Xcode](https://github.com/travisjeffery/ClangFormat-Xcode)一款格式化代码工具，能够让开发者使用 Clang 将代码格式化为 LLVM、Google、Chromium、Mozilla 或 WebKit 等格式。操作类似下面这样

![demo](https://raw.github.com/travisjeffery/ClangFormat-Xcode/master/README/clangformat-xcode-demo.gif)

## 2.定制模版

团队内部可以设置类的代码组织结构, 例如ViewController类可以按照以下顺序来组织代码结构：

```
#pragma mark - def
#pragma mark - override
#pragma mark - api
#pragma mark - model event 
#pragma mark - view event
#pragma mark - private
#pragma mark - getter / setter
```

那么如何制定一个模版呢，从头制作一个模板类有些坑。 我们采用简单的办法, 先拷贝一个模板类， 然后修改成自己需要的样子。
这里推荐一个[简单的模板类的模板](<https://github.com/uxyheaven/XYXcodeTemplate>). 先下载下来, 再修改成你需要的样子, 最后拷贝到Xcode的文件模板文件夹里 
```
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Folder
```
这样就可以使用了。


<div align=center>
<img src="http://img.blog.csdn.net/20160411144323366" width = "400" height = "300" alt="" />
</div >


（这里顺便安利下之前写的一个单元测试的[模版](https://github.com/Bupterambition/Kiwi-Template)通过Alcatraz搜索Kiwi-Template进行安装）


## 3.最佳推荐


以上两种方法操作起来都稍微有点麻烦或是不是太方便，比如使用插件的话每次只能一个文件一个文件的去修改，而且只能装在Xcode上；使用定制模版的话每次需要从模版中创建，似乎有点别扭，并且也只能用在Xcode上。而且两种方法也起不到通知程序员代码风格矫正的作用，那么有没有一种既简单又不限制IDE而且还能通知程序员代码风格不符的方法呢？

这里羞羞地推荐一下自己写的一个工具。具体的使用方法如下：

这里以最近正在写的[AwesomeCommand](http://gitlab.mogujie.org/payfront/AwesomeCommand.git)为例,首先打开工程目录，例如我的目录是下面这样
<div align=center>
<img src="https://github.com/Bupterambition/UIImage-Categories/blob/master/pic1.png?raw=true" width = "400" height = "300" alt="" />
</div>

然后打开终端执行命令

    curl -o format-check -ssl https://github.com/Bupterambition/objc-format-check/blob/master/format-check?raw=true
    
下载完毕后执行 

	bash format-check
	
	
这样就全部搞定了。那么上面操作具体做了什么呢，其实很简单。

首先format-check会clone下来一个[工具](https://github.com/Bupterambition/objc-format-check)（这里参考了Space Commander）放在.format-check目录，然后执行我们的工具。工具主要干了两件事。

### .clang-format
在当前目录下添加了.clang-format文件，这个文件主要是做什么的呢?
其主要是设定了代码的一些风格.

```
Language:        Cpp
AccessModifierOffset: -1
ConstructorInitializerIndentWidth: 4
SortIncludes: false

AlignAfterOpenBracket: true
AlignEscapedNewlinesLeft: true
AlignOperands: false
AlignTrailingComments: true

AllowAllParametersOfDeclarationOnNextLine: false
AllowShortBlocksOnASingleLine: true
AllowShortCaseLabelsOnASingleLine: false
AllowShortFunctionsOnASingleLine: true
AllowShortIfStatementsOnASingleLine: false
AllowShortLoopsOnASingleLine: false

AlwaysBreakAfterDefinitionReturnType: false
AlwaysBreakTemplateDeclarations: false
AlwaysBreakBeforeMultilineStrings: false

BreakBeforeBinaryOperators: None
BreakBeforeTernaryOperators: false
BreakConstructorInitializersBeforeComma: false
```
什么意思呢，比如将

	AllowShortFunctionsOnASingleLine:false
那么这样风格的代码

	int f() { return 0; }
将是不允许的，
需要改成这样的才能通过规则

	int f() {
    	return 0;
	}
那么具体效果是什么样呢,如果你commit的代码中有上述风格的代码，那么提交的时候将会这样
<div align=center>
<img src="https://github.com/Bupterambition/UIImage-Categories/blob/master/pic3.png?raw=true" width = "400" height = "300" alt="" />
</div>

根据提示你可以选择一键修正所有要commit的脚本或是使用git commit --no-verify来忽略。

### Git Hook
另一个是在/AwesomeCommand/.git/hook/中添加了一个pre-commit的脚本，那么这个pre-commit是干什么的呢，很简单,这个东西就是在你每次要commit代码之前，git都会去找有没有这个文件。如果有这个文件，那么就去文件里执行一些特定的shell脚本，比如我们的pre-commit是去/.format-check/目录下执行`format-objc-hook`脚本

如果您使用后觉得这个工具不好用的话可以在您的工程目录下执行下面命令进行删除

	curl -ssl https://raw.githubusercontent.com/Bupterambition/objc-format-check/master/uninstall.sh|bash

至此，我们就完成了一个代码风格审查工具的部署，如果团队想要制定代码风格的话只需要修改和`.git`同目录下的`.clang-format`文件就好，具体的规则可以参考[这个](http://clangformat.com/)，每种样式点击一下会弹出相应的实例代码。［不过要记得.gitignore中需要把.clang-fotmat去掉,这样只需要由一个人制定好了规则每个人pull一下就OK了］。同时只需要把刚刚download下来的format-check文件放到相应的组件文件夹下执行一边就可以完成全部组件的代码风格部署。
