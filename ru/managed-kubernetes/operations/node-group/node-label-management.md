# Управление {{ k8s }}-метками узлов

## Назначить {{ k8s }}-метки при создании группы узлов {#node-group-creation}

Вы можете добавлять [{{ k8s }}-метки](../../concepts/index.md#node-labels) сразу на все узлы {{ managed-k8s-name }} в [группе узлов](../../concepts/index.md#node-group). Для этого задайте набор меток в параметре `node_labels` при [создании группы узлов {{ managed-k8s-name }}](../../operations/node-group/node-group-create.md).

1. Создайте [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).

   Вы можете использовать уже работающий кластер {{ managed-k8s-name }} или [создать новый](../kubernetes-cluster/kubernetes-cluster-create.md).
   
1. Создайте группу узлов с {{ k8s }}-метками:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан кластер {{ managed-k8s-name }}.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Выберите кластер {{ managed-k8s-name }}, для которого необходимо создать группу узлов.
     1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
     1. Введите имя группы узлов {{ managed-k8s-name }}.
     1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** выберите версию {{ k8s }} для узлов {{ managed-k8s-name }}.
     1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**:
        * Выберите тип политики масштабирования.
        * Укажите количество узлов в группе узлов {{ managed-k8s-name }}.
     1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}** укажите максимальное количество [виртуальных машин](../../../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы {{ managed-k8s-name }}.
     1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
        * Выберите [платформу](../../../compute/concepts/vm-platforms.md).
        * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../../../compute/concepts/performance-levels.md), а также объем RAM.
     1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
        * Укажите **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}** узла {{ managed-k8s-name }}:
          * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
          * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}` — обладает теми же скоростными характеристиками, что и `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.
        * Укажите размер [диска](../../../compute/concepts/disk.md) узла {{ managed-k8s-name }}.
     1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
        * В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** выберите способ назначения адреса:
          * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}` — чтобы назначить случайный [IP-адрес](../../../vpc/concepts/address.md) из пула адресов {{ yandex-cloud }}.
          * `{{ ui-key.yacloud.k8s.node-groups.create.switch_none }}` — чтобы не назначать публичный IP-адрес.
        * Укажите расположение узлов {{ managed-k8s-name }} по [зонам доступности](../../../overview/concepts/geo-scope.md) и [сетям](../../../vpc/concepts/network.md#network).
     1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}** укажите данные для доступа на узел {{ managed-k8s-name }}:
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [публичного ключа](../../operations/node-connect-ssh.md#creating-ssh-keys).
     1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
        * В поле **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** выберите окно для [обновлений](../../concepts/release-channels-and-updates.md#updates):
          * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}` — отключение автоматических обновлений.
          * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}` — обновления разрешены в любое время.
          * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}` — обновления будут происходить во временной интервал, указанный в поле **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}**.
          * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}` — обновления будут происходить во временной интервал, указанный в поле **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}**.
     1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_additional }}**:
        * В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-labels }}** нажмите кнопку **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-label }}** и укажите ее ключ и значение. Если необходимо, добавьте несколько меток.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   - CLI {#cli}

     Создайте группу узлов {{ managed-k8s-name }}:

     ```bash
     yc managed-kubernetes node-group create \
      --name k8s-labels-node \
      --cluster-name k8s-labels \
      --disk-type network-ssd \
      --fixed-size 1 \
      --node-labels environment=production,apps/tier=backend
     ```

     Где:

     * `--name` — имя группы узлов {{ managed-k8s-name }}.
     * `--cluster-name` — имя кластера {{ managed-k8s-name }}, в котором будет создана группа узлов.
     * `--disk-type` — [тип диска](../../../compute/concepts/disk.md) узла {{ managed-k8s-name }}.
     * `--fixed-size` — количество узлов {{ managed-k8s-name }} в группе.
     * `--node-labels` — метки узла {{ managed-k8s-name }}. Можно указать несколько меток через запятую.

     Результат:

     ```bash
     done (2m19s)
     id: catkuapro07e********
     cluster_id: abcsk1s2f3fm********
     created_at: "2020-09-24T13:32:24Z"
     name: k8s-labels-node
     status: RUNNING
     node_template:
       platform_id: standard-v2
       resources_spec:
         memory: "4294967296"
         cores: "2"
         core_fraction: "100"
       boot_disk_spec:
         disk_type_id: network-ssd
         disk_size: "103079215104"
       v4_address_spec: {}
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "1"
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-a
         subnet_id: e9bm87gkjd81********
     deploy_policy:
       max_expansion: "3"
     instance_group_id: cl1v2gh33j1c********
     node_version: "1.17"
     version_info:
       current_version: "1.17"
     maintenance_policy:
       auto_upgrade: true
       auto_repair: true
       maintenance_window:
         anytime: {}
     node_labels:
       apps/tier: backend
       environment: production
     ```

   - {{ TF }} {#tf}

     {% note warning %}

     Группа узлов {{ managed-k8s-name }} будет создана заново.

     {% endnote %}

     1. Откройте актуальный конфигурационный файл с описанием группы узлов {{ managed-k8s-name }}.

        О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
     1. Добавьте к описанию группы узлов {{ managed-k8s-name }} параметр `node_labels`:

        ```hcl
        resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
          cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
          ...
          node_labels = {
            "<метка_1>" = "<значение_1>"
            "<метка_2>" = "<значение_2>"
            ...
          }
        }
        ```

     1. Проверьте корректность конфигурационных файлов.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

     1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

   - API {#api}

     Чтобы создать группу узлов {{ managed-k8s-name }}, воспользуйтесь методом [create](../../api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

   {% endlist %}

1. Посмотрите информацию о созданной группе узлов с {{ k8s }}-метками:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан кластер {{ managed-k8s-name }}.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Выберите кластер {{ managed-k8s-name }}, в котором создана группа узлов.
     1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
     1. На странице одного из узлов {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.node.overview.label_labels }}**. На вкладке перечислены системные и пользовательские {{ k8s }}-метки узла.

   - CLI {#cli}

     1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
     1. Посмотрите все узлы кластера {{ managed-k8s-name }}:

        ```bash
        kubectl get nodes
        ```

        Результат:

        ```bash
        NAME                        STATUS   ROLES    AGE  VERSION
        catkuapro07e********-hgjd   Ready    <none>   1h   v1.17.8
        catkuapro07e********-lskc   Ready    <none>   1h   v1.17.8
        ```

     1. Посмотрите информацию о выбранном узле кластера {{ managed-k8s-name }}:

        ```bash
        kubectl describe node catkuapro07e********-hgjd
        ```

        Результат:

        ```bash
        Name:               catkuapro07e********-hgjd
        Roles:              <none>
        Labels:             apps/tier=backend
                            beta.kubernetes.io/arch=amd64
                            beta.kubernetes.io/instance-type=standard-v2
                            beta.kubernetes.io/os=linux
                            environment=production
                            failure-domain.beta.kubernetes.io/zone={{ region-id }}-a
                            kubernetes.io/arch=amd64
                            kubernetes.io/hostname=catkuapro07e********-hgjd
                            kubernetes.io/os=linux
                            node.kubernetes.io/kube-proxy-ds-ready=true
                            node.kubernetes.io/masq-agent-ds-ready=true
                            node.kubernetes.io/node-problem-detector-ds-ready=true
                            yandex.cloud/node-group-id=catkuapro07e********
                            yandex.cloud/pci-topology=k8s
                            yandex.cloud/preemptible=false
        ```

   - API {#api}

     Чтобы посмотреть информацию об узле {{ managed-k8s-name }}, воспользуйтесь методом [list](../../api-ref/NodeGroup/list.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

   {% endlist %}

## Назначить {{ k8s }}-метку на уже созданную группу узлов {#assign-label}

Назначение {{ k8s }}-меток не приводит к пересозданию группы узлов.

{% list tabs group=instructions %}

* CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы назначить {{ k8s }}-метку на уже созданную группу узлов, выполните команду:

  ```bash
  {{ yc-k8s }} node-group add-node-labels \
     --id <идентификатор_группы_узлов> \
     --labels <ключ>=<значение>, ...
  ```

  Команда содержит параметры:

  * `--id` — идентификатор группы узлов. Его можно [получить вместе со списком](node-group-list.md#list) групп узлов в кластере {{ managed-k8s-name }}.
  * `--labels` — {{ k8s }}-метки в формате `<ключ>=<значение>`. Можно указать одну или несколько меток через запятую.

* {{ TF }} {#tf}

  Чтобы назначить {{ k8s }}-метку на уже созданную группу узлов:

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).

  1. В описании группы узлов добавьте блок `node_labels`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       node_labels {
         "<имя_метки>" = "<значение_метки>"
         ...
       }
       ...
     }
     ```

     Можно назначить несколько меток. Для этого укажите каждую метку на отдельной строке.

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

