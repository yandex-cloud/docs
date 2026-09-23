[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с группой узлов BareMetal > Удаление группы узлов

# Удаление группы узлов на серверах BareMetal

{% note info %}

Создавать, изменять и удалять группы узлов на серверах BareMetal можно только в консоли управления.

{% endnote %}

При удалении группы сервис автоматически отказывается от продления аренды серверов, которые входили в группу. Отдельно отказываться от аренды не нужно. После окончания оплаченного периода серверы переходят в [карантин](../../../baremetal/concepts/servers.md#quarantine), а затем удаляются из каталога.

Чтобы удалить [группу узлов](../../concepts/index.md#node-group) на серверах BareMetal:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление кластером** и выберите раздел **Группы узлов**.
  1. В строке группы типа ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **BareMetal** нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Подтвердите удаление.

{% endlist %}