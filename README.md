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


*** 需要研究spring的配置类的写法

*** 需要研究springmvc的配置方法和核心类

