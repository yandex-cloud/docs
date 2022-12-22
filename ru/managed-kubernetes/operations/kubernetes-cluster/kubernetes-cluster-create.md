# Создание кластера {{ k8s }}

Создайте [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster), а затем [создайте группу узлов](../node-group/node-group-create.md).

## Перед началом работы {#before-you-begin}

Чтобы создать кластер {{ k8s }}:

{% list tabs %}

- Консоль управления

  1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.

  {% if product == "yandex-cloud" %}

  1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).

  {% endif %}

  1. Если у вас еще нет [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../../resource-manager/operations/folder/create.md).

  1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

  1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md).
  1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и [группа узлов](../../concepts/index.md#node-group).
  1. Создайте [сервисные аккаунты](../../../iam/operations/sa/create.md):
     * Сервисный аккаунт с ролью [{{ roles-editor }}](../../../resource-manager/security/index.md#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
     * Сервисный аккаунт с ролью [{{ roles-cr-puller }}](../../../container-registry/security/index.md#required-roles) на каталог с [реестром](../../../container-registry/concepts/registry.md) [Docker-образов](../../../container-registry/concepts/docker-image.md). От его имени узлы будут скачивать из реестра необходимые Docker-образы.

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

      {% include [k8s.tunnelClusters.agent role](../../../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}

  1. Создайте нужные [группы безопасности](../connect/security-groups.md).
  1. Изучите [рекомендации по использованию {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

{% endlist %}

## Создайте кластер {{ k8s }} {#kubernetes-cluster-create}

{% list tabs %}

- Консоль управления

  {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

  1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

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
       --security-group-ids enpe5sdn7vs5mu6udl7i,enpj6c5ifh755o6evmu4 \
       --service-account-name default-sa \
       --node-service-account-name default-sa \
       --daily-maintenance-window start=22:00,duration=10h
     ```

     Где:
     * `--name` — имя кластера {{ k8s }}.
     * `--network-name` — имя сети.
     * `--zone` — зона доступности.
     * `--subnet-name` — имя подсети.
     * `--public-ip` — флаг, который указывает, если кластеру {{ k8s }} требуется публичный IP-адрес.
     * `--release-channel` — [релизный канал](../../concepts/release-channels-and-updates.md#release-channels).
     * `--version` — версия {{ k8s }}.
     * `--cluster-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для [подов](../../concepts/index.md#pod).
     * `--service-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для [сервисов](../../concepts/index.md#service).
     * `--security-group-ids` — список идентификаторов групп безопасности кластера.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--service-account-id` — уникальный идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
     * `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
     * `--daily-maintenance-window` — настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates).

     Результат выполнения команды:

     ```bash
     done (5m47s)
     id: cathn0s6qobfa61p3u6k
     folder_id: b1g66jflru0ek1omtsu0
     ...
       service_account_id: aje3932acd0c5ur7gatp
       node_service_account_id: aje3932acd0c5hg8dagp
       release_channel: REGULAR
     ```

  1. Чтобы включить [контроллер сетевых политик](../../concepts/network-policy.md) Calico, передайте в команде создания кластера параметр `--enable-network-policy`:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --enable-network-policy
     ```

  1. Чтобы использовать [ключ шифрования {{ kms-full-name }}](../../concepts/encryption.md) для защиты конфиденциальной информации, передайте в команде создания кластера его имя или идентификатор:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --kms-key-name <имя ключа шифрования> \
       --kms-key-id <идентификатор ключа шифрования>
     ```

     {% include [write-once-setitng.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать кластер:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер {{ k8s }} — описание кластера.
     * Сеть — описание [облачной сети](../../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
     * Подсети — описание [подсетей](../../../vpc/concepts/network.md#subnet), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.
     * [Сервисный аккаунт](#before-you-begin) для кластера и узлов и [настройки роли]({{ tf-provider-link }}/resourcemanager_folder_iam_binding) для этого аккаунта. При необходимости создайте отдельные сервисные аккаунты для кластера и узлов. Если у вас уже есть подходящий сервисный аккаунт, описывать его повторно не нужно.

     >Пример структуры конфигурационного файла:
     >
     >```hcl
     >resource "yandex_kubernetes_cluster" "<имя кластера>" {
     >  network_id = yandex_vpc_network.<имя сети>.id
     >  master {
     >    zonal {
     >      zone      = yandex_vpc_subnet.<имя подсети>.zone
     >      subnet_id = yandex_vpc_subnet.<имя подсети>.id
     >    }
     >  }
     >  service_account_id      = yandex_iam_service_account.<имя сервисного аккаунта>.id
     >  node_service_account_id = yandex_iam_service_account.<имя сервисного аккаунта>.id
     >    depends_on = [
     >      yandex_resourcemanager_folder_iam_binding.editor,
     >      yandex_resourcemanager_folder_iam_binding.images-puller
     >    ]
     > }
     >
     >resource "yandex_vpc_network" "<имя сети>" { name = "<имя сети>" }
     >
     >resource "yandex_vpc_subnet" "<имя подсети>" {
     >  v4_cidr_blocks = ["<диапазон адресов подсети>"]
     >  zone           = "<зона доступности>"
     >  network_id     = yandex_vpc_network.<имя сети>.id
     >}
     >
     >resource "yandex_iam_service_account" "<имя сервисного аккаунта>" {
     >  name        = "<имя сервисного аккаунта>"
     >  description = "<описание сервисного аккаунта>"
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_binding" "editor" {
     >  # Сервисному аккаунту назначается роль "editor".
     >  folder_id = "<идентификатор каталога>"
     >  role      = "editor"
     >  members   = [
     >    "serviceAccount:${yandex_iam_service_account.<имя сервисного аккаунта>.id}"
     >  ]
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
     >  # Сервисному аккаунту назначается роль "container-registry.images.puller".
     >  folder_id = "<идентификатор каталога>"
     >  role      = "container-registry.images.puller"
     >  members   = [
     >    "serviceAccount:${yandex_iam_service_account.<имя сервисного аккаунта>.id}"
     >  ]
     >}
     >```

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

  Чтобы создать кластер {{ k8s }}, воспользуйтесь методом [create](../../api-ref/Cluster/create.md) для ресурса [Cluster](../../api-ref/Cluster).

  Чтобы использовать для защиты секретов [ключ шифрования {{ kms-name }}](../../concepts/encryption.md), передайте его идентификатор в параметре `kmsProvider.keyId`.

{% endlist %}

## Примеры {#examples}

### Создание зонального кластера {#example-zonal-cluster}

{% list tabs %}

- {{ TF }}

  Допустим, нужно создать кластер {{ k8s }} и сеть для него со следующими характеристиками:
  * С именем `k8s-zonal`.
  * Версии `1.22`.
  * В облаке с идентификатором `{{ tf-cloud-id }}`.
  * В каталоге с идентификатором `{{ tf-folder-id }}`.
  * В новой сети `mynet`.
  * В новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.1.0.0/16`.
  * С новым сервисным аккаунтом `myaccount`, имеющим права `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.viewer`.
  * С ключом шифрования {{ kms-name }} `kms-key`.
  * В новой группе безопасности `k8s-public-services`, разрешающей [подключение к сервисам из интернета](../connect/security-groups.md#rules-nodes).
  
  Для этого установите Terraform (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  {% cut "Конфигурационный файл для кластера:" %}

  {% if product == "yandex-cloud" %}

  ```hcl
  locals {
    cloud_id    = "{{ tf-cloud-id }}"
    folder_id   = "{{ tf-folder-id }}"
    k8s_version = "1.22"
    sa_name     = "myaccount"
  }

  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    folder_id = local.folder_id
  }

  resource "yandex_kubernetes_cluster" "k8s-zonal" {
    network_id = yandex_vpc_network.mynet.id
    master {
      version = local.k8s_version
      zonal {
        zone      = yandex_vpc_subnet.mysubnet.zone
        subnet_id = yandex_vpc_subnet.mysubnet.id
      }
      security_group_ids = [yandex_vpc_security_group.k8s-public-services.id]
    }
    service_account_id      = yandex_iam_service_account.myaccount.id
    node_service_account_id = yandex_iam_service_account.myaccount.id
    depends_on = [
      yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
      yandex_resourcemanager_folder_iam_binding.images-puller
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    v4_cidr_blocks = ["10.1.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = local.sa_name
    description = "K8S zonal service account"
  }

  resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
    symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
    role             = "viewer"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}",
    ]
  }

  resource "yandex_vpc_security_group" "k8s-public-services" {
    name        = "k8s-public-services"
    description = "Правила группы разрешают подключение к сервисам из интернета. Примените правила только для групп узлов."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
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
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера и сервисов."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
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

{% endif %}

{% if product == "cloud-il" %}

```hcl
  locals {
    cloud_id    = "{{ tf-cloud-id }}"
    folder_id   = "{{ tf-folder-id }}"
    k8s_version = "1.22"
    sa_name     = "myaccount"
  }

  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    endpoint  = "{{ api-host }}:443"
    folder_id = local.folder_id
  }

  resource "yandex_kubernetes_cluster" "k8s-zonal" {
    network_id = yandex_vpc_network.mynet.id
    master {
      version = local.k8s_version
      zonal {
        zone      = yandex_vpc_subnet.mysubnet.zone
        subnet_id = yandex_vpc_subnet.mysubnet.id
      }
      security_group_ids = [yandex_vpc_security_group.k8s-public-services.id]
    }
    service_account_id      = yandex_iam_service_account.myaccount.id
    node_service_account_id = yandex_iam_service_account.myaccount.id
    depends_on = [
      yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
      yandex_resourcemanager_folder_iam_binding.images-puller
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    v4_cidr_blocks = ["10.1.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = local.sa_name
    description = "K8S zonal service account"
  }

  resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }

  resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
    symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
    role             = "viewer"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}",
    ]
  }

  resource "yandex_vpc_security_group" "k8s-public-services" {
    name        = "k8s-public-services"
    description = "Правила группы разрешают подключение к сервисам из интернета. Примените правила только для групп узлов."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
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
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера и сервисов."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
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

  {% endif %}

  {% endcut %}

{% endlist %}

### Создание регионального кластера {#example-regional-cluster}

{% list tabs %}

- {{ TF }}

  Допустим, нужно создать кластер {{ k8s }} и сеть для него со следующими характеристиками:
  * С именем `k8s-regional`.
  * Версии `1.22`.
  * В облаке с идентификатором `{{ tf-cloud-id }}`.
  * В каталоге с идентификатором `{{ tf-folder-id }}`.
  * В новой сети `mynet` с новыми подсетями:
    * `mysubnet-a` в зоне доступности {{ region-id }}-a с диапазоном `10.5.0.0/16`.
    * `mysubnet-b` в зоне доступности {{ region-id }}-b с диапазоном `10.6.0.0/16`.
    * `mysubnet-c` в зоне доступности {{ region-id }}-c с диапазоном `10.7.0.0/16`.
  * С новым сервисным аккаунтом `myaccount`, имеющим права `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `kms.viewer`.
  * С ключом шифрования {{ kms-name }} `kms-key`.
  * В новой группе безопасности `k8s-main-sg`, содержащей [правила для служебного трафика](../connect/security-groups.md#rules-internal).

  Для этого установите Terraform (если он еще не установлен) и настройте провайдер по [инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), а затем примените конфигурационный файл:

  {% cut "Конфигурационный файл для кластера:" %}

  {% if product == "yandex-cloud" %}

  ```hcl
  locals {
    cloud_id    = "{{ tf-cloud-id }}"
    folder_id   = "{{ tf-folder-id }}"
    k8s_version = "1.22"
    sa_name     = "myaccount"
  }

  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    folder_id = local.folder_id
  }

  resource "yandex_kubernetes_cluster" "k8s-regional" {
    network_id = yandex_vpc_network.mynet.id
    master {
      version = local.k8s_version
      regional {
        region = "{{ region-id }}"
        location {
          zone      = yandex_vpc_subnet.mysubnet-a.zone
          subnet_id = yandex_vpc_subnet.mysubnet-a.id
        }
        location {
          zone      = yandex_vpc_subnet.mysubnet-b.zone
          subnet_id = yandex_vpc_subnet.mysubnet-b.id
        }
        location {
          zone      = yandex_vpc_subnet.mysubnet-c.zone
          subnet_id = yandex_vpc_subnet.mysubnet-c.id
        }
      }
      security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    }
    service_account_id      = yandex_iam_service_account.myaccount.id
    node_service_account_id = yandex_iam_service_account.myaccount.id
    depends_on = [
      yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
      yandex_resourcemanager_folder_iam_binding.images-puller
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }
  
  resource "yandex_vpc_subnet" "mysubnet-b" {
    v4_cidr_blocks = ["10.6.0.0/16"]
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_vpc_subnet" "mysubnet-c" {
    v4_cidr_blocks = ["10.7.0.0/16"]
    zone           = "{{ region-id }}-c"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = local.sa_name
    description = "K8S regional service account"
  }

  resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }
  
  resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
    symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
    role             = "viewer"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}",
    ]
  }
  
  resource "yandex_vpc_security_group" "k8s-main-sg" {
    name        = "k8s-main-sg"
    description = "Правила группы обеспечивают базовую работоспособность кластера. Примените ее к кластеру и группам узлов."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
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
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера и сервисов."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
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

  {% endif %}

  {% if product == "cloud-il" %}

    ```hcl
  locals {
    cloud_id    = "{{ tf-cloud-id }}"
    folder_id   = "{{ tf-folder-id }}"
    k8s_version = "1.22"
    sa_name     = "myaccount"
  }

  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    endpoint  = "{{ api-host }}:443"
    folder_id = local.folder_id
  }

  resource "yandex_kubernetes_cluster" "k8s-regional" {
    network_id = yandex_vpc_network.mynet.id
    master {
      version = local.k8s_version
      regional {
        region = "{{ region-id }}"
        location {
          zone      = yandex_vpc_subnet.mysubnet-a.zone
          subnet_id = yandex_vpc_subnet.mysubnet-a.id
        }
        location {
          zone      = yandex_vpc_subnet.mysubnet-b.zone
          subnet_id = yandex_vpc_subnet.mysubnet-b.id
        }
        location {
          zone      = yandex_vpc_subnet.mysubnet-c.zone
          subnet_id = yandex_vpc_subnet.mysubnet-c.id
        }
      }
      security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    }
    service_account_id      = yandex_iam_service_account.myaccount.id
    node_service_account_id = yandex_iam_service_account.myaccount.id
    depends_on = [
      yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
      yandex_resourcemanager_folder_iam_binding.images-puller
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }
  
  resource "yandex_vpc_subnet" "mysubnet-b" {
    v4_cidr_blocks = ["10.6.0.0/16"]
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_vpc_subnet" "mysubnet-c" {
    v4_cidr_blocks = ["10.7.0.0/16"]
    zone           = "{{ region-id }}-c"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = local.sa_name
    description = "K8S regional service account"
  }

  resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
    # Сервисному аккаунту назначается роль "k8s.clusters.agent".
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
    # Сервисному аккаунту назначается роль "vpc.publicAdmin".
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
    # Сервисному аккаунту назначается роль "container-registry.images.puller".
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    ]
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 год.
  }
  
  resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
    symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
    role             = "viewer"
    members = [
      "serviceAccount:${yandex_iam_service_account.myaccount.id}",
    ]
  }
  
  resource "yandex_vpc_security_group" "k8s-main-sg" {
    name        = "k8s-main-sg"
    description = "Правила группы обеспечивают базовую работоспособность кластера. Примените ее к кластеру и группам узлов."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки. Нужно для работы отказоустойчивого кластера и сервисов балансировщика."
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
      description       = "Правило разрешает взаимодействие под-под и сервис-сервис. Укажите подсети вашего кластера и сервисов."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
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

  {% endif %}
 
  {% endcut %}

{% endlist %}