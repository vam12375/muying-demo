# 母婴商城系统API文档

本文档提供母婴商城系统的API参考，包括所有前后端交互的接口定义、参数说明和返回值格式。

## API概述

母婴商城系统的后端API采用RESTful风格设计，主要包括以下几个部分：

1. **用户认证与授权API**
2. **商品管理API**
3. **订单管理API**
4. **用户管理API**
5. **购物车API**
6. **支付API**
7. **内容管理API**
8. **搜索API**
9. **系统管理API**

## API通用规范

### 基本URL

- 开发环境：`http://localhost:8080/api`
- 测试环境：`https://test-api.muyingmall.com/api`
- 生产环境：`https://api.muyingmall.com/api`

### 请求格式

所有API请求均采用JSON格式，请求头需设置：

```
Content-Type: application/json
```

对于需要认证的接口，请求头还需携带令牌：

```
Authorization: Bearer {token}
```

### 响应格式

所有API响应均为JSON格式，基本结构如下：

```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    // 具体的响应数据
  },
  "timestamp": 1684123456789
}
```

### 状态码说明

| 状态码 | 描述 |
|--------|------|
| 200 | 操作成功 |
| 400 | 请求参数错误 |
| 401 | 未授权访问 |
| 403 | 拒绝访问 |
| 404 | 资源不存在 |
| 500 | 服务器内部错误 |

### 分页参数

支持分页的API接口通常接受以下参数：

- `page`: 当前页码，默认为1
- `size`: 每页记录数，默认为10
- `sort`: 排序字段，格式为`字段名,排序方式`，如`createTime,desc`

分页响应结果格式：

```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "content": [
      // 数据条目
    ],
    "totalElements": 100,
    "totalPages": 10,
    "size": 10,
    "number": 0,
    "first": true,
    "last": false,
    "empty": false
  }
}
```

## API文档目录

以下是各模块的详细API文档：

1. [用户认证API](./auth.md)
2. [商品管理API](./product.md)
3. [订单管理API](./order.md)
4. [用户管理API](./user.md)
5. [购物车API](./cart.md)
6. [支付API](./payment.md)
7. [内容管理API](./content.md)
8. [搜索API](./search.md)
9. [系统管理API](./system.md)

## API版本控制

母婴商城系统API采用URL路径版本控制策略，格式为：

```
/api/v{version}/{resource}
```

例如：
- `/api/v1/products` - 商品API的v1版本
- `/api/v2/products` - 商品API的v2版本

当API发生不兼容变更时，将发布新版本API，并保持旧版本API一段时间以便客户端平滑迁移。

## API调用示例

### 获取商品列表

**请求:**

```http
GET /api/v1/products?page=1&size=10&category=母婴用品 HTTP/1.1
Host: api.muyingmall.com
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**响应:**

```json
{
  "code": 200,
  "message": "获取商品列表成功",
  "data": {
    "content": [
      {
        "id": 1001,
        "name": "婴儿奶粉",
        "description": "优质婴儿奶粉",
        "price": 268.00,
        "stock": 100,
        "imageUrl": "https://img.muyingmall.com/products/1001.jpg",
        "category": "母婴用品",
        "status": "上架"
      },
      // 更多商品...
    ],
    "totalElements": 50,
    "totalPages": 5,
    "size": 10,
    "number": 0,
    "first": true,
    "last": false,
    "empty": false
  },
  "timestamp": 1684123456789
}
```

### 创建订单

**请求:**

```http
POST /api/v1/orders HTTP/1.1
Host: api.muyingmall.com
Content-Type: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

{
  "items": [
    {
      "productId": 1001,
      "quantity": 2
    },
    {
      "productId": 1002,
      "quantity": 1
    }
  ],
  "addressId": 5001,
  "couponId": 3001,
  "note": "请尽快发货"
}
```

**响应:**

```json
{
  "code": 200,
  "message": "订单创建成功",
  "data": {
    "id": 10001,
    "orderNo": "MYM202305150001",
    "totalAmount": 536.00,
    "discountAmount": 50.00,
    "payAmount": 486.00,
    "status": "待支付",
    "createTime": "2023-05-15T10:30:00Z",
    "paymentDeadline": "2023-05-15T11:00:00Z"
  },
  "timestamp": 1684123456789
}
```

## SDK与客户端库

母婴商城提供多种语言的客户端SDK，简化API调用：

- [JavaScript SDK](https://github.com/your-username/muying-sdk-js)
- [Java SDK](https://github.com/your-username/muying-sdk-java)
- [Python SDK](https://github.com/your-username/muying-sdk-python)

## API变更日志

查看 [API变更日志](./changelog.md) 了解API的历史变更。

## 错误处理

API错误响应示例：

```json
{
  "code": 400,
  "message": "请求参数错误",
  "data": {
    "errors": [
      {
        "field": "email",
        "message": "邮箱格式不正确"
      },
      {
        "field": "password",
        "message": "密码长度必须在6-20位之间"
      }
    ]
  },
  "timestamp": 1684123456789
}
``` 