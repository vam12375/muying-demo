# 母婴商城系统数据库设计

本文档详细介绍母婴商城系统的数据库设计，包括表结构、关系模型、索引设计和优化策略。

## 数据库概述

母婴商城系统使用MySQL 8.0作为主要的关系型数据库，用于存储系统中的核心业务数据。数据库采用InnoDB存储引擎，支持事务处理和外键约束，确保数据完整性和一致性。

## ER图

下面是母婴商城系统的核心实体关系图：

```
┌────────────┐       ┌────────────┐       ┌────────────┐
│    用户    │       │    订单    │       │  订单详情  │
├────────────┤       ├────────────┤       ├────────────┤
│ user_id    ├───┐   │ order_id   │◄──────┤ item_id    │
│ username   │   │   │ user_id    │       │ order_id   │
│ password   │   └──►│ total      │       │ product_id │
│ email      │       │ status     │       │ quantity   │
│ phone      │       │ create_time│       │ price      │
└────────────┘       └────────────┘       └────────┬───┘
                                                   │
┌────────────┐       ┌────────────┐                │
│  收货地址  │       │  支付记录  │                │
├────────────┤       ├────────────┤                │
│ address_id │       │ payment_id │                │
│ user_id    │       │ order_id   │                │
│ name       │       │ amount     │                │
│ phone      │       │ method     │                │
│ province   │       │ status     │                │
│ city       │       │ create_time│                │
│ district   │       └────────────┘                │
│ detail     │                                     │
└────────────┘                                     │
                                                   │
┌────────────┐       ┌────────────┐       ┌────────▼───┐
│   商品类别  │       │    商品    │◄──────┤    SKU    │
├────────────┤       ├────────────┤       ├────────────┤
│ category_id│◄──────┤ product_id │◄──────┤ sku_id     │
│ name       │       │ name       │       │ product_id │
│ parent_id  │       │ category_id│       │ attrs      │
│ level      │       │ price      │       │ price      │
│ sort       │       │ description│       │ stock      │
└────────────┘       │ status     │       │ code       │
                     └────────────┘       └────────────┘
```

## 数据库表设计

以下是系统中主要表的详细设计。

### 1. 用户表 (user)

存储用户基本信息和认证数据。

```sql
CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码（加密存储）',
  `salt` varchar(32) NOT NULL COMMENT '加密盐值',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像URL',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `gender` tinyint(1) DEFAULT '0' COMMENT '性别：0-未知，1-男，2-女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：0-禁用，1-正常',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(64) DEFAULT NULL COMMENT '最后登录IP',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_email` (`email`),
  KEY `idx_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
```

### 2. 会员表 (member)

存储用户的会员信息。

```sql
CREATE TABLE `member` (
  `member_id` bigint NOT NULL AUTO_INCREMENT COMMENT '会员ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `level` tinyint NOT NULL DEFAULT '1' COMMENT '会员等级',
  `points` int NOT NULL DEFAULT '0' COMMENT '积分',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计消费金额',
  `valid_until` datetime DEFAULT NULL COMMENT '会员有效期',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  CONSTRAINT `fk_member_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员表';
