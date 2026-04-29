# dotfiles

## インストール

必要な設定ファイルをコピー。<br>
(e.g. zsh と atuin)

```
% cd
% cp -r dotfiles/.config/{atuin,zsh} .config/
```

ホームディレクトリ直下に .zshenv を作成。

```
% ln -sf ~/.config/zsh/.zshenv
```
