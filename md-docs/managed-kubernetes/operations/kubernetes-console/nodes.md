[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с объектами Kubernetes из консоли управления > Управление размещением подов на узлах

# Управление размещением подов на узлах

Узлы — виртуальные машины Yandex Compute Cloud, на которых запускаются поды с пользовательскими контейнерами. Консоль управления позволяет управлять размещением подов на узле в Managed Service for Kubernetes без использования kubectl.

## Запретить размещение подов на узле {#cordon}

В консоли управления можно запрещать размещение новых подов на узле так же, как с помощью команды `kubectl cordon <имя_узла>`. Запущенные на узле поды продолжат работать.

Чтобы запретить размещение подов на узле:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes и перейдите на вкладку **Управление узлами**.
  1. Перейдите на вкладку **Узлы**.
  1. В строке узла нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![Cordon](../../../_assets/console-icons/lock.svg) **Cordon**.
  1. Подтвердите действие.

{% endlist %}

## Разрешить размещение подов на узле {#uncordon}

В консоли управления можно разрешать размещение подов на узле так же, как с помощью команды `kubectl uncordon <имя_узла>`.

Чтобы разрешить размещение подов на узле:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes и перейдите на вкладку **Управление узлами**.
  1. Перейдите на вкладку **Узлы**.
  1. В строке узла нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![Uncordon](../../../_assets/console-icons/lock-open.svg) **Uncordon**.
  1. Подтвердите действие.

{% endlist %}

#### Полезные ссылки {#see-also}

[Взаимосвязь ресурсов в Managed Service for Kubernetes](../../concepts/index.md)