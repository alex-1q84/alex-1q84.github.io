# Blog 样式修改指南

## 修改入口

**唯一可编辑的样式文件**：`css/custom.css`（其余 CSS/JS 为第三方库，不动）

加载顺序（HTML `<head>` 中）：bootstrap.min.css → pygments.css → scribble.css → **custom.css**（最后加载，理论上优先级最高，但 Bootstrap 的 ID/属性选择器仍可能赢）

## 色系规范

整体风格：暖色编辑式（Editorial），接近素色纸张质感。

| 用途 | 变量/值 | 说明 |
|------|---------|------|
| 页面背景 | `--paper: #F2F3ED`（body） | 素纸色，柔和暖白 |
| 代码块背景 | `--color-canvas-subtle: #ECE6D9` | 比页面背景深一档，保持同色温 |
| 正文链接 | `--sepia: #8B5A2B` | 暖棕色，hover 加深至 `--sepia-deep: #5E3A1A` |
| 文章标题 | `--ink: #2C2620` | 近纯黑墨色，不用彩色 |
| 品牌名 | `--ink: #2C2620` | 同文章标题 |
| 弱化文字 | `--color-fg-muted: #7A6F62` | 日期、标签、页脚 |
| 边框 | `--color-border-default: #DCD5C8` | 暖灰色 |
| 行内代码底色 | `--code-bg: rgba(139,90,43,0.06)` | 暖棕透明度 |

默认主题修改颜色时必须保持整体色温一致（色相 30° 左右的暖棕色系），避免冷灰/蓝色系混入。各主题在自身色系内保持一致，主题级换色通过 `[data-theme]` 变量覆盖实现（见下方「主题系统」）。

## 字体规范

| 用途 | 字体栈 | 备注 |
|------|--------|------|
| 文章标题 | Georgia, Palatino Linotype, serif | 衬线体，粗体 700 |
| 导航品牌名 | "New York", "Palatino Linotype", Georgia, serif | New York 优先（数字等高），启用 `lnum` |
| 正文/代码 | 系统默认 | 代码用等宽字体栈 |

## CSS 优先级陷阱（重要）

### Bootstrap 覆盖问题

Bootstrap 的 `a { color: #007bff }` 选择器优先级 (0,0,1) 低于自定义的 `footer a` (0,1,0)，理论上应该生效，但实际某些场景下需要 `!important` 才能覆盖。

**经验**：页脚链接等非 `#content` 区域的链接样式，加 `!important` 更稳妥。

### 标题链接被正文链接样式覆盖

`#content a`（ID 选择器 1,0,0）会覆盖 `article header h2 a`（0,1,3），导致标题链接颜色被正文链接色覆盖。

**解决**：用 `#content article header h2 a`（ID + 多层元素）确保优先级高于 `#content a`，并显式设置 `border-bottom: none` 避免下划线残留。

### Georgia 数字对齐问题

Georgia 默认使用老式数字（old-style figures），数字高度参差不齐。"Alex-1Q84" 这类含数字的品牌名会出现视觉错位。

**解决**：
- 字体栈把 "New York"（macOS 原生衬线）或 "Palatino Linotype" 排在 Georgia 前面
- 添加 `font-variant-numeric: lining-nums` + `font-feature-settings: "lnum" 1, "kern" 1`

## 各区域样式速查

### 导航栏 (navbar)
- 模板使用 Bootstrap `navbar-light`（无背景类），覆盖为透明背景 + 底部暖色细线
- 品牌名用衬线体、粗体、黑色
- 导航链接 `--ink-muted`，hover 加深 + 暖色底
- 汉堡按钮需自定义 SVG 图标颜色（`--toggler-icon`，覆盖 Bootstrap 默认色）
- 主题切换按钮 `.theme-toggle`：窄屏靠 `margin-left: auto` 紧贴汉堡按钮左侧，桌面端（≥768px）用 `order: 5` 排到导航末尾

### 文章标题
- `article header h1`（详情页）、`article header h2`（列表页）
- 首页 `h2 a` 是链接，需单独处理优先级（见上方陷阱）
- 首页 "… more …" 链接在 `article footer` 中

### 代码块
- `pre`：暖灰背景、8px 圆角、1px 暖色边框、20px 内边距
- `code`（行内）：暖色半透明底、4px 圆角、1px 边框
- 禁止换行（`white-space: pre`），保持代码行对齐

### 链接
- 正文链接：暖棕色 + 底部细线（border-bottom 模拟下划线，视觉更柔和）
- 标签链接：去下划线，改为小药丸样式（背景色 + 圆角）
- 页脚链接：需 `!important` 确保覆盖 Bootstrap

### 页脚 (footer)
- 文字色 `--color-fg-muted`
- `hr` 用暖色边框
- 链接同正文链接风格

## 主题系统

主题由 `<html data-theme>` 表达：默认主题无属性，永乐主题为 `data-theme="yongle"`。选中状态存于 localStorage 键 `theme`（值为 `yongle` / `default`）。

- 实现：所有颜色收敛为 `:root` CSS 变量；主题差异只在 `css/custom.css` 的 `[data-theme="yongle"]` 块重定义变量，组件规则本身不分主题
- 防闪烁：`_src/page-template.html` 的 `<head>` 内联脚本在渲染前读 localStorage 恢复 `data-theme`
- 切换按钮：导航栏 `<button id="theme-toggle">`，文案显示将切换到的主题名（默认 ↔ 永乐），原生 JS 不依赖 jQuery
- 永乐主题取自《永乐大典》册页：纸面 `#F7F1E3`、朱丝栏 `#B5442D`（链接/强调/标题分隔线）、松烟墨 `#2B2620`、暖褐灰 `#6E5F4E`；body 不铺 `bg.png` 纹理，用干净纸色

## 修改检查清单

改完样式后验证（默认主题与永乐主题各验一遍）：
1. 首页文章标题是否保持黑色（不被链接色覆盖）
2. 代码块背景是否与页面背景色温一致
3. 导航栏链接、下拉菜单是否正常显示
4. 页脚链接颜色是否正确（不是蓝色）
5. 移动端汉堡按钮图标颜色是否匹配
6. 所有数字（品牌名、日期）是否对齐
