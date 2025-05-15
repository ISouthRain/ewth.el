[中文](README-zh.md)

# Introduction

`ewth.el` is a simple Emacs minor mode that displays weather information in the Emacs modeline.

It leverages the `wttr.in` service, which provides concise weather reports, allowing you to stay informed without leaving Emacs.

![Preview](./modeline.png)

## Why not use display-wttrn.el?

[display-wttrn](https://github.com/josegpt/display-wttr)

- Freezes Emacs while updating data.

## Key Features

*   **Asynchronous Data Updates:** Prevents Emacs from freezing during updates.

*   **Modeline Display:** Weather information is displayed directly in the Emacs window's modeline, without interrupting your editing.

*   **Automatic Updates:** `ewth.el` automatically fetches the latest weather data from `wttr.in` at regular intervals and updates the modeline display. The update frequency can be adjusted via a customizable variable.

*   **Configurable:** You can configure the `wttr.in` URL (`ewth-url`) via a customizable variable to retrieve weather information for a specific city or in a specific format.

*   **Easy to Enable/Disable:** Easily enable or disable the weather information display with `ewth-mode`.

*   **Clean and Concise:** By default, the weather information is displayed in a simple text format that doesn't take up too much modeline space.

## Usage

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

## Dependencies

*   `request.el`: Used for sending HTTP requests. Ensure you have the `request` package installed. You can install it using `M-x package-install request`.

## Customization Options

*   `ewth-url`: Specifies the `wttr.in` URL.  Affects the displayed city, format, etc.
*   `ewth-update-interval`: Specifies the interval (in seconds) at which the weather information is updated.

## Important Notes

*   `wttr.in` is a public service. Please use it responsibly and avoid requesting data too frequently.
*   If the `request` package is not installed correctly, `ewth.el` will not function properly.

## Acknowledgements
- Inspired by: [display-wttrn](https://github.com/josegpt/display-wttr)
