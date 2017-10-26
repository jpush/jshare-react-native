## 配置 JGShareSDK.xml

无论是使用自动集成还是手动集成方式，都需要配置 JGShareSDK.xml。 主要步骤为：
复制或者新建 JGShareSDK.xml 到工程目录的 asset 目录下。
把 JGShareSDK.xml 中相关的 AppKey、AppSecret 替换成自己在第三方平台创建的应用得到的信息。
根据需要配置各个平台，不需要的平台可以删除。

JGShareSDK.xml示例
```
<?xml version="1.0" encoding="utf-8"?>
<DevInfor>

    <!-- 如果不需要支持某平台，可缺省该平台的配置-->

    <SinaWeibo
        AppKey="新浪微博的 AppKey"
        AppSecret="新浪微博 AppSecret"
        RedirectUrl="微博开放平台填写的授权回调页"/>

    <QQ
        AppId="QQ 的 AppId"
        AppKey="QQ 的 AppKey"/>

    <Wechat
        AppId="微信的 AppId"
        AppSecret="微信的 AppSectet"/>

    <Facebook
        AppId="facebook 的 appId"
        AppName="facebook 后台填写的名称"
    />

</DevInfor>
```
