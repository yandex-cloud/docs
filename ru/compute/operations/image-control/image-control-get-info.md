---
title: "Как получить информацию об образе диска в {{ compute-full-name }}"
---

# Получить информацию об образе диска

Чтобы получить информацию об образе диска:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об образе диска:

      ```bash
      yc compute image get --help
      ```
      
  1. Получите информацию об образе диска, указав его имя или идентификатор:
      
      ```bash
      yc compute image get <имя_образа>
      ```

      Результат:

      ```bash
      id: fd8orln8oii5********
      folder_id: b1g72vbihiut********
      created_at: "2023-05-19T06:46:14Z"
      name: image-ubuntu-20-04
      description: ubuntu-20.04.6-live-server-amd64
      storage_size: "1488977920"
      min_disk_size: "1488977920"
      status: READY
      os:
        type: LINUX
      ```

{% endlist %}
