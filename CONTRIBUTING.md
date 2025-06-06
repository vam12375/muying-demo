# 贡献指南

感谢您对母婴商城项目的关注！我们欢迎所有形式的贡献，包括但不限于：功能开发、bug修复、文档改进、UI/UX优化等。

## 贡献流程

### 1. 准备工作

1. Fork 本仓库
2. 将你的 Fork clone 到本地：`git clone https://github.com/YOUR_USERNAME/muying-demo.git`
3. 添加上游仓库：`git remote add upstream https://github.com/original-owner/muying-demo.git`
4. 创建新分支：`git checkout -b feature/your-feature-name`

### 2. 开发

1. 确保代码符合项目的编码规范
2. 编写必要的测试
3. 保证所有测试通过
4. 提交代码前请运行相关的测试和构建过程

### 3. 提交

1. 保持提交信息清晰明了：`git commit -m "feat: add new feature"`
2. 我们使用以下提交类型前缀：
   - `feat`: 新功能
   - `fix`: 错误修复
   - `docs`: 文档更改
   - `style`: 不影响代码含义的格式调整
   - `refactor`: 代码重构
   - `perf`: 性能优化
   - `test`: 添加测试
   - `chore`: 构建过程或辅助工具的变动

### 4. 发起 Pull Request

1. 推送到你的仓库：`git push origin feature/your-feature-name`
2. 在GitHub上发起Pull Request
3. 等待维护者审核和合并

## 开发规范

### 前端规范

1. 使用ESLint和Prettier保持代码风格一致
2. 组件命名采用PascalCase
3. 使用TypeScript类型定义
4. CSS采用BEM命名规范或TailwindCSS
5. 遵循组件化和模块化开发原则

### 后端规范

1. 遵循RESTful API设计规范
2. 使用Java编码规范
3. 方法命名明确表达其功能
4. 编写单元测试和集成测试
5. 异常处理和日志记录规范

## 文档规范

1. 使用Markdown格式编写文档
2. 中文文档中的英文术语前后添加空格
3. 图片和示例代码应有清晰的说明
4. 保持文档结构清晰和一致

## 问题反馈

如果你发现了bug或有新功能建议，请先查看是否已有相关issue，如果没有，请创建新的issue，并提供：

1. 问题的详细描述
2. 复现步骤
3. 预期行为和实际行为
4. 截图和错误日志（如有）

## 代码评审

所有的代码贡献都需要通过代码评审。代码评审的主要关注点包括：

1. 代码质量和规范
2. 架构设计和性能
3. 安全性和健壮性
4. 测试覆盖率

## 许可协议

通过贡献代码，您同意您的贡献将在[MIT许可证](./LICENSE)下发布。 