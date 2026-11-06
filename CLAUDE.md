# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

Alex-1Q84 的个人技术博客，使用 Racket 语言的 **Frog** 静态站点生成器构建，部署在 GitHub Pages。**不是 Jekyll**，构建命令是 `raco frog -b`。

核心工作流：`_src/` 中的 Markdown 博文 + HTML 模板 → `raco frog -b` → 静态 HTML 输出到仓库根目录 → 发布到 `gh-pages` 分支。`master` 分支保存源文件。

发布方式：推送 `master` 后由 GitHub Actions（`.github/workflows/deploy.yml`）自动构建并发布到 `gh-pages`（孤儿分支，仅含构建产物），日常无需手动发布。`publish.sh` 为手动发布的备用方案。

## 常用命令

```bash
make deps            # 安装依赖（frog 包 + pygments）
make build           # 构建静态页面
make preview         # 构建并启动本地预览（http://localhost:3000，watch 自动重建）
make clean           # 清理构建产物
./postmd.sh <name>   # 新建带日期前缀的博文
./publish.sh         # 手动发布：合并 master 到 gh-pages 并构建推送
```

## 架构关键点

- `_src/` 是源文件根目录，Frog 读取此目录编译输出
- `_src/posts/` 存放博文 Markdown，文件名格式 `YYYY-MM-DD-slug.md`
- `_src/` 中的 `.md` 文件会被 Frog 编译为独立 HTML 页面（如 `About.md` → `About.html`），**不要在 `_src/` 中放置非页面文件**
- 模板使用 Frog at-exp 语法（`@|variable|`、`@(when ...)`、`@list{...}`）

## 博文格式

```markdown
    Title: 文章标题
    Date: YYYY-MM-DDTHH:MM:SS
    Tags: tag1, tag2
```

- `<!-- more -->` 标记摘要分隔点
- 含 `DRAFT` 标签的博文不会发布

## 注意事项

- `make preview`（watch 模式）只监视 `_src/`，轮询周期 2 秒：保存博文或模板后约 2~3 秒自动重建，然后手动刷新浏览器即可；改 `css/`、`js/` 等静态资源无需重建，刷新即生效。watch 终端日志因 stdout 缓冲基本不可见，属正常现象，以页面效果为准
- 删除博文后 watch 重建不会清理对应产物页，本地残留可 `make clean` 清掉；线上部署是 CI 全量构建，不受影响
- `css/custom.css` 是唯一应编辑的样式文件，其余 CSS/JS 为第三方库
- `publish.sh` 中 `git reset --hard` + `git clean -dqxf` 会清空工作区，执行前确认无未提交改动
- Shell 脚本中 `emacs` 调用是写死的，非 emacs 用户需替换
- Frog 无内置文件排除机制，clean 规则已手动列出需清理的产物
