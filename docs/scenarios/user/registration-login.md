# 新用户注册与登录

本文档详细介绍母婴商城系统的用户注册与登录流程，帮助新用户快速完成账号创建和登录操作。

## 目录

- [前置条件](#前置条件)
- [注册流程](#注册流程)
- [登录流程](#登录流程)
- [忘记密码](#忘记密码)
- [第三方账号登录](#第三方账号登录)
- [常见问题](#常见问题)

## 前置条件

- 手机号码（用于接收验证码）
- 有效的电子邮箱（可选）
- 稳定的网络连接
- 最新版本的浏览器（推荐Chrome、Firefox、Edge等）

## 注册流程

### 步骤1：进入注册页面

1. 打开母婴商城首页
2. 点击页面右上角的"登录/注册"按钮
3. 在弹出的登录窗口中，点击"立即注册"按钮

### 步骤2：选择注册方式

系统提供两种注册方式：
- **手机注册**（推荐）：使用手机号码接收验证码完成注册
- **邮箱注册**：使用电子邮箱接收验证链接完成注册

### 步骤3：填写注册信息

**手机注册**流程：
1. 输入手机号码
2. 点击"获取验证码"按钮
3. 输入收到的短信验证码
4. 设置账号密码（8-20位，包含字母、数字、特殊字符）
5. 再次输入密码确认
6. 勾选"同意用户协议和隐私政策"
7. 点击"注册"按钮完成注册

**邮箱注册**流程：
1. 输入电子邮箱地址
2. 设置账号密码（8-20位，包含字母、数字、特殊字符）
3. 再次输入密码确认
4. 勾选"同意用户协议和隐私政策"
5. 点击"注册"按钮
6. 系统发送验证邮件至邮箱
7. 登录邮箱，点击验证链接完成注册

<div align="center">
  <img src="../../screenshots/registration-form.png" alt="注册表单示例" width="60%" />
  <p>注册表单示例</p>
</div>

### 步骤4：完善个人信息

注册成功后，系统会引导用户完善个人信息（可选步骤）：
1. 设置昵称
2. 上传头像
3. 选择宝宝信息（年龄、性别等）
4. 设置常用收货地址

> **提示**：完善个人信息可获得新用户积分奖励，建议完成此步骤。

## 登录流程

### 步骤1：进入登录页面

1. 打开母婴商城首页
2. 点击页面右上角的"登录/注册"按钮

### 步骤2：选择登录方式

系统提供多种登录方式：
- **账号密码登录**：使用注册时设置的账号和密码
- **短信验证码登录**：使用手机号接收验证码登录
- **第三方账号登录**：使用微信、QQ、微博等第三方账号登录

### 步骤3：输入登录信息

**账号密码登录**步骤：
1. 输入手机号/邮箱
2. 输入密码
3. （可选）勾选"记住密码"
4. 点击"登录"按钮

**短信验证码登录**步骤：
1. 切换至"短信验证码"登录选项卡
2. 输入手机号码
3. 点击"获取验证码"按钮
4. 输入收到的验证码
5. 点击"登录"按钮

<div align="center">
  <img src="../../screenshots/login-page.png" alt="登录界面示例" width="60%" />
  <p>登录界面示例</p>
</div>

### 步骤4：登录成功

登录成功后，系统会：
1. 显示欢迎信息
2. 自动跳转到首页或上次浏览的页面
3. 右上角显示用户头像和昵称

## 忘记密码

如果忘记了登录密码，可以通过以下步骤重置：

1. 在登录页面点击"忘记密码"链接
2. 选择重置方式（手机号或邮箱）
3. 输入账号关联的手机号或邮箱
4. 接收验证码并填写
5. 设置新密码
6. 确认新密码
7. 点击"确认修改"按钮

<div align="center">
  <img src="../../screenshots/reset-password.png" alt="重置密码界面" width="60%" />
  <p>重置密码界面</p>
</div>

## 第三方账号登录

### 微信登录

1. 在登录页面点击微信图标
2. 系统弹出微信二维码
3. 使用手机微信扫描二维码
4. 确认授权登录
5. 登录成功

### QQ登录

1. 在登录页面点击QQ图标
2. 系统跳转至QQ授权页面
3. 输入QQ账号密码或使用手机QQ扫码
4. 确认授权登录
5. 登录成功

### 其他第三方登录

类似流程适用于微博、苹果账号等其他支持的第三方登录方式。

> **注意**：首次使用第三方账号登录时，系统会要求用户绑定手机号以确保账号安全。

## 常见问题

### 1. 注册时提示"手机号已被注册"

可能原因：
- 您之前已使用该手机号注册过账号
- 手机号输入错误

解决方法：
- 尝试直接登录
- 使用"忘记密码"功能找回账号
- 检查手机号是否输入正确
- 联系客服协助处理

### 2. 无法收到验证码

可能原因：
- 手机信号不佳
- 短信被拦截
- 到达短信发送限制

解决方法：
- 检查手机信号
- 查看是否被拦截
- 稍后再试
- 尝试使用邮箱注册

### 3. 第三方登录失败

可能原因：
- 网络连接不稳定
- 第三方账号授权已过期
- 浏览器限制了弹窗

解决方法：
- 检查网络连接
- 重新授权第三方账号
- 允许浏览器弹窗
- 尝试使用其他登录方式

如有其他问题，请联系客服热线：400-888-8888（工作时间：9:00-18:00） 