# Martin
spring cloud企业级微服务，开箱即用

带你领略spring boot、spring cloud 之美

----
## 体验地址
[https://www.erdonline.com/](https://www.erdonline.com/)


## 技术架构图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309181517227.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70#pic_center)
## 技术栈
- spring boot
- spring cloud
- mybatis plus
- oauth2.0
- nacos
- sentinel
- skywalking
- redis
- minio
- elk
- spring boot admin
- swagger
- docker
- docker compose

## 背景
为什么有了那么多优秀的spring cloud开源项目了，我还要再自己做一个呢？

> 问君哪得清如许，为有源头活水来。

正如这句名言所讲，水清是因为有源头活水，用到架构设计、写代码上，也是一个道理，要想写出好的代码，就必须到源头学习。[spirng boot官方英文文档](https://spring.io/projects/spring-boot#learn)就是 spring boot 最好的学习源头，而翻译它官方的文档，就是最好的实践。我阅读了[spirng boot官方英文文档](https://spring.io/projects/spring-boot#learn)，翻译了[spring boot 官网多篇技术文章](https://blog.csdn.net/qq_30054961/article/category/8016817)，在做了上述两件事之后，我开始调研国内外开源的 spring boot 项目，对比了gitee、github上五个比较优秀的开源项目，从这几个开源项目里也学到了很多优秀的思想与技术，比如mybatis-plus、ouath2.0、jwt、项目结构划分等等。

看过的开源项目地址如下：

    1. iBase4J       https://gitee.com/iBase4J/iBase4J
    2. guns         https://gitee.com/stylefeng/guns 
    3. pig          https://gitee.com/log4j/pig
    4. paascloud-master https://github.com/paascloud/paascloud-master
    5. piggyMetrics    https://github.com/sqshq/PiggyMetrics


## 解决哪些问题 

### 项目结构规划不合理
项目结构规划对整个开发周期来说，有着决定性的作用，一个好的结构设计，对后期开发和维护项目有着很友好辅助作用，项目划分的越细，做的越大，体现的越明显。下面看看我看的这几个开源项目的一个划分思路：

 - iBase4J
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190729143354718.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
 - guns         
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190729143530857.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
 - pig
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190729143839281.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
 - paascloud-master 
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190729144124178.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
 
 - piggyMetrics
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190729144048716.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)

**总结：**

这几个项目的架构设计划分上，各有千秋，我无权说哪个好，哪个差，有的更偏向按业务划分，有的更偏向按技术划分，我个人结合这几个项目，加自己多年的开发经验，为 Martin做了如下结构设计：

    ----> Martin
    
	    ----> Martin-biz（各种资源、业务模块）
	        ----> Martin-biz-auth     （定义整个项目认证模块）
	        ----> Martin-biz-resource （示例资源模块）
	        ----> Martin-biz-sso       （示例单点登录模块）
	        ----> Martin-biz-swagger   （示例接口文档模块）
	        ----> Martin-biz-system    （定义整个项目核心业务、系统功能）
	       
	
	    ----> Martin-cloud（各种 spring cloud 模块）
	        ----> Martin-cloud-gateway  （网关）
	        ----> Martin-cloud-nacos    （注册、配置中心）
	
	    ----> Martin-common（各种公共组件模块）
	        ----> Martin-common-api     （暴露整个项目各个模块开放的api）
	        ----> Martin-common-bean    （暴露整个项目核心系统的bean）
	        ----> Martin-common-bom     （约定整个项目jar版本）
	        ----> Martin-common-core    （定义整个项目核心ar）
	        ----> Martin-common-data    （约定整个项目缓存、mybatis-plus）
	        ----> Martin-common-feign   （约定整个项目远程通信方式）
	        ----> Martin-common-log     （定义整个项目日志输出）
	        ----> Martin-common-security（控制整个项目安全策略）
	        ----> Martin-common-sentinel（约定整个项目流控组件为sentinel）
	        ----> Martin-common-swagger （配置整个项目接口文档）
	
	    ----> Martin-extension（各种拓展模块）
	        ----> Martin-extension-generator     （代码生成）
	        ----> Martin-common-monitor          （系统监控）
	        ----> Martin-common-skywalking       （skywalking消息推送）

	        
	        
下面看看 eureka 管理端展示图吧！所有服务从上至下有序排列，一目了然！
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190729172614736.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)

