[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с группой узлов BareMetal > Удаление группы узлов

# Удаление группы узлов на серверах BareMetal

{% note info %}

Создавать, изменять и удалять группы узлов на серверах BareMetal можно только в консоли управления.

{% endnote %}

Чтобы удалить [группу узлов](../../concepts/index.md#node-group) на серверах BareMetal:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление кластером** и выберите раздел **Группы узлов**.
  1. В строке группы типа ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **BareMetal** нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Подтвердите удаление.
  1. [Откажитесь](../../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды серверов BareMetal, которые входили в группу узлов. После отказа от аренды серверы проработают до конца оплаченного периода, а затем будут удалены.

{% endlist %}