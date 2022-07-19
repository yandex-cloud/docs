# Создание кластера {{ k8s }}

Создайте [кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster), а затем [создайте группу узлов](../node-group/node-group-create.md).

## Перед началом работы {#before-you-begin}

Чтобы создать кластер {{ k8s }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.

{% if product == "yandex-cloud" %}

1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).

{% endif %}

1. Если у вас еще нет [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../../resource-manager/operations/folder/create.md).

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md).
1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md){% if product == "yandex-cloud" %} в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и [группа узлов](../../concepts/index.md#node-group){% endif %}.
1. Создайте [сервисные аккаунты](../../../iam/operations/sa/create.md):
   * Сервисный аккаунт с ролью [{{ roles-editor }}](../../../resource-manager/security/index.md#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
   * Сервисный аккаунт с ролью [{{ roles-cr-puller }}](../../../container-registry/security/index.md#required-roles) на каталог с [реестром](../../../container-registry/concepts/registry.md) [Docker-образов](../../../container-registry/concepts/docker-image.md). От его имени узлы будут скачивать из реестра необходимые Docker-образы.

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.
1. Создайте нужные [группы безопасности](../connect/security-groups.md).
1. Изучите [рекомендации по использованию {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

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

     Результат:

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