### jar包引用不合理
有的项目中jar引入过多，导致最终打出的jar包有点大。Martin中尽量只引入必须的包，比如想使用 spring boot 的一些基础功能，只引入spring-boot-starter，后面用到什么引入什么，做到最小化引入。
### spring boot 使用不简洁、规范
得益于对 spring boot 官方教程的翻译工作，对 srpig boot 的基础实用有了一定了解， spring boot 最核心的功能是“自动装配”，有的开源项目中并未发挥该优势，还在基于 spring mvc 做技术架构设计。Martin中但凡是第三方功能，都不需要Enalbe*去开启相应功能，比如swagger、oauth-resource等等，均为自动配置，Martin 默认为martin-biz模块下的所有模块开启这些功能，可通过修改配置文件一键关闭。所有新增的biz模块，只需要像搭建最简单的 spring boot 项目那样，写一个启动类，然后开心的写业务模块。
## 项目端口规划
    ----> Martin
    
	    ----> Martin-biz：94**（各种资源、业务模块）
	        ----> Martin-biz-auth：9400     （定义整个项目认证模块）
	        ----> Martin-biz-resource：9401 （示例资源模块）
	        ----> Martin-biz-sso：9402      （示例单点登录模块）
	        ----> Martin-biz-swagger：9403   （示例接口文档模块）
	        ----> Martin-biz-system：9404    （定义整个项目核心业务、系统功能）
	       
	
	    ----> Martin-cloud（各种 spring cloud 模块）
	        ----> Martin-cloud-gateway：9527  （网关）
	        ----> Martin-cloud-nacos：8848    （注册、配置中心）
	
	
	    ----> Martin-extension：96**（各种拓展模块）
	        ----> Martin-extension-generator：9601     （代码生成）
	        ----> Martin-common-monitor：9602          （系统监控）
	        ----> Martin-common-skywalking：9603       （skywalking消息推送）
	        ----> skywalking-ui：9604       （skywalking消息推送）
	        
----

## 开关特性
spring boot最核心的特性是`自动装配`，这个特性在spring boot 本身，以及很多开源项目上得到了广泛使用，大部分非spring boot的第三方代码，都是用enable***来开启功能。诸君想过这么做的后果是什么吗？`硬编码`，对，会导致在代码里硬编码，要开启或者关闭某些功能，就只能改代码。

Martin Cloud对这一现象做了改进、优化，将一切用到的特性，封装成可配置开关，只需修改nacos配置即可实时生效！

![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309175047442.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)

## feign链路加密
为了暴露出来的feign接口更加安全，Martin Cloud对所有Feign调用配置了秘钥，可在配置文件动态修改。
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021030917521956.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
## 管理端支持全字段搜索、排序
管理端每个功能都支持全字段搜索、排序。

- 排序
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182430573.png)
- 搜索
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182455541.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)


## 项目jar打包加密
```shell
mvn install
```
执行上述命令打包出来的jar是加密的，无法查看源码

## 演示图片
- 用户管理
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182043536.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
- 角色管理
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182107326.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
- 部门管理
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182135418.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
- 菜单管理
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182153250.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
- 操作日志管理
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182210870.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
- 服务监控
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182232259.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309183129849.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2021030918330249.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)


![在这里插入图片描述](https://img-blog.csdnimg.cn/2021030918320783.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)


- redis监控
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182248794.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)
- 链路追踪
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210309182307970.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMwMDU0OTYx,size_16,color_FFFFFF,t_70)

