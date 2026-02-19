---
title: Загрузить binary-артефакт в реестр {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы загрузите binary-артефакт в реестр {{ cloud-registry-full-name }}.
---

# Binary-артефакт

_Binary-артефакт_ — это файл, содержащий пакет любого типа: скрипт установки, исполняемый файл, файл [CSV](https://ru.wikipedia.org/wiki/CSV), документ, картинку и т.д. Пакет binary-артефакта всегда содержит ровно один файл. Максимальный размер загружаемого файла — 100 МБ.

В [реестре](../registry.md) любой binary-артефакт задается парой `<имя_артефакта>`/`<версия_артефакта>` и сохраняется по адресу `<URL_реестра>/<имя_артефакта>/<версия_артефакта>/<имя_файла>`. Например:

```text
https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
```

[Загрузить](../../operations/binary/push.md) и [скачать](../../operations/binary/pull.md) binary-артефакт вы можете с помощью [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP)-запросов с аутентификацией по [IAM-токену](../../../iam/concepts/authorization/iam-token.md).

Удалить binary-артефакт вы можете в [консоли управления]({{ link-console-main }}). Перезаписать существующую версию binary-артефакта невозможно.

#### См. также {#see-also}

[Поддерживаемые типы артефактов](./index.md#artifacts)
