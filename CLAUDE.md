# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

Alex-1Q84 的个人技术博客，使用 Racket 语言的 **Frog** 静态站点生成器构建，部署在 GitHub Pages。**不是 Jekyll**，构建命令是 `raco frog -b`。

核心工作流：`_src/` 中的 Markdown 博文 + HTML 模板 → `raco frog -b` → 静态 HTML 输出到仓库根目录 → 推送 `gh-pages` 分支发布。`master` 分支保存源文件。

## 常用命令

```bash
make deps            # 安装依赖（frog 包 + pygments）
make build           # 构建静态页面
make preview         # 构建并启动本地预览服务器
make clean           # 清理构建产物
./postmd.sh <name>   # 新建带日期前缀的博文
./publish.sh         # 合并 master 到 gh-pages 并发布
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

- `css/custom.css` 是唯一应编辑的样式文件，其余 CSS/JS 为第三方库
- `publish.sh` 中 `git reset --hard` + `git clean -dqxf` 会清空工作区，执行前确认无未提交改动
- Shell 脚本中 `emacs` 调用是写死的，非 emacs 用户需替换
- Frog 无内置文件排除机制，clean 规则已手动列出需清理的产物
