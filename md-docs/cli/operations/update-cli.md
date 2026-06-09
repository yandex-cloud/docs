# Обновление CLI

## Посмотреть версию CLI {#see-version}

Чтобы узнать текущую версию CLI, в терминале выполните команду:
    
```bash
yc version
```

Результат:

```text
Yandex Cloud CLI 0.144.0 darwin/arm64
```

Информация о версиях CLI представлена на странице [{#T}](../release-notes.md).

## Обновить CLI {#update}

CLI автоматически проверяет наличие обновления. Если обновление доступно, при вызове любой команды CLI в терминале выводится следующее сообщение:

```text
There is a new yc version '0.145.0' available. Current version: '0.144.0'.
See release notes at https://yandex.cloud/ru/docs/cli/release-notes
You can install it by running the following command in your shell:
    $ yc components update
```

Чтобы обновить CLI до новой версии, выполните команду:

```bash
yc components update
```

Результат:

```text
Installing yc 0.145.0 ...
Update is complete!
Please reload your shell for changes to take place.
Now we have zsh completion. Type "echo 'source /Users/vnkiryushkin/yandex-cloud/completion.zsh.inc' >>  ~/.zshrc" to install it
```

## Откатить версию CLI {#rollback}

Вы можете вернуться к предыдущей версии CLI с помощью команды:

```bash
yc components restore
```

Результат:

```text
Restoring backup...
Restoration done!
```