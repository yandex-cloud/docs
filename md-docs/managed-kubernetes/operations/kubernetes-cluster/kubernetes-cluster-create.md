# Создание кластера {{ managed-k8s-name }}


Создайте [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), а затем [создайте группу узлов](../node-group/node-group-create.md).

Если вы хотите создать кластер без доступа в интернет, обратитесь к разделу [{#T}](../../tutorials/k8s-cluster-with-no-internet.md).

## Перед началом работы {#before-you-begin}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
  1. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).
  1. Если у вас еще нет [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../../resource-manager/operations/folder/create.md).
  1. Убедитесь, что у [аккаунта](../../../iam/concepts/users/accounts.md), с помощью которого вы собираетесь создавать кластер {{ managed-k8s-name }}, есть [необходимые для этого роли](../../security/index.md#required-roles).
  1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md).
  1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и [группа узлов](../../concepts/index.md#node-group).
  1. Создайте [сервисные аккаунты](../../../iam/operations/sa/create.md):
      * Сервисный аккаунт с [ролями](../../security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на каталог, в котором создается кластер {{ managed-k8s-name }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
      * Сервисный аккаунт с ролью [{{ roles-cr-puller }}](../../../container-registry/security/index.md#container-registry-images-puller) на каталог с реестром [Docker-образов](../../../container-registry/concepts/docker-image.md) в [{{ container-registry-full-name }}](../../../container-registry/concepts/index.md). От его имени узлы будут скачивать из реестра необходимые Docker-образы.

        Если вы хотите использовать реестр [Docker-образов](../../../cloud-registry/concepts/artifacts/docker.md) в [{{ cloud-registry-full-name }}](../../../cloud-registry/concepts/index.md), назначьте сервисному аккаунту роль [cloud-registry.artifacts.puller](../../../cloud-registry/security/index.md#cloud-registry-artifacts-puller).

      Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

      {% note info %}
      
      Для создания кластера с [туннельным режимом](../../concepts/network-policy.md#cilium) его сервисному аккаунту необходима роль `k8s.tunnelClusters.agent`.
      
      {% endnote %}

  1. [Создайте и настройте нужные группы безопасности](../connect/security-groups.md).

  1. Изучите [рекомендации по использованию {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

{% endlist %}

## Создайте кластер {{ managed-k8s-name }} {#kubernetes-cluster-create}

{% note info %}

Функциональность выбора и изменения конфигурации мастера находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

{% note warning %}

С 18 июня 2026 года тарификация мастеров изменится — плата будет взиматься за количество vCPU и объем RAM. Чтобы рассчитать необходимое количество ресурсов мастера для своего кластера, воспользуйтесь таблицей [{#T}](../../concepts/master-configuration.md).

{% endnote %}

{% note warning %}

Начиная с {{ k8s }} версии 1.30 во всех [релизных каналах](../../concepts/release-channels-and-updates.md) базовый образ узлов кластера {{ managed-k8s-name }} изменен с Ubuntu 20.04 на Ubuntu 22.04. В существующих кластерах и группах узлов версия операционной системы будет повышена в соответствии с выбранным способом обновления.

Особенности и рекомендации по обновлению ОС приведены в разделе [{#T}](../../concepts/node-os-update.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
  1. Введите имя и описание кластера {{ managed-k8s-name }}. Имя кластера {{ managed-k8s-name }} должно быть уникальным в рамках {{ yandex-cloud }}.
  1. Укажите **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}**, который будет использоваться для создания ресурсов.
  1. Укажите **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}**, который будет использоваться [узлами {{ managed-k8s-name }}](../../concepts/index.md#node-group) для доступа к реестру [Docker-образов](../../../container-registry/concepts/docker-image.md) в {{ container-registry-full-name }}.
  1. (Опционально) Укажите **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}**, который будет использоваться для [шифрования секретов](../../concepts/encryption.md).
  
     Эту настройку невозможно изменить после создания кластера.
  
  1. Укажите [релизный канал](../../concepts/release-channels-and-updates.md).
  
     Эту настройку невозможно изменить после создания кластера.
  
  1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** добавьте [облачные метки](../../concepts/index.md#cluster-labels).
  
  1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
     * (Опционально) Раскройте секцию **Вычислительные ресурсы** и выберите [конфигурацию ресурсов](../../concepts/index.md#master-resources) для мастера.
  
       Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.
  
       _По умолчанию_ для работы одного хоста мастера предоставляются следующие ресурсы:
       * [платформа](../../../compute/concepts/vm-platforms.md) — Intel Cascade Lake;
       * гарантированная доля vCPU — 100%;
       * количество vCPU — 2;
       * объем RAM — 8 ГБ.
  
     * В поле **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** выберите версию {{ k8s }}, которая будет установлена на [мастере {{ managed-k8s-name }}](../../concepts/index.md#master).
     * В поле **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** выберите способ назначения [IP-адреса](../../../vpc/concepts/address.md):
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}` — чтобы назначить случайный IP-адрес из пула IP-адресов {{ yandex-cloud }}.
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_none }}` — чтобы не назначать публичный IP-адрес.
  
       {% note warning %}
       
       Не размещайте кластер с публичным IP-адресом в подсетях, в которых доступ в интернет обеспечивается через [NAT-инстанс](../../../tutorials/routing/nat-instance/index.md). При такой конфигурации ответ на запрос к публичному IP-адресу кластера придет с IP-адреса NAT-инстанса и будет отклонен клиентом. Подробнее см. [Приоритет маршрутов в сложных сценариях](../../../vpc/concepts/routing.md#priority).
       
       {% endnote %}
  
       Эту настройку невозможно изменить после создания кластера.
  
     * В поле **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}** выберите тип мастера {{ managed-k8s-name }}:
       * `Базовый` — содержит один хост мастера в одной зоне доступности. Такой мастер дешевле, но он не является отказоустойчивым. Прежнее название — _зональный_.
  
         {% note warning %}
  
         _Базовый_ мастер тарифицируется как _зональный_ и отображается в {{ billing-name }} как `{{ managed-k8s-name }}. Зональный мастер`.
  
         {% endnote %}
  
       * `Высокодоступный` — содержит три хоста мастера. Прежнее название — _региональный_.
  
         {% note warning %}
  
         _Высокодоступный_ мастер тарифицируется как _региональный_ и отображается в {{ billing-name }} как `{{ managed-k8s-name }}. Региональный мастер`.
  
         {% endnote %}
  
     * В поле **{{ ui-key.yacloud.k8s.clusters.create.field_network }}** выберите [сеть](../../../vpc/concepts/network.md#network), в которой будет создан мастер {{ managed-k8s-name }}. Если сети нет, [создайте ее](../../../vpc/operations/network-create.md).
  
        При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
        * [{{ roles-vpc-private-admin }}](../../../vpc/security/index.md#vpc-private-admin)
        * [{{ roles-vpc-user }}](../../../vpc/security/index.md#vpc-user)
        * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
        
        Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [{{ roles-vpc-public-admin }}](../../../vpc/security/index.md#vpc-public-admin).
  
        {% note warning %}
        
        Не изменяйте и не удаляйте ресурсы {{ vpc-name }}, которые используются кластером {{ managed-k8s-name }}. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
        
        {% endnote %}
  
     * Для высокодоступного мастера в поле **Распределение мастеров по зонам доступности** выберите, как должны быть размещены хосты мастера:
       * `Одна зона` — в одной зоне доступности и одной подсети. Такой мастер подойдет, если вы хотите обеспечить высокую доступность кластера и уменьшить сетевую задержку внутри него.
       * `Разные зоны` — в трех разных зонах доступности. Такой мастер обеспечивает наибольшую отказоустойчивость: при недоступности одной зоны мастер остается работоспособным.
  
     * В зависимости от выбранного типа мастера:
       * Для базового или высокодоступного мастера в одной зоне укажите зону доступности и подсеть. 
       * Для высокодоступного мастера в разных зонах укажите подсети в каждой зоне. 
  
       Если подсетей нет, [создайте](../../../vpc/operations/subnet-create.md) их.
  
       {% note warning %}
  
       Тип мастера и его размещение нельзя изменить после создания кластера.
  
       {% endnote %}
  
     * Выберите [группы безопасности](../../../vpc/concepts/security-groups.md) для сетевого трафика кластера {{ managed-k8s-name }}.
  
       {% note warning %}
       
       От [настройки групп безопасности](../connect/security-groups.md) зависит работоспособность и доступность кластера, а также запущенных в нем сервисов.
       
       {% endnote %}
  
  1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_maintenance }}**:
     * В поле **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** настройте окно для обновлений:
       * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}` — отключение автоматических обновлений.
       * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}` — обновления разрешены в любое время.
       * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}` — обновления будут происходить во временном интервале, указанном в поле **{{ ui-key.yacloud.k8s.clusters.create.field_maintenance-daily }}**.
       * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}` — обновления будут происходить во временном интервале, указанном в поле **{{ ui-key.yacloud.k8s.clusters.create.label_maintenance-weekly }}**.
  1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
     * (Опционально) Выберите [контроллер сетевых политик](../../concepts/network-policy.md#policy-controllers):
  
       Эту настройку невозможно изменить после создания кластера.
  
       {% note warning %}
       
       Нельзя одновременно включить контроллер сетевых политик Calico и туннельный режим Cilium.
       
       {% endnote %}
  
       * **{{ ui-key.yacloud.k8s.clusters.create.field_network-policy }}**, чтобы задействовать Calico.
       * **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}**, чтобы задействовать Cilium.
  
     * Укажите **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}** — диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](../../concepts/index.md#pod).
     * Укажите **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}** — диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../concepts/index.md#service).
     * Задайте маску подсети узлов {{ managed-k8s-name }} и максимальное количество подов в узле.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать кластер {{ managed-k8s-name }}:

  1. Укажите параметры кластера {{ managed-k8s-name }} в команде создания (в примере приведены не все параметры):

     ```bash
     {{ yc-k8s }} cluster create \
       --name <имя_кластера> \
       --network-name <имя_сети> \
       --public-ip \
       --release-channel <релизный_канал:_rapid,_regular_или_stable> \
       --version <версия_{{ k8s }}> \
       --cluster-ipv4-range <диапазон_IP-адресов_для_подов> \
       --service-ipv4-range <диапазон_IP-адресов_для_сервисов> \
       --security-group-ids <список_идентификаторов_групп_безопасности> \
       --service-account-name <имя_сервисного_аккаунта_для_ресурсов> \
       --node-service-account-name <имя_сервисного_аккаунта_для_узлов> \
       --master-location zone=<зона_доступности>,subnet-id=<имя_подсети> \
       --master-scale-policy policy=auto,min-resource-preset-id=<класс_хостов_мастера> \
       --daily-maintenance-window start=22:00,duration=10h
       --labels <имя_облачной_метки=значение_облачной_метки>

     ```

     Где:

     * `--name` — имя кластера {{ managed-k8s-name }}.
     * `--network-name` — имя [сети](../../../vpc/concepts/network.md#network).

        При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
        * [{{ roles-vpc-private-admin }}](../../../vpc/security/index.md#vpc-private-admin)
        * [{{ roles-vpc-user }}](../../../vpc/security/index.md#vpc-user)
        * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
        
        Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [{{ roles-vpc-public-admin }}](../../../vpc/security/index.md#vpc-public-admin).

        {% note warning %}
        
        Не изменяйте и не удаляйте ресурсы {{ vpc-name }}, которые используются кластером {{ managed-k8s-name }}. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
        
        {% endnote %}

     * `--public-ip` — флаг, который указывает, если кластеру {{ managed-k8s-name }} требуется [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).

       {% note warning %}
       
       Не размещайте кластер с публичным IP-адресом в подсетях, в которых доступ в интернет обеспечивается через [NAT-инстанс](../../../tutorials/routing/nat-instance/index.md). При такой конфигурации ответ на запрос к публичному IP-адресу кластера придет с IP-адреса NAT-инстанса и будет отклонен клиентом. Подробнее см. [Приоритет маршрутов в сложных сценариях](../../../vpc/concepts/routing.md#priority).
       
       {% endnote %}

       Эту настройку невозможно изменить после создания кластера.

     * `--release-channel` — [релизный канал](../../concepts/release-channels-and-updates.md#release-channels).

       Эту настройку невозможно изменить после создания кластера.

     * `--version` — версия {{ k8s }}. Укажите версию, доступную для выбранного релизного канала.
     * `--cluster-ipv4-range` — диапазон [IP-адресов](../../../vpc/concepts/address.md), из которого будут выделяться IP-адреса для [подов](../../concepts/index.md#pod).
     * `--service-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../concepts/index.md#service).
     * `--security-group-ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/security-groups.md) кластера {{ managed-k8s-name }}.

       {% note warning %}
       
       От [настройки групп безопасности](../connect/security-groups.md) зависит работоспособность и доступность кластера, а также запущенных в нем сервисов.
       
       {% endnote %}

     * `--service-account-id` — уникальный идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
     * `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для [узлов](../../concepts/index.md#node-group). От его имени узлы будут скачивать из [реестра](../../../container-registry/concepts/registry.md) {{ container-registry-full-name }} необходимые [Docker-образы](../../../container-registry/concepts/docker-image.md).
     * `--master-location` — конфигурация [мастера](../../concepts/index.md#master). Укажите в параметре зону доступности и подсеть, где будет размещен мастер.

        Количество параметров `--master-location` зависит от типа мастера:

        * Для базового мастера передайте один параметр `--master-location`.
        * Для высокодоступного мастера, который размещается в трех зонах доступности, передайте три параметра `--master-location`. В каждом из них укажите разные зоны доступности и подсети.
        * Для высокодоступного мастера, который размещается в одной зоне доступности, передайте три параметра `--master-location`. В каждом из них укажите одинаковую зону доступности и подсеть.

     * `--master-scale-policy` — конфигурация [вычислительных ресурсов мастера](../../concepts/index.md#master-resources).

        Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

        {% note info %}

        Если не передать параметр `--master-scale-policy`, то будет применена минимально доступная конфигурация мастера.

        _По умолчанию_ для работы одного хоста мастера предоставляются следующие ресурсы:
        * [платформа](../../../compute/concepts/vm-platforms.md) — Intel Cascade Lake;
        * гарантированная доля vCPU — 100%;
        * количество vCPU — 2;
        * объем RAM — 8 ГБ.

        {% endnote %}

     * `--daily-maintenance-window` — настройки времени начала окна [обновления](../../concepts/release-channels-and-updates.md#updates) в UTC.
     * `--labels` — [облачные метки](../../concepts/index.md#cluster-labels) для кластера.

     Результат:

     ```text
     done (5m47s)
     id: cathn0s6qobf********
     folder_id: b1g66jflru0e********
     ...
       service_account_id: aje3932acd0c********
       node_service_account_id: aje3932acd0c********
       release_channel: REGULAR
     ```
  
  1. Настройте [Container Network Interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/) кластера:

      Эту настройку невозможно изменить после создания кластера.

      {% note warning %}
      
      Нельзя одновременно включить контроллер сетевых политик Calico и туннельный режим Cilium.
      
      {% endnote %}

      * Чтобы включить [контроллер сетевых политик](../../concepts/network-policy.md#calico) Calico, передайте в команде создания кластера {{ managed-k8s-name }} флаг `--enable-network-policy`:

        ```bash
        {{ yc-k8s }} cluster create \
        ...
          --enable-network-policy
        ```

      * Чтобы включить [туннельный режим](../../concepts/network-policy.md#cilium) Cilium, передайте в команде создания кластера {{ managed-k8s-name }} флаг `--cilium`:

        ```bash
        {{ yc-k8s }} cluster create \
        ...
          --cilium
        ```

  1. Чтобы использовать [ключ шифрования {{ kms-full-name }}](../../concepts/encryption.md) для защиты конфиденциальной информации, передайте в команде создания кластера {{ managed-k8s-name }} его имя или идентификатор:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --kms-key-name <имя_ключа_шифрования> \
       --kms-key-id <идентификатор_ключа_шифрования>
     ```

     Эту настройку невозможно изменить после создания кластера.

  1. Чтобы включить отправку логов в [{{ cloud-logging-full-name }}](../../../logging/index.md):

     1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [{{ roles-logging-writer }}](../../../logging/security/index.md#loggingwriter).
     1. Передайте настройки отправки в команде создания кластера, в параметре `--master-logging`:

        ```bash
        {{ yc-k8s }} cluster create \
        ...
          --master-logging enabled=<отправка_логов:_true_или_false>,`
            `log-group-id=<идентификатор_лог-группы>,`
            `folder-id=<идентификатор_каталога>,`
            `kube-apiserver-enabled=<отправка_логов_kube-apiserver:_true_или_false>,`
            `cluster-autoscaler-enabled=<отправка_логов_cluster-autoscaler:_true_или_false>,`
            `events-enabled=<отправка_событий_{{ k8s }}:_true_или_false>
            `audit-enabled=<отправка_событий_аудита>
        ```

        Где:

        * `enabled` — флаг отправки логов: `true` или `false`.
        * `log-group-id` — идентификатор [лог-группы](../../../logging/concepts/log-group.md), в которую нужно отправлять логи.
        * `folder-id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
        * `kube-apiserver-enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/): `true` или `false`.
        * `cluster-autoscaler-enabled` — флаг отправки логов `cluster-autoscaler`: `true` или `false`.
        * `events-enabled` — флаг отправки событий {{ k8s }}: `true` или `false`.
        * `audit-enabled` — флаг отправки событий аудита: `true` или `false`.

        Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы создать кластер {{ managed-k8s-name }}:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер {{ managed-k8s-name }} — описание кластера.
     * [Сеть](../../../vpc/concepts/network.md#network) — описание облачной сети, в которой будет расположен кластер {{ managed-k8s-name }}. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

        При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
        * [{{ roles-vpc-private-admin }}](../../../vpc/security/index.md#vpc-private-admin)
        * [{{ roles-vpc-user }}](../../../vpc/security/index.md#vpc-user)
        * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
        
        Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [{{ roles-vpc-public-admin }}](../../../vpc/security/index.md#vpc-public-admin).

     * [Подсети](../../../vpc/concepts/network.md#subnet) — описание подсетей, к которым будут подключены хосты кластера {{ managed-k8s-name }}. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

         {% note warning %}
         
         Не изменяйте и не удаляйте ресурсы {{ vpc-name }}, которые используются кластером {{ managed-k8s-name }}. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
         
         {% endnote %}

     * [Сервисный аккаунт](#before-you-begin) для кластера {{ managed-k8s-name }} и [узлов](../../concepts/index.md#node-group) и [настройки роли]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) для этого аккаунта. При необходимости создайте отдельные [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для кластера {{ managed-k8s-name }} и узлов. Если у вас уже есть подходящий сервисный аккаунт, описывать его повторно не нужно.

     >Пример структуры конфигурационного файла:
     >
     >```hcl
     >resource "yandex_kubernetes_cluster" "<имя_кластера_Managed_Service_for_Kubernetes>" {
     >  network_id = yandex_vpc_network.<имя_сети>.id
     >  master {
     >    master_location {
     >      zone      = yandex_vpc_subnet.<имя_подсети>.zone
     >      subnet_id = yandex_vpc_subnet.<имя_подсети>.id
     >    }
     >  }
     >  service_account_id      = yandex_iam_service_account.<имя_сервисного_аккаунта>.id
     >  node_service_account_id = yandex_iam_service_account.<имя_сервисного_аккаунта>.id
     >    depends_on = [
     >      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
     >      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
     >      yandex_resourcemanager_folder_iam_member.images-puller
     >    ]
     > }
     >  labels {
     >    "<имя_облачной_метки>"="<значение_облачной_метки>"
     >  }
     >resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }
     >
     >resource "yandex_vpc_subnet" "<имя_подсети>" {
     >  v4_cidr_blocks = ["<диапазон_адресов_подсети>"]
     >  zone           = "<зона_доступности>"
     >  network_id     = yandex_vpc_network.<имя_сети>.id
     >}
     >
     >resource "yandex_iam_service_account" "<имя_сервисного_аккаунта>" {
     >  name        = "<имя_сервисного_аккаунта>"
     >  description = "<описание_сервисного_аккаунта>"
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
     >  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
     >  folder_id = "<идентификатор_каталога>"
     >  role      = "k8s.clusters.agent"
     >  member    = "serviceAccount:${yandex_iam_service_account.<имя_сервисного_аккаунта>.id}"
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
     >  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
     >  folder_id = "<идентификатор_каталога>"
     >  role      = "vpc.publicAdmin"
     >  member    = "serviceAccount:${yandex_iam_service_account.<имя_сервисного_аккаунта>.id}"
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
     >  # Сервисному аккаунту назначается роль "container-registry.images.puller".
     >  folder_id = "<идентификатор_каталога>"
     >  role      = "container-registry.images.puller"
     >  member    = "serviceAccount:${yandex_iam_service_account.<имя_сервисного_аккаунта>.id}"
     >}
     >```

     {% note info %}

     Облачные метки для кластера {{ k8s }} составляются по определенным [правилам](../../concepts/index.md#cluster-labels).

     {% endnote %}

     Чтобы задать конфигурацию [вычислительных ресурсов мастера](../../concepts/index.md#master-resources), добавьте к описанию кластера {{ managed-k8s-name }} блок:

     >```hcl
     >resource "yandex_kubernetes_cluster" "<имя_кластера>" {
     >  ...
     >  master {
     >    ...
     >    scale_policy {
     >      auto_scale  {
     >        min_resource_preset_id = "<класс_хостов_мастера>"
     >      }
     >    }
     >  }
     >}
     >```

     Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

     {% note info %}

     Если не передать параметр `scale_policy`, то будет применена минимально доступная конфигурация мастера.

     _По умолчанию_ для работы одного хоста мастера предоставляются следующие ресурсы:
     * [платформа](../../../compute/concepts/vm-platforms.md) — Intel Cascade Lake;
     * гарантированная доля vCPU — 100%;
     * количество vCPU — 2;
     * объем RAM — 8 ГБ.

     {% endnote %}

     Чтобы включить [туннельный режим](../../concepts/network-policy.md#cilium) Cilium, добавьте к описанию кластера {{ managed-k8s-name }} блок:

     ```hcl
     network_implementation {
      cilium {}
     }
     ```

     Чтобы включить [контроллер сетевых политик](../../concepts/network-policy.md#calico) Calico, добавьте к описанию кластера {{ managed-k8s-name }} строку:

     ```hcl
     network_policy_provider = "CALICO"
     ```

     {% note warning %}

     Контроллер сетевых политик Calico и туннельный режим Cilium нельзя включить одновременно. Их также нельзя включить после создания кластера.

     {% endnote %}

     Чтобы включить отправку логов в [{{ cloud-logging-full-name }}](../../../logging/index.md):

     1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [{{ roles-logging-writer }}](../../../logging/security/index.md#loggingwriter).
     1. Добавьте к описанию кластера {{ managed-k8s-name }} блок `master_logging`:

        >```hcl
        >resource "yandex_kubernetes_cluster" "<имя_кластера>" {
        >  ...
        >  master {
        >    ...
        >    master_logging {
        >      enabled                    = <отправка_логов>
        >      log_group_id               = "<идентификатор_лог-группы>"
        >      folder_id                  = "<идентификатор_каталога>"
        >      kube_apiserver_enabled     = <отправка_логов_kube-apiserver>
        >      cluster_autoscaler_enabled = <отправка_логов_cluster-autoscaler>
        >      events_enabled             = <отправка_событий_{{ k8s }}>
        >      audit_enabled              = <отправка_событий_аудита>
        >    }
        >  }
        >}
        >```

        Где:

        * `enabled` — флаг отправки логов: `true` или `false`.
        * `log_group_id` — идентификатор [лог-группы](../../../logging/concepts/log-group.md), в которую нужно отправлять логи.
        * `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
        * `kube_apiserver_enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/): `true` или `false`.
        * `cluster_autoscaler_enabled` — флаг отправки логов `cluster-autoscaler`: `true` или `false`.
        * `events_enabled` — флаг отправки событий {{ k8s }}: `true` или `false`.
        * `audit_enabled` — флаг отправки событий аудита: `true` или `false`.

        Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором создан конфигурационный файл.
        
     1. Выполните проверку с помощью команды:
        
        ```bash
        terraform plan
        ```
     
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. Это проверочный этап: ресурсы не будут созданы.

  1. Создайте кластер {{ managed-k8s-name }}.

     1. Если в конфигурации нет ошибок, выполните команду:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите создание ресурсов.
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на создание и изменение кластера {{ managed-k8s-name }} 30 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_cluster" "<имя_кластера>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Чтобы создать кластер {{ managed-k8s-name }}, воспользуйтесь методом REST API [create](../../managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../../managed-kubernetes/api-ref/grpc/Cluster/create.md).

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Тело запроса зависит от [типа мастера](../../concepts/index.md#master):

  * Для базового мастера передайте в запросе один параметр `masterSpec.locations`.
  * Для высокодоступного мастера, который размещается в трех зонах доступности, передайте в запросе три параметра `masterSpec.locations`. В каждом из них укажите разные зоны доступности и подсети.
  * Для высокодоступного мастера, который размещается в одной зоне доступности, передайте в запросе три параметра `masterSpec.locations`. В каждом из них укажите одинаковую зону доступности и подсеть.

  {% note warning %}
  
  Не изменяйте и не удаляйте ресурсы {{ vpc-name }}, которые используются кластером {{ managed-k8s-name }}. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
  
  {% endnote %}

  При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
  * [{{ roles-vpc-private-admin }}](../../../vpc/security/index.md#vpc-private-admin)
  * [{{ roles-vpc-user }}](../../../vpc/security/index.md#vpc-user)
  * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
  
  Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [{{ roles-vpc-public-admin }}](../../../vpc/security/index.md#vpc-public-admin).

  При передаче параметра `masterSpec.locations` не нужно указывать параметры `masterSpec.zonalMasterSpec` или `masterSpec.regionalMasterSpec`.

  Чтобы задать конфигурацию [вычислительных ресурсов мастера](../../concepts/index.md#master-resources), передайте ее значение в параметре `masterSpec.scalePolicy.autoScale.minResourcePresetId`.

  Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

  {% note info %}

  Если не передать параметр `masterSpec.scalePolicy`, то будет применена минимально доступная конфигурация мастера.

  _По умолчанию_ для работы одного хоста мастера предоставляются следующие ресурсы:
  * [платформа](../../../compute/concepts/vm-platforms.md) — Intel Cascade Lake;
  * гарантированная доля vCPU — 100%;
  * количество vCPU — 2;
  * объем RAM — 8 ГБ.

  {% endnote %}

  Чтобы использовать для защиты секретов [ключ шифрования {{ kms-full-name }}](../../concepts/encryption.md), передайте его идентификатор в параметре `kmsProvider.keyId`.

  Чтобы включить отправку логов в [{{ cloud-logging-full-name }}](../../../logging/index.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [{{ roles-logging-writer }}](../../../logging/security/index.md#loggingwriter) и передайте настройки отправки в параметре `masterSpec.masterLogging`.

  Чтобы добавить [облачную метку](../../concepts/index.md#cluster-labels), передайте ее имя и значение в параметре `labels`.

{% endlist %}

## Примеры {#examples}

### Создание кластера {{ managed-k8s-name }} с базовым мастером {#example-single-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ managed-k8s-name }} с тестовыми характеристиками:

  * Название — `k8s-single`.
  * Сеть — `mynet`.
  * Зона доступности — `{{ region-id }}-a`.
  * Подсеть — `mysubnet`.
  * Сервисный аккаунт — `myaccount`.
  * Идентификатор группы безопасности — `{{ security-group }}`.

  Чтобы создать кластер {{ managed-k8s-name }} с базовым мастером, выполните команду:

  ```bash
  {{ yc-k8s }} cluster create \
     --name k8s-single \
     --network-name mynet \
     --master-location zone={{ region-id }}-a,subnet-name=mysubnet \
     --service-account-name myaccount \
     --node-service-account-name myaccount \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Создайте кластер {{ managed-k8s-name }} и сеть для него с тестовыми характеристиками:

  * Название — `k8s-single`.
  * Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) — `{{ tf-folder-id }}`.
  * Сеть — `mynet`.
  * Подсеть — `mysubnet`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-a`.
    * Диапазон — `10.1.0.0/16`.

  * Сервисный аккаунт — `myaccount`.
  * [Роли](../../../iam/concepts/access-control/roles.md) сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * [Ключ шифрования](../../concepts/encryption.md) {{ kms-full-name }} — `kms-key`.
  * Группа безопасности — `k8s-public-services`. Она содержит [правила для подключения к сервисам из интернета](../connect/security-groups.md#rules-nodes).

  Установите {{ TF }} (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-single" {
    name = "k8s-single"
    network_id = yandex_vpc_network.mynet.id
    master {
      master_location {
        zone      = yandex_vpc_subnet.mysubnet.zone
        subnet_id = yandex_vpc_subnet.mysubnet.id
      }
      security_group_ids = [yandex_vpc_security_group.k8s-public-services.id]
    }
    service_account_id      = yandex_iam_service_account.myaccount.id
    node_service_account_id = yandex_iam_service_account.myaccount.id
    depends_on = [
      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
      yandex_resourcemanager_folder_iam_member.images-puller,
      yandex_resourcemanager_folder_iam_member.encrypterDecrypter
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name = "mysubnet"
    v4_cidr_blocks = ["10.1.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = "myaccount"
    description = "Service account for the single Kubernetes cluster"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
    # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
    folder_id = local.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ {{ kms-full-name }} для шифрования важной информации, такой как пароли и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_vpc_security_group" "k8s-public-services" {
    name        = "k8s-public-services"
    description = "Правила группы разрешают подключение к сервисам из интернета. Примените правила только для групп узлов."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера {{ managed-k8s-name }} и сервисов балансировщика."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера {{ managed-k8s-name }} и сервисов."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub и т. д."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

### Создание кластера {{ managed-k8s-name }} с высокодоступным мастером в трех зонах доступности {#example-ha-cluster-three-zones}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ managed-k8s-name }} с тестовыми характеристиками:
  * Название — `k8s-ha-three-zones`.
  * Сеть — `my-ha-net`.
  * Подсеть для зоны доступности `{{ region-id }}-a` — `mysubnet-a`.
  * Подсеть для зоны доступности `{{ region-id }}-b` — `mysubnet-b`.
  * Подсеть для зоны доступности `{{ region-id }}-d` — `mysubnet-d`.
  * Сервисный аккаунт — `ha-k8s-account`.
  * Идентификатор группы безопасности — `{{ security-group }}`.

  Чтобы создать кластер {{ managed-k8s-name }} с высокодоступным мастером в трех зонах доступности, выполните команду:

  ```bash
  {{ yc-k8s }} cluster create \
     --name k8s-ha-three-zones \
     --network-name my-ha-net \
     --master-location zone={{ region-id }}-a,subnet-name=mysubnet-a \
     --master-location zone={{ region-id }}-b,subnet-name=mysubnet-b \
     --master-location zone={{ region-id }}-d,subnet-name=mysubnet-d \
     --service-account-name ha-k8s-account \
     --node-service-account-name ha-k8s-account \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Создайте кластер {{ managed-k8s-name }} и сеть для него с тестовыми характеристиками:

  * Название — `k8s-ha-three-zones`.
  * Идентификатор каталога — `{{ tf-folder-id }}`.
  * Сеть — `my-ha-net`.
  * Подсеть — `mysubnet-a`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-a`.
    * Диапазон — `10.5.0.0/16`.

  * Подсеть — `mysubnet-b`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-b`.
    * Диапазон — `10.6.0.0/16`.

  * Подсеть — `mysubnet-d`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-d`.
    * Диапазон — `10.7.0.0/16`.

  * Сервисный аккаунт — `ha-k8s-account`.
  * Роли сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * [Ключ шифрования](../../concepts/encryption.md) {{ kms-full-name }} — `kms-key`.
  * Группа безопасности — `regional-k8s-sg`. Она содержит [правила для служебного трафика](../connect/security-groups.md#rules-internal).

  Установите {{ TF }} (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-ha-three-zones" {
    name = "k8s-ha-three-zones"
    network_id = yandex_vpc_network.my-ha-net.id
    master {
      master_location {
        zone      = yandex_vpc_subnet.mysubnet-a.zone
        subnet_id = yandex_vpc_subnet.mysubnet-a.id
      }
      master_location {
        zone      = yandex_vpc_subnet.mysubnet-b.zone
        subnet_id = yandex_vpc_subnet.mysubnet-b.id
      }
      master_location {
        zone      = yandex_vpc_subnet.mysubnet-d.zone
        subnet_id = yandex_vpc_subnet.mysubnet-d.id
      }
      security_group_ids = [yandex_vpc_security_group.ha-k8s-sg.id]
    }
    service_account_id      = yandex_iam_service_account.ha-k8s-account.id
    node_service_account_id = yandex_iam_service_account.ha-k8s-account.id
    depends_on = [
      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
      yandex_resourcemanager_folder_iam_member.images-puller,
      yandex_resourcemanager_folder_iam_member.encrypterDecrypter
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "my-ha-net" {
    name = "my-ha-net"
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    name = "mysubnet-a"
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-b" {
    name = "mysubnet-b"
    v4_cidr_blocks = ["10.6.0.0/16"]
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-d" {
    name = "mysubnet-d"
    v4_cidr_blocks = ["10.7.0.0/16"]
    zone           = "{{ region-id }}-d"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_iam_service_account" "ha-k8s-account" {
    name        = "ha-k8s-account"
    description = "Service account for the highly available Kubernetes cluster"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
    # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
    folder_id = local.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ {{ kms-full-name }} для шифрования важной информации, такой как пароли и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_vpc_security_group" "ha-k8s-sg" {
    name        = "ha-k8s-sg"
    description = "Правила группы обеспечивают базовую работоспособность кластера {{ managed-k8s-name }}. Примените ее к кластеру и группам узлов."
    network_id  = yandex_vpc_network.my-ha-net.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера {{ managed-k8s-name }} и сервисов балансировщика."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера {{ managed-k8s-name }} и сервисов."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-d.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub и т. д."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

### Создание кластера {{ managed-k8s-name }} с высокодоступным мастером в одной зоне доступности {#example-ha-cluster-one-zone}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ managed-k8s-name }} с тестовыми характеристиками:

  * Название — `k8s-ha-one-zone`.
  * Сеть — `my-ha-net`.
  * Подсеть для зоны доступности `{{ region-id }}-a` — `my-ha-subnet`.
  * Количество одинаковых параметров `--master-location` — три. Так создается три экземпляра мастера в одной зоне доступности.
  * Зона доступности — `{{ region-id }}-a`.
  * Сервисный аккаунт — `ha-k8s-account`.
  * Идентификатор группы безопасности — `{{ security-group }}`.

  Чтобы создать кластер {{ managed-k8s-name }} с высокодоступным мастером в одной зоне доступности, выполните команду:

  ```bash
  {{ yc-k8s }} cluster create \
     --name k8s-ha-one-zone \
     --network-name my-ha-net \
     --master-location zone={{ region-id }}-a,subnet-name=my-ha-subnet \
     --master-location zone={{ region-id }}-a,subnet-name=my-ha-subnet \
     --master-location zone={{ region-id }}-a,subnet-name=my-ha-subnet \
     --service-account-name ha-k8s-account \
     --node-service-account-name ha-k8s-account \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Создайте кластер {{ managed-k8s-name }} и сеть для него с тестовыми характеристиками:

  * Название — `k8s-ha-one-zone`.
  * Идентификатор каталога — `{{ tf-folder-id }}`.
  * Сеть — `my-ha-net`.
  * Подсеть — `my-ha-subnet`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-a`.
    * Диапазон — `10.5.0.0/16`.

  * Сервисный аккаунт — `ha-k8s-account`.
  * Роли сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * Ключ шифрования {{ kms-full-name }} — `kms-key`.
  * Группа безопасности — `ha-k8s-sg`. Она содержит [правила для служебного трафика](../connect/security-groups.md#rules-internal).

  Установите {{ TF }} (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-ha-one-zone" {
    name = "k8s-ha-one-zone"
    network_id = yandex_vpc_network.my-ha-net.id
    master {
      master_location {
        zone      = yandex_vpc_subnet.my-ha-subnet.zone
        subnet_id = yandex_vpc_subnet.my-ha-subnet.id
      }
      master_location {
        zone      = yandex_vpc_subnet.my-ha-subnet.zone
        subnet_id = yandex_vpc_subnet.my-ha-subnet.id
      }
      master_location {
        zone      = yandex_vpc_subnet.my-ha-subnet.zone
        subnet_id = yandex_vpc_subnet.my-ha-subnet.id
      }
      security_group_ids = [yandex_vpc_security_group.ha-k8s-sg.id]
    }
    service_account_id      = yandex_iam_service_account.ha-k8s-account.id
    node_service_account_id = yandex_iam_service_account.ha-k8s-account.id
    depends_on = [
      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
      yandex_resourcemanager_folder_iam_member.images-puller,
      yandex_resourcemanager_folder_iam_member.encrypterDecrypter
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "my-ha-net" {
    name = "my-ha-net"
  }

  resource "yandex_vpc_subnet" "my-ha-subnet" {
    name = "my-ha-subnet"
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_iam_service_account" "ha-k8s-account" {
    name        = "ha-k8s-account"
    description = "Service account for the highly available Kubernetes cluster"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
    # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
    folder_id = local.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ {{ kms-full-name }} для шифрования важной информации, такой как пароли и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_vpc_security_group" "ha-k8s-sg" {
    name        = "ha-k8s-sg"
    description = "Правила группы обеспечивают базовую работоспособность кластера {{ managed-k8s-name }}. Примените ее к кластеру и группам узлов."
    network_id  = yandex_vpc_network.my-ha-net.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера {{ managed-k8s-name }} и сервисов балансировщика."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера {{ managed-k8s-name }} и сервисов."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.my-ha-subnet.v4_cidr_blocks, yandex_vpc_subnet.my-ha-subnet.v4_cidr_blocks, yandex_vpc_subnet.my-ha-subnet.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub и т. д."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

## См. также {#see-also}

[Обзор способов подключения к кластеру](../connect/index.md)