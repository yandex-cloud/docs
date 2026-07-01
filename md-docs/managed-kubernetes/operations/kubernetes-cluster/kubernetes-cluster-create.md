# Создание кластера Managed Service for Kubernetes


Создайте [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), а затем [создайте группу узлов](../node-group/node-group-create.md).

Если вы хотите создать кластер без доступа в интернет, обратитесь к разделу [Создание и настройка кластера Kubernetes без доступа в интернет](../../tutorials/k8s-cluster-with-no-internet.md).

## Перед началом работы {#before-you-begin}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
  1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).
  1. Если у вас еще нет [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../../resource-manager/operations/folder/create.md).
  1. Убедитесь, что у [аккаунта](../../../iam/concepts/users/accounts.md), с помощью которого вы собираетесь создавать кластер Managed Service for Kubernetes, есть [необходимые для этого роли](../../security/index.md#required-roles).
  1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md).
  1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер Managed Service for Kubernetes и [группа узлов](../../concepts/index.md#node-group).
  1. Создайте [сервисные аккаунты](../../../iam/operations/sa/create.md):
      * Сервисный аккаунт с [ролями](../../security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на каталог, в котором создается кластер Managed Service for Kubernetes. От его имени будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes.
      * Сервисный аккаунт с ролью [container-registry.images.puller](../../../container-registry/security/index.md#container-registry-images-puller) на каталог с реестром [Docker-образов](../../../container-registry/concepts/docker-image.md) в [Yandex Container Registry](../../../container-registry/concepts/index.md). От его имени узлы будут скачивать из реестра необходимые Docker-образы.

        Если вы хотите использовать реестр [Docker-образов](../../../cloud-registry/concepts/artifacts/docker.md) в [Yandex Cloud Registry](../../../cloud-registry/concepts/index.md), назначьте сервисному аккаунту роль [cloud-registry.artifacts.puller](../../../cloud-registry/security/index.md#cloud-registry-artifacts-puller).

      Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

      {% note info %}
      
      Для создания кластера с [туннельным режимом](../../concepts/network-policy.md#cilium) его сервисному аккаунту необходима роль `k8s.tunnelClusters.agent`.
      
      {% endnote %}

  1. [Создайте и настройте нужные группы безопасности](../connect/security-groups.md).

  1. Изучите [рекомендации по использованию Managed Service for Kubernetes](../../concepts/usage-recommendations.md).

{% endlist %}

## Создайте кластер Managed Service for Kubernetes {#kubernetes-cluster-create}

{% note warning %}

С 18 июня 2026 года тарификация мастеров изменилась — плата взимается за количество vCPU и объем RAM мастера, выбранные при [создании](kubernetes-cluster-create.md) или [изменении](kubernetes-cluster-update.md#manage-resources) кластера. Чтобы рассчитать необходимое количество ресурсов мастера для своего кластера, воспользуйтесь таблицей [Рекомендуемые конфигурации мастера](../../concepts/master-configuration.md).

{% endnote %}

{% note warning %}

Начиная с Kubernetes версии 1.30 во всех [релизных каналах](../../concepts/release-channels-and-updates.md) базовый образ узлов кластера Managed Service for Kubernetes изменен с Ubuntu 20.04 на Ubuntu 22.04. В существующих кластерах и группах узлов версия операционной системы будет повышена в соответствии с выбранным способом обновления.

Особенности и рекомендации по обновлению ОС приведены в разделе [Обновление операционной системы в группе узлов](../../concepts/node-os-update.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster).
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя и описание кластера Managed Service for Kubernetes. Имя кластера Managed Service for Kubernetes должно быть уникальным в рамках Yandex Cloud.
  1. Укажите **Сервисный аккаунт для ресурсов**, который будет использоваться для создания ресурсов.
  1. Укажите **Сервисный аккаунт для узлов**, который будет использоваться [узлами Managed Service for Kubernetes](../../concepts/index.md#node-group) для доступа к реестру [Docker-образов](../../../container-registry/concepts/docker-image.md) в Yandex Container Registry.
  1. (Опционально) Укажите **Ключ шифрования**, который будет использоваться для [шифрования секретов](../../concepts/encryption.md).
  
     Эту настройку невозможно изменить после создания кластера.
  
  1. Укажите [релизный канал](../../concepts/release-channels-and-updates.md).
  
     Эту настройку невозможно изменить после создания кластера.
  
  1. В поле **Метки** добавьте [облачные метки](../../concepts/index.md#cluster-labels).
  
  1. В блоке **Конфигурация мастера**:
     * (Опционально) Раскройте секцию **Вычислительные ресурсы** и выберите [конфигурацию ресурсов](../../concepts/index.md#master-resources) для мастера.
  
       Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.
  
       _По умолчанию_ для работы одного хоста мастера предоставляются следующие ресурсы:
       * [платформа](../../../compute/concepts/vm-platforms.md) — Intel Cascade Lake;
       * гарантированная доля vCPU — 100%;
       * количество vCPU — 2;
       * объем RAM — 8 ГБ.
  
     * В поле **Версия Kubernetes** выберите версию Kubernetes, которая будет установлена на [мастере Managed Service for Kubernetes](../../concepts/index.md#master).
     * В поле **Публичный адрес** выберите способ назначения [IP-адреса](../../../vpc/concepts/address.md):
       * `Автоматически` — чтобы назначить случайный IP-адрес из пула IP-адресов Yandex Cloud.
       * `Без адреса` — чтобы не назначать публичный IP-адрес.
  
       {% note warning %}
       
       Не размещайте кластер с публичным IP-адресом в подсетях, в которых доступ в интернет обеспечивается через [NAT-инстанс](../../../tutorials/routing/nat-instance/index.md). При такой конфигурации ответ на запрос к публичному IP-адресу кластера придет с IP-адреса NAT-инстанса и будет отклонен клиентом. Подробнее смотрите [Приоритет маршрутов в сложных сценариях](../../../vpc/concepts/routing.md#priority).
       
       {% endnote %}
  
       Эту настройку невозможно изменить после создания кластера.
  
     * В поле **Тип мастера** выберите тип мастера Managed Service for Kubernetes:
       * `Базовый` — содержит один хост мастера в одной зоне доступности. Чаще всего такой мастер дешевле, но не гарантирует высокую доступность.
  
       * `Высокодоступный` — содержит три хоста мастера.
  
     * В поле **Облачная сеть** выберите [сеть](../../../vpc/concepts/network.md#network), в которой будет создан мастер Managed Service for Kubernetes. Если сети нет, [создайте ее](../../../vpc/operations/network-create.md).
  
        При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
        * [vpc.privateAdmin](../../../vpc/security/index.md#vpc-private-admin)
        * [vpc.user](../../../vpc/security/index.md#vpc-user)
        * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
        
        Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin).
  
        {% note warning %}
        
        Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
        
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
  
     * Выберите [группы безопасности](../../../vpc/concepts/security-groups.md) для сетевого трафика кластера Managed Service for Kubernetes.
  
       {% note warning %}
       
       От [настройки групп безопасности](../connect/security-groups.md) зависит работоспособность и доступность кластера, а также запущенных в нем сервисов.
       
       {% endnote %}
  
  1. В блоке **Настройки окна обновлений**:
     * В поле **Частота обновлений / Отключение** настройте окно для обновлений:
       * `Отключено` — отключение автоматических обновлений.
       * `В любое время` — обновления разрешены в любое время.
       * `Ежедневно` — обновления будут происходить во временном интервале, указанном в поле **Начало окна обновления в UTC**.
       * `В выбранные дни` — обновления будут происходить во временном интервале, указанном в поле **Расписание по дням**.
  1. В блоке **Сетевые настройки кластера**:
     * (Опционально) Выберите [контроллер сетевых политик](../../concepts/network-policy.md#policy-controllers):
  
       Эту настройку невозможно изменить после создания кластера.
  
       {% note warning %}
       
       Нельзя одновременно включить контроллер сетевых политик Calico и туннельный режим Cilium.
       
       {% endnote %}
  
       * **Сalico CNI**, чтобы задействовать Calico.
       * **Сilium CNI**, чтобы задействовать Cilium.
  
     * Укажите **CIDR кластера** — диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](../../concepts/index.md#pod).
     * Укажите **CIDR сервисов** — диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../concepts/index.md#service).
     * Задайте маску подсети узлов Managed Service for Kubernetes и максимальное количество подов в узле.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать кластер Managed Service for Kubernetes:

  1. Укажите параметры кластера Managed Service for Kubernetes в команде создания (в примере приведены не все параметры):

     ```bash
     yc managed-kubernetes cluster create \
       --name <имя_кластера> \
       --network-name <имя_сети> \
       --public-ip \
       --release-channel <релизный_канал:_rapid,_regular_или_stable> \
       --version <версия_Kubernetes> \
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

     * `--name` — имя кластера Managed Service for Kubernetes.
     * `--network-name` — имя [сети](../../../vpc/concepts/network.md#network).

        При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
        * [vpc.privateAdmin](../../../vpc/security/index.md#vpc-private-admin)
        * [vpc.user](../../../vpc/security/index.md#vpc-user)
        * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
        
        Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin).

        {% note warning %}
        
        Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
        
        {% endnote %}

     * `--public-ip` — флаг, который указывает, если кластеру Managed Service for Kubernetes требуется [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).

       {% note warning %}
       
       Не размещайте кластер с публичным IP-адресом в подсетях, в которых доступ в интернет обеспечивается через [NAT-инстанс](../../../tutorials/routing/nat-instance/index.md). При такой конфигурации ответ на запрос к публичному IP-адресу кластера придет с IP-адреса NAT-инстанса и будет отклонен клиентом. Подробнее смотрите [Приоритет маршрутов в сложных сценариях](../../../vpc/concepts/routing.md#priority).
       
       {% endnote %}

       Эту настройку невозможно изменить после создания кластера.

     * `--release-channel` — [релизный канал](../../concepts/release-channels-and-updates.md#release-channels).

       Эту настройку невозможно изменить после создания кластера.

     * `--version` — версия Kubernetes. Укажите версию, доступную для выбранного релизного канала.
     * `--cluster-ipv4-range` — диапазон [IP-адресов](../../../vpc/concepts/address.md), из которого будут выделяться IP-адреса для [подов](../../concepts/index.md#pod).
     * `--service-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../concepts/index.md#service).
     * `--security-group-ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/security-groups.md) кластера Managed Service for Kubernetes.

       {% note warning %}
       
       От [настройки групп безопасности](../connect/security-groups.md) зависит работоспособность и доступность кластера, а также запущенных в нем сервисов.
       
       {% endnote %}

     * `--service-account-id` — уникальный идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes.
     * `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для [узлов](../../concepts/index.md#node-group). От его имени узлы будут скачивать из [реестра](../../../container-registry/concepts/registry.md) Yandex Container Registry необходимые [Docker-образы](../../../container-registry/concepts/docker-image.md).
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

      * Чтобы включить [контроллер сетевых политик](../../concepts/network-policy.md#calico) Calico, передайте в команде создания кластера Managed Service for Kubernetes флаг `--enable-network-policy`:

        ```bash
        yc managed-kubernetes cluster create \
        ...
          --enable-network-policy
        ```

      * Чтобы включить [туннельный режим](../../concepts/network-policy.md#cilium) Cilium, передайте в команде создания кластера Managed Service for Kubernetes флаг `--cilium`:

        ```bash
        yc managed-kubernetes cluster create \
        ...
          --cilium
        ```

  1. Чтобы использовать [ключ шифрования Yandex Key Management Service](../../concepts/encryption.md) для защиты конфиденциальной информации, передайте в команде создания кластера Managed Service for Kubernetes его имя или идентификатор:

     ```bash
     yc managed-kubernetes cluster create \
     ...
       --kms-key-name <имя_ключа_шифрования> \
       --kms-key-id <идентификатор_ключа_шифрования>
     ```

     Эту настройку невозможно изменить после создания кластера.

  1. Чтобы включить отправку логов в [Yandex Cloud Logging](../../../logging/index.md):

     1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [logging.writer](../../../logging/security/index.md#loggingwriter).
     1. Передайте настройки отправки в команде создания кластера, в параметре `--master-logging`:

        ```bash
        yc managed-kubernetes cluster create \
        ...
          --master-logging enabled=<отправка_логов:_true_или_false>,`
            `log-group-id=<идентификатор_лог-группы>,`
            `folder-id=<идентификатор_каталога>,`
            `kube-apiserver-enabled=<отправка_логов_kube-apiserver:_true_или_false>,`
            `cluster-autoscaler-enabled=<отправка_логов_cluster-autoscaler:_true_или_false>,`
            `events-enabled=<отправка_событий_Kubernetes:_true_или_false>
            `audit-enabled=<отправка_событий_аудита>
        ```

        Где:

        * `enabled` — флаг отправки логов: `true` или `false`.
        * `log-group-id` — идентификатор [лог-группы](../../../logging/concepts/log-group.md), в которую нужно отправлять логи.
        * `folder-id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
        * `kube-apiserver-enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/): `true` или `false`.
        * `cluster-autoscaler-enabled` — флаг отправки логов `cluster-autoscaler`: `true` или `false`.
        * `events-enabled` — флаг отправки событий Kubernetes: `true` или `false`.
        * `audit-enabled` — флаг отправки событий аудита: `true` или `false`.

        Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы создать кластер Managed Service for Kubernetes:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер Managed Service for Kubernetes — описание кластера.
     * [Сеть](../../../vpc/concepts/network.md#network) — описание облачной сети, в которой будет расположен кластер Managed Service for Kubernetes. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

        При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
        * [vpc.privateAdmin](../../../vpc/security/index.md#vpc-private-admin)
        * [vpc.user](../../../vpc/security/index.md#vpc-user)
        * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
        
        Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin).

     * [Подсети](../../../vpc/concepts/network.md#subnet) — описание подсетей, к которым будут подключены хосты кластера Managed Service for Kubernetes. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

         {% note warning %}
         
         Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
         
         {% endnote %}

     * [Сервисный аккаунт](#before-you-begin) для кластера Managed Service for Kubernetes и [узлов](../../concepts/index.md#node-group) и [настройки роли](../../../terraform/resources/resourcemanager_folder_iam_member.md) для этого аккаунта. При необходимости создайте отдельные [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для кластера Managed Service for Kubernetes и узлов. Если у вас уже есть подходящий сервисный аккаунт, описывать его повторно не нужно.

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

     Облачные метки для кластера Kubernetes составляются по определенным [правилам](../../concepts/index.md#cluster-labels).

     {% endnote %}

     Чтобы задать конфигурацию [вычислительных ресурсов мастера](../../concepts/index.md#master-resources), добавьте к описанию кластера Managed Service for Kubernetes блок:

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

     Чтобы включить [туннельный режим](../../concepts/network-policy.md#cilium) Cilium, добавьте к описанию кластера Managed Service for Kubernetes блок:

     ```hcl
     network_implementation {
      cilium {}
     }
     ```

     Чтобы включить [контроллер сетевых политик](../../concepts/network-policy.md#calico) Calico, добавьте к описанию кластера Managed Service for Kubernetes строку:

     ```hcl
     network_policy_provider = "CALICO"
     ```

     {% note warning %}

     Контроллер сетевых политик Calico и туннельный режим Cilium нельзя включить одновременно. Их также нельзя включить после создания кластера.

     {% endnote %}

     Чтобы включить отправку логов в [Yandex Cloud Logging](../../../logging/index.md):

     1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [logging.writer](../../../logging/security/index.md#loggingwriter).
     1. Добавьте к описанию кластера Managed Service for Kubernetes блок `master_logging`:

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
        >      events_enabled             = <отправка_событий_Kubernetes>
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
        * `events_enabled` — флаг отправки событий Kubernetes: `true` или `false`.
        * `audit_enabled` — флаг отправки событий аудита: `true` или `false`.

        Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

     Подробнее в [документации провайдера Terraform](../../../terraform/resources/kubernetes_cluster.md).
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором создан конфигурационный файл.
        
     1. Выполните проверку с помощью команды:
        
        ```bash
        terraform plan
        ```
     
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. Это проверочный этап: ресурсы не будут созданы.

  1. Создайте кластер Managed Service for Kubernetes.

     1. Если в конфигурации нет ошибок, выполните команду:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите создание ресурсов.
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на создание и изменение кластера Managed Service for Kubernetes 30 минутами.
     
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

  Чтобы создать кластер Managed Service for Kubernetes, воспользуйтесь методом REST API [create](../../managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../../managed-kubernetes/api-ref/grpc/Cluster/create.md).

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Тело запроса зависит от [типа мастера](../../concepts/index.md#master):

  * Для базового мастера передайте в запросе один параметр `masterSpec.locations`.
  * Для высокодоступного мастера, который размещается в трех зонах доступности, передайте в запросе три параметра `masterSpec.locations`. В каждом из них укажите разные зоны доступности и подсети.
  * Для высокодоступного мастера, который размещается в одной зоне доступности, передайте в запросе три параметра `masterSpec.locations`. В каждом из них укажите одинаковую зону доступности и подсеть.

  {% note warning %}
  
  Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
  
  {% endnote %}

  При выборе [облачной сети](../../../vpc/concepts/network.md#network) из другого [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../../iam/concepts/access-control/roles.md) в этом каталоге:
  * [vpc.privateAdmin](../../../vpc/security/index.md#vpc-private-admin)
  * [vpc.user](../../../vpc/security/index.md#vpc-user)
  * [vpc.bridgeAdmin](../../../vpc/security/index.md#vpc-bridge-admin)
  
  Для использования [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) роль [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin).

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

  Чтобы использовать для защиты секретов [ключ шифрования Yandex Key Management Service](../../concepts/encryption.md), передайте его идентификатор в параметре `kmsProvider.keyId`.

  Чтобы включить отправку логов в [Yandex Cloud Logging](../../../logging/index.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [logging.writer](../../../logging/security/index.md#loggingwriter) и передайте настройки отправки в параметре `masterSpec.masterLogging`.

  Чтобы добавить [облачную метку](../../concepts/index.md#cluster-labels), передайте ее имя и значение в параметре `labels`.

{% endlist %}

## Примеры {#examples}

### Создание кластера Managed Service for Kubernetes с базовым мастером {#example-single-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер Managed Service for Kubernetes с тестовыми характеристиками:

  * Название — `k8s-single`.
  * Сеть — `mynet`.
  * Зона доступности — `ru-central1-a`.
  * Подсеть — `mysubnet`.
  * Сервисный аккаунт — `myaccount`.
  * Идентификатор группы безопасности — `enp6saqnq4ie********`.

  Чтобы создать кластер Managed Service for Kubernetes с базовым мастером, выполните команду:

  ```bash
  yc managed-kubernetes cluster create \
     --name k8s-single \
     --network-name mynet \
     --master-location zone=ru-central1-a,subnet-name=mysubnet \
     --service-account-name myaccount \
     --node-service-account-name myaccount \
     --security-group-ids enp6saqnq4ie********
  ```

- Terraform {#tf}

  Создайте кластер Managed Service for Kubernetes и сеть для него с тестовыми характеристиками:

  * Название — `k8s-single`.
  * Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) — `b1gia87mbaom********`.
  * Сеть — `mynet`.
  * Подсеть — `mysubnet`. Ее сетевые настройки:

    * Зона доступности — `ru-central1-a`.
    * Диапазон — `10.1.0.0/16`.

  * Сервисный аккаунт — `myaccount`.
  * [Роли](../../../iam/concepts/access-control/roles.md) сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * [Ключ шифрования](../../concepts/encryption.md) Yandex Key Management Service — `kms-key`.
  * Группа безопасности — `k8s-public-services`. Она содержит [правила для подключения к сервисам из интернета](../connect/security-groups.md#rules-nodes).

  Установите Terraform (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  ```hcl
  locals {
    folder_id   = "b1gia87mbaom********"
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
    zone           = "ru-central1-a"
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
    # Ключ Yandex Key Management Service для шифрования важной информации, такой как пароли и SSH-ключи.
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
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера Managed Service for Kubernetes и сервисов балансировщика."
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
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера Managed Service for Kubernetes и сервисов."
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
      description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

### Создание кластера Managed Service for Kubernetes с высокодоступным мастером в трех зонах доступности {#example-ha-cluster-three-zones}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер Managed Service for Kubernetes с тестовыми характеристиками:
  * Название — `k8s-ha-three-zones`.
  * Сеть — `my-ha-net`.
  * Подсеть для зоны доступности `ru-central1-a` — `mysubnet-a`.
  * Подсеть для зоны доступности `ru-central1-b` — `mysubnet-b`.
  * Подсеть для зоны доступности `ru-central1-d` — `mysubnet-d`.
  * Сервисный аккаунт — `ha-k8s-account`.
  * Идентификатор группы безопасности — `enp6saqnq4ie********`.

  Чтобы создать кластер Managed Service for Kubernetes с высокодоступным мастером в трех зонах доступности, выполните команду:

  ```bash
  yc managed-kubernetes cluster create \
     --name k8s-ha-three-zones \
     --network-name my-ha-net \
     --master-location zone=ru-central1-a,subnet-name=mysubnet-a \
     --master-location zone=ru-central1-b,subnet-name=mysubnet-b \
     --master-location zone=ru-central1-d,subnet-name=mysubnet-d \
     --service-account-name ha-k8s-account \
     --node-service-account-name ha-k8s-account \
     --security-group-ids enp6saqnq4ie********
  ```

- Terraform {#tf}

  Создайте кластер Managed Service for Kubernetes и сеть для него с тестовыми характеристиками:

  * Название — `k8s-ha-three-zones`.
  * Идентификатор каталога — `b1gia87mbaom********`.
  * Сеть — `my-ha-net`.
  * Подсеть — `mysubnet-a`. Ее сетевые настройки:

    * Зона доступности — `ru-central1-a`.
    * Диапазон — `10.5.0.0/16`.

  * Подсеть — `mysubnet-b`. Ее сетевые настройки:

    * Зона доступности — `ru-central1-b`.
    * Диапазон — `10.6.0.0/16`.

  * Подсеть — `mysubnet-d`. Ее сетевые настройки:

    * Зона доступности — `ru-central1-d`.
    * Диапазон — `10.7.0.0/16`.

  * Сервисный аккаунт — `ha-k8s-account`.
  * Роли сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * [Ключ шифрования](../../concepts/encryption.md) Yandex Key Management Service — `kms-key`.
  * Группа безопасности — `regional-k8s-sg`. Она содержит [правила для служебного трафика](../connect/security-groups.md#rules-internal).

  Установите Terraform (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  ```hcl
  locals {
    folder_id   = "b1gia87mbaom********"
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
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-b" {
    name = "mysubnet-b"
    v4_cidr_blocks = ["10.6.0.0/16"]
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-d" {
    name = "mysubnet-d"
    v4_cidr_blocks = ["10.7.0.0/16"]
    zone           = "ru-central1-d"
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
    # Ключ Yandex Key Management Service для шифрования важной информации, такой как пароли и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_vpc_security_group" "ha-k8s-sg" {
    name        = "ha-k8s-sg"
    description = "Правила группы обеспечивают базовую работоспособность кластера Managed Service for Kubernetes. Примените ее к кластеру и группам узлов."
    network_id  = yandex_vpc_network.my-ha-net.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера Managed Service for Kubernetes и сервисов балансировщика."
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
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера Managed Service for Kubernetes и сервисов."
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
      description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

### Создание кластера Managed Service for Kubernetes с высокодоступным мастером в одной зоне доступности {#example-ha-cluster-one-zone}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер Managed Service for Kubernetes с тестовыми характеристиками:

  * Название — `k8s-ha-one-zone`.
  * Сеть — `my-ha-net`.
  * Подсеть для зоны доступности `ru-central1-a` — `my-ha-subnet`.
  * Количество одинаковых параметров `--master-location` — три. Так создается три экземпляра мастера в одной зоне доступности.
  * Зона доступности — `ru-central1-a`.
  * Сервисный аккаунт — `ha-k8s-account`.
  * Идентификатор группы безопасности — `enp6saqnq4ie********`.

  Чтобы создать кластер Managed Service for Kubernetes с высокодоступным мастером в одной зоне доступности, выполните команду:

  ```bash
  yc managed-kubernetes cluster create \
     --name k8s-ha-one-zone \
     --network-name my-ha-net \
     --master-location zone=ru-central1-a,subnet-name=my-ha-subnet \
     --master-location zone=ru-central1-a,subnet-name=my-ha-subnet \
     --master-location zone=ru-central1-a,subnet-name=my-ha-subnet \
     --service-account-name ha-k8s-account \
     --node-service-account-name ha-k8s-account \
     --security-group-ids enp6saqnq4ie********
  ```

- Terraform {#tf}

  Создайте кластер Managed Service for Kubernetes и сеть для него с тестовыми характеристиками:

  * Название — `k8s-ha-one-zone`.
  * Идентификатор каталога — `b1gia87mbaom********`.
  * Сеть — `my-ha-net`.
  * Подсеть — `my-ha-subnet`. Ее сетевые настройки:

    * Зона доступности — `ru-central1-a`.
    * Диапазон — `10.5.0.0/16`.

  * Сервисный аккаунт — `ha-k8s-account`.
  * Роли сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * Ключ шифрования Yandex Key Management Service — `kms-key`.
  * Группа безопасности — `ha-k8s-sg`. Она содержит [правила для служебного трафика](../connect/security-groups.md#rules-internal).

  Установите Terraform (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  ```hcl
  locals {
    folder_id   = "b1gia87mbaom********"
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
    zone           = "ru-central1-a"
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
    # Ключ Yandex Key Management Service для шифрования важной информации, такой как пароли и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_vpc_security_group" "ha-k8s-sg" {
    name        = "ha-k8s-sg"
    description = "Правила группы обеспечивают базовую работоспособность кластера Managed Service for Kubernetes. Примените ее к кластеру и группам узлов."
    network_id  = yandex_vpc_network.my-ha-net.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера Managed Service for Kubernetes и сервисов балансировщика."
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
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера Managed Service for Kubernetes и сервисов."
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
      description       = "Правило разрешает весь исходящий трафик. Узлы могут связаться с Yandex Container Registry, Yandex Object Storage, Docker Hub и т. д."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

## Полезные ссылки {#see-also}

[Обзор способов подключения к кластеру](../connect/index.md)