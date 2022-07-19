# Релизы COI

{% cut "Как узнать свою версию COI" %}

* Чтобы узнать версию внутри образа (для версии 2.0.4 и выше), выполните команду:

  ```bash
  cat /etc/ycloud/image-info
  ```

  Результат:

  ```bash
  coi-version: 2.0.4
  ```

* Чтобы узнать версию в `description` (для версии 2.1.0 и выше), выполните команду:

  ```bash
  yc compute image get <ID или имя образа> --profile preprod --format json | jq -r '.description'
  ```

  Результат:

  ```bash
  Container Optimized Image 2.1.0
  ```

{% endcut %}

{% note info %}

В версии 2.2.0 и выше патч (третья цифра в версии, например, 3 в 1.2.3) означает обновление системных компонентов и пакетов и не упоминается в списке релизов.

{% endnote %}

{% include [latest-release](../_includes/cos/latest-release.md) %}

## Предыдущие релизы {#previous-releases}

{% include [previous-releases](../_includes/cos/previous-releases.md) %}