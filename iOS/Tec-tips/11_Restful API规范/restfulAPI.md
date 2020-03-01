# Restfull API

**记录描述**

restful架构和restfulAPI设计

接口设计规范

server端统一提供一套RESTful API，供web、Android、iOS来进行api调用，

- API应该返回合理的HTTP状态码，API错误一般情况下分成两类：代表客户端错误的400系列状态码和代表服务端错误的500系列状态码。

- RESTful API应该是无状态的。这意味着对请求的认证不应该基于cookie或者session。相反，每个请求应该带有一些认证凭证。  

- 使用SSL，一定要使用SSL，使用SSL的另一个优势是，加密的链接简化了用户认证的工作，你可以使用简单的accesstoken，而不需要对每个API请求进行签名。

