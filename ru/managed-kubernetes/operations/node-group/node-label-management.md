# Управление метками узлов кластера {{ k8s }}

Вы можете добавлять [{{ k8s }}-метки](../../concepts/index.md#node-labels) сразу на все узлы в [группе узлов](../../concepts/index.md#node-group). Для этого задайте набор меток в параметре `node_labels` при [создании группы узлов](../../operations/node-group/node-group-create.md).

1. Создайте [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster).

   Вы можете использовать уже работающий кластер {{ k8s }} или [создать новый](../kubernetes-cluster/kubernetes-cluster-create.md).
1. Создайте группу узлов с метками.

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан кластер {{ k8s }}.
     1. В списке сервисов выберите **{{ managed-k8s-name }}**.
     1. Выберите кластер {{ k8s }}, для которого необходимо создать группу узлов.
     1. На странице кластера {{ k8s }} перейдите на вкладку **Группы узлов**.
     1. Нажмите кнопку **Создать группу узлов**.
     1. Введите имя группы узлов.
     1. Укажите **Версию {{ k8s }}** для узлов.
     1. В блоке **Масштабирование**:
        * Выберите тип политики масштабирования.
        * Укажите количество узлов в группе узлов.
     1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество виртуальных машин, на которое можно превысить и уменьшить размер группы.
     1. В блоке **Вычислительные ресурсы**:
        * Выберите [платформу](../../../compute/concepts/vm-platforms.md).
        * Укажите необходимое количество vCPU и [гарантированную долю vCPU](../../../compute/concepts/performance-levels.md), а также объем RAM.
     1. В блоке **Хранилище**:
        * Укажите **Тип диска** узла:
          * **HDD** — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * **SSD** — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
         * Укажите размер [диска](../../../compute/concepts/disk.md) узла.
     1. В блоке **Сетевые настройки**:
        * В поле **Публичный адрес** выберите способ назначения адреса:
          * **Автоматически** — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
          * **Без адреса** — чтобы не назначать публичный IP-адрес.
        * Укажите расположение узлов по зонам доступности и сетям.
     1. В блоке **Доступ** укажите данные для доступа на узел:
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

     Создайте группу узлов:

     ```bash
     yc managed-kubernetes node-group create \
      --name k8s-labels-node \
      --cluster-name k8s-labels \
      --disk-type network-ssd \
      --fixed-size 1 \
      --node-labels environment=production,apps/tier=backend
     ```

     Где:

     * `--name` — имя группы узлов.
     * `--cluster-name` — имя кластера {{ k8s }}, в котором будет создана группа узлов.
     * `--disk-type` — [тип диска](../../../compute/concepts/disk.md) узла.
     * `--fixed-size` — количество узлов в группе.
     * `--node-labels` — метки узла. Можно указать несколько меток через запятую.

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

     Группа узлов будет создана заново.

     {% endnote %}

     1. Откройте актуальный конфигурационный файл с описанием группы узлов.

        О том, как создать такой файл, см. в разделе [{#T}](node-group-create.md).
     1. Добавьте к описанию группы узлов параметр `node_labels`:

        ```hcl
        resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
          cluster_id = yandex_kubernetes_cluster.<имя кластера>.id
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

     Чтобы создать группу узлов, воспользуйтесь методом [create](../../api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

   {% endlist %}

1. Посмотрите информацию о созданной группе узлов с метками:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан кластер {{ k8s }}.
     1. В списке сервисов выберите **{{ managed-k8s-name }}**.
     1. Выберите кластер {{ k8s }}, в котором создана группа узлов.
     1. На странице кластера {{ k8s }} перейдите на вкладку **Узлы**.
     1. На странице одного из узлов, перейдите на вкладку **Метки**. На вкладке перечислены системные и пользовательские метки узла.

   - CLI

     1. Посмотрите все узлы кластера {{ k8s }}:

     ```bash
     kubectl get nodes
     ```

     Результат:

     ```bash
     NAME                        STATUS   ROLES    AGE  VERSION
     catkuapro07enihqmk51-hgjd   Ready    <none>   1h   v1.17.8
     catkuapro07enihqmk51-lskc   Ready    <none>   1h   v1.17.8
     ```

     1. Посмотрите информацию о выбранном узле кластера {{ k8s }}:

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

     Чтобы посмотреть информацию об узле, воспользуйтесь методом [list](../../api-ref/NodeGroup/list.md) для ресурса [NodeGroup](../../api-ref/NodeGroup/).

   {% endlist %}