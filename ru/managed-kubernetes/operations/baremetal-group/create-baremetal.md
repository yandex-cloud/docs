---
title: Создание группы узлов на серверах {{ baremetal-name }}
description: Создайте группу узлов на серверах {{ baremetal-name }} в кластере {{ managed-k8s-name }}. Подготовьте сеть и выберите конфигурацию серверов.
---

# Создание группы узлов на серверах {{ baremetal-name }}

{% note info %}

Создавать, изменять и удалять группы узлов на серверах {{ baremetal-name }} можно только в консоли управления.

{% endnote %}

В кластере {{ managed-k8s-name }} можно создать [группу узлов](../../concepts/index.md#node-group) на выделенных серверах {{ baremetal-name }}. Сервис арендует серверы, автоматически настроит их и подключит к кластеру. По умолчанию срок аренды серверов — один день.

## Перед началом работы {#before-you-begin}

Для создания группы узлов на серверах {{ baremetal-name }} нужен кластер {{ managed-k8s-name }} версии 1.35 с публичным адресом мастера и включенным [туннельным режимом Cilium](../../../managed-kubernetes/concepts/network-policy.md#cilium) (Cilium CNI). Можно использовать существующий кластер, если он соответствует этим требованиям. Туннельный режим можно включить только при создании кластера.

Если подходящего кластера нет, подготовьте инфраструктуру:

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) и [назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md) `k8s.tunnelClusters.agent` и `vpc.publicAdmin` на каталог, в котором будете создавать кластер.
1. [Создайте](../../../vpc/operations/security-group-create.md) и [настройте](../../../managed-kubernetes/operations/connect/security-groups.md) группы безопасности для кластера.

   {% note warning %}

   От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.

   {% endnote %}

1. [Создайте кластер](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md):

   * В поле **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** выберите версию `1.35`.
   * В полях **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** и **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** выберите созданный сервисный аккаунт.
   * В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}** в поле **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** выберите `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`, чтобы подключаться к мастеру через интернет.
   * В поле **{{ ui-key.yacloud.mdb.forms.field_security-group }}** укажите подготовленные группы безопасности.
   * В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}** включите опцию **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}**, чтобы использовать туннельный режим.

В разделе **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** → **{{ ui-key.yacloud.common.overview }}** в блоке **Сетевые настройки** посмотрите CIDR кластера и CIDR сервисов. Они понадобятся для настройки маршрутизации.

## Создайте виртуальный маршрутизатор {#create-routing-instance}

[Виртуальный маршрутизатор](../../../cloud-router/concepts/routing-instance.md) {{ cr-name }} используется для связи приватной сети {{ baremetal-name }} с облачной сетью мастера {{ managed-k8s-name }}.

Если у вас уже есть подходящий маршрутизатор, [добавьте в него](../../../cloud-router/operations/ri-prefixes-upsert.md#upsert-prefixes) CIDR кластера и CIDR сервисов как анонсированные IP-префиксы облачной сети мастера и перейдите к [созданию группы узлов](#create-node-group).

{% note info %}

Для создания виртуального маршрутизатора необходима [роль](../../../cloud-router/security/index.md#cloudrouter-editor) `cloud-router.editor`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен кластер.
  1. [Перейдите]({{ link-console-main }}/link/cloud-router) в сервис **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cloud-router.router.create-router_v4cPC }}**.
  1. Введите имя и описание виртуального маршрутизатора.
  1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md) и включите **{{ ui-key.yacloud.common.deletion-protection }}**.
  1. В поле **{{ ui-key.yacloud.cloud-router.router.networks_fbzKL }}** выберите облачную сеть, в которой расположен мастер кластера.
  1. В блоке выбранной сети добавьте IP-префиксы: CIDR ее подсетей, CIDR кластера и CIDR сервисов.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте группу узлов {#create-node-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** и выберите раздел **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}** и выберите ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create-baremetal-ng }}**.
  1. На шаге **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_configuration }}**:

     1. Укажите **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**. Значение используется, чтобы подобрать конфигурации с достаточным количеством доступных серверов, и не задает размер группы. Задать размер группы можно на следующем шаге.
     1. Выберите [конфигурацию серверов](../../../baremetal/concepts/server-configurations.md) с подходящими процессорами, объемом оперативной памяти, типом и размером дисков.

     Доступность конфигураций зависит от [пула серверов](../../../baremetal/concepts/servers.md#server-pools). Приватная подсеть объединяет серверы одного пула, поэтому на следующем шаге создайте или выберите подсеть из пула, в котором доступна выбранная конфигурация.

  1. На шаге **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_settings }}**:

     1. Укажите имя группы узлов. При необходимости добавьте описание и метки.
     1. Убедитесь, что в поле **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_k8s-version }}** указана версия 1.35.
     1. (Опционально) Измените **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**.
     1. В разделе **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.section_network-interfaces }}** для первого интерфейса в поле **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_private-subnet }}** нажмите **{{ ui-key.yacloud.common.create }}**:

        1. Укажите имя приватной подсети. При необходимости добавьте описание и метки.
        1. Включите **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
        1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите существующий [VRF](../../../baremetal/concepts/private-network.md#vrf-segment) или создайте новый.
        1. Заполните поля **{{ ui-key.yacloud.baremetal.field_CIDR_rwYMi }}** и **{{ ui-key.yacloud.baremetal.field_gateway_t7LLk }}**. Подсеть должна принадлежать диапазону `10.0.0.0/8`, `172.16.0.0/12` или `192.168.0.0/16`. Диапазоны подсетей одного VRF не должны пересекаться друг с другом, подсетями облачной сети, CIDR кластера и CIDR сервисов.
        1. Включите **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**. Проверьте автоматически заполненный диапазон IP-адресов и при необходимости измените его.
        1. Сохраните подсеть.

        Можно выбрать существующую подсеть из пула, в котором доступна выбранная конфигурация. Подсеть должна входить в VRF, а в ее настройках должен быть [включен DHCP](../../../baremetal/concepts/dhcp.md#dhcp-private).

     1. Для второго интерфейса включите опцию **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.label_internet-access }}**. Публичные IP-адреса будут назначены автоматически.

        Публичные IP-адреса обеспечивают подключение к узлам из интернета и доступ узлов к внешним ресурсам, например реестрам Docker-образов ([{{ container-registry-name }}](../../../container-registry/concepts/index.md), [{{ cloud-registry-name }}](../../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/)), а также бакетам [{{ objstorage-name }}](../../../storage/concepts/bucket.md).

     1. Настройте **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** и укажите **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_max-unavailable }}**.

     1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-labels }}** добавьте метку `node-type=baremetal`. Она понадобится, чтобы запустить тестовый под на узлах этой группы. При необходимости добавьте другие метки и **{{ ui-key.yacloud.k8s.node-groups.create.field_node-taints }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.action_create-node-group }}**.

