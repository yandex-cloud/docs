# Создание кластера {{ k8s }}

Создайте кластер {{ k8s }}, а затем [создайте группу узлов](../node-group/node-group-create.md).

## Перед началом работы {#before-you-begin}

Чтобы создать кластер {{ k8s }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../../resource-manager/operations/folder/create.md).
1. Установите [{{ k8s }} CLI (kubectl)](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/).
1. Убедитесь, что у вас достаточно [свободных ресурсов в облаке](../../concepts/limits.md).
1. Если у вас еще нет сети, [создайте ее](../../../vpc/operations/network-create.md).
1. Если у вас еще нет подсетей, [создайте их](../../../vpc/operations/subnet-create.md) в зонах доступности, где будут созданы кластер {{ k8s }} и группа узлов.
1. Создайте [сервисные аккаунты](../../../iam/operations/sa/create.md):
   * Сервисный аккаунт с ролью [{{ roles-editor }}](../../../resource-manager/security/index.md#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
   * Сервисный аккаунт с ролью [{{ roles-cr-puller }}](../../../container-registry/security/index.md#required-roles) на каталог с реестром Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

1. Создайте нужные [группы безопасности](../security-groups.md).
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
       --zone ru-central1-a \
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
     * `--service-ipv4-range` — диапазон IP-адресов, из которого будут выделяться IP-адреса для сервисов.
     * `--security-group-ids` — список идентификаторов групп безопасности кластера.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--service-account-id` — уникальный идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
     * `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
     * `--daily-maintenance-window` — настройки окна обновлений.

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

  1. Чтобы использовать [ключ шифрования](../../concepts/encryption.md) для защиты конфиденциальной информации, передайте в команде создания кластера его имя или идентификатор:

     ```bash
     {{ yc-k8s }} cluster create \
        ...
        --kms-key-name <имя ключа шифрования> \
        --kms-key-id <идентификатор ключа шифрования> \
        ...
     ```

     {% include [write-once-setitng.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать. Вы можете добавить несколько записей одновременно.

     * `name` — имя кластера {{ k8s }}.
     * `description` — описание кластера {{ k8s }}.
     * `network_id` — идентификатор сети.
     * `version` — версия {{ k8s }}.
     * (опционально) `kms_provider` — [ключ шифрования](../../concepts/encryption.md) {{ kms-full-name }}, который будет использоваться для защиты секретов.

       {% include [write-once-setitng.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

     * `zonal` — параметры зонального мастера:
       * `zone` — зона доступности.
       * `subnet_id` — идентификатор подсети. Если он не указан, а в указанной зоне есть только одна подсеть, будет выделен адрес в этой подсети.
     * `public_ip` — флаг, который указывается, если кластеру {{ k8s }} требуется публичный IP-адрес.
     * `service_account_id` — идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}. Указанный аккаунт службы должен иметь роль редактирования в каталоге, в которой будет расположен кластер.
     * `node_service_account_id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
     * `release_channel` — [релизный канал](../../concepts/release-channels-and-updates.md#release-channels).

     {% note info %}

     Если права доступа для `service_account_id` или `node_service_account_id` предоставляются с использованием ресурсов Terraform, то необходимо добавить зависимость от этих ресурсов доступа в конфигурацию кластера в блоке `depends_on`.

     Права выдаются с некоторой задержкой, поэтому следует в соответствующих ресурсах (в данном примере это `yandex_resourcemanager_folder_iam_member`), добавить `sleep_after = 30s`.

     ```
     depends_on = [
       "yandex_resourcemanager_folder_iam_member.ServiceAccountResourceName",
       "yandex_resourcemanager_folder_iam_member.NodeServiceAccountResourceName"
     ]
     ```

     Иначе, при удалении ресурсов, Terraform удалит одновременно кластер и права доступа для учетных записей служб. Это может вызвать проблемы при удалении кластера и связанных с ним групп узлов.

     {% endnote %}

     ```
     provider "yandex" {
       token     = "key.json"
       cloud_id  = "<идентификатор облака>"
       folder_id = var.folder-id
       zone      = "ru-central1-a"
     }

     variable "folder-id" {
       default = "<идентификатор каталога>"
     }

     resource "yandex_kubernetes_cluster" "zonal_cluster_resource_name" {
       name        = "my-cluster"
       description = "my-cluster description"
       network_id = "${yandex_vpc_network.this.id}"

       master {
         version = "1.17"
         zonal {
           zone      = "${yandex_vpc_subnet.subnet_resource_name.zone}"
           subnet_id = "${yandex_vpc_subnet.subnet_resource_name.id}"
         }
         public_ip = true
       }

       service_account_id      = "${yandex_iam_service_account.this.id}"
       node_service_account_id = "${yandex_iam_service_account.this.id}"
       release_channel = "STABLE"
       depends_on = ["yandex_resourcemanager_folder_iam_member.this"]
       kms_provider {
         key_id = "<идентификатор ключа шифрования>"
       }
     }

     resource "yandex_vpc_network" "this" {}

     resource "yandex_vpc_subnet" "subnet_resource_name" {
       network_id     = yandex_vpc_network.this.id
       zone           = "ru-central1-a"
       v4_cidr_blocks = ["192.168.20.0/24"]
     }

     resource "yandex_iam_service_account" "this" {
       name = "k8-sa"
     }

     resource "yandex_resourcemanager_folder_iam_member" "this" {
       folder_id = var.folder-id

       member = "serviceAccount:${yandex_iam_service_account.this.id}"
       role   = "editor"
     }

     locals {
       kubeconfig = <<KUBECONFIG
     apiVersion: v1
     clusters:
     - cluster:
         server: ${yandex_kubernetes_cluster.zonal_cluster_resource_name.master[0].external_v4_endpoint}
         certificate-authority-data: ${base64encode(yandex_kubernetes_cluster.zonal_cluster_resource_name.master[0].cluster_ca_certificate)}
       name: kubernetes
     contexts:
     - context:
         cluster: kubernetes
         user: yc
       name: ycmk8s
     current-context: ycmk8s
     users:
     - name: yc
       user:
         exec:
           apiVersion: client.authentication.k8s.io/v1beta1
           command: yc
           args:
           - k8s
           - create-token
     KUBECONFIG
     }
     output "kubeconfig" {
       value = "${local.kubeconfig}"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, смотрите в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Выполните проверку с помощью команды:

     ```bash
     terraform plan
     ```

     Результат выполнения команды:

     ```
     Refreshing Terraform state in-memory prior to plan...
     The refreshed state will be used to calculate this plan, but will not be
     persisted to local or remote state storage.
     ...
     Note: You didn't specify an "-out" parameter to save this plan, so Terraform
     can't guarantee that exactly these actions will be performed if
     "terraform apply" is subsequently run.
     ```

     В терминале будет выведен список ресурсов с параметрами. Это проверочный этап, ресурсы не будут созданы. Если в конфигурации есть ошибки, Terraform на них укажет.

     {% note alert %}

     Все созданные с помощью Terraform ресурсы тарифицируются. Внимательно проверьте план.

     {% endnote %}

  1. Чтобы создать ресурсы, выполните команду:

     ```bash
     terraform apply
     ```

     Результат выполнения команды:

     ```
     An execution plan has been generated and is shown below.
     Resource actions are indicated with the following symbols:
     + create
     ...
     Terraform will perform the actions described above.
     Only 'yes' will be accepted to approve.

     Enter a value:
     ```

  1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**:

     ```bash
     Enter a value: yes
     ```

     Terraform создаст все требуемые ресурсы. В результате выполнения команды, в консоли отобразится содержимое файла конфигурации `kubeconfig` — его можно использовать с [kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/).

     {% note info %}

     В системе должен быть установлен и инициализирован [CLI](../../../cli/quickstart.md#install) — он используется для получения токена.

     {% endnote %}

     ```yaml
     apiVersion: v1
     clusters:
     - cluster:
         server: https://178.154.202.231
         certificate-authority-data: ...JKdkI0dE1ra0RzRVRSOWIzcFJ1NjNHRFRJRj==...
       name: kubernetes
     contexts:
     - context:
         cluster: kubernetes
         user: yc
       name: ycmk8s
     current-context: ycmk8s
     users:
     - name: yc
       user:
         exec:
           apiVersion: client.authentication.k8s.io/v1beta1
           command: yc
           args:
           - k8s
           - create-token
     ```

  1. Проверьте ресурсы и их настройки в [консоли управления]({{ link-console-main }}).

- API

  Чтобы создать кластер {{ k8s }}, воспользуйтесь методом [create](../../api-ref/Cluster/create.md) для ресурса [Cluster](../../api-ref/Cluster).

  Чтобы использовать для защиты секретов [ключ шифрования KMS](../../concepts/encryption.md), передайте его идентификатор в параметре `kmsProvider.keyId`.

{% endlist %}