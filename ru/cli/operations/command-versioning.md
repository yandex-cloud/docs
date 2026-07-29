# Работа с версиями команд {{ yandex-cloud }} CLI

{% include [command-ver-intro](../../_includes/cli/command-ver-intro.md) %}

## Узнать, какие версии доступны {#get-versions}

Когда сервис поддерживает несколько версий команд, для каждой из них доступна отдельная ветка с номером версии.

Чтобы узнать, какие версии доступны и какая из них используется в основной ветке, выполните команду:

```bash
yc <название_сервиса> --help
```

Пример:

```bash
yc baremetal --help
```

Результат:

```text
Command tree v1 (new CLI interface) is the default. Run `yc baremetal v1 <command>`.
Legacy command tree v0 is also available: `yc baremetal v0 <command>`.
Set `services.baremetal.version: v0` or `services.baremetal.version: v1` in your profile to change the default.
```

Эта информация также указана на обзорной странице соответствующего сервиса в справочнике CLI, например [yc baremetal](../cli-ref/baremetal/cli-ref/index.md) или [yc smartwebsecurity](../cli-ref/smartwebsecurity/cli-ref/index.md).

## Использовать определенную версию {#use-version}

Чтобы использовать определенную версию, укажите ее в команде после названия сервиса:

```bash
yc <название_сервиса> v<номер_версии> <команда>
```

Например:

```bash
yc baremetal v0 server list
```

## Изменить версию для основной ветки {#default-version}

Чтобы переопределить версию в основной ветке для выбранного профиля CLI, выполните команду:

```bash
yc config set services.<название_сервиса>.version v<номер_версии>
```

Например:

```bash
yc config set services.smartwebsecurity.version v0
```

#### Полезные ссылки

* [Справочник CLI](../cli-ref/index.md)
* [{#T}](../release-notes.md)
* [{#T}](./profile/manage-properties.md)
