# honeycomb-adventure
## 蜂窝大冒险

***
## 环境变量

|Key|File|Usage|
|--|--|--|
|URL_HOST|[prod.exs](./config/prod.exs)||
|URL_PORT|[prod.exs](./config/prod.exs)||
|DATABASE_URL|[repo.ex](./lib/honeycomb_adventure/repo.ex)|数据库连接|
|DB_USERNAME|[prod.secret.exs](./config/prod.secret.exs)||
|DB_PASSWORD|[prod.secret.exs](./config/prod.secret.exs)||
|DB_NAME|[prod.secret.exs](./config/prod.secret.exs)||
|SECRET_KEY_BASE|[prod.secret.exs](./config/prod.secret.exs)|用来对cookie签名，防止篡改|
|SESSION_SALT|[endpoint.ex](./lib/honeycomb_adventure_web/endpoint.ex)||


***
## 关于协议
暂时不开源哦！虽然源码是公开的但不是开放的哦！之后会开放的，等完成的差不多了的时候。


***
## 踩坑记录
### Before All
请注意，这是 `踩坑记录` ，不是开发教程！我会尝试解释一些东西，但不会太多，因为我也在学习中。
你至少要具备与我相近的水平，才应该继续看下去，我不会对一些我认为基础的问题过多讲解。