{% endlist %}

Группа появится в списке групп узлов с типом **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}**. Сервис арендует выбранное количество серверов и настроит их. Для подключения узлов к кластеру настройте приватное соединение между VRF подсети и облачной сетью мастера.

## Создайте приватное соединение {#create-prc}

Дождитесь готовности виртуального маршрутизатора и создайте [приватное соединение](../../../baremetal/concepts/private-network.md#private-connection-to-vpc) {{ interconnect-name }} в сервисе {{ baremetal-name }}. Если VRF выбранной подсети уже соединен с облачной сетью мастера через подготовленный маршрутизатор, перейдите к [проверке группы узлов](#check-node-group).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится VRF подсети группы узлов.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** и выберите VRF подсети группы узлов.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** нажмите **{{ ui-key.yacloud.baremetal.action_add-vrf-interconnect }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-select-type }}** выберите `{{ ui-key.yacloud.baremetal.field_interconnect-from-folder }}` и в появившемся списке укажите подготовленный `Routing Instance`.

     В форме отобразятся CIDR подсетей {{ vpc-name }}, которые будут анонсироваться в {{ interconnect-name }}. Убедитесь, что среди префиксов указаны CIDR кластера и CIDR сервисов.

     {% note warning %}

     Для настройки связности диапазоны адресов подсетей {{ baremetal-name }} не должны пересекаться с диапазонами подключенных облачных и локальных сетей, CIDR кластера и CIDR сервисов.

     {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Дождитесь, когда в блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** статус соединения изменится с `CREATING` на `READY`. Если соединение перешло в статус `ERROR`, обратитесь в [техническую поддержку]({{ link-console-support }}/tickets/create).

{% endlist %}

## Проверьте группу узлов {#check-node-group}

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте подключение к кластеру](../../../managed-kubernetes/operations/connect/index.md#kubectl-connect).
1. Посмотрите состояние узлов с меткой, заданной при создании группы:

   ```bash
   kubectl get nodes -l node-type=baremetal
   ```

   Дождитесь, когда узлы перейдут в состояние `Ready`.

### Создайте под {#create-pod}

1. Сохраните манифест пода в файл `busybox.yaml`:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: busybox
   spec:
     restartPolicy: OnFailure
     nodeSelector:
       node-type: baremetal
     containers:
       - name: busybox
         image: cr.yandex/mirror/busybox:latest
         command: ["sh", "-c", "echo 'Hello from BareMetal'; sleep 3600"]
   ```

   Поле `nodeSelector` ограничивает размещение пода узлами с меткой `node-type=baremetal`. Если вы задали группе taint-политики, добавьте в манифест соответствующие [tolerations](../../../managed-kubernetes/concepts/index.md#taints-tolerations).

1. Создайте под:

   ```bash
   kubectl create -f busybox.yaml
   ```

### Проверьте работу пода {#check-pod}

1. Посмотрите информацию о поде:

   ```bash
   kubectl get pod busybox -o wide
   kubectl describe pod busybox
   ```

   Дождитесь статуса `Running`. В поле `NODE` должен быть указан один из узлов {{ baremetal-name }}, полученных на предыдущем шаге. В разделе `Events` команды `describe` проверьте, что образ загружен, а контейнер создан и запущен.

1. Посмотрите логи пода:

   ```bash
   kubectl logs busybox
   ```

   Результат:

   ```text
   Hello from BareMetal
   ```

1. После проверки удалите тестовый под:

   ```bash
   kubectl delete pod busybox
   ```

## Что дальше {#whats-next}

* [Создайте рабочую нагрузку](../../../managed-kubernetes/operations/kubernetes-console/workloads.md#create-workload) в кластере.
* [Измените группу узлов](../../../managed-kubernetes/operations/baremetal-group/update-baremetal.md), например увеличьте или уменьшите количество серверов.
* Удалите [группу узлов](../../../managed-kubernetes/operations/baremetal-group/delete-baremetal.md), [кластер](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) и зарезервированный статический [публичный IP-адрес](../../../vpc/operations/address-delete.md) кластера, если эти ресурсы больше не нужны. Перед удалением освободите адрес: он не должен использоваться кластером или другими ресурсами.
