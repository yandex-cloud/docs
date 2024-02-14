---
title: "Как получить информацию о расписании, по которому создаются снимки дисков в {{ compute-full-name }}"
---

# Получить информацию о расписании, по которому создаются снимки дисков

Вы можете посмотреть идентификатор расписания, время его создания и политику создания снимков.

Чтобы получить информацию о расписании:

{% list tabs %}

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о расписании:

      ```bash
      yc compute snapshot-schedule get --help
      ```

  1. Получите информацию о расписании, указав его имя или идентификатор:

      ```bash
      yc compute snapshot-schedule get <имя_расписания>
      ```

      Результат:

      ```
      id: fd8cc5qd25cp********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:53:33Z"
      name: sched-1
      status: ACTIVE
      schedule_policy:
        start_at: "2023-10-30T14:00:51Z"
        expression: 0 10 */1 * *
      snapshot_count: "2"
      snapshot_spec: {}
      ```

{% endlist %}