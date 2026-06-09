# Автоматическая привязка политики резервного копирования {{ backup-full-name }} к ВМ с помощью {{ TF }}

Чтобы создать виртуальную машину с автоматической привязкой к политике резервного копирования {{ backup-name }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Активируйте сервис](#service-activate).
1. [Создайте инфраструктуру](#deploy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md#prices-instance-resources));
* плата за диски ВМ (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md#prices-storage));
* плата за использование динамического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md#prices-public-ip));
* плата за подключенные к сервису {{ backup-name }} ВМ и объем резервных копий (см. [тарифы {{ backup-full-name }}](../../../backup/pricing.md#rules)).

## Активируйте сервис {#service-activate}

{% note info %}

Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](../../../backup/security/index.md#backup-user) `backup.user` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создавать резервные копии ВМ или серверов {{ baremetal-name }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Если сервис {{ backup-name }} еще не активирован, нажмите **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет, и вам доступно создание ВМ с подключением к {{ backup-name }}, значит, сервис уже активирован. Переходите к следующему шагу.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды [CLI](../../../cli/index.md) для активации сервиса:
  
     ```bash
     yc backup provider activate --help
     ```
  
  1. Активируйте сервис в каталоге по умолчанию:
  
     ```bash
     yc backup provider activate --async
     ```
  
     Где `--async` — отображение информации о прогрессе операции. Необязательный параметр.
  
  1. После выполнения команды появится предупреждение об активации `This command will activate backup provider for your folder. Do you confirm this action to be executed? [Yes/no][y/N]`. Подтвердите активацию — в терминале введите `yes` или `y`.
  
     {% note tip %}
  
     Чтобы активировать сервис без подтверждения, используйте флаг `--force`.
  
     {% endnote %}
  
     Результат:
  
     ```text
     id: cdgmnefxiatx********
     description: activate provider
     created_at: "2024-10-14T09:03:47.960564Z"
     created_by: ajec1gaqcmtr********
     modified_at: "2024-10-14T09:03:47.960564Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.backup.v1.ActivateProviderMetadata
       folder_id: b1go3el0d8fs********
     response:
       '@type': type.googleapis.com/google.protobuf.Empty
       value: {}
     ```
  
  После активации автоматически создаются следующие политики резервного копирования:
  * `Default daily` — ежедневное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default weekly` — еженедельное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default monthly` — ежемесячное создание инкрементальной копии с сохранением последних 15 копий.
  
  Если вы не хотите их создавать, используйте параметр `--skip-default-policy`.

{% endlist %}

## Создайте инфраструктуру {#deploy}

{% note info %}

Привязка политики резервного копирования {{ backup-full-name }} к ВМ доступна для [{{ TF }}-провайдера]({{ tf-provider-link }}) `0.127.0` и более поздних версий.

{% endnote %}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-baas-backup-policy-auto-binding
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `backup-policy-auto-binding-config.tf` — конфигурация создаваемой инфраструктуры.
          * `cloud-init.yaml` — файл метаданных ВМ.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке:

          1. Конфигурационный файл `backup-policy-auto-binding-config.tf`:

            {% cut "backup-policy-auto-binding-config.tf" %}

            ```hcl
            # Настройка провайдера
            
            terraform {
              required_providers {
                yandex = {
                  source = "yandex-cloud/yandex"
                }
              }
              required_version = ">= 0.13"
            }
            
            provider "yandex" {
              zone = "{{ region-id }}-a"
            }
            
            # Создание сервисного аккаунта
            
            resource "yandex_iam_service_account" "my_sa" {
              name = "backup-sa"
            }
            
            # Назначение роли сервисному аккаунту
            
            resource "yandex_resourcemanager_folder_iam_member" "my_binding" {
              folder_id = yandex_iam_service_account.my_sa.folder_id
              role      = "backup.user"
              member    = "serviceAccount:${yandex_iam_service_account.my_sa.id}"
            }
            
            # Создание облачной сети
            
            resource "yandex_vpc_network" "my_backup_network" {
              name = "cloud-network"
            }
            
            # Создание облачной подсети
            
            resource "yandex_vpc_subnet" "my_backup_subnet" {
              zone           = "{{ region-id }}-a"
              network_id     = yandex_vpc_network.my_backup_network.id
              v4_cidr_blocks = ["192.168.0.0/24"]
            }
            
            # Создание группы безопасности
            # https://yandex.cloud/ru/docs/backup/concepts/vm-connection#vm-network-access
            
            resource "yandex_vpc_security_group" "my_backup_security_group" {
              name       = "backup-sg"
              network_id = yandex_vpc_network.my_backup_network.id
              egress {
                protocol       = "TCP"
                from_port      = 7770
                to_port        = 7800
                v4_cidr_blocks = ["84.47.172.0/24"]
              }
              egress {
                protocol       = "TCP"
                port           = 443
                v4_cidr_blocks = ["213.180.204.0/24", "213.180.193.0/24", "178.176.128.0/24", "84.201.181.0/24", "84.47.172.0/24"]
              }
              egress {
                protocol       = "TCP"
                port           = 80
                v4_cidr_blocks = ["213.180.204.0/24", "213.180.193.0/24"]
              }
              egress {
                protocol       = "TCP"
                port           = 8443
                v4_cidr_blocks = ["84.47.172.0/24"]
              }
              egress {
                protocol       = "TCP"
                port           = 44445
                v4_cidr_blocks = ["51.250.1.0/24"]
              }
              ingress {
                protocol       = "TCP"
                description    = "ssh"
                v4_cidr_blocks = ["0.0.0.0/0"]
                port           = 22
              }
            }
            
            # Получение информации об образе для загрузочного диска виртуальной машины
            
            data "yandex_compute_image" "ubuntu" {
              family = "ubuntu-2204-lts"
            }
            
            # Создание загрузочного диска для виртуальной машины
            
            resource "yandex_compute_disk" "boot-disk" {
              type     = "network-ssd"
              zone     = "{{ region-id }}-a"
              size     = "20"
              image_id = data.yandex_compute_image.ubuntu.id
            }
            
            # Создание виртуальной машины
            
            resource "yandex_compute_instance" "my_backup_compute" {
              name               = "backup-instance"
              platform_id        = "standard-v3"
              zone               = "{{ region-id }}-a"
              service_account_id = yandex_iam_service_account.my_sa.id
              network_interface {
                subnet_id          = yandex_vpc_subnet.my_backup_subnet.id
                security_group_ids = [yandex_vpc_security_group.my_backup_security_group.id]
                nat                = true
              }
            
              boot_disk {
                disk_id = yandex_compute_disk.boot-disk.id
              }
            
              resources {
                cores  = 2
                memory = 4
              }
            
              metadata = {
                user-data = "${file("cloud-init.yaml")}"
              }
            }
            
            # Создание политики резервного копирования
            
            resource "yandex_backup_policy" "my_policy" {
              name                = "weekly-backup"
              fast_backup_enabled = true
              retention {
                after_backup = false
              }
              reattempts {
                enabled      = true
                interval     = "1m"
                max_attempts = 10
              }
              scheduling {
                scheme            = "ALWAYS_INCREMENTAL"
                weekly_backup_day = "FRIDAY"
                backup_sets {
                  execute_by_time {
                    repeat_at = ["03:00"]
                    type      = "WEEKLY"
                    weekdays  = ["FRIDAY"]
                  }
                }
              }
              vm_snapshot_reattempts {
                enabled      = true
                interval     = "1m"
                max_attempts = 10
              }
            }
            
            # Привязка политики резервного копирования к ВМ
            
            resource "yandex_backup_policy_bindings" "my_backup_binding" {
              instance_id = yandex_compute_instance.my_backup_compute.id
              policy_id   = yandex_backup_policy.my_policy.id
            }
            ```

            {% endcut %}

          1. Файл метаданных ВМ `cloud-init.yaml`:

            {% cut "cloud-init.yaml" %}

            ```yaml
            #cloud-config
            datasource:
             Ec2:
              strict_id: false
            ssh_pwauth: no
            users:
            - name: <имя_пользователя>
              sudo: ALL=(ALL) NOPASSWD:ALL
              shell: /bin/bash
              ssh_authorized_keys:
              - <публичный_ssh_ключ>
            packages:
              - curl
              - perl
              - jq
            runcmd:
              - curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
            ```

            {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Назначение [роли](../../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Группа безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * Данные [образа ВМ](../../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-datasources-link }}/compute_image).
    * Загрузочный [диск](../../../compute/concepts/disk.md) виртуальной машины — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Политика резервного копирования](../../../backup/concepts/policy.md) — [yandex_backup_policy]({{ tf-provider-resources-link }}/backup_policy). Вы можете создать новую или использовать одну из политик, автоматически созданных при активации сервиса.
    * Привязка политики резервного копирования к ВМ — [yandex_backup_policy_bindings]({{ tf-provider-resources-link }}/backup_policy_bindings). Чтобы привязать к ВМ одну из политик, автоматически созданных при активации сервиса, [получите](../../../backup/operations/policy-vm/get-info.md) ее идентификатор.

1. В файле `cloud-init.yaml` задайте пользовательские параметры:

    * `name` — имя пользователя ВМ, например `vm-user`.
    * `ssh_authorized_keys` — содержимое файла [открытого ключа](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

1. Создайте ресурсы:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

{% note info %}

Когда ВМ перейдет в статус `Running`, на нее начнет устанавливаться агент {{ backup-name }}. Установка займет от 5 до 10 минут.

Привязка политики выполняется асинхронно после создания и инициализации ВМ, а также установки и настройки агента {{ backup-name }}. Это может занимать до 10–15 минут. В итоге виртуальная машина появится в списке ВМ сервиса {{ backup-name }} и в списке ВМ, привязанных к политике `weekly-backup`.

{% endnote %}

За процессом установки можно следить с помощью [последовательного порта](../../../compute/operations/vm-info/get-serial-port-output.md) ВМ в консоли управления.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `backup-policy-auto-binding.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### См. также {#see-also}

* [{#T}](console.md)