[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > [Пошаговые инструкции](../index.md) > BareMetal Extend > Создать группу узлов BareMetal для Extend: Managed Service for Kubernetes®

# Создать группу узлов BareMetal для Extend: Managed Service for Kubernetes®

## Перед началом работы {#before-you-begin}

Чтобы в меню создания группы узлов появился пункт ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **BareMetal**, выполните следующие действия:

1. [Создайте кластер Managed Service for Kubernetes](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) версии 1.35 с включенным [туннельным режимом Cilium](../../../managed-kubernetes/concepts/network-policy.md#cilium) (Cilium CNI) или убедитесь, что существующий кластер соответствует этим требованиям. Туннельный режим можно включить только при создании кластера.
1. Узнайте [CIDR кластера и CIDR сервисов](../../../managed-kubernetes/quickstart.md#kubernetes-cluster-create), указанные в сетевых настройках кластера.
1. Подготовьте приватную подсеть BareMetal: она должна входить в VRF, а в ее настройках должен быть [включен DHCP](../../concepts/dhcp.md#dhcp-private). Если подходящей подсети нет, [создайте ее](../subnet-create.md).
1. [Создайте приватное соединение](../create-vpc-connection.md) между VRF и облачной сетью, в которой размещен мастер Managed Service for Kubernetes. Для соединения используется виртуальный маршрутизатор Cloud Router.
1. [Добавьте в виртуальный маршрутизатор](../../../cloud-router/operations/ri-prefixes-upsert.md#upsert-prefixes) CIDR кластера и CIDR сервисов как анонсированные IP-префиксы облачной сети мастера.

## Создайте группу узлов {#create-node-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер.
  1. Перейдите на вкладку **Управление кластером** и выберите раздел **Группы узлов**.
  1. Нажмите кнопку **Создать группу узлов** и выберите ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **BareMetal**.
  1. На шаге **Конфигурация серверов BareMetal**:

     1. Укажите **Количество узлов в группе**. Значение используется, чтобы подобрать конфигурации с достаточным количеством доступных серверов, и не задает размер группы. Задать размер группы можно на следующем шаге.
     1. Выберите [конфигурацию серверов](../../concepts/server-configurations.md) с подходящими процессорами, объемом оперативной памяти, типом и размером дисков.

     Доступность конфигураций зависит от [пула серверов](../../concepts/servers.md#server-pools). Приватная подсеть объединяет серверы одного пула, поэтому на следующем шаге выберите подсеть из пула, в котором доступна выбранная конфигурация.

  1. На шаге **Настройка группы узлов**:

     1. Укажите имя группы узлов. При необходимости добавьте описание и метки.
     1. Убедитесь, что в поле **Версия Kubernetes** указана версия 1.35.
     1. (Опционально) Измените **Количество узлов в группе**.
     1. В разделе **Сетевые интерфейсы** для первого интерфейса выберите в поле **Приватная подсеть** подготовленную подсеть из пула, в котором доступна выбранная конфигурация. В подсети должен быть включен DHCP, а VRF подсети должен быть соединен с облачной сетью мастера.
     1. Если узлам требуется доступ в интернет, для второго интерфейса включите опцию **Доступ в интернет**. Публичные IP-адреса будут назначены автоматически. Доступ в интернет для группы узлов BareMetal не обязателен.
     1. Настройте **Частота обновлений / Отключение** и укажите **Максимум недоступных узлов**.

     1. При необходимости добавьте **Taint-политики узла** и **Метки узла**.

  1. Нажмите кнопку **Создать группу узлов**.

{% endlist %}

После создания сервис арендует выбранное количество серверов, настроит их и подключит к кластеру. Группа появится в списке групп узлов с типом **BareMetal**.

#### Полезные ссылки {#see-also}

* [Изменение группы узлов на серверах BareMetal](../../../managed-kubernetes/operations/baremetal-group/update-baremetal.md)
* [Удаление группы узлов на серверах BareMetal](../../../managed-kubernetes/operations/baremetal-group/delete-baremetal.md)
* [Extend: Managed Service for Kubernetes®](../../concepts/extend/managed-kubernetes.md)
* [Создать приватное соединение с облачными сетями](../create-vpc-connection.md)
* [Управлять сетями и IP-префиксами в виртуальном маршрутизаторе](../../../cloud-router/operations/ri-prefixes-upsert.md)
* [Сервис DHCP в сети Yandex BareMetal](../../concepts/dhcp.md)