---
title: Удалить пул зарезервированных ВМ
description: Из статьи вы узнаете, как удалить пул зарезервированных ВМ {{ compute-full-name }}.
---

# Удаление пула зарезервированных виртуальных машин

{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

Чтобы удалить [пул зарезервированных ВМ](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [{{ yandex-cloud }} CLI](../../../cli/index.yaml) для удаления пула зарезервированных ВМ:

      ```bash
      yc compute reserved-instance-pool delete --help
      ```
  1. {% include [list-reserved-pools-cli](../../../_includes/compute/list-reserved-pools-cli.md) %}
  1. Удалите пул зарезервированных ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      ```bash
      yc compute reserved-instance-pool delete <имя_или_идентификатор_пула>
      ```

      Результат:

      ```text
      done (15s)
      {}
      ```

      Подробнее о команде `yc compute reserved-instance-pool delete` читайте в [справочнике {{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/delete.md).

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/ReservedInstancePool/delete.md) для ресурса [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) или вызовом gRPC API [ReservedInstancePoolService/Delete](../../api-ref/grpc/ReservedInstancePool/delete.md).

{% endlist %}

{% note info %}

При удалении пула зарезервированных ВМ все привязанные к пулу виртуальные машины будут от него отвязаны, а запущенные ВМ продолжат работать.

{% endnote %}

#### См. также {#see-also}

* [{#T}](./manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)