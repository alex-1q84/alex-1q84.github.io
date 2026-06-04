# Blog 样式修改指南

## 修改入口

**唯一可编辑的样式文件**：`css/custom.css`（其余 CSS/JS 为第三方库，不动）

加载顺序（HTML `<head>` 中）：bootstrap.min.css → pygments.css → scribble.css → **custom.css**（最后加载，理论上优先级最高，但 Bootstrap 的 ID/属性选择器仍可能赢）

## 色系规范

整体风格：暖色编辑式（Editorial），接近素色纸张质感。

| 用途 | 变量/值 | 说明 |
|------|---------|------|
| 页面背景 | `#F5F1EC`（body） | 素纸色，柔和暖白 |
| 代码块背景 | `--color-canvas-subtle: #EDEAE4` | 比页面背景深一档，保持同色温 |
| 正文链接 | `#6B4C2A` | 暖棕色，hover 加深至 `#4A3420` |
| 文章标题 | `#1a1a1a` | 近纯黑，不用彩色 |
| 品牌名 | `#1a1a1a` | 同文章标题 |
| 弱化文字 | `--color-fg-muted: #57606a` | 日期、标签、页脚 |
| 边框 | `--color-border-default: #d5d0c8` | 暖灰色 |
| 行内代码底色 | `--color-neutral-muted: rgba(165,158,145,0.2)` | 暖色调透明度 |

修改颜色时必须保持整体色温一致（色相 30° 左右的暖棕色系），避免冷灰/蓝色系混入。

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
- 覆盖 Bootstrap `navbar-dark bg-dark` → 透明背景 + 底部暖色细线
- 品牌名用衬线体、粗体、黑色
- 导航链接 `#57606a`，hover 加深 + 暖灰底色
- 下拉菜单：暖白底 `#F5F1EC`、暖色边框、淡阴影
- 汉堡按钮需自定义 SVG 图标颜色（覆盖 Bootstrap 默认白色）

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

## 修改检查清单

改完样式后验证：
1. 首页文章标题是否保持黑色（不被链接色覆盖）
2. 代码块背景是否与页面背景色温一致
3. 导航栏链接、下拉菜单是否正常显示
4. 页脚链接颜色是否正确（不是蓝色）
5. 移动端汉堡按钮图标颜色是否匹配
6. 所有数字（品牌名、日期）是否对齐
