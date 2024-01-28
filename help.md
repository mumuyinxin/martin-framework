## this exceeds GitHub's file size limit of 100.00 MB

解决方法
https://git-lfs.github.com/

下载并安装 Git 命令行扩展。下载并安装后，运行以下命令为您的用户帐户设置 Git LFS：

git lfs install

在您要使用 Git LFS 的每个 Git 存储库中，选择您希望 Git LFS 管理的文件类型（或直接编辑您的 .gitattributes）。您可以随时配置其他文件扩展名

git lfs migrate import --include="*.pdf"
git lfs track "*.pdf"

现在确保 .gitattributes 被跟踪：

git add .gitattributes
