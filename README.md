# Mirroring branch

[![mirror](https://github.com/abougouffa/jujutsushi/actions/workflows/mirror.yaml/badge.svg)](https://github.com/abougouffa/jujutsushi/actions/workflows/mirror.yaml)

> [!NOTE]
> This branch is set a the default one for mirroring purposes. **To access the code, please check the [default branch](../../tree/default)**.

The `__mirror` branch is set as the **default** branch because of GitHub's schedule actions policy. The schedule actions can only be run on the default branch.

Therefore, if you are using this repo as an alternative to the default one, please make sure you specify the right branch (`default` in this case) in you recipe. Here is an example of such a recipe for `straight.el`:

```elisp
(use-package jujutsushi
  :straight (:host github :repo "abougouffa/jujutsushi" :branch "default"))
```