### Install Environment
[官网指引](https://elixir-lang.org/install.html) ，或者，直接下载 `OTP` 与 `Elixir v1.5.2` 的安装器进行安装：[8jji](https://pan.baidu.com/s/1pLBSjov)
> `OTP` 即 `Open Telecom Platform` ，开放电信平台，是随 `Erlang` 一起发布的库。

安装完毕后，可以在命令行输入 `erl` 进入 `Erlang` 的REPL，输入 `iex` 进入 `Elixir` 的REPL，请自行验证版本号和一些基础语法。

然后，我们需要安装 `Phoenix` ， `Elixir` 的Web框架。我们使用 `mix` 来安装它
``` bash
mix local.hex
mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
```
> Elixir 自带 `mix` 作为构建工具，大概是 `Managing elixir` 之类的意思？反正我是这么理解的。<br>
> `local.hex` 全名 `Hex package manager` ，16进制包管理器， [官方指引](https://hexdocs.pm/phoenix/installation.html#elixir-1-4-or-later) 说这是必要的。<br>
> `phx` 即 `Phoenix` ，你也可以手动下载 `ez` 包，然后把GitHub地址换成本地路径来从本地安装。


### Create Project
``` bash
mix phx.new PROJECT_NAME
```
> `phx` 默认使用 `Brunch.io` 来支持前端构建（代替 `Webpack` ），你可以添加 `--no-brunch` 选项来 [禁用它](https://hexdocs.pm/phoenix/installation.html#node-js-5-0-0) <br>
> 但我们当然不会用传统Web技术去写前端，我们要用那些酷炫的东西，并且早就受够 `Webpack` 了，对吧？ <br>
> [Brunch](https://github.com/brunch/brunch.github.io) 看起来要好的多，不知道比起我之前挺喜欢的 [roadhog](https://github.com/sorrycc/roadhog) 来怎么样，借此机会我准备尝试一下它。<br>
> `phx` 会自动帮我们安装 `Brunch` 以及其它一些 `NodeJS` 的依赖，这意味着你需要先搭建好 `NodeJS` 环境。

> `phx` 默认使用 `PostgreSQL` 持久化数据，我同样不打算我禁用或更换，这意味着你需要事先装好 `PostgreSQL` 。<br>
> 你可以从 [Postgres官方](https://www.postgresql.org/download/) 或 [9z3x](https://pan.baidu.com/s/1c19q5uo) 下载安装，或参考 [官方指引](https://hexdocs.pm/phoenix/ecto.html#content) 换别的数据库，又或者干脆 `--no-ecto` 禁用了。

> `PROJECT_NAME` 必须为小写字母数字下划线，不支持短横杠这点让我稍稍不爽了一下。


### Config Secret
创建好的项目默认通过文件方式来配置，关键信息被放在了 [prod.secret.exs](./config/prod.secret.exs) 里，并添加进了 [.gitignore](./.gitignore) 。我不喜欢这种方式，让我们做点改造：
1. 注释掉 [.gitignore](./.gitignore) 的 `/config/*.secret.exs` 。
2. 把 [prod.secret.exs](./config/prod.secret.exs) 中的关键信息换成环境变量，比如 `secret_key_base` 的值换成 `System.get_env("SECRET_KEY_BASE")` 。
3. 检查其它文件，把需要自定义的地方也都换成环境变量，比如 [prod.exs](./config/prod.exs) 里的url的host和port， [endpoint.ex](./lib/honeycomb_adventure_web/endpoint.ex) 里的 `signing_salt` 。
4. 别忘了顺手整理一下你添加环境变量，一般我的习惯就是直接写ReadMe里面了，部署的时候找起来方便。

确定数据库安装好了并正确运行了，数据库连接配置也没问题后，我们来创建数据库：
``` bash
mix ecto.create
```

### Start server
运行开发服务器：
``` bash
mix.bat phx.server
```

由于我提交了 [VSCode的任务配置](./.vscode/tasks.json) ，如果你也用 [VSCode](https://code.visualstudio.com) ，那么只需要 `Ctrl + Shift + B` 就能运行。

然后浏览器打开 [:4000](http://localhost:4000/) ，应该就能看到 `Phoenix` 的欢迎页面了。

目前为止都是照着官方指引的基础操作，下面我要开始添加自己的 `私货` 了。

在这之前先提交了一次，因为后面的步骤与内容视具体情况可能差异很大，比如用不用 `React` 之类。


### Write pages
首先要改动的当然就是前段结构。虽然我决定保留并尝试 `Brunch` ，但我可一点都不打算遵循现在的模板开发架构。
> 当然，不是说这种架构不好，写一些简单的小页面大概是很合适的吧。但这样前端对后端的依赖太重了。<br>
> 具体来说，我不希望写前端时还要去考虑后端模板渲染适配，不希望还要去后端添加路由、控制器等。<br>
> 再次强调，这只是我个人爱好。这么做本身并没错，这种传统方式填充数据可以节省很多Ajax请求。<br>

第一步，我们需要引入 `React` 和 `Redux` ， `CSS-Module` 、 `babel` 和 `eslint` 等：
> F**k，安装错目录了， `package.json` 都没有还能安装，那么 `--save-dev` 参数怎么解释啊，直接忽略了？<br>
> 东西有点多不写出来了，你可以直接 `npm i` 来安装所有，或者自己去 [package.json](./assets/package.json) 里看我具体都装了哪些东西。

第一点五步，随手复制了一份自己以前用的 [.eslintrc](./assets/.eslintrc) ，点开几个 `js` 文件，嗯报错了，说明起作用了。

第一点七五步，把报错的地方改了，用什么双引号啊，js没分号能忍啊。呃，有点多，那么干脆删了吧。

第一点八七五，于是看了看， `socket.js` 还有点价值，其它的都可以删了，同时重新 [配置](./assets/brunch-config.js) 一下目录结构。

第xxxx：F**k，果然踩坑里了。 [重大bug发现](https://github.com/brunch/brunch/issues/1771) ， `Brunch` 的 `require` 实现有问题，导致一使用 `PostCSS` 就玩完儿。
> 我提交了修复issue，但考虑到不止会不会、何时会采用，且由于实现比较偏门，不知道还有多少问题。<br>
> 现在就又遇到个，不能直接 `require` 图片等资源获取连接。。。可见 `brunch` 还不太成熟。。。<br>
> 是继续这个折腾了半天的缺陷明显的 `brunch` ，还是换回惯用的 `roadhog` ，我陷入了深深的忧郁 -_-!!!<br>

F**k，又踩坑了，这次好像是 `phoenix` 的坑，不是换不换 `brunch` 的问题了。
> 详细原因还没查出来，就是现在这次提交，直接运行，没问题。保存个文件热加载一下，页面没了， `_build` 里的 `index.js` 被删空了。<br>
> [看起来是热加载问题](https://github.com/phoenixframework/phoenix_live_reload/issues/67) ，勉强还能继续用下去。嘛，慢慢来吧，希望这些问题能早点修复。<br>
> 问题虽然没完全修复但也算有了临时解决方案，就是先用管理员身份运行一次，详情见那个 issue 。


F**k，到底多少坑啊！垃圾 `brunch` ，玩票的东西吧？时不时会报跟source_file有关的错误，然后就tm的不重编译了。
> 具体来说，某个watch的文件的本来被import了，然后我不想用了，删掉那行import，就会导致 `brunch` 报错崩溃。<br>
> 之前报的bug，pull-request都提了，官方毫无响应。GitHub上open着的issue居然有一百多个了，不能想象。<br>
> 软连接导致热加载失败问题好歹解决了， `Phoenix` 本身是可以继续用下去了，但 `Brunch` 这垃圾还是早点换掉吧。<br>
> 差点忘了，brunch的sourceMap完全没用，浏览器报错根本找不到源码。不知道是不是哪里配错了，但实在太难用了。<br>
> 擦，还原到初始状态没有复现这个问题，看来是之后添加的插件之类造成的。懒得麻烦了，换掉不成熟的 `brunch` 吧。<br>


好吧但我真的不想用回 `Webpack` ，作为代替，我们这次来试试 `parcel`：
``` bash
npm i --save-dev parcel-bundler
```
> 简直nice，名不虚传， `parcel` 就是我想要的，跟 `roadhog` 类似的简单配置，但完全摆脱了 `Webpack` 。<br>
> 收回， `parcel` 也不怎么成熟，没有sourceMap就算了， [CSS-Module经常编译报错](https://github.com/parcel-bundler/parcel/issues/378) ，还是考虑 `Roadhog` 吧。<br>

然而切换 `roadhog` 失败了。。。暂时先用着 `parcel` 吧，没办法，实在懒的折腾了。。。
> ~~因为突然发现 `roadhog` 并不支持 `watch` 模式~~ ，要换 `roadhog` 的话，就得采取以前的前后端分别开发的流程了。<br>
> 不是说那样不好，但不适合个人项目快速构建，有悖于我的初衷。我认可前后端分离架构，但不认可前后端分离开发。<br>
> 前端用各种proxy去模拟后端，后端用各种单元用例去模拟前端，然后双方各自开发，最后再集成到一起，我觉得没必要。<br>
> 只要做到写前端不用考虑后端代码，写后端不用考虑前端代码就够了，本身开发中还是可以直接使用对方的服务的。<br>
> `roadhog` 原来是支持 `watch` 的，等什么时候有空了再试试切到 `roadhog` 上吧，现在先继续后面的。


### Write service
前端踩坑先告一段落，让我们开始后端吧，这才是主要目的。首先呢，我们需要部署 `GraphQL` 来提供服务：
> 我们将选择 [absinthe-graphql](https://github.com/absinthe-graphql) ，相比于 [graphql-elixir](https://github.com/graphql-elixir) ，这个库封装更加高级，文档也更加齐全。

遵循 [官方指南](https://hexdocs.pm/absinthe/plug-phoenix.html) ，我们直接在 [mix.exs](./mix.esx) 的 `deps` 里添加 `absinthe_plug` 依赖 `{:absinthe_plug, "~> 1.4"}`
> [absinthe_plug](https://github.com/absinthe-graphql/absinthe_plug) 是 `Absinthe` 的插件，用来提供 `HTTP` 以及 [GraphiQL](https://github.com/graphql/graphiql) （一个基于浏览器的交互实验台）支持。<br>
> 官方指引里说还要添加 `poison` 以提供 `JSON` 支持，但我觉得没必要，因为这个库事实上早已引入了。

然后编辑项目的 [Web路由](./lib/honeycomb_adventure_web/router.ex) ，为 `Absinthe.Plug` 添加一条路由，别忘了指定你的 `Schema` 模块。
> 这里我在开发环境下做了个特殊处理，将路由控制器换成了 `Absinthe.Plug.GraphiQL` ，以支持 `GraphiQL` 。<br>
> 如果后端只打算提供 `GraphQL` 服务，你可以简单的把插件注入到 [Web入口](./lib/honeycomb_adventure_web/endpoint.ex) 来全局应用插件。

最后，编个简单的 [Schema](./lib/honeycomb_adventure_web/schema.ex) ，主要看看里面的 `query` 和 `object` 的写法吧，没什么难的。
> 因为写这段时我事实上已经顺手把 [下一节](#Use-socket) 弄完了，看起来复杂的话就参考 [官方指引](https://hexdocs.pm/absinthe/schemas.html#content) 吧。<br>
> 关于数据表模型 [HoneycombAdventure.User](./lib/honeycomb_adventure/user.ex) 的创建于用法等参见 [这里 ](https://hexdocs.pm/phoenix/ecto.html#content) ，应该也没什么难理解的吧。

然后安装依赖，跑起项目，打开浏览器，访问 [GraphiQL实验台](localhost:4000/api) ，没问题的话就可以试试拉点数据了。


### Use socket
单纯的 `Http` 请求-响应太落后了，我们当然要用 `WebSocket` ！并且仍然要加上 `GraphQL` ！
> 其实 `Phoenix` 已经默认帮我们把 `WebSocket` 准备好了，我们主要来看看怎么引入 `GraphQL` 。

与上一节类似，先安装 [absinthe_phoenix](https://github.com/absinthe-graphql/absinthe_phoenix) 依赖以提供 `WebSocket` 的 `GraphQL` 支持，官方指引 [在这](https://hexdocs.pm/absinthe/subscriptions.html#content) 。

然后在 [application.ex](./lib/honeycomb_adventure/application.ex) 里注册 `Absinthe.Subscription` ，以在应用启动时启动 `Absinthe` 服务。

在 [Web入口](./lib/honeycomb_adventure_web/endpoint.ex) 里添加一行 `use Absinthe.Phoenix.Endpoint` 以引入 `absinthe_phoenix` 。

在 [Socket](./lib/honeycomb_adventure_web/channels/user_socket.ex) 里引入 `Absinthe.Phoenix.Socket` 并指定 `Schema` ，复用上一节的就好了。

在 [Web路由](./lib/honeycomb_adventure_web/router.ex) 上一节添加的路由后，再加一行，指定 `socket` 模块，以便 `GraphiQL` 访问 `WebSocket` 。

最后，编辑 [Schema](./lib/honeycomb_adventure_web/schema.ex) ，添加 `mutation` 和 `subscription` ，分别用于发布和订阅消息，具体参考 [这里](https://hexdocs.pm/absinthe/subscriptions.html#schema)
> 这样上一节让大家跳过的地方应该就能看懂了吧？有没有觉得这个地方思路和 `Redux` 真的挺像？

一切就绪，再次跑起应用，访问 [GraphiQL实验台](localhost:4000/api) ，这次开俩窗口，试试订阅与发布消息吧。


### Account manager
~~ 加密算法选择 `Argon2` ，添加这个库依赖以支持： [comeonin](https://github.com/riverrun/comeonin) ，详细环境要求 [在这里](https://github.com/riverrun/comeonin/wiki/Requirements) ~~


### Client connect
客户端连接
