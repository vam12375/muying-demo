#!/bin/bash

# 初始化Git仓库
git init

# 添加所有文件
git add .

# 创建初始提交
git commit -m "初始化母婴商城演示仓库"

# 添加远程仓库（请替换为您的GitHub用户名和仓库名称）
# git remote add origin https://github.com/用户名/muying-demo.git

# 推送到GitHub
# git push -u origin main

echo "仓库已初始化，请完成以下步骤："
echo "1. 在GitHub创建新仓库 'muying-demo'"
echo "2. 取消注释init-repo.sh中的remote和push命令，并替换为您的GitHub用户名"
echo "3. 运行以下命令推送到GitHub："
echo "   chmod +x init-repo.sh"
echo "   ./init-repo.sh" 