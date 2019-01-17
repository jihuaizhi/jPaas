http://www.cnblogs.com/myknow/p/9559011.html

*** html表单form通过post方式提交到控制器,控制器跳转htm出错
// <bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
// <property name="urlMap">
// <map>
// <entry key="/请求的文件路径/**" value="myResourceHandler" />
// </map>
// </property>
// <property name="order" value="100000" />
// </bean>
//
//
// <bean id="myResourceHandler" name="myResourceHandler"
// class="org.springframework.web.servlet.resource.ResourceHttpRequestHandler">
// <property name="locations" value="/请求的文件路径/" />
// <property name="supportedMethods">
// <list>
// <value>GET</value>
// <value>HEAD</value>
// <value>POST</value>
// </list>
// </property>
//
// </bean>


form下的button 按钮在没有明确的给出type类型时，会有一个默认值为：type=”submit”. 如果该按钮的作用不是为了提交表单的话，我们给其加上type属性就行了：
<button id="validate" type="button" onclick="validate();"></button>

rem 生成私钥库
rem -genkey生成私钥库 -alias别名 -keystore私钥库文件名 –validity20表示20天有效
keytool -genkey -alias privatekey -keystore privateKeys.store -validity 20

rem 从私钥库导出证书
rem -export导出 -alias别名  -file输出文件名 -keystore私钥库文件名
keytool -export -alias privatekey -file certfile.cer -keystore privateKeys.store

rem将证书导入公钥库
rem  -import导入 -alias公钥库别名 -file证书文件名 -keystore公钥库文件名
keytool -import -alias publiccert -file certfile.cer -keystore publicCerts.store



*** 需要研究spring的配置类的写法

*** 需要研究springmvc的配置方法和核心类

