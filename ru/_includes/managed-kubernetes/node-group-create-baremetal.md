## Перед началом работы {#before-you-begin}

Чтобы в меню создания группы узлов появился пункт ![objects-align-justify-horizontal](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create-baremetal-ng }}**, выполните следующие действия:

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) версии 1.35 с включенным [туннельным режимом Cilium](../../managed-kubernetes/concepts/network-policy.md#cilium) (Cilium CNI) или убедитесь, что существующий кластер соответствует этим требованиям. Туннельный режим можно включить только при создании кластера.
1. Узнайте [CIDR кластера и CIDR сервисов](../../managed-kubernetes/quickstart.md#kubernetes-cluster-create), указанные в сетевых настройках кластера.
1. Подготовьте приватную подсеть {{ baremetal-name }}: она должна входить в VRF, а в ее настройках должен быть [включен DHCP](../../baremetal/concepts/dhcp.md#dhcp-private). Если подходящей подсети нет, [создайте ее](../../baremetal/operations/subnet-create.md).
1. [Создайте приватное соединение](../../baremetal/operations/create-vpc-connection.md) между VRF и облачной сетью, в которой размещен мастер {{ managed-k8s-name }}. Для соединения используется виртуальный маршрутизатор {{ cr-name }}.
1. [Добавьте в виртуальный маршрутизатор](../../cloud-router/operations/ri-prefixes-upsert.md#upsert-prefixes) CIDR кластера и CIDR сервисов как анонсированные IP-префиксы облачной сети мастера.

## Создайте группу узлов {#create-node-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** и выберите раздел **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}** и выберите ![objects-align-justify-horizontal](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create-baremetal-ng }}**.
  1. На шаге **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_configuration }}**:

     1. Укажите **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**. Значение используется, чтобы подобрать конфигурации с достаточным количеством доступных серверов, и не задает размер группы. Задать размер группы можно на следующем шаге.
     1. Выберите [конфигурацию серверов](../../baremetal/concepts/server-configurations.md) с подходящими процессорами, объемом оперативной памяти, типом и размером дисков.

     Доступность конфигураций зависит от [пула серверов](../../baremetal/concepts/servers.md#server-pools). Приватная подсеть объединяет серверы одного пула, поэтому на следующем шаге выберите подсеть из пула, в котором доступна выбранная конфигурация.

  1. На шаге **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_settings }}**:

     1. Укажите имя группы узлов. При необходимости добавьте описание и метки.
     1. Убедитесь, что в поле **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_k8s-version }}** указана версия 1.35.
     1. (Опционально) Измените **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**.
     1. В разделе **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.section_network-interfaces }}** для первого интерфейса выберите в поле **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_private-subnet }}** подготовленную подсеть из пула, в котором доступна выбранная конфигурация. В подсети должен быть включен DHCP, а VRF подсети должен быть соединен с облачной сетью мастера.
     1. Если узлам требуется доступ в интернет, для второго интерфейса включите опцию **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.label_internet-access }}**. Публичные IP-адреса будут назначены автоматически. Доступ в интернет для группы узлов {{ baremetal-name }} не обязателен.
     1. Настройте **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** и укажите **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_max-unavailable }}**.

     1. При необходимости добавьте **{{ ui-key.yacloud.k8s.node-groups.create.field_node-taints }}** и **{{ ui-key.yacloud.k8s.node-groups.create.field_node-labels }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.action_create-node-group }}**.

{% endlist %}

После создания сервис арендует выбранное количество серверов, настроит их и подключит к кластеру. Группа появится в списке групп узлов с типом **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}**.

#### Полезные ссылки {#see-also}

* [{#T}](../../managed-kubernetes/operations/baremetal-group/update-baremetal.md)
* [{#T}](../../managed-kubernetes/operations/baremetal-group/delete-baremetal.md)
* [{#T}](../../baremetal/concepts/extend/managed-kubernetes.md)
* [{#T}](../../baremetal/operations/create-vpc-connection.md)
* [{#T}](../../cloud-router/operations/ri-prefixes-upsert.md)
* [{#T}](../../baremetal/concepts/dhcp.md)
