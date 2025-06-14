# 母婴商城系统功能演示指南

本文档提供母婴商城系统的功能演示和详细操作指南，帮助不同角色用户快速了解和上手系统的各项功能。通过场景化的演示，您可以直观地了解系统如何满足实际业务需求。

## 文档导航

### 快速链接
- [前台商城系统演示视频](#前台商城系统演示)
- [后台管理系统演示视频](#后台管理系统演示)
- [用户操作场景](#用户操作场景)
- [管理员操作场景](#管理员操作场景)
- [系统功能详情](#功能详情)
- [演示环境信息](#演示环境访问)

## 演示视频

### 前台商城系统演示

前台商城系统是面向用户的购物平台，提供商品浏览、购物车、订单管理等功能。

**演示视频链接**：[母婴商城前台系统演示](https://live.csdn.net/v/480130)

<div align="center">
  <img src="../screenshots/frontend-home.gif" alt="前台首页功能演示" width="80%" />
  <p>前台商城系统功能演示</p>
</div>

#### 主要功能演示：
- 用户注册与登录
- 商品分类浏览与搜索
- 商品详情查看
- 购物车操作
- 订单提交与支付
- 个人中心管理

### 后台管理系统演示

后台管理系统是面向管理员的运营平台，提供商品管理、订单处理、用户管理等功能。

**演示视频链接**：[母婴商城后台系统演示](https://live.csdn.net/v/480131)

<div align="center">
  <img src="../screenshots/admin-dashboard.gif" alt="后台管理系统功能演示" width="80%" />
  <p>后台管理系统功能演示</p>
</div>

#### 主要功能演示：
- 管理员登录与权限控制
- 数据仪表盘
- 商品管理（添加、编辑、下架）
- 订单管理与处理
- 用户管理
- 营销活动管理
- 系统设置

## 用户操作场景

以下是面向普通用户的常见使用场景，每个场景都包含详细的操作步骤和说明：

1. [**新用户注册与登录**](./scenarios/user/registration-login.md)
   - 账号注册流程
   - 登录验证方式
   - 忘记密码处理
   - 第三方账号登录

2. [**完整购物流程**](./scenarios/user/shopping-process.md)
   - 商品浏览与搜索
   - 商品详情查看
   - 购物车管理
   - 结算与支付

3. [**订单管理与售后**](./scenarios/user/order-management.md)
   - 订单状态跟踪
   - 物流信息查询
   - 退款/退货申请
   - 评价与晒单

4. [**会员特权与积分使用**](./scenarios/user/member-benefits.md)
   - 会员等级说明
   - 积分获取与使用
   - 优惠券管理
   - 生日特权与专属活动

## 管理员操作场景

以下是面向系统管理员的常见工作场景，每个场景都包含详细的操作流程和最佳实践：

1. [**商品管理工作流**](./scenarios/admin/product-management.md)
   - 添加新商品
   - 管理商品分类
   - 库存管理
   - 商品上下架操作

2. [**订单处理流程**](./scenarios/admin/order-processing.md)
   - 订单审核与确认
   - 发货管理
   - 退款处理
   - 异常订单处理

3. [**营销活动创建与分析**](./scenarios/admin/marketing-campaign.md)
   - 优惠活动设置
   - 满减/满赠活动
   - 限时秒杀管理
   - 活动效果分析

4. [**数据分析与报表**](./scenarios/admin/dashboard-analytics.md)
   - 销售报表分析
   - 用户行为分析
   - 商品表现分析
   - 自定义报表生成

## 功能详情

### 前台商城系统

#### 1. 首页布局
- 顶部导航栏：提供分类入口、搜索功能和用户入口
- 轮播图：展示促销活动和热门商品
- 商品分类：显示各类母婴商品分类
- 推荐商品：根据用户偏好和热度推荐商品
- 活动专区：展示当前进行的促销活动和特价商品

<div align="center">
  <img src="../screenshots/frontend-home.gif" alt="前台首页功能演示" width="60%" />
  <p>首页功能展示</p>
</div>

#### 2. 商品浏览
- 分类导航：按照品类、年龄段、品牌等多维度筛选
- 搜索功能：支持关键词搜索和高级筛选
- 排序选项：支持按价格、销量、评价等排序
- 商品列表：显示商品图片、名称、价格、评分等信息
- 快速查看：悬停商品可查看简要信息

#### 3. 商品详情
- 商品图片：多角度展示商品，支持放大查看细节
- 商品信息：详细规格、参数、使用说明
- 价格展示：包括原价、促销价、会员价等
- 用户评价：展示购买用户的评价和图片
- 相关推荐：展示相关商品推荐
- 购买选项：选择规格、数量，添加到购物车或立即购买

<div align="center">
  <img src="../screenshots/frontend-product.gif" alt="商品详情功能演示" width="60%" />
  <p>商品详情功能展示</p>
</div>

#### 4. 购物车
- 添加/移除商品
- 修改商品数量
- 选择/取消选择商品
- 计算总价和优惠
- 优惠券/积分应用
- 结算功能

#### 5. 订单管理
- 订单提交：确认收货地址、支付方式等
- 订单状态跟踪：待付款、待发货、待收货等
- 订单详情：查看订单商品、配送信息、发票信息等
- 订单操作：取消订单、申请退款、确认收货等
- 售后服务：退货/退款申请、售后进度查询

### 后台管理系统

#### 1. 仪表盘
- 销售数据统计：展示销售额、订单量等指标
- 用户增长趋势：新增用户、活跃用户等数据
- 热销商品分析：展示热销商品排行
- 营销效果分析：各营销活动的效果数据
- 实时监控：系统性能、用户在线状态等

<div align="center">
  <img src="../screenshots/admin-dashboard.gif" alt="后台仪表盘功能演示" width="60%" />
  <p>管理后台仪表盘功能展示</p>
</div>

#### 2. 商品管理
- 商品列表：展示所有商品及状态
- 添加商品：填写商品信息、上传图片、设置库存等
- 编辑商品：修改商品信息、价格、库存等
- 商品分类管理：添加、编辑、删除商品分类
- 品牌管理：添加、编辑、删除品牌信息
- 库存预警：低库存商品提醒和管理

#### 3. 订单管理
- 订单列表：展示所有订单及状态
- 订单详情：查看订单商品、用户信息、支付信息等
- 订单处理：发货、修改订单状态、备注等
- 退款管理：处理退款申请、退款记录等
- 批量操作：批量发货、批量确认等

#### 4. 用户管理
- 用户列表：展示所有用户及基本信息
- 用户详情：查看用户订单、积分、优惠券等
- 用户分析：用户购买习惯、活跃度等分析
- 用户分组：按照不同标准对用户进行分组
- 会员等级：管理会员等级和权益

## 开发与技术实现

关于系统的开发与技术实现，请参考：
- [架构设计文档](./architecture/README.md)
- [开发指南](./development/README.md)
- [API文档](./api/README.md)

## 部署与运维

关于系统的部署与运维，请参考：
- [部署指南](./deployment/README.md)

## 演示环境访问

### 在线演示环境

- 前台商城系统演示环境：[http://muying-mall.example.com](http://muying-mall.example.com)
- 后台管理系统演示环境：[http://admin.muying-mall.example.com](http://admin.muying-mall.example.com)
  - 演示账号：admin
  - 演示密码：admin123

### 本地演示环境

如需在本地运行演示环境，请参考[部署指南](./deployment/README.md)中的"本地开发环境搭建"部分。

> 注：演示环境仅供功能展示，部分功能可能受限。数据定期重置，请勿用于实际业务。

## 常见问题

请参考[常见问题解答](./FAQ.md)获取更多帮助和支持。 