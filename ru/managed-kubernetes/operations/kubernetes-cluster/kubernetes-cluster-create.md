# Создание кластера {{ managed-k8s-name }}

Создайте [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), а затем [создайте группу узлов](../node-group/node-group-create.md).

{% include [unable-in-relocated-subnet](../../../_includes/managed-kubernetes/unable-in-relocated-subnet.md) %}

Если вы хотите создать кластер без доступа в интернет, обратитесь к разделу [{#T}](../../tutorials/k8s-cluster-with-no-internet.md).

## Перед началом работы {#before-you-begin}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.

  
  1. На странице [**{{ ui-key.yacloud.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).


  1. Если у вас еще нет [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../../resource-manager/operations/folder/create.md).
  1. Убедитесь, что у [аккаунта](../../../iam/concepts/users/accounts.md), с помощью которого вы собираетесь создавать кластер {{ managed-k8s-name }}, есть [необходимые для этого роли](../../security/index.md#required-roles).
  1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md).
  1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и [группа узлов](../../concepts/index.md#node-group).
  1. Создайте [сервисные аккаунты](../../../iam/operations/sa/create.md):
     * Сервисный аккаунт с [ролью](../../security/index.md#yc-api) `k8s.clusters.agent` на каталог, в котором создается кластер {{ managed-k8s-name }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
     * Сервисный аккаунт с ролью [{{ roles-cr-puller }}](../../../container-registry/security/index.md#choosing-roles) на каталог с [реестром](../../../container-registry/concepts/registry.md) [Docker-образов](../../../container-registry/concepts/docker-image.md). От его имени узлы будут скачивать из реестра необходимые Docker-образы.

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

     {% include [k8s.tunnelClusters.agent role](../../../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}

  1. [Создайте и настройте нужные группы безопасности](../connect/security-groups.md).

  1. Изучите [рекомендации по использованию {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

{% endlist %}

## Создайте кластер {{ managed-k8s-name }} {#kubernetes-cluster-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  1. Укажите параметры кластера {{ managed-k8s-name }} в команде создания (в примере приведены не все параметры):

     ```bash
     {{ yc-k8s }} cluster create \
       --name test-k8s \
       --network-name default \
       --zone {{ region-id }}-a \
       --subnet-name default-a \
       --public-ip \
       --release-channel regular \
       --version 1.13 \
       --cluster-ipv4-range 10.1.0.0/16 \
       --service-ipv4-range 10.2.0.0/16 \
       --security-group-ids enpe5sdn7vs5********,enpj6c5ifh75******** \
       --service-account-name default-sa \
       --node-service-account-name default-sa \
       --daily-maintenance-window start=22:00,duration=10h
     ```

     Где:

     * `--name` — имя кластера {{ managed-k8s-name }}.
     * `--network-name` — имя [сети](../../../vpc/concepts/network.md#network).

        {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

     * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
     * `--subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet).
     * `--public-ip` — флаг, который указывает, если кластеру {{ managed-k8s-name }} требуется [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).
     * `--release-channel` — [релизный канал](../../concepts/release-channels-and-updates.md#release-channels).
     * `--version` — версия {{ k8s }}.
     * `--cluster-ipv4-range` — диапазон [IP-адресов](../../../vpc/concepts/address.md), из которого будут выделяться IP-адреса для [подов](../../concepts/index.md#pod).
     * `--service-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../concepts/index.md#service).
     * `--security-group-ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/security-groups.md) кластера {{ managed-k8s-name }}.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--service-account-id` — уникальный идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
     * `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для [узлов](../../concepts/index.md#node-group). От его имени узлы будут скачивать из [реестра](../../../container-registry/concepts/registry.md) необходимые [Docker-образы](../../../container-registry/concepts/docker-image.md).
     * `--daily-maintenance-window` — настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates).

     Результат:

     ```bash
     done (5m47s)
     id: cathn0s6qobf********
     folder_id: b1g66jflru0e********
     ...
       service_account_id: aje3932acd0c********
       node_service_account_id: aje3932acd0c********
       release_channel: REGULAR
     ```

  1. Чтобы включить [контроллер сетевых политик](../../concepts/network-policy.md) Calico, передайте в команде создания кластера {{ managed-k8s-name }} флаг `--enable-network-policy`:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --enable-network-policy
     ```

  1. Чтобы использовать [ключ шифрования {{ kms-full-name }}](../../concepts/encryption.md) для защиты конфиденциальной информации, передайте в команде создания кластера {{ managed-k8s-name }} его имя или идентификатор:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --kms-key-name <имя_ключа_шифрования> \
       --kms-key-id <идентификатор_ключа_шифрования>
     ```

     {% include [write-once-setting.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

  1. Чтобы включить отправку логов в [{{ cloud-logging-full-name }}](../../../logging/), передайте настройки отправки в команде создания кластера {{ managed-k8s-name }} в параметре `--master-logging`:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --master-logging enabled=<отправка_логов>,`
         `log-group-id=<идентификатор_лог-группы>,`
         `folder-id=<идентификатор_каталога>,`
         `kube-apiserver-enabled=<отправка_логов_kube-apiserver>,`
         `cluster-autoscaler-enabled=<отправка_логов_cluster-autoscaler>,`
         `events-enabled=<отправка_событий_{{ k8s }}>`
         `audit-enabled=<отправка_событий_аудита>
     ```

     Где:

     {% include [master-logging-cli-description.md](../../../_includes/managed-kubernetes/master-logging-cli-description.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ managed-k8s-name }}:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер {{ managed-k8s-name }} — описание кластера.
     * [Сеть](../../../vpc/concepts/network.md#network) — описание облачной сети, в которой будет расположен кластер {{ managed-k8s-name }}. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

        {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

     * [Подсети](../../../vpc/concepts/network.md#subnet) — описание подсетей, к которым будут подключены хосты кластера {{ managed-k8s-name }}. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.
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
     >      yandex_resourcemanager_folder_iam_member.editor,
     >      yandex_resourcemanager_folder_iam_member.images-puller
     >    ]
     > }
     >
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
     >resource "yandex_resourcemanager_folder_iam_member" "editor" {
     >  # Сервисному аккаунту назначается роль "editor".
     >  folder_id = "<идентификатор_каталога>"
     >  role      = "editor"
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

     Чтобы включить отправку логов в [{{ cloud-logging-full-name }}](../../../logging/), добавьте к описанию кластера {{ managed-k8s-name }} блок `master_logging`:

     {% include [master-logging-tf.md](../../../_includes/managed-kubernetes/master-logging-tf.md) %}

     Где:

     {% include [master-logging-tf-description.md](../../../_includes/managed-kubernetes/master-logging-tf-description.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер {{ managed-k8s-name }}.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API {#api}

  Чтобы создать кластер {{ managed-k8s-name }}, воспользуйтесь методом [create](../../api-ref/Cluster/create.md) для ресурса [Cluster](../../api-ref/Cluster).

  {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

  Чтобы использовать для защиты секретов [ключ шифрования {{ kms-full-name }}](../../concepts/encryption.md), передайте его идентификатор в параметре `kmsProvider.keyId`.

  Чтобы включить отправку логов в [{{ cloud-logging-full-name }}](../../../logging/), передайте настройки отправки в параметре `masterSpec.masterLogging`.

{% endlist %}

## Примеры {#examples}

### Создание зонального кластера {{ managed-k8s-name }} {#example-zonal-cluster}

  Создайте кластер {{ managed-k8s-name }} и сеть для него с тестовыми характеристиками:

  * Название — `k8s-zonal`.
  * Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) — `{{ tf-folder-id }}`.
  * Сеть — `mynet`.
  * Подсеть — `mysubnet`. Ее сетевые настройки:

    * [Зона доступности](../../../overview/concepts/geo-scope.md) — `{{ region-id }}-a`.
    * Диапазон — `10.1.0.0/16`.

  * Сервисный аккаунт — `myaccount`.
  * [Роли](../../../iam/concepts/access-control/roles.md) сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * [Ключ шифрования](../../concepts/encryption.md) {{ kms-full-name }} — `kms-key`.
  * [Группа безопасности](../../../vpc/concepts/security-groups.md) — `k8s-public-services`. Она содержит [правила для подключения к сервисам из интернета](../connect/security-groups.md#rules-nodes).

  Установите {{ TF }} (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  
  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-zonal" {
    name = "k8s-zonal"
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
    name        = "zonal-k8s-account"
    description = "K8S zonal service account"
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
    # Ключ {{ kms-full-name }} для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
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

### Создание регионального кластера {{ managed-k8s-name }} {#example-regional-cluster}

  Создайте кластер {{ managed-k8s-name }} и сеть для него с тестовыми характеристиками:

  * Название — `k8s-regional`.
  * Идентификатор каталога — `{{ tf-folder-id }}`.
  * Сеть — `my-regional-net`.
  * Подсеть — `mysubnet-a`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-a`.
    * Диапазон — `10.5.0.0/16`.

  * Подсеть — `mysubnet-b`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-b`.
    * Диапазон — `10.6.0.0/16`.

  * Подсеть — `mysubnet-d`. Ее сетевые настройки:

    * Зона доступности — `{{ region-id }}-d`.
    * Диапазон — `10.7.0.0/16`.

  * Сервисный аккаунт — `regional-k8s-account`.
  * Роли сервисного аккаунта — `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.keys.encrypterDecrypter`.
  * [Ключ шифрования](../../concepts/encryption.md) {{ kms-full-name }} — `kms-key`.
  * Группа безопасности — `regional-k8s-sg`. Она содержит [правила для служебного трафика](../connect/security-groups.md#rules-internal).

  Установите {{ TF }} (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  
  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-regional" {
    name = "k8s-regional"
    network_id = yandex_vpc_network.my-regional-net.id
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
      security_group_ids = [yandex_vpc_security_group.regional-k8s-sg.id]
    }
    service_account_id      = yandex_iam_service_account.my-regional-account.id
    node_service_account_id = yandex_iam_service_account.my-regional-account.id
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

  resource "yandex_vpc_network" "my-regional-net" {
    name = "my-regional-net"
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    name = "mysubnet-a"
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.my-regional-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-b" {
    name = "mysubnet-b"
    v4_cidr_blocks = ["10.6.0.0/16"]
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.my-regional-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-d" {
    name = "mysubnet-d"
    v4_cidr_blocks = ["10.7.0.0/16"]
    zone           = "{{ region-id }}-d"
    network_id     = yandex_vpc_network.my-regional-net.id
  }

  resource "yandex_iam_service_account" "my-regional-account" {
    name        = "regional-k8s-account"
    description = "K8S regional service account"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
    # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
    folder_id = local.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ {{ kms-full-name }} для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_vpc_security_group" "regional-k8s-sg" {
    name        = "regional-k8s-sg"
    description = "Правила группы обеспечивают базовую работоспособность кластера {{ managed-k8s-name }}. Примените ее к кластеру и группам узлов."
    network_id  = yandex_vpc_network.my-regional-net.id
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
