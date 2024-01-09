---
title: "Как получить информацию об имеющихся реестрах в {{ container-registry-full-name }}"
description: "Следуя данной инструкции, вы сможете получить информацию об имеющихся реестрах." 
---

# Получить информацию об имеющихся реестрах

Узнайте, как получить:
* [Список реестров в каталоге](#registry-list).
* [Подробную информацию о реестре](#registry-get).

## Получить список реестров в каталоге {#registry-list}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Получите список [реестров](../../concepts/registry.md) в каталоге по умолчанию:

  ```bash
  yc container registry list
  ```

  Результат:

  ```bash
  +----------------------+--------+----------------------+
  |          ID          |  NAME  |      FOLDER ID       |
  +----------------------+--------+----------------------+
  | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
  +----------------------+--------+----------------------+
  ```

- API {#api}

  Чтобы получить список реестров в каталоге по умолчанию, воспользуйтесь методом [list](../../api-ref/Registry/list.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}

## Получить подробную информацию о реестре {#registry-get}

Для обращения к реестру используйте параметры `id` или `name` из [предыдущего](#registry-list) пункта.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Получите подробную информацию о реестре:

  ```bash
  yc container registry get my-reg
  ```

  Результат:

  ```bash
  id: crpd50616s9a********
  folder_id: b1g88tflru0e********
  name: my-reg
  status: ACTIVE
  created_at: "2019-01-09T14:34:06.601Z"
  ```

- API {#api}

  Чтобы получить подробную информацию о реестре, воспользуйтесь методом [get](../../api-ref/Registry/get.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}