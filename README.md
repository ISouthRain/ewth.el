# 介绍
`ewth.el` 是一个简单的 Emacs 小工具，用于在 Emacs 的 modeline 中显示天气信息。  
它利用了 `wttr.in` 这个提供简洁天气信息的服务，让你无需离开 Emacs 就能随时了解天气状况。  

![预览](./modeline.png)

## 为什么不用 display-wttrn.el
[display-wttrn](https://github.com/josegpt/display-wttr)

- 更新数据时莫名卡住 Emacs

## 主要特性
*   **异步更新数据不卡住 Emacs**

*   **模式行显示：** 天气信息直接显示在 Emacs 窗口底部的模式行中，不会干扰你的编辑工作。

*   **自动更新：**  `ewth.el` 会定期自动从 `wttr.in` 获取最新的天气数据，并更新 modeline 显示。更新频率可以通过自定义变量进行调整。

*   **可配置：**  你可以通过自定义变量来配置 `wttr.in` 的 eth-url，从而获取特定城市或格式的天气信息。

*   **易于启用/禁用：** 使用 `ewth-mode` 即可轻松地启用或禁用天气信息的显示。

*   **简洁美观：**  默认配置下，天气信息以简洁的文本形式显示，不会占用太多模式行空间。

## 使用方法
```emacs-lisp
(use-package ewth
  :ensure nil
  :load-path "path/to/ewth"
  :defer 2
  :config
  (setq ewth-url "http://wttr.in/纽约?format=2&M")
  (ewth-mode)
  )
```

## 依赖

*   `request.el`：用于发送 HTTP 请求。 确保你已经安装了 `request` 包。 你可以使用 `M-x package-install request` 命令安装。


## 自定义选项

*   `ewth-url`：指定 `wttr.in` 的 URL。  影响显示的城市，格式等
*   `ewth-update-interval`：指定天气信息更新的间隔（秒）。

## 注意事项

*   `wttr.in` 是一个公共服务，请合理使用，不要过于频繁地请求数据。
*   如果 `request` 包没有正确安装，`ewth.el` 将无法正常工作。

## 致谢
- 灵感来源: [display-wttrn](https://github.com/josegpt/display-wttr)
