[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с группой узлов BareMetal > Изменение группы узлов

# Изменение группы узлов на серверах BareMetal

{% note info %}

Создавать, изменять и удалять группы узлов на серверах BareMetal можно только в консоли управления.

{% endnote %}

У группы узлов на серверах BareMetal можно изменить имя и количество узлов. При увеличении группы убедитесь, что в выбранном [пуле](../../../baremetal/concepts/servers.md#server-pools) доступны серверы нужной конфигурации.

При уменьшении группы сервис автоматически отказывается от продления аренды серверов, исключенных из группы. Отдельно отказываться от аренды не нужно. После окончания оплаченного периода серверы переходят в [карантин](../../../baremetal/concepts/servers.md#quarantine), а затем удаляются из каталога.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление кластером** и выберите раздел **Группы узлов**.
  1. В строке группы типа ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **BareMetal** нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Измените имя или **Количество узлов в группе**.
  1. Сохраните изменения.

{% endlist %}