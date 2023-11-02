# Управление метками узлов кластера {{ managed-k8s-name }}

Вы можете добавлять [{{ k8s }}-метки](../../concepts/index.md#node-labels) сразу на все узлы {{ managed-k8s-name }} в [группе узлов](../../concepts/index.md#node-group). Для этого задайте набор меток в параметре `node_labels` при [создании группы узлов {{ managed-k8s-name }}](../../operations/node-group/node-group-create.md).
1. Создайте [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).

   Вы можете использовать уже работающий кластер {{ managed-k8s-name }} или [создать новый](../kubernetes-cluster/kubernetes-cluster-create.md).
1. Создайте группу узлов {{ managed-k8s-name }} с метками.

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан кластер {{ managed-k8s-name }}.
     1. В списке сервисов выберите **{{ managed-k8s-name }}**.
     1. Выберите кластер {{ managed-k8s-name }}, для которого необходимо создать группу узлов.
     1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **Управление узлами**.
     1. Нажмите кнопку **Создать группу узлов**.
     1. Введите имя группы узлов {{ managed-k8s-name }}.
     1. Укажите **Версию {{ k8s }}** для узлов {{ managed-k8s-name }}.
     1. В блоке **Масштабирование**:
        * Выберите тип политики масштабирования.
        * Укажите количество узлов в группе узлов {{ managed-k8s-name }}.
     1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество [виртуальных машин](../../../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы {{ managed-k8s-name }}.
     1. В блоке **Вычислительные ресурсы**:
        * Выберите [платформу](../../../compute/concepts/vm-platforms.md).
        * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../../../compute/concepts/performance-levels.md), а также объем RAM.
     1. В блоке **Хранилище**:
        * Укажите **Тип диска** узла {{ managed-k8s-name }}:
          * **HDD** — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * **SSD** — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * **Нереплицируемый SSD** — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.
          * **SSD IO** — обладает теми же скоростными характеристиками, что и **Нереплицируемый SSD**, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.
         * Укажите размер [диска](../../../compute/concepts/disk.md) узла {{ managed-k8s-name }}.
     1. В блоке **Сетевые настройки**:
        * В поле **Публичный адрес** выберите способ назначения адреса:
          * **Автоматически** — чтобы назначить случайный [IP-адрес](../../../vpc/concepts/address.md) из пула адресов {{ yandex-cloud }}.
          * **Без адреса** — чтобы не назначать публичный IP-адрес.
        * Укажите расположение узлов {{ managed-k8s-name }} по [зонам доступности](../../../overview/concepts/geo-scope.md) и [сетям](../../../vpc/concepts/network.md#network).
     1. В блоке **Доступ** укажите данные для доступа на узел {{ managed-k8s-name }}:
        * В поле **Логин** введите имя пользователя.
        * В поле **SSH-ключ** вставьте содержимое файла [публичного ключа](../../operations/node-connect-ssh.md#creating-ssh-keys).
     1. В блоке **Настройки окна обновлений**:
        * В поле **Частота обновлений / Отключение** выберите окно для [обновлений](../../concepts/release-channels-and-updates.md#updates):
          * **Отключено** — отключение автоматических обновлений.
          * **В любое время** — обновления разрешены в любое время.
          * **Ежедневно** — обновления будут происходить во временной интервал, указанный в поле **Время (UTC) и продолжительность**.
          * **В выбранные дни** — обновления будут происходить во временной интервал, указанный в поле **Расписание по дням**.
     1. В блоке **Дополнительно**:
        * В поле **Метки узла** нажмите кнопку **Добавить метку** и укажите ее ключ и значение. Если необходимо, добавьте несколько меток.
     1. Нажмите кнопку **Создать группу узлов**.

   - CLI

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
     id: catkuapro07enihqmk51
     cluster_id: abcsk1s2f3fmb5h0pd94
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
         subnet_id: e9bm87gkjd81eroc6dqg
     deploy_policy:
       max_expansion: "3"
     instance_group_id: cl1v2gh33j1c71df9jsv
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

   - {{ TF }}

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
            "<метка1>" = "<значение1>"
            "<метка2>" = "<значение2>"
            ...
          }
        }
        ```

     1. Проверьте корректность конфигурационных файлов.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

     1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

   - API

     Чтобы создать группу узлов {{ managed-k8s-name }}, воспользуйтесь методом [create](../../api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

   {% endlist %}

1. Посмотрите информацию о созданной группе узлов {{ managed-k8s-name }} с метками:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан кластер {{ managed-k8s-name }}.
     1. В списке сервисов выберите **{{ managed-k8s-name }}**.
     1. Выберите кластер {{ managed-k8s-name }}, в котором создана группа узлов.
     1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **Управление узлами**.
     1. На странице одного из узлов {{ managed-k8s-name }}, перейдите на вкладку **Метки**. На вкладке перечислены системные и пользовательские метки узла {{ managed-k8s-name }}.

   - CLI

     1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
     1. Посмотрите все узлы кластера {{ managed-k8s-name }}:

        ```bash
        kubectl get nodes
        ```

        Результат:

        ```bash
        NAME                        STATUS   ROLES    AGE  VERSION
        catkuapro07enihqmk51-hgjd   Ready    <none>   1h   v1.17.8
        catkuapro07enihqmk51-lskc   Ready    <none>   1h   v1.17.8
        ```

     1. Посмотрите информацию о выбранном узле кластера {{ managed-k8s-name }}:

        ```bash
        kubectl describe node catkuapro07enihqmk51-hgjd
        ```

        Результат:

        ```bash
        Name:               catkuapro07enihqmk51-hgjd
        Roles:              <none>
        Labels:             apps/tier=backend
                            beta.kubernetes.io/arch=amd64
                            beta.kubernetes.io/instance-type=standard-v2
                            beta.kubernetes.io/os=linux
                            environment=production
                            failure-domain.beta.kubernetes.io/zone={{ region-id }}-a
                            kubernetes.io/arch=amd64
                            kubernetes.io/hostname=catkuapro07enihqmk51-hgjd
                            kubernetes.io/os=linux
                            node.kubernetes.io/kube-proxy-ds-ready=true
                            node.kubernetes.io/masq-agent-ds-ready=true
                            node.kubernetes.io/node-problem-detector-ds-ready=true
                            yandex.cloud/node-group-id=catkuapro07enihqmk51
                            yandex.cloud/pci-topology=k8s
                            yandex.cloud/preemptible=false
        ```

   - API

     Чтобы посмотреть информацию об узле {{ managed-k8s-name }}, воспользуйтесь методом [list](../../api-ref/NodeGroup/list.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

   {% endlist %}