---
title: Изменить пул зарезервированных ВМ
description: Из статьи вы узнаете, как изменить пул зарезервированных ВМ {{ compute-full-name }}.
---

# Изменение пула зарезервированных виртуальных машин

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

Чтобы изменить [пул зарезервированных ВМ](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [{{ yandex-cloud }} CLI](../../../cli/index.yaml) для изменения пула зарезервированных ВМ:

      ```bash
      yc compute reserved-instance-pool update --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Получите подробную информацию о пуле зарезервированных ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      ```bash
      yc compute reserved-instance-pool get <имя_или_идентификатор_пула>
      ```

      Результат:

      ```text
      id: fv48qa9iiq19********
      zone_id: ru-central1-d
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: test-pool
      created_at: "2025-05-06T19:46:49Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "1"
      ```
  1. Измените пул зарезервированных ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      {% note info %}

      Изменить конфигурацию виртуальных машин пула нельзя.

      {% endnote %}

      ```bash
      yc compute reserved-instance-pool update <имя_или_идентификатор_пула> \
        --new-name <новое_имя_пула> \
        --description <описание_пула> \
        --size <размер_пула>
      ```

      Где:
      * `--new-name` — новое имя пула. Необязательный параметр. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--description` — описание пула. Необязательный параметр.
      * `--size` — новое количество слотов в пуле. Необязательный параметр.

      Результат:

      ```text
      done (11s)
      id: fv48qa9iiq19********
      zone_id: {{ region-id }}-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: test-pool-new
      description: pool description
      created_at: "2025-05-06T19:46:49Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "2"
      ```

      Подробнее о команде `yc compute reserved-instance-pool update` читайте в [справочнике {{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/ReservedInstancePool/update.md) для ресурса [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) или вызовом gRPC API [ReservedInstancePoolService/Update](../../api-ref/grpc/ReservedInstancePool/update.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](./manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)