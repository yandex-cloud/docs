---
title: "Как получить информацию о снимке диска в {{ compute-full-name }}"
---

# Получить информацию о снимке диска

Вы можете посмотреть идентификатор снимка, время его создания и размер диска.

Чтобы получить информацию о снимке диска:

{% list tabs %}

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о снимке диска:

      ```bash
      yc compute snapshot get --help
      ```

  1. Получите информацию о снимке диска, указав его имя или идентификатор:

      ```bash
      yc compute snapshot get <имя_снимка>
      ```

      Результат:

      ```
      id: fd8if7bg95dm********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:52:37Z"
      name: fhm0r72q6mvq********-1698677556360
      storage_size: "3779067904"
      disk_size: "34359738368"
      product_ids:
        - f2ebcrn2h53v********
        - f2e8f6be9gr1********
      status: READY
      source_disk_id: fhm0r72q6mvq********
      ```

{% endlist %}