# Emacs SE

This package is fully respecting
+ http://emacs.rubikitch.com/sound-wav/
+ http://rubikitch.com/f/160817113854.sound-wav.el

## Setup

In init.el, you should write

```elisp
(add-to-list 'load-path "YOUR PATH")
(require 'emacs-se)
```

## Usage

### 1. Set Your Favorite SE

You should customize the variables below.

+ emacs-se--type: SE for typing
+ emacs-se--enter: SE for type `Enter`
+ emacs-se--delete: SE for type `Delete`
+ emacs-se--space: SE for type `Space`
+ emacs-se--find-file: SE for `find-file`

For example

```elisp
;; NOTE: PATH should be absolute path
(setq emacs-se--enter "PATH")
```

### 2. Enable Minor Mode

```elisp
M-x toggle-emacs-se
```

## Limitation

+ Only `wav` file is allowed
  + To avoid this limitation, you should read [this](http://emacs.rubikitch.com/sound-wav/).
