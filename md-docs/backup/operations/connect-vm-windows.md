# Подключить существующую виртуальную машину на Windows Server к Cloud Backup

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) Compute Cloud c [поддерживаемыми операционными системами на базе Windows](../concepts/vm-connection.md#windows).

Для корректной работы [агента Cloud Backup](../concepts/agent.md) ВМ должна соответствовать [минимальным требованиям](../concepts/vm-connection.md#requirements).

{% note warning %}

Чтобы ВМ можно было подключить к Cloud Backup, для нее должны быть правильно настроены сервисный аккаунт, публичный IP-адрес и группа безопасности. Подробнее в разделе [Подключение виртуальных машин Compute Cloud и серверов Yandex BareMetal к Cloud Backup](../concepts/vm-connection.md).

{% endnote %}

Если вы [удалили](delete-vm.md) ВМ из Cloud Backup и хотите подключить ее к сервису заново, воспользуйтесь инструкцией ниже.

Чтобы подключить ВМ на Windows к Cloud Backup:

1. [Создайте сервисный аккаунт](#create-sa).
1. [Подключите сервисный аккаунт к ВМ](#connect-sa-to-vm).
1. [Настройте сетевой доступ для ВМ](#configure-network-access).
1. [Установите агент Cloud Backup](#connect-vm).


## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../security/index.md#backup-user) `backup.user`.
  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для создания [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):

      ```bash
      yc iam service-account create --help
      ```

  1. Создайте сервисный аккаунт, выполнив команду:

      ```bash
      yc iam service-account create \
        --name <имя_сервисного_аккаунта>
      ```

      Результат:

      ```text
      id: ajehb3tcdfa1********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T16:05:14.237381531Z"
      name: backup-sa
      ```

      Подробнее о команде `yc iam service-account create` смотрите в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Посмотрите описание команды для назначения роли на каталог:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Назначьте сервисному аккаунту [роль](../security/index.md#backup-user) `backup.user` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role backup.user \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```text
      done (3s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: backup.user
            subject:
              id: ajehb3tcdfa1********
              type: serviceAccount
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` смотрите в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов:

      ```hcl
      resource "yandex_iam_service_account" "backup-sa" {
        name        = "<имя_сервисного_аккаунта>"
        folder_id   = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "backup-user-role" {
        folder_id   = "<идентификатор_каталога>"
        role        = "backup.user"
        member      = "serviceAccount:${yandex_iam_service_account.backup-sa.id}"
      }
      ```

      Где:

      * `yandex_iam_service_account` — описание [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
      * `yandex_resourcemanager_folder_iam_member` — описание прав доступа сервисного аккаунта к [каталогу](../../resource-manager/concepts/resources-hierarchy.md#folder), где:

          * `role` — назначаемая [роль](../security/index.md#backup-user).
          * `member` — субъект, которому назначается роль.

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

  Более подробную информацию о параметрах ресурсов смотрите в документации провайдера:

  * [yandex_iam_service_account](../../terraform/resources/iam_service_account.md)
  * [yandex_resourcemanager_folder_iam_member](../../terraform/resources/resourcemanager_folder_iam_member.md)

- API {#api}

  Чтобы создать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту [роль](../security/index.md#backup-user) `backup.user` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

Подробности в разделе [Создание сервисного аккаунта](../../iam/operations/sa/create.md).


## Подключите сервисный аккаунт к ВМ {#connect-sa-to-vm}

{% note info %}

К виртуальной машине можно привязать только один сервисный аккаунт.

{% endnote %}

Чтобы привязать сервисный аккаунт к ВМ, необходимо иметь разрешение на использование этого сервисного аккаунта. Это разрешение входит в роли [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../iam/roles-reference.md#editor) и выше.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ к Cloud Backup.
  1. Перейдите в сервис **Compute Cloud** и в открывшемся списке выберите нужную ВМ.
  1. В правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **Изменить ВМ**.
  1. В блоке **Дополнительно** выберите сервисный аккаунт с ролью `backup.user` или выше.
  1. Нажмите **Сохранить изменения**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для изменения ВМ:

      ```bash
      yc compute instance update --help
      ```

  1. Привяжите к ВМ сервисный аккаунт, выполнив команду:

      ```bash
      yc compute instance update <имя_или_идентификатор_ВМ> \
        --service-account-name <имя_сервисного_аккаунта>
      ```

      Где `--service-account-name` — имя сервисного аккаунта с ролью `backup.user` или выше.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      created_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      service_account_id: ajelprpohp7r********
      ...
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле Terraform в блоке с описанием ресурса `yandex_compute_instance` добавьте параметр `service_account_id` и укажите идентификатор сервисного аккаунта с ролью `backup.user` или выше:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        ...
      }
      ```

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления](https://console.yandex.cloud).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` смотрите в [документации провайдера](../../terraform/data-sources/compute_instance.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../compute/api-ref/grpc/Instance/update.md). В запросе укажите идентификатор сервисного аккаунта с ролью `backup.user` или выше.

{% endlist %}

Подробности в разделе [Изменить виртуальную машину](../../compute/operations/vm-control/vm-update.md).


## Настройте сетевой доступ для ВМ {#configure-network-access}

### Создайте группу безопасности {#create-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно подключить ВМ.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **Группы безопасности**.
  1. Нажмите **Создать группу безопасности**.
  1. Введите имя [группы безопасности](../../vpc/concepts/security-groups.md), например `backup-sg`.
  1. В поле **Сеть** выберите [сеть](../../vpc/concepts/network.md), в которой находится ВМ.
  1. В блоке **Правила** перейдите на вкладку **Исходящий трафик** и нажмите **Добавить правило**.
  1. Последовательно добавьте следующие правила для исходящего трафика:

      Диапазон портов | Протокол | Назначение | CIDR блоки
      --- | --- | --- | ---
      `80` | `TCP` | `CIDR` | `213.180.193.0/24`
      `80` | `TCP` | `CIDR` | `213.180.204.0/24`
      `443` | `TCP` | `CIDR` | `84.47.172.0/24`
      `443` | `TCP` | `CIDR` | `84.201.181.0/24`
      `443` | `TCP` | `CIDR` | `178.176.128.0/24`
      `443` | `TCP` | `CIDR` | `213.180.193.0/24`
      `443` | `TCP` | `CIDR` | `213.180.204.0/24`
      `7770-7800` | `TCP` | `CIDR` | `84.47.172.0/24`
      `8443` | `TCP` | `CIDR` | `84.47.172.0/24`
      `44445` | `TCP` | `CIDR` | `51.250.1.0/24`
      
      
      
      {% note tip %}
      
      При установке [агента Cloud Backup](../concepts/agent.md) на ВМ или сервер BareMetal может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
      * **Диапазон портов** — `0-65535`.
      * **Протокол** — `Любой` (`Any`).
      * **Назначение** — `CIDR`.
      * **CIDR блоки** — `0.0.0.0/0`.
      После установки агента Cloud Backup вы можете удалить это правило.
      
      Для доступа к ВМ по протоколу [SSH](../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
      * **Диапазон портов** — `22`.
      * **Протокол** — `Любой` (`Any`).
      * **Назначение** — `CIDR`.
      * **CIDR блоки** — `0.0.0.0/0`.
      
      {% endnote %}

  1. Нажмите **Сохранить**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для создания [группы безопасности](../../vpc/concepts/security-groups.md):

      ```bash
      yc vpc security-group create --help
      ```

  1. Создайте группу безопасности с [правилами](../../vpc/concepts/network.md#security-groups-rules), выполнив команду:

      ```bash
      yc vpc security-group create \
        --name <имя_группы_безопасности> \
        --network-id <идентификатор_сети> \
        --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
        --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.201.181.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[178.176.128.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
        --rule "direction=egress,from-port=7770,to-port=7800,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=8443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=44445,protocol=tcp,v4-cidrs=[51.250.1.0/24]"
      ```

      Где:

      * `name` — имя группы безопасности.
      * `network-id` — идентификатор [сети](../../vpc/concepts/network.md), в которой находится ВМ.
      * `rule` — описание правила:

          * `direction` — направление трафика. `egress` — исходящий.
          * `port` — порт для получения трафика.
          * `from-port` — первый порт из диапазона портов для трафика.
          * `to-port` — последний порт из диапазона портов для трафика.
          * `protocol` — протокол передачи данных.
          * `v4-cidrs` — список CIDR IPv4 и масок подсетей, куда будет поступать трафик.

      Результат:

      ```bash
      id: enp0v73fe8fs********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T20:17:43Z"
      name: backup-sg
      network_id: enp3srbi9u49********
      status: ACTIVE
      rules:
        - id: enpdadptjl77********
          direction: EGRESS
          ports:
            from_port: "80"
            to_port: "80"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 213.180.193.0/24
      ...
        - id: enpji0640a0f********
          direction: EGRESS
          ports:
            from_port: "44445"
            to_port: "44445"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 51.250.1.0/24
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_vpc_security_group" "test_sg_outgoing" {
        name        = "<имя_группы_безопасности>"
        network_id  = "<идентификатор_сети>"

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.193.0/24"]
          port           = 80
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.204.0/24"]
          port           = 80
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.201.181.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["178.176.128.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.193.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.204.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          from_port      = 7770
          to_port        = 7800
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          port           = 8443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["51.250.1.0/24"]
          port           = 44445
        }
      }
      ```

      Где:

      * `name` — имя [группы безопасности](../../vpc/concepts/security-groups.md).
      * `network_id` — идентификатор [сети](../../vpc/concepts/network.md), в которой находится ВМ.
      * `egress` — описание [правила](../../vpc/concepts/network.md#security-groups-rules) для исходящего трафика:

          * `protocol` — протокол передачи данных.
          * `v4-cidrs` — список CIDR IPv4 и масок подсетей, куда будет поступать трафик.
          * `port` — порт для получения трафика.
          * `from_port` — первый порт из диапазона портов для трафика.
          * `to_port` — последний порт из диапазона портов для трафика.

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

    Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` смотрите в [документации провайдера](../../terraform/data-sources/vpc_security_group.md).

- API {#api}

  Чтобы создать [группу безопасности](../../vpc/concepts/security-groups.md), воспользуйтесь методом REST API [create](../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md).

{% endlist %}

Подробности в разделе [Создать группу безопасности](../../vpc/operations/security-group-create.md).


### Настройте сетевой интерфейс ВМ {#configure-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно подключить ВМ к Cloud Backup.
  1. Перейдите в сервис **Compute Cloud** и выберите нужную ВМ.
  1. В блоке **Сетевой интерфейс** добавьте группу безопасности в [сетевой интерфейс](../../compute/concepts/network.md) ВМ:
  
      * В правом верхнем углу блока нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Изменить**.
      * В открывшемся окне в поле **Группы безопасности** выберите созданную ранее группу безопасности.
      * Нажмите **Сохранить**.
  
  1. Если у ВМ нет [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses), то в секции **Сеть** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Добавить публичный IP-адрес**. В открывшемся окне:
  
      * В поле **Публичный адрес** выберите `Автоматически`, чтобы автоматически получить IP-адрес, или `Список`, чтобы выбрать зарезервированный адрес из списка.
      * (Опционально) Если в поле **Публичный адрес** вы выбрали `Автоматически`, включите опцию **Защита от DDoS-атак**. Подробнее в разделе [Yandex DDoS Protection в Virtual Private Cloud](../../vpc/ddos-protection/index.md).
      * Если в поле **Публичный адрес** вы выбрали `Список`, выберите IP-адрес, который хотите привязать к ВМ. IP-адрес и ВМ должны находиться в одной [зоне доступности](../../overview/concepts/geo-scope.md).
      * Нажмите **Добавить**.
  
      Вместо назначения ВМ публичного IP-адреса вы можете привязать к подсети с ВМ [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для изменения [сетевого интерфейса](../../compute/concepts/network.md) ВМ:

      ```bash
      yc compute instance update-network-interface --help
      ```

  1. Добавьте созданную ранее группу безопасности в сетевой интерфейс ВМ:

      ```bash
      yc compute instance update-network-interface \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса> \
        --security-group-id <идентификатор_группы_безопасности>
      ```

      Где:

      * `--id` — идентификатор ВМ.
      * `--network-interface-index` — номер сетевого интерфейса, например `0`.
      * `--security-group-id` — идентификатор группы безопасности.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

  1. Посмотрите описание команды для привязки публичного IP-адреса к ВМ:

      ```bash
      yc compute instance add-one-to-one-nat --help
      ```

  1. Если у ВМ нет [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses), то привяжите его:

      ```bash
      yc compute instance add-one-to-one-nat \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса>
      ```

      Где:

      * `--id` — идентификатор ВМ.
      * `--network-interface-index` — номер сетевого интерфейса, например `0`.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл и в блоке с описанием ресурса `yandex_compute_instance` измените параметры [сетевого интерфейса](../../compute/concepts/network.md) ВМ:

      ```hcl
      resource "yandex_compute_instance" "my-vm" {
      ...
        network_interface {
          ...
          security_group_ids = "<идентификатор_группы_безопасности>"
          nat                = true
          ...
        }
      ...
      }
      ```

      Где:

      * `yandex_compute_instance` — описание ВМ.
      * `network_interface` — настройки сетевого интерфейса ВМ.
      * `security_group_ids` — список идентификаторов групп безопасности.
      * `nat` — параметр, задающий привязку публичного IP-адреса к ВМ.

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления](https://console.yandex.cloud).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` смотрите в [документации провайдера](../../terraform/data-sources/compute_instance.md).

- API {#api}

  Чтобы добавить группу безопасности в [сетевой интерфейс](../../compute/concepts/network.md) ВМ, воспользуйтесь методом REST API [updateNetworkInterface](../../compute/api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateNetworkInterface](../../compute/api-ref/grpc/Instance/updateNetworkInterface.md).

  Чтобы привязать [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) к ВМ, воспользуйтесь методом REST API [addOneToOneNat](../../compute/api-ref/Instance/addOneToOneNat.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AddOneToOneNat](../../compute/api-ref/grpc/Instance/addOneToOneNat.md).

{% endlist %}

Подробности в разделах [Изменить группы безопасности сетевого интерфейса виртуальной машины](../../compute/operations/vm-control/vm-change-security-groups-set.md) и [Привязать к виртуальной машине публичный IP-адрес](../../compute/operations/vm-control/vm-attach-public-ip.md).


## Установите агент Cloud Backup {#connect-vm}

1. [Подключитесь к ВМ по RDP](../../compute/operations/vm-connect/rdp.md).
1. Запустите Windows PowerShell.

    {% note info %}
    
    В политиках выполнения PowerShell должен быть разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).
        
    {% endnote %}

1. Выполните следующую команду:

    ```powershell
    . { iwr -useb https://storage.yandexcloud.net/backup-distributions/agent_installer.ps1 } | iex
    ```

    Результат:

    ```text
    ...
    Backup agent installation complete after 190 s!
    ```

После этого ВМ можно привязать к [политике резервного копирования](../concepts/policy.md).


#### Полезные ссылки {#see-also}

* [Создать виртуальную машину на Linux с подключением к Cloud Backup](create-vm.md)
* [Привязать виртуальную машину к политике резервного копирования](policy-vm/update.md#update-vm-list)
* [Восстановить виртуальную машину или сервер Yandex BareMetal из резервной копии](backup-vm/recover.md)
* [Удалить резервную копию](backup-vm/delete.md)
* [Создать политику резервного копирования](policy-vm/create.md)