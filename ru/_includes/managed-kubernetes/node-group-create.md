Чтобы создать [группу узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group):
1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Выберите кластер {{ managed-k8s-name }}, для которого необходимо создать группу узлов.
1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
1. Введите имя и описание группы узлов {{ managed-k8s-name }}.
1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** выберите версию {{ k8s }} для узлов {{ managed-k8s-name }}.
1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_container-runtime }}** выберите `{{ ui-key.yacloud.k8s.node-groups.create.label_runtime-CONTAINERD }}`.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}** выберите его тип:
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}` — чтобы количество узлов {{ managed-k8s-name }} в группе оставалось неизменным. Укажите количество узлов {{ managed-k8s-name }} в группе.

     При этом станет доступна настройка **{{ ui-key.yacloud.k8s.node-groups.create.field_scale-size }}**.
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}` — чтобы управлять количеством узлов в группе с помощью [автоматического масштабирования кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/autoscale.md#ca).

     При этом станут доступны настройки:
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}**.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-size }}**.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}**, с которым будет создана группа {{ managed-k8s-name }}.

   {% note warning %}

   Тип масштабирования нельзя изменить после создания группы узлов {{ managed-k8s-name }}.

   {% endnote %}

1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}** укажите максимальное количество [виртуальных машин](../../compute/concepts/vm.md), на которое можно превысить и уменьшить размер группы узлов {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Выберите [платформу](../../compute/concepts/vm-platforms.md).
   * Укажите необходимое количество [GPU](../../compute/concepts/gpus.md), vCPU и [гарантированную долю vCPU](../../compute/concepts/performance-levels.md), а также объем RAM.
   * (Опционально) Укажите, что ВМ должна быть [прерываемой](../../compute/concepts/preemptible-vm.md).
   * (Опционально) Включите [программно-ускоренную сеть](../../compute/concepts/software-accelerated-network.md).

     {% include [note-software-accelerated-network](note-software-accelerated-network.md) %}

   {% note info %}

   Набор параметров зависит от выбранной платформы.

   {% endnote %}

1. (Опционально) В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_gpu-settings }}** укажите, если группа узлов {{ managed-k8s-name }} должна быть без предустановленных драйверов NVIDIA® и библиотек CUDA® для [GPU-ускорения](../../compute/concepts/gpus.md).
1. (Опционально) В блоке **{{ ui-key.yacloud.k8s.node-group.overview.section_placement-policy }}** укажите имя [группы размещения](../../compute/concepts/placement-groups.md) для узлов {{ managed-k8s-name }}. Эту настройку невозможно изменить после создания группы узлов {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
   * Укажите **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}** узла {{ managed-k8s-name }}:
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}` — [стандартный сетевой диск](../../compute/concepts/disk.md#disks-types), сетевое блочное хранилище на HDD-накопителе.
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}` — сетевой диск с повышенной производительностью, реализованной за счет устранения избыточности. Размер такого диска можно менять только с шагом 93 ГБ.

       {% include [Нереплицируемый диск не имеет резервирования](nrd-no-backup-note.md) %}

     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}` — обладает теми же скоростными характеристиками, что и `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, и одновременно обеспечивает избыточность. Размер такого диска можно менять только с шагом 93 ГБ.

   * Укажите размер диска узла {{ managed-k8s-name }}.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
   * В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** выберите способ назначения адреса:
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}` — чтобы назначить случайный [IP-адрес](../../vpc/concepts/address.md) из пула адресов {{ yandex-cloud }}.
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_none }}` — чтобы не назначать публичный IP-адрес.
   * Выберите [группы безопасности](../../vpc/concepts/security-groups.md).

     {% include [security-groups-alert](security-groups-alert.md) %}


   * Укажите расположение узлов {{ managed-k8s-name }} по [зонам доступности](../../overview/concepts/geo-scope.md) и [сетям](../../vpc/concepts/network.md#network).
   * (Опционально) Нажмите кнопку **{{ ui-key.yacloud.k8s.node-groups.create.label_add-location }}** и укажите дополнительную зону доступности и сеть, чтобы создать узлы {{ managed-k8s-name }} в разных зонах доступности.


1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}** настройте один из способов подключения к узлам в группе узлов {{ managed-k8s-name }}:

    * Чтобы подключаться к узлам через {{ oslogin }}, выберите опцию **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}**.

        При выборе этой опции будет нельзя указать SSH-ключи, так как эти способы подключения являются взаимоисключающими.

        Настройка и использование {{ oslogin }} подробно рассмотрены в разделе [{#T}](../../managed-kubernetes/operations/node-connect-oslogin.md).

    * Чтобы подключаться к узлам с использованием SSH-ключей, укажите необходимые реквизиты:

        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

        * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [публичного ключа](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys).

        Подготовка реквизитов, настройка и использование SSH-ключей подробно рассмотрены в разделе [{#T}](../../managed-kubernetes/operations/node-connect-ssh.md).

    {% include [node-group-metadata-postponed-update-note](./node-group-metadata-postponed-update-note.md) %}

1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
   * В поле **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-window }}** выберите окно для обновлений:
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}` — отключение автоматических обновлений.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}` — обновления разрешены в любое время.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}` — обновления будут происходить во временной интервал, указанный в поле **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}**.
     * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}` — обновления будут происходить во временной интервал, указанный в поле **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}**.
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_additional }}**:
   * Чтобы иметь возможность изменять [небезопасные параметры ядра](../../managed-kubernetes/concepts/index.md#node-group) на узлах группы {{ managed-k8s-name }}, используйте кнопку **{{ ui-key.yacloud.k8s.node-groups.create.button_add-sysctl }}**. Для ввода имени каждого параметра ядра создайте отдельное поле.
   * Чтобы задать [taint-политики узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#taints-tolerations), используйте кнопку **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-taint }}**. Укажите ключ, значение и эффект каждой taint-политики в отдельном наборе полей.
   * Чтобы задать [{{ k8s }}-метки](../../managed-kubernetes/concepts/index.md#node-labels) узлов группы, используйте кнопку **{{ ui-key.yacloud.k8s.node-groups.create.button_add-node-label }}**. Укажите ключ и значение каждой {{ k8s }}-метки в отдельном наборе полей.

1. (Опционально) Раскройте блок **{{ ui-key.yacloud.common.metadata }}** и добавьте метаданные для узлов.

    {% note warning %}

    {% include [node-group-metadata-warning](./node-group-metadata-warning.md) %}

    {% endnote %}

    Чтобы добавить метаданные, используйте кнопку **{{ ui-key.yacloud.common.metadata-add-field }}**. Укажите ключ и значение каждого элемента метаданных в отдельном наборе полей.

    {% include [node-group-metadata-postponed-update-note](./node-group-metadata-postponed-update-note.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
