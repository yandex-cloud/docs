---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Релизы COI

{% cut "Как узнать свою версию COI" %}

* Чтобы узнать версию изнутри образа (для версии 2.0.4 и выше), выполните команду:

  ```bash
  cat /etc/ycloud/image-info
  ```

  Результат выполнения команды:

  ```
  coi-version: 2.0.4
  ```

* Чтобы узнать версию в `description` (для версии 2.1.0 и выше), выполните команду:

  ```bash
  yc compute image get <ID или имя образа> --profile preprod --format json | jq -r '.description'
  ```

  Результат выполнения команды:

  ```bash
  Container Optimized Image 2.1.0
  ```

{% endcut %}

{% include [latest-release](../_includes/cos/latest-release.md) %}

## Предыдущие релизы {#previous-releases}

{% include [previous-releases](../_includes/cos/previous-releases.md) %}
