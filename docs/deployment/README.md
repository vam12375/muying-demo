# 母婴商城系统部署指南

本文档提供母婴商城系统的完整部署流程，包括开发环境、测试环境和生产环境的部署方案。

## 部署架构概述

母婴商城系统采用前后端分离架构，包含三个主要组件：

1. **前台商城系统** (muying-web)：基于Vue 3开发的用户端应用
2. **后台管理系统** (muying-admin-react)：基于React开发的管理端应用
3. **后端API服务** (muying-mall)：基于Spring Boot开发的后端服务

### 基础架构

生产环境推荐的部署架构如下：

```
                                    ┌─────────────┐
                                    │   Nginx     │
                                    │  (负载均衡)  │
                                    └──────┬──────┘
                                           │
                 ┌─────────────────────────┼────────────────────┐
                 │                         │                    │
        ┌────────▼───────┐       ┌─────────▼────────┐    ┌─────▼──────┐
        │  前台商城系统   │       │   后台管理系统   │    │  API服务   │
        │ (多实例部署)   │       │  (多实例部署)    │    │ (集群部署) │
        └────────────────┘       └──────────────────┘    └─────┬──────┘
                                                                │
                                      ┌────────────────────────┬┴───────────┐
                                      │                        │            │
                               ┌──────▼──────┐          ┌──────▼──────┐    │
                               │   MySQL     │          │   Redis     │    │
                               │ (主从复制)  │          │  (集群部署)  │    │
                               └─────────────┘          └─────────────┘    │
                                                                           │
                                                                    ┌──────▼──────┐
                                                                    │Elasticsearch│
                                                                    │  (集群部署)  │
                                                                    └─────────────┘
```

## 部署前提

### 系统要求

- **服务器**：建议使用Linux系统(CentOS 8+ / Ubuntu 20.04+)
- **内存**：
  - 前端应用：至少2GB RAM
  - 后端服务：至少4GB RAM
  - 数据库：至少8GB RAM
  - Elasticsearch：至少4GB RAM
- **存储**：
  - 系统盘：至少50GB
  - 数据盘：根据预计数据量决定，建议至少100GB
- **网络**：公网IP和域名(用于HTTPS配置)

### 软件要求

- Docker 20.10+
- Docker Compose 2.0+
- Nginx 1.20+
- MySQL 8.0+
- Redis 6.0+
- JDK 21
- Node.js 18+（仅构建时需要）

## 快速部署方案

母婴商城系统提供了基于Docker Compose的快速部署方案，适用于开发和测试环境。

### 前置准备

1. 安装Docker和Docker Compose
   ```bash
   # 安装Docker
   curl -fsSL https://get.docker.com -o get-docker.sh
   sh get-docker.sh
   
   # 安装Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```

2. 克隆部署仓库
   ```bash
   git clone https://github.com/your-username/muying-demo.git
   cd muying-demo/deploy
   ```

### 使用Docker Compose部署

1. 配置环境变量
   ```bash
   cp .env.example .env
   # 编辑.env文件，设置必要的环境变量
   vim .env
   ```

2. 启动所有服务
   ```bash
   docker-compose up -d
   ```

3. 验证服务状态
   ```bash
   docker-compose ps
   ```

## 生产环境部署

生产环境建议采用更加健壮的部署方案，以下是详细步骤。

### 1. 前台商城系统部署

详细步骤请参考[前台商城系统部署文档](./frontend-web.md)。

核心步骤概述：

1. **构建静态文件**
   ```bash
   # 克隆代码
   git clone https://github.com/your-username/muying-web.git
   cd muying-web
   
   # 安装依赖
   npm install
   
   # 构建生产版本
   npm run build
   ```

