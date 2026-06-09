# Подключить существующую виртуальную машину на Windows Server к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами на базе Windows](../concepts/vm-connection.md#windows).

Для корректной работы [агента {{ backup-name }}](../concepts/agent.md) ВМ должна соответствовать [минимальным требованиям](../concepts/vm-connection.md#requirements).

{% note warning %}

Чтобы ВМ можно было подключить к {{ backup-name }}, для нее должны быть правильно настроены сервисный аккаунт, публичный IP-адрес и группа безопасности. Подробнее см. в разделе [{#T}](../concepts/vm-connection.md).

{% endnote %}

Если вы [удалили](delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкцией ниже.

Чтобы подключить ВМ на Windows к {{ backup-name }}:

1. [{#T}](#create-sa).
1. [{#T}](#connect-sa-to-vm).
1. [{#T}](#configure-network-access).
1. [{#T}](#connect-vm).


## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../security/index.md#backup-user) `backup.user`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

      Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

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

      Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурсов см. в документации провайдера:

  * [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
  * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)

- API {#api}

  Чтобы создать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту [роль](../security/index.md#backup-user) `backup.user` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

Подробности см. в разделе [{#T}](../../iam/operations/sa/create.md).


## Подключите сервисный аккаунт к ВМ {#connect-sa-to-vm}

{% note info %}

К виртуальной машине можно привязать только один сервисный аккаунт.

{% endnote %}

Чтобы привязать сервисный аккаунт к ВМ, необходимо иметь разрешение на использование этого сервисного аккаунта. Это разрешение входит в роли [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../iam/roles-reference.md#editor) и выше.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ к {{ backup-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и в открывшемся списке выберите нужную ВМ.
  1. В правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите сервисный аккаунт с ролью `backup.user` или выше.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле {{ TF }} в блоке с описанием ресурса `yandex_compute_instance` добавьте параметр `service_account_id` и укажите идентификатор сервисного аккаунта с ролью `backup.user` или выше:

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Воспользуйтесь методом REST API [update](../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../compute/api-ref/grpc/Instance/update.md). В запросе укажите идентификатор сервисного аккаунта с ролью `backup.user` или выше.

{% endlist %}

Подробности см. в разделе [{#T}](../../compute/operations/vm-control/vm-update.md).


## Настройте сетевой доступ для ВМ {#configure-network-access}

### Создайте группу безопасности {#create-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Введите имя [группы безопасности](../../vpc/concepts/security-groups.md), например `backup-sg`.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите [сеть](../../vpc/concepts/network.md), в которой находится ВМ.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** и нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Последовательно добавьте следующие правила для исходящего трафика:

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | ---
      `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
      `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.201.181.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `178.176.128.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
      `7770-7800` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
      `8443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
      `44445` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `51.250.1.0/24`
      
      
      
      {% note tip %}
      
      При установке [агента {{ backup-name }}](../concepts/agent.md) на ВМ или сервер {{ baremetal-name }} может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
      После установки агента {{ backup-name }} вы можете удалить это правило.
      
      Для доступа к ВМ по протоколу [SSH](../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
      
      {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

    Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_security_group).

- API {#api}

  Чтобы создать [группу безопасности](../../vpc/concepts/security-groups.md), воспользуйтесь методом REST API [create](../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md).

{% endlist %}

Подробности см. в разделе [{#T}](../../vpc/operations/security-group-create.md).


### Настройте сетевой интерфейс ВМ {#configure-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ к {{ backup-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и выберите нужную ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** добавьте группу безопасности в [сетевой интерфейс](../../compute/concepts/network.md) ВМ:
  
      * В правом верхнем углу блока нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
      * В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** выберите созданную ранее группу безопасности.
      * Нажмите **{{ ui-key.yacloud.common.save }}**.
  
  1. Если у ВМ нет [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses), то в секции **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. В открывшемся окне:
  
      * В поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** выберите `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, чтобы автоматически получить IP-адрес, или `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, чтобы выбрать зарезервированный адрес из списка.
      * (Опционально) Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, включите опцию **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. Подробнее см. в разделе [{#T}](../../vpc/ddos-protection/index.md).
      * Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, выберите IP-адрес, который хотите привязать к ВМ. IP-адрес и ВМ должны находиться в одной [зоне доступности](../../overview/concepts/geo-scope.md).
      * Нажмите **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.
  
      Вместо назначения ВМ публичного IP-адреса вы можете привязать к подсети с ВМ [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Чтобы добавить группу безопасности в [сетевой интерфейс](../../compute/concepts/network.md) ВМ, воспользуйтесь методом REST API [updateNetworkInterface](../../compute/api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateNetworkInterface](../../compute/api-ref/grpc/Instance/updateNetworkInterface.md).

  Чтобы привязать [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) к ВМ, воспользуйтесь методом REST API [addOneToOneNat](../../compute/api-ref/Instance/addOneToOneNat.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AddOneToOneNat](../../compute/api-ref/grpc/Instance/addOneToOneNat.md).

{% endlist %}

Подробности см. в разделах [{#T}](../../compute/operations/vm-control/vm-change-security-groups-set.md) и [{#T}](../../compute/operations/vm-control/vm-attach-public-ip.md).


## Установите агент {{ backup-name }} {#connect-vm}

1. [Подключитесь к ВМ по RDP](../../compute/operations/vm-connect/rdp.md).
1. Запустите Windows PowerShell.

    {% note info %}
    
    В политиках выполнения PowerShell должен быть разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее см. в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).
        
    {% endnote %}

1. Выполните следующую команду:

    ```powershell
    . { iwr -useb https://{{ s3-storage-host }}/backup-distributions/agent_installer.ps1 } | iex
    ```

    Результат:

    ```text
    ...
    Backup agent installation complete after 190 s!
    ```

После этого ВМ можно привязать к [политике резервного копирования](../concepts/policy.md).


#### См. также {#see-also}

* [{#T}](create-vm.md)
* [Привязать виртуальную машину к политике резервного копирования](policy-vm/update.md#update-vm-list)
* [{#T}](backup-vm/recover.md)
* [{#T}](backup-vm/delete.md)
* [{#T}](policy-vm/create.md)