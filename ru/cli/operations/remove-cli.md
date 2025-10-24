---
title: Как удалить {{ yandex-cloud }} CLI
description: Следуя данной инструкции, вы сможете удалить {{ yandex-cloud }} CLI.
---

# Удаление CLI

Чтобы полностью удалить [CLI](../../glossary/cli.md), удалите установочную папку, пользовательские настройки и переменные среды.

{% list tabs group=operating_system %}

- Linux/MacOS {#linux-macos}

  1. Удалите CLI:

      ```bash
      rm -rf <путь_к_установочной_папке>
      ```

      По умолчанию путь к установочной папке — `~/yandex-cloud`:

      ```bash
      rm -rf ~/yandex-cloud
      ```

  1. Удалите пользовательские настройки CLI:

      ```bash
      rm -rf ~/.config/yandex-cloud
      ```

  1. Удалите строки с упоминанием `yandex-cloud` из файла конфигурации оболочки, например `~/.zshrc`, `~/.bashrc` или `~/.bash_profile`:

      ```bash
      if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
      if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
      ```

  1. Перезапустите терминал.

- Windows {#windows}

  1. Удалите CLI через проводник или командой:

      ```bash
      rmdir /S /Q "%USERPROFILE%\yandex-cloud"
      ```

  1. Удалите пользовательские настройки CLI:

      ```bash
      rmdir /S /Q "%USERPROFILE%\.config\yandex-cloud"
      ```

  1. Если вы добавляли CLI в переменную `PATH`:

      1. Нажмите **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Выберите в списке путь `...\yandex-cloud\bin`.
      1. Нажмите **Удалить**.
      1. Нажмите **ОК**.

  1. Перезапустите терминал.

{% endlist %}