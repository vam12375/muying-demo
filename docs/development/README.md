# 母婴商城系统开发指南

本文档提供母婴商城系统的开发环境设置、开发规范和常见问题解决方案。

## 开发环境要求

### 通用要求

- Git
- Docker & Docker Compose
- IDE: VS Code / IntelliJ IDEA

### 前端开发环境

- Node.js 18.0+ (推荐使用LTS版本)
- npm 8.0+ / yarn 1.22+ / pnpm 7+
- Chrome 浏览器(用于开发调试)

### 后端开发环境

- JDK 21 (Amazon Corretto或OpenJDK)
- Maven 3.8+
- MySQL 8.0+
- Redis 6.0+
- Elasticsearch 8.11.0 (可选，用于搜索功能)

## 开发环境设置

### 前台商城系统(muying-web)

详细的环境设置和开发指南请参考[前台商城系统开发指南](./frontend-web.md)

简要步骤:

```bash
# 克隆仓库
git clone https://github.com/your-username/muying-web.git
cd muying-web

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

### 后台管理系统(muying-admin-react)

详细的环境设置和开发指南请参考[后台管理系统开发指南](./frontend-admin.md)

简要步骤:

```bash
# 克隆仓库
git clone https://github.com/your-username/muying-admin-react.git
cd muying-admin-react

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

### 后端API服务(muying-mall)

详细的环境设置和开发指南请参考[后端服务开发指南](./backend.md)

简要步骤:

```bash
# 克隆仓库
git clone https://github.com/your-username/muying-mall.git
cd muying-mall

# 启动MySQL和Redis（使用Docker）
docker-compose up -d

# 使用Maven运行应用
./mvnw spring-boot:run
```

## 开发规范

### 代码风格规范

- **前端代码风格**
  - 使用ESLint和Prettier
  - 组件命名采用PascalCase
  - 变量和函数命名采用camelCase
  - 常量使用全大写+下划线
  - CSS类名采用kebab-case

- **后端代码风格**
  - 遵循Google Java Style Guide
  - 类名采用PascalCase
  - 方法和变量命名采用camelCase
  - 常量使用全大写+下划线
  - 包名全小写，有意义的缩写

### 提交规范

所有代码提交必须遵循[Conventional Commits](https://www.conventionalcommits.org/)规范:

```
<类型>[可选的作用域]: <描述>

[可选的正文]

[可选的脚注]
```

类型包括:
- `feat`: 新功能
- `fix`: Bug修复
- `docs`: 文档更改
- `style`: 格式调整，不影响代码功能
- `refactor`: 代码重构，既不修复错误也不添加功能
- `perf`: 性能优化
- `test`: 添加或修改测试
- `build`: 构建系统或外部依赖项的更改
- `ci`: CI配置和脚本的更改

示例:
```
feat(product): 添加商品评论功能

- 实现评论提交
- 实现评论分页加载
- 添加评论点赞功能

解决: #123
```

### 分支管理

采用[GitFlow](https://nvie.com/posts/a-successful-git-branching-model/)工作流:

- `main`: 生产环境分支，稳定版本
- `develop`: 开发分支，最新开发版本
- `feature/*`: 功能分支，用于开发新功能
- `release/*`: 发布分支，准备发布版本
- `hotfix/*`: 热修复分支，用于修复生产环境bug

### 文档规范

- API文档使用OpenAPI 3.0规范
- 代码注释遵循JSDoc(前端)和Javadoc(后端)规范
- 需要为每个模块、类和公共方法提供文档注释
- README文件应包含必要的使用说明和示例

## 开发流程

### 功能开发流程

1. **需求分析**
   - 理解需求文档
   - 明确功能范围和验收标准
   - 与产品经理确认细节

2. **设计**
   - 技术方案设计
   - 数据模型设计
   - 接口设计
   - 前端组件设计

3. **开发**
   - 创建功能分支
   - 编写代码和单元测试
   - 进行代码自测

4. **代码评审**
   - 提交Pull Request
   - 其他开发者进行代码评审
   - 根据反馈修改代码

5. **测试**
   - 集成测试
   - 功能测试
   - 性能测试(如需要)

6. **部署**
   - 合并到开发分支
   - 部署到测试环境
   - 验证功能正常

### Bug修复流程

1. **Bug确认**
   - 复现问题
   - 明确错误现象和影响范围

2. **分析**
   - 定位错误原因
   - 评估修复方案

3. **修复**
   - 创建修复分支
   - 编写修复代码和测试用例

4. **验证**
   - 确认bug已修复
   - 确认没有引入新问题

5. **提交评审**
   - 提交Pull Request
   - 进行代码评审

## 测试指南

### 单元测试

- **前端**：使用Jest和React Testing Library/Vue Test Utils
- **后端**：使用JUnit 5和Mockito

### 集成测试

- **前端**：使用Cypress进行E2E测试
- **后端**：使用Spring Boot Test和TestContainers

### API测试

- 使用Postman或REST Assured自动化API测试

## 常见问题与解决方案

### 前端开发问题

1. **问题**: 启动开发服务器时报错 `ENOSPC: System limit for number of file watchers reached`
   **解决方案**: 增加系统文件监视器限制
   ```bash
   echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
   ```

2. **问题**: 构建时出现内存不足错误
   **解决方案**: 增加Node.js内存限制
   ```bash
   export NODE_OPTIONS=--max-old-space-size=4096
   ```

### 后端开发问题

1. **问题**: 启动应用时端口冲突
   **解决方案**: 修改`application.yml`中的服务端口
   ```yaml
   server:
     port: 8081  # 修改为未占用的端口
   ```

2. **问题**: Redis连接失败
   **解决方案**: 检查Redis服务是否启动，验证连接配置是否正确

## 参考资源

- [Vue 3文档](https://v3.vuejs.org/)
- [React文档](https://reactjs.org/)
- [Spring Boot文档](https://spring.io/projects/spring-boot)
- [MyBatis-Plus文档](https://baomidou.com/)
- [Element Plus文档](https://element-plus.org/)
- [Ant Design文档](https://ant.design/) 