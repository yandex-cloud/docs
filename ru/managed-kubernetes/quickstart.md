---
title: "Начало работы с управляемым {{ k8s }}"
description: "В этой инструкции вы создадите кластер {{ managed-k8s-name }} и группу узлов, научитесь управлять ими с помощью kubectl — командной оболочки {{ k8s }}. Для начала создайте кластер {{ managed-k8s-name }}, добавьте учетные данные в конфигурационный файл kubectl, создайте группу узлов."
---

# Начало работы с {{ managed-k8s-name }}

Создайте [кластер {{ managed-k8s-name }}](concepts/index.md#kubernetes-cluster) и [группу узлов](concepts/index.md#node-group) и управляйте ими с помощью kubectl — командной оболочки {{ k8s }}.

## Перед началом работы {#before-you-begin}

Чтобы начать работать с сервисом {{ managed-k8s-name }}:
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.


1. На странице [**{{ ui-key.yacloud.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).


1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../resource-manager/operations/folder/create.md).
1. Установите [интерфейс командной строки](../glossary/cli.md) {{ k8s }} — [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/).
1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](concepts/limits.md).
1. Если у вас еще нет [сети](../vpc/concepts/network.md#network), [создайте ее](../vpc/operations/network-create.md).
1. Если у вас еще нет [подсетей](../vpc/concepts/network.md#subnet), [создайте их](../vpc/operations/subnet-create.md) в [зонах доступности](../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и группа узлов.
1. Создайте [сервисные аккаунты](../iam/operations/sa/create.md):

   * Сервисный аккаунт с [ролями](security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на каталог, в котором создается кластер {{ managed-k8s-name }}. От имени этого сервисного аккаунта будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
   * Сервисный аккаунт с ролью [{{ roles-cr-puller }}](../container-registry/security/index.md#container-registry-images-puller) на каталог с [реестром](../container-registry/concepts/registry.md) [Docker-образов](../container-registry/concepts/docker-image.md). От его имени узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

   {% include [k8s.tunnelClusters.agent role](../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}
1. [Настройте группы безопасности](operations/connect/security-groups.md#rules-internal) для сетевого трафика кластера {{ managed-k8s-name }}.

## Создайте кластер {{ managed-k8s-name }} {#kubernetes-cluster-create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ managed-k8s-name }}.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
1. Введите имя кластера {{ managed-k8s-name }}. Оно должно быть уникальным в рамках каталога.
1. (Опционально) Введите описание кластера {{ managed-k8s-name }}.
1. **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** — укажите [сервисный аккаунт](../iam/concepts/users/service-accounts.md) с ролями `k8s.clusters.agent` и `vpc.publicAdmin`, который будет использоваться для создания ресурсов.
1. **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** — укажите сервисный аккаунт с ролью [{{ roles-cr-puller }}](../container-registry/security/index.md#container-registry-images-puller), который будет использоваться узлами {{ managed-k8s-name }} для доступа к реестру Docker-образов.
1. Укажите [релизный канал](concepts/release-channels-and-updates.md). Эту настройку невозможно изменить после создания кластера {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
   * **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** — выберите версию {{ k8s }}, которая будет установлена на [мастере {{ managed-k8s-name }}](concepts/index.md#master).
   * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** — выберите способ назначения [IP-адреса](../vpc/concepts/address.md):
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}` — чтобы назначить случайный IP-адрес из пула IP-адресов {{ yandex-cloud }}.
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_none }}` — чтобы не назначать публичный IP-адрес.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}** — выберите тип мастера:
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_zone }}` — будет создан один хост-мастер в выбранной зоне доступности. Укажите облачную сеть и выберите в ней подсеть для размещения хоста-мастера.
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_region }}` — в каждой зоне доступности будет создано по одному хосту-мастеру. Укажите облачную сеть и подсеть для каждой зоны доступности.
   * Выберите [группы безопасности](operations/connect/security-groups.md) для сетевого трафика кластера {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
   * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](concepts/index.md#pod).
   * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}** — укажите диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](concepts/index.md#service).
   * Задайте маску подсети узлов {{ managed-k8s-name }} и максимальное количество подов в узле.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

Подробнее см. в [пошаговой инструкции по созданию кластера {{ managed-k8s-name }}](operations/kubernetes-cluster/kubernetes-cluster-create.md).

## Добавьте учетные данные в конфигурационный файл kubectl {#add-conf}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  Чтобы добавить учетные данные кластера {{ managed-k8s-name }} в конфигурационный файл kubectl:
  1. Выполните команду:

     ```bash
     yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
     ```

     * По умолчанию учетные данные добавляются в директорию `$HOME/.kube/config`.
     * Если необходимо изменить расположение конфигураций, используйте флаг `--kubeconfig <путь_к_файлу>`.
  1. Проверьте конфигурацию kubectl после добавления учетных данных:

     ```bash
     kubectl config view
     ```

     Результат:

     ```yml
     apiVersion: v1
     clusters:
       - cluster:
         certificate-authority-data: DATA+OMITTED
     ...
     ```

{% endlist %}

## Создайте группу узлов {#node-group-create}

Чтобы создать группу узлов {{ managed-k8s-name }}:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан нужный кластер {{ managed-k8s-name }}.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Выберите кластер {{ managed-k8s-name }}, для которого необходимо создать группу узлов.
1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку ![nodes-management.svg](../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
1. Введите имя и описание группы узлов {{ managed-k8s-name }}.
1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** выберите версию {{ k8s }} для узлов {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}** выберите его тип:
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}`, чтобы количество узлов в группе {{ managed-k8s-name }} оставалось неизменным. Укажите количество узлов в группе {{ managed-k8s-name }}.
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`, чтобы управлять количеством узлов в группе {{ managed-k8s-name }} с помощью [автоматического масштабирования кластера {{ managed-k8s-name }}](concepts/autoscale.md#ca).
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}** укажите максимальное количество [виртуальных машин](../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Выберите [платформу](../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../compute/concepts/performance-levels.md), а также объем RAM.
   * (Опционально) Укажите, что ВМ должна быть [прерываемой](../compute/concepts/preemptible-vm.md).
   * (Опционально) Включите [программно-ускоренную сеть](../compute/concepts/software-accelerated-network.md).

1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
   * Укажите **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}** для узлов группы {{ managed-k8s-name }}:
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-hdd }}` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd }}` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd-nonreplicated }}` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd-io-m3 }}` — обладает теми же скоростными характеристиками, что и `{{ ui-key.yacloud.k8s.node-groups.create.value_network-ssd-nonreplicated }}`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.

     Подробнее о типах дисков см. в [документации {{ compute-full-name }}](../compute/concepts/disk.md#disks_types).
   * Укажите размер дисков для узлов группы {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
   * В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** выберите способ назначения IP-адреса:
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}` — чтобы назначить случайный IP-адрес из пула IP-адресов {{ yandex-cloud }}.
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_none }}` — чтобы не назначать публичный IP-адрес.
   * Выберите [группы безопасности](operations/connect/security-groups.md).
   * Выберите зону доступности и подсеть для размещения узлов группы {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}** укажите данные для доступа к узлам группы {{ managed-k8s-name }} по [SSH](../glossary/ssh-keygen.md):
   * **{{ ui-key.yacloud.compute.instances.create.field_user }}** — укажите имя пользователя.
   * **{{ ui-key.yacloud.compute.instances.create.field_key }}** — вставьте содержимое файла [публичного ключа](operations/node-connect-ssh.md#creating-ssh-keys).
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

Подробнее см. в [пошаговой инструкции по созданию группы узлов {{ managed-k8s-name }}](operations/node-group/node-group-create.md).

## Что дальше {#what-is-next}

* Ознакомьтесь с [концепциями сервиса](concepts/index.md).
* Узнайте, как [работать с кластером {{ managed-k8s-name }} и группами узлов](operations/index.md).
* Ознакомьтесь с [вопросами и ответами](qa/all.md).
* Изучите [рекомендации по использованию {{ k8s }}](concepts/usage-recommendations.md).