```

### 3. 收货地址表 (address)

存储用户的收货地址信息。

```sql
CREATE TABLE `address` (
  `address_id` bigint NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `name` varchar(64) NOT NULL COMMENT '收货人姓名',
  `phone` varchar(20) NOT NULL COMMENT '收货人电话',
  `province` varchar(32) NOT NULL COMMENT '省份',
  `city` varchar(32) NOT NULL COMMENT '城市',
  `district` varchar(32) NOT NULL COMMENT '区/县',
  `detail` varchar(200) NOT NULL COMMENT '详细地址',
  `post_code` varchar(10) DEFAULT NULL COMMENT '邮政编码',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认地址：0-否，1-是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`address_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_address_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收货地址表';
```

### 4. 商品分类表 (product_category)

存储商品分类信息。

```sql
CREATE TABLE `product_category` (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(64) NOT NULL COMMENT '分类名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父分类ID，顶级分类为0',
  `level` tinyint NOT NULL COMMENT '层级：1-一级分类，2-二级分类，3-三级分类',
  `sort` int DEFAULT '0' COMMENT '排序值，越小越靠前',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标URL',
  `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：0-不显示，1-显示',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`category_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_level` (`level`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';
```

### 5. 商品表 (product)

存储商品基本信息。

```sql
CREATE TABLE `product` (
  `product_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `name` varchar(128) NOT NULL COMMENT '商品名称',
  `subtitle` varchar(255) DEFAULT NULL COMMENT '副标题',
  `main_image` varchar(255) DEFAULT NULL COMMENT '主图URL',
  `detail_images` text COMMENT '详情图片URLs，JSON数组格式',
  `detail_html` text COMMENT '商品详情HTML',
  `price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `market_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `stock` int NOT NULL DEFAULT '0' COMMENT '库存',
  `sale` int NOT NULL DEFAULT '0' COMMENT '销量',
  `unit` varchar(16) DEFAULT NULL COMMENT '单位',
  `weight` decimal(10,2) DEFAULT NULL COMMENT '重量，单位：kg',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键词',
  `tags` varchar(255) DEFAULT NULL COMMENT '标签，多个用逗号分隔',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0-下架，1-上架',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_name` (`name`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';
```

### 6. 商品SKU表 (product_sku)

存储商品的规格信息。

```sql
CREATE TABLE `product_sku` (
  `sku_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'SKU ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `attrs` varchar(255) NOT NULL COMMENT '属性组合，JSON格式',
  `attrs_text` varchar(255) NOT NULL COMMENT '属性组合文本描述',
  `price` decimal(10,2) NOT NULL COMMENT 'SKU价格',
  `stock` int NOT NULL DEFAULT '0' COMMENT 'SKU库存',
  `code` varchar(64) DEFAULT NULL COMMENT 'SKU编码',
  `image` varchar(255) DEFAULT NULL COMMENT 'SKU图片URL',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`sku_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_code` (`code`),
  CONSTRAINT `fk_sku_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品SKU表';
```

### 7. 商品属性表 (product_attribute)

存储商品属性定义。

```sql
CREATE TABLE `product_attribute` (
  `attribute_id` bigint NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `name` varchar(64) NOT NULL COMMENT '属性名称',
  `values` text COMMENT '可选值列表，以逗号分隔',
  `type` tinyint NOT NULL COMMENT '类型：1-规格，2-参数',
  `sort` int DEFAULT '0' COMMENT '排序值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`attribute_id`),
  KEY `idx_category_id` (`category_id`),
  CONSTRAINT `fk_attr_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品属性表';
```

### 8. 购物车表 (cart_item)

存储用户购物车中的商品信息。

```sql
CREATE TABLE `cart_item` (
  `cart_id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `sku_id` bigint NOT NULL COMMENT 'SKU ID',
  `quantity` int NOT NULL DEFAULT '1' COMMENT '数量',
  `checked` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否选中：0-未选中，1-选中',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `uk_user_sku` (`user_id`,`sku_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_sku_id` (`sku_id`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cart_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_cart_sku` FOREIGN KEY (`sku_id`) REFERENCES `product_sku` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';
```

### 9. 订单表 (order)

存储订单基本信息。

```sql
CREATE TABLE `order` (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `pay_amount` decimal(10,2) NOT NULL COMMENT '实付金额',
  `freight_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费',
  `discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `coupon_id` bigint DEFAULT NULL COMMENT '使用的优惠券ID',
  `pay_type` tinyint DEFAULT NULL COMMENT '支付方式：1-支付宝，2-微信，3-银联',
  `source` tinyint NOT NULL DEFAULT '1' COMMENT '订单来源：1-PC，2-移动端，3-小程序，4-H5',
  `status` tinyint NOT NULL COMMENT '订单状态：0-已取消，1-待付款，2-待发货，3-待收货，4-待评价，5-已完成',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `comment_time` datetime DEFAULT NULL COMMENT '评价时间',
  `address_snapshot` text NOT NULL COMMENT '收货地址快照，JSON格式',
  `note` varchar(500) DEFAULT NULL COMMENT '订单备注',
  `delete_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除状态：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';
```

### 10. 订单详情表 (order_item)

存储订单中的商品详情信息。

```sql
CREATE TABLE `order_item` (
  `item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单项ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `product_id` bigint NOT NULL COMMENT '商品ID',
  `sku_id` bigint NOT NULL COMMENT 'SKU ID',
  `product_snapshot` text NOT NULL COMMENT '商品快照，JSON格式',
  `product_name` varchar(128) NOT NULL COMMENT '商品名称',
  `product_image` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `sku_attrs` varchar(255) NOT NULL COMMENT 'SKU属性',
  `quantity` int NOT NULL COMMENT '购买数量',
  `price` decimal(10,2) NOT NULL COMMENT '商品单价',
  `total_price` decimal(10,2) NOT NULL COMMENT '商品总价',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`item_id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_sku_id` (`sku_id`),
  CONSTRAINT `fk_item_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单详情表';
```

### 11. 支付信息表 (payment)

存储支付相关信息。

```sql
CREATE TABLE `payment` (
  `payment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '支付ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `payment_no` varchar(64) DEFAULT NULL COMMENT '支付流水号',
  `payment_method` tinyint NOT NULL COMMENT '支付方式：1-支付宝，2-微信，3-银联',
  `payment_amount` decimal(10,2) NOT NULL COMMENT '支付金额',
  `payment_status` tinyint NOT NULL COMMENT '支付状态：0-未支付，1-支付中，2-支付成功，3-支付失败',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `uk_order_id` (`order_id`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_payment_no` (`payment_no`),
  CONSTRAINT `fk_payment_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付信息表';
```

## 索引设计

系统的索引设计原则：

1. **主键索引**：每张表都设置了自增主键
2. **唯一索引**：对于需要唯一性约束的字段，如用户名、订单编号等
3. **外键索引**：对于关联字段，如user_id, product_id等
4. **复合索引**：根据查询需求，对多个字段组合建立复合索引
5. **普通索引**：对于常用于查询条件和排序的字段

## 查询优化

1. **慢查询优化**
   - 建立合适的索引
   - 优化SQL语句，避免全表扫描
   - 使用适当的分页查询

2. **数据分区**
   - 对大表采用分区策略，如订单表按时间分区

3. **读写分离**
   - 主库处理写操作
   - 从库处理读操作，减轻主库压力

## 数据库维护

1. **备份策略**
   - 每日全量备份
   - 实时binlog日志备份

2. **监控与告警**
   - 监控数据库性能指标
   - 设置阈值告警

3. **数据清理**
   - 定期归档历史数据
   - 清理过期日志和临时数据

## 完整数据库初始化脚本

完整的数据库初始化脚本可以在[这里](./main.sql)找到。该脚本包含所有表结构、索引、初始数据和存储过程的定义。

## 数据库版本升级策略

系统采用版本号管理数据库变更，升级步骤如下：

1. 备份当前数据库
2. 运行版本差异脚本
3. 验证升级结果
4. 如有问题，回滚到备份

## 附录

- [数据字典](./data-dictionary.md)
- [查询示例](./query-examples.md)
- [性能优化指南](./performance-tuning.md) 