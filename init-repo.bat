@echo off
echo 初始化母婴商城演示仓库

rem 初始化Git仓库
git init

rem 添加所有文件
git add .

rem 创建初始提交
git commit -m "初始化母婴商城演示仓库"

rem 添加远程仓库（请替换为您的GitHub用户名和仓库名称）
rem git remote add origin https://github.com/用户名/muying-demo.git

rem 推送到GitHub
rem git push -u origin main

echo.
echo 仓库已初始化，请完成以下步骤：
echo 1. 在GitHub创建新仓库 'muying-demo'
echo 2. 编辑init-repo.bat，取消注释remote和push命令，并替换为您的GitHub用户名
echo 3. 再次运行init-repo.bat 