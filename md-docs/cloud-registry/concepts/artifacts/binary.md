# Binary-артефакт

_Binary-артефакт_ — это файл, содержащий пакет любого типа: скрипт установки, исполняемый файл, файл [CSV](https://ru.wikipedia.org/wiki/CSV), документ, картинку и т.д. Пакет binary-артефакта всегда содержит ровно один файл.

В [реестре](../registry.md) любой binary-артефакт задается парой `<имя_артефакта>`/`<версия_артефакта>` и сохраняется по адресу `<URL_реестра>/<имя_артефакта>/<версия_артефакта>/<имя_файла>`. Например:

```text
https://registry.yandexcloud.net/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
```

{% note info %}

Версия binary-артефакта должна соответствовать формату [SemVer](https://semver.org/lang/ru/) — состоять из трех неотрицательных целых чисел, разделенных точками (`major.minor.patch`). Опционально после версии можно добавить знак `+` и идентификаторы версии, разделенные точками.

Примеры версий:

* `1.0.0`
* `1.2.3+first`
* `4.5.6+first.second`
* `7.8.9+first-----with-long-idf`

{% endnote %}

[Загрузить](../../operations/binary/push.md) и [скачать](../../operations/binary/pull.md) binary-артефакт вы можете с помощью [HTTP](https://ru.wikipedia.org/wiki/HTTP)-запросов с аутентификацией по [IAM-токену](../../../iam/concepts/authorization/iam-token.md).

Удалить binary-артефакт вы можете в [консоли управления](https://console.yandex.cloud). Перезаписать существующую версию binary-артефакта невозможно.

#### Полезные ссылки {#see-also}

[Поддерживаемые типы артефактов](index.md#artifacts)