* API {#api}

  Чтобы назначить {{ k8s }}-метку на уже созданную группу узлов, воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/index.md) и передайте в запросе:

  * {{ k8s }}-метки в параметре `nodeLabels`.
  * Обновляемый параметр `nodeLabels` в параметре `updateMask`.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Снять {{ k8s }}-метку с группы узлов {#remove-label}

Удаление {{ k8s }}-меток не приводит к пересозданию группы узлов.

{% list tabs group=instructions %}

* CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы снять {{ k8s }}-метку с группы узлов, выполните команду:

  ```bash
  {{ yc-k8s }} node-group remove-node-labels \
     --id <идентификатор_группы_узлов> \
     --labels <ключ_метки>, ...
  ```

  Команда содержит параметры:

  * `--id` — идентификатор группы узлов. Его можно [получить вместе со списком](node-group-list.md#list) групп узлов в кластере {{ managed-k8s-name }}.
  * `--labels` — ключи {{ k8s }}-меток, которые надо снять. Можно указать одну или несколько меток через запятую.

* {{ TF }} {#tf}

  Чтобы снять {{ k8s }}-метку с группы узлов:

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).

  1. Удалите из описания группы узлов ненужные {{ k8s }}-метки в блоке `node_labels`.

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

* API {#api}

  Чтобы снять {{ k8s }}-метку с группы узлов, воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/index.md) и передайте в запросе:

  * Новый набор {{ k8s }}-меток в параметре `nodeLabels`. Если вы хотите снять все метки, передайте в запросе `"nodeLabels": {}`.
  * Обновляемый параметр `nodeLabels` в параметре `updateMask`.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}
