---
title: Изменить пул резервов ВМ
description: Из статьи вы узнаете, как изменить пул резервов ВМ {{ compute-full-name }}.
---

# Изменение пула резервов виртуальных машин

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

Чтобы изменить [пул резервов ВМ](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [{{ yandex-cloud }} CLI](../../../cli/index.yaml) для изменения пула резервов ВМ:

      ```bash
      yc compute reserved-instance-pool update --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Получите подробную информацию о пуле резервов ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      ```bash
      yc compute reserved-instance-pool get <имя_или_идентификатор_пула>
      ```

      Результат:

      ```text
      id: fv4vnl1ncbja********
      zone_id: {{ region-id }}-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: test-pool
      description: sample description
      created_at: "2025-08-12T07:58:57Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "2"
      committed_size: "2"
      slot_stats:
        total: "2"
        used: "1"
        available: "1"
      instance_stats:
        total: "1"
      ```
  1. Измените пул резервов ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      {% note info %}

      Изменить конфигурацию виртуальных машин пула нельзя.

      {% endnote %}

      ```bash
      yc compute reserved-instance-pool update <имя_или_идентификатор_пула> \
        --new-name <новое_имя_пула> \
        --description <описание_пула> \
        --size <размер_пула> \
        --allow-oversubscription \
        --allow-pending-slots
      ```

      Где:
      * `--new-name` — новое имя пула. Необязательный параметр. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--description` — описание пула. Необязательный параметр.
      * `--size` — новое количество слотов в пуле. Необязательный параметр.
      * `--allow-oversubscription` — параметр, включающий и выключающий для пула [режим переподписки](../../concepts/reserved-pools.md#oversubscription), при котором к пулу можно привязывать ВМ в количестве, превышающем размер пула. Необязательный параметр.

          Чтобы включить режим переподписки, передайте в команде параметр `--allow-oversubscription`.

          Чтобы выключить включенный ранее режим переподписки, передайте в команде параметр `--allow-oversubscription=false`.
      * `--allow-pending-slots` — параметр, включающий [опцию ожидания ресурсов](../../concepts/reserved-pools.md#pending-slots) при изменении размера пула. Необязательный параметр. По умолчанию опция ожидания ресурсов для операции изменения размера пула выключена.

      Результат:

      ```text
      done (8s)
      id: fv4vnl1ncbja********
      zone_id: {{ region-id }}-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: new-pool
      description: the new description
      created_at: "2025-08-12T07:58:57Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "3"
      committed_size: "3"
      slot_stats:
        total: "3"
        used: "1"
        available: "2"
      instance_stats:
        total: "1"
      ```

      Подробнее о команде `yc compute reserved-instance-pool update` читайте в [справочнике {{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/ReservedInstancePool/update.md) для ресурса [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) или вызовом gRPC API [ReservedInstancePoolService/Update](../../api-ref/grpc/ReservedInstancePool/update.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](./manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)