2. **部署到Nginx**
   ```bash
   # 复制构建产物到Nginx静态文件目录
   cp -r dist/* /var/www/muying-web/
   
   # 配置Nginx
   vim /etc/nginx/conf.d/muying-web.conf
   ```

   Nginx配置示例:
   ```nginx
   server {
       listen 80;
       server_name mall.muyingmall.com;
       
       # 重定向到HTTPS
       return 301 https://$host$request_uri;
   }
   
   server {
       listen 443 ssl;
       server_name mall.muyingmall.com;
       
       ssl_certificate /path/to/cert.pem;
       ssl_certificate_key /path/to/key.pem;
       
       root /var/www/muying-web;
       index index.html;
       
       # API代理
       location /api {
           proxy_pass http://api-service:8080;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
       }
       
       # 处理前端路由
       location / {
           try_files $uri $uri/ /index.html;
       }
   }
   ```

3. **重启Nginx**
   ```bash
   nginx -t
   systemctl reload nginx
   ```

### 2. 后台管理系统部署

详细步骤请参考[后台管理系统部署文档](./frontend-admin.md)。

核心步骤概述：

1. **构建静态文件**
   ```bash
   # 克隆代码
   git clone https://github.com/your-username/muying-admin-react.git
   cd muying-admin-react
   
   # 安装依赖
   npm install
   
   # 构建生产版本
   npm run build
   ```

2. **部署到Nginx**
   ```bash
   # 复制构建产物到Nginx静态文件目录
   cp -r dist/* /var/www/muying-admin/
   
   # 配置Nginx
   vim /etc/nginx/conf.d/muying-admin.conf
   ```

   Nginx配置示例:
   ```nginx
   server {
       listen 80;
       server_name admin.muyingmall.com;
       
       # 重定向到HTTPS
       return 301 https://$host$request_uri;
   }
   
   server {
       listen 443 ssl;
       server_name admin.muyingmall.com;
       
       ssl_certificate /path/to/cert.pem;
       ssl_certificate_key /path/to/key.pem;
       
       root /var/www/muying-admin;
       index index.html;
       
       # API代理
       location /api {
           proxy_pass http://api-service:8080;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
       }
       
       # 处理前端路由
       location / {
           try_files $uri $uri/ /index.html;
       }
   }
   ```

3. **重启Nginx**
   ```bash
   nginx -t
   systemctl reload nginx
   ```

### 3. 后端API服务部署

详细步骤请参考[后端服务部署文档](./backend.md)。

核心步骤概述：

1. **构建Java应用**
   ```bash
   # 克隆代码
   git clone https://github.com/your-username/muying-mall.git
   cd muying-mall
   
   # 使用Maven构建
   ./mvnw clean package -DskipTests
   ```

2. **部署Spring Boot应用**

   **方法一：使用Docker部署**
   ```bash
   # 构建Docker镜像
   docker build -t muying-mall:latest .
   
   # 运行容器
   docker run -d -p 8080:8080 \
     -e SPRING_PROFILES_ACTIVE=prod \
     -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/muying_mall \
     -e SPRING_DATASOURCE_USERNAME=root \
     -e SPRING_DATASOURCE_PASSWORD=your_password \
     -e SPRING_REDIS_HOST=redis \
     --name muying-mall \
     muying-mall:latest
   ```

   **方法二：直接部署到服务器**
   ```bash
   # 复制JAR文件
   cp target/muying-mall-0.0.1-SNAPSHOT.jar /opt/muying-mall/app.jar
   
   # 创建服务
   cat > /etc/systemd/system/muying-mall.service << 'EOF'
   [Unit]
   Description=Muying Mall API Service
   After=network.target
   
   [Service]
   User=app
   WorkingDirectory=/opt/muying-mall
   ExecStart=/usr/bin/java -jar /opt/muying-mall/app.jar --spring.profiles.active=prod
   SuccessExitStatus=143
   TimeoutStopSec=10
   Restart=on-failure
   RestartSec=5
   
   [Install]
   WantedBy=multi-user.target
   EOF
   
   # 启动服务
   systemctl daemon-reload
   systemctl enable muying-mall
   systemctl start muying-mall
   ```

## 数据库部署

详细步骤请参考[数据库部署文档](./database.md)。

核心步骤概述：

1. **安装MySQL**
   ```bash
   # 使用Docker
   docker run -d --name mysql \
     -p 3306:3306 \
     -e MYSQL_ROOT_PASSWORD=your_password \
     -e MYSQL_DATABASE=muying_mall \
     -v mysql_data:/var/lib/mysql \
     mysql:8.0
   ```

2. **初始化数据库**
   ```bash
   # 导入数据库结构
   docker exec -i mysql mysql -uroot -pyour_password muying_mall < main.sql
   ```

## 缓存服务部署

1. **安装Redis**
   ```bash
   # 使用Docker
   docker run -d --name redis \
     -p 6379:6379 \
     -v redis_data:/data \
     redis:6.0
   ```

## 搜索引擎部署

详细步骤请参考[搜索引擎部署文档](./elasticsearch.md)。

核心步骤概述：

1. **安装Elasticsearch**
   ```bash
   # 使用Docker
   docker run -d --name elasticsearch \
     -p 9200:9200 -p 9300:9300 \
     -e "discovery.type=single-node" \
     -e "ES_JAVA_OPTS=-Xms1g -Xmx1g" \
     -v elasticsearch_data:/usr/share/elasticsearch/data \
     elasticsearch:8.11.0
   ```

## 监控与日志

详细步骤请参考[监控与日志文档](./monitoring.md)。

### 1. 安装Prometheus和Grafana

```bash
# 使用Docker Compose
docker-compose -f monitoring-stack.yml up -d
```

### 2. 配置应用程序日志

推荐使用ELK栈(Elasticsearch, Logstash, Kibana)来集中管理日志。

## 安全配置

详细步骤请参考[安全配置文档](./security.md)。

核心安全配置：

1. **HTTPS配置**
   - 使用Let's Encrypt获取免费SSL证书
   - 配置Nginx的SSL设置

2. **防火墙配置**
   - 只开放必要的端口
   - 使用iptables或ufw配置

3. **数据库安全**
   - 禁用远程root登录
   - 使用强密码
   - 定期备份数据

## 备份策略

详细步骤请参考[备份与恢复文档](./backup-recovery.md)。

核心备份策略：

1. **数据库备份**
   ```bash
   # 创建备份脚本
   cat > /opt/scripts/backup-db.sh << 'EOF'
   #!/bin/bash
   DATE=$(date +%Y%m%d)
   BACKUP_DIR=/opt/backups/mysql
   mkdir -p $BACKUP_DIR
   
   docker exec mysql mysqldump -uroot -pyour_password --all-databases > $BACKUP_DIR/muying_mall_$DATE.sql
   
   # 保留最近30天的备份
   find $BACKUP_DIR -type f -name "*.sql" -mtime +30 -delete
   EOF
   
   # 设置权限并添加到crontab
   chmod +x /opt/scripts/backup-db.sh
   (crontab -l 2>/dev/null; echo "0 2 * * * /opt/scripts/backup-db.sh") | crontab -
   ```

2. **应用数据备份**
   - 定期备份上传的文件和图片
   - 使用对象存储服务备份静态资源

## 故障恢复

详细步骤请参考[故障恢复文档](./disaster-recovery.md)。

核心故障恢复方案：

1. **数据库恢复**
   ```bash
   # 从备份恢复
   docker exec -i mysql mysql -uroot -pyour_password < /opt/backups/mysql/muying_mall_20230515.sql
   ```

2. **应用恢复**
   - 从备份恢复文件
   - 重启服务

## 附录

- [系统性能调优指南](./performance-tuning.md)
- [负载均衡配置](./load-balancing.md)
- [CDN配置](./cdn-setup.md)
- [持续集成/持续部署配置](./ci-cd.md) 