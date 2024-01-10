# Резервное копирование ВМ с помощью Hystax Acura Backup

Вы можете автоматически создавать резервные копии [виртуальных машин](../../glossary/vm.md) и восстанавливать их в облачной инфраструктуре с помощью инструмента [Hystax Acura Backup в {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-backup).

ВМ с Hystax Acura Backup управляет процессами резервного копирования и восстановления. Резервные копии ВМ сохраняются в [бакете](../../storage/concepts/bucket.md) {{ objstorage-name }}. Восстановление выполняется с помощью вспомогательной ВМ Hystax Cloud Agent, которая создает новую ВМ с определенной точкой отката RPO (Recovery Point Objective) на произвольный момент времени в прошлом. Время, необходимое для восстановления из резервной копии RTO (Recovery Time Objective), зависит от объема исходных данных.

Чтобы выполнить резервное копирование и восстановление ВМ с помощью Hystax Acura Backup:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Настройте разрешения сетевого трафика](#network-settings).
1. [Создайте бакет](#create-bucket).
1. [Создайте ВМ с Hystax Acura Backup](#create-acura-vm).
1. [Сделайте IP-адрес ВМ статическим](#static-ip).
1. [Настройте Hystax Acura Backup](#setup-hystax-acura).
1. [Подготовьте и установите агент на ВМ](#prepare-agent).
1. [Создайте резервную копию ВМ](#start-protection).
1. [Создайте план восстановления](#create-recovery-plan).
1. [Запустите восстановление](#run-recover).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% note info %}

Обратите внимание, что оплачиваться и учитываться в [квотах]({{ link-console-quotas }}) будут как инфраструктура для Hystax Acura Backup, так и все восстановленные ВМ.
* ВМ для Hystax Acura Backup использует 8 ядер vCPU, 16 ГБ памяти и диск на 200 ГБ.
* Вспомогательные ВМ Hystax Cloud Agent используют 2 ядра vCPU, 4 ГБ памяти и диск на 10 ГБ. Одна ВМ Hystax Cloud Agent может одновременно обслуживать до 6 реплицируемых дисков. В случае, если дисков больше 6, автоматически будут созданы дополнительные ВМ Hystax Cloud Agent.

Подробные системные требования см. в [документации Hystax](https://cdn.hystax.com/Hystax/Documentation/Deployment-requirements.pdf).

{% endnote %}

В стоимость ресурсов для использования Hystax Acura Backup входят:
* Плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-instance-resources)).
* Плата за диски ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md#prices-storage)).
* Плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за хранение данных в бакете и операции с ними (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).
* Плата за использование Hystax Acura Backup (см. [описание продукта](/marketplace/products/hystax/hystax-acura-backup) в {{ marketplace-name }}).


### Создайте сервисный аккаунт и ключи доступа {#create-sa}

Hystax Acura Backup будет выполнять действия от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `hystax-acura-account` с ролями `editor` и `marketplace.meteringAgent`. Сохраните идентификатор сервисного аккаунта, он потребуется в дальнейшем.
1. [Создайте](../../iam/operations/authorized-key/create.md) авторизованный ключ для сервисного аккаунта. Авторизованный ключ нужен для выполнения операций в {{ yandex-cloud }} от имени сервисного аккаунта. Сохраните идентификатор и закрытый ключ, они потребуются в дальнейшем.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статический ключ доступа. Статический ключ нужен для доступа к бакету от имени сервисного аккаунта. Сохраните идентификатор и секретный ключ, они потребуются в дальнейшем.

### Настройте разрешения сетевого трафика {#network-settings}

Настройте разрешения сетевого трафика в [группе безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group). 

[Добавьте](../../vpc/operations/security-group-update.md#add-rule) в нее следующие правила:

Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
--- | --- | --- | --- | --- | ---
Входящий | `http` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `https` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `https` | `4443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `iSCSI` | `3260` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `udp` | `12201` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `tcp` | `15000` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `http` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `https` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `vmware` | `902` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `iSCSI` | `3260` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `udp` | `12201` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

Сохраните идентификатор группы безопасности, он потребуется в дальнейшем.

{% note info %}

Вспомогательные ВМ Hystax Cloud Agent автоматически создаются в группе безопасности по умолчанию. Если вы создали отдельную группу для ВМ Hystax Acura Backup, [перенесите](../../compute/operations/vm-control/vm-update.md) в эту же группу вспомогательные ВМ Hystax Cloud Agent после того, как они будут созданы.

{% endnote %}

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. На странице создания бакета:
      1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
      1. При необходимости ограничьте максимальный размер бакета.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access):
          * **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** — `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
          * **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** — `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
          * **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** — `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
      1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) — `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.
  1. Сохраните имя бакета, оно потребуется в дальнейшем.

- API {#api}

  Воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/) или вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create).

{% endlist %}

## Создайте ВМ с Hystax Acura Backup {#create-acura-vm}

1. [Сгенерируйте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару [SSH-ключей](../../glossary/ssh-keygen.md). Они понадобятся при создании ВМ.
1. Чтобы создать ВМ с рекомендуемыми характеристиками и загрузочным диском из образа Hystax Acura Backup:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. На панели слева выберите ![img](../../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
          * Введите имя `hystax-acura-vm` и описание ВМ.
          * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

            Сохраните обозначение зоны доступности, оно потребуется в дальнейшем.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:
          * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**.
          * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}**.
          * В списке публичных образов выберите [Hystax Acura Backup в {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-backup) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** укажите размер диска `200 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите:
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `8`.
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `16 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
          * Выберите в списке облачную [сеть](../../vpc/concepts/network.md#network). Если сети нет, нажмите кнопку **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}**. Задайте параметры сети и нажмите кнопку **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
          * Выберите [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, нажмите кнопку ![image](../../_assets/plus.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**. Задайте параметры подсети и нажмите кнопку **{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.button_create }}**. Сохраните идентификатор подсети, он потребуется в дальнейшем.
          * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**, выберите [группу безопасности](../../vpc/concepts/security-groups.md#default-security-group), для которой ранее настраивали разрешения сетевого трафика.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
          * Выберите сервисный аккаунт `hystax-acura-account`, [созданный ранее](#create-sa).
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя для доступа через SSH, например, `yc-user`.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа SSH.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      yc compute instance create \
        --name hystax-acura-vm \
        --zone <зона_доступности> \
        --cores 8 \
        --memory 16 \
        --network-interface subnet-id=<идентификатор_подсети>,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
        --create-boot-disk name=hystax-acura-disk,size=200,image-id=<идентификатор_образа_Hystax_Acura_Backup> \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --ssh-key <путь_к_файлу_открытого_ключа_SSH>
      ```

      Где:
      * `name` — имя ВМ, например, `hystax-acura-vm`.
      * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), например `{{ region-id }}-a`. Сохраните обозначение зоны доступности, оно потребуется в дальнейшем.
      * `cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
      * `memory` — [размер оперативной памяти](../../compute/concepts/vm.md) ВМ.
      * `network-interface` — описание сетевого интерфейса ВМ:
        * `subnet-id` — идентификатор подсети, к которой будет подключена ВМ. Получить список подсетей можно с помощью команды CLI `yc vpc subnet list`. Сохраните идентификатор подсети, он потребуется в дальнейшем.
        * `nat-ip-version=ipv4` — подключить публичный IP-адрес.
        * `security-group-ids` — группа безопасности. Используйте этот параметр, если группа была настроена ранее. Получить список групп можно с помощью команды CLI `yc vpc security-group list`. Если параметр не указывать, будет назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).
      * `create-boot-disk` — создать для ВМ новый диск:
        * `name` — имя диска, например `hystax-acura-disk`.
        * `size` — размер диска.
        * `image-id` — идентификатор образа диска. Используйте `image_id` из [описания продукта](/marketplace/products/hystax/hystax-acura-backup) в {{ marketplace-name }}.
      * `service-account-id` — идентификатор сервисного аккаунта, [созданного ранее](#create-sa). Получить список аккаунтов можно с помощью команды `yc iam service-account list`.
      * `ssh-key` — путь к файлу открытого ключа SSH. Имя пользователя по умолчанию для доступа по SSH — `yc-user`.

    - API {#api}

      Воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/instance_service.md#Create).

    {% endlist %}

## Сделайте IP-адрес ВМ статическим {#static-ip}

ВМ создаются с динамическим публичным IP-адресом. Так как ВМ с Hystax Acura Backup может быть перезагружена, сделайте IP-адрес статическим:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте страницу каталога, в котором вы работаете.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке адреса ВМ с Hystax Acura Backup.
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_static }}**.
  1. Сохраните IP-адрес, он потребуется в дальнейшем.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Просмотрите описание команд CLI для изменения атрибутов адреса:

      ```bash
      yc vpc address update --help
      ```

  1. Получите список имеющихся адресов:

      ```bash
      yc vpc address list
      ```

      Результат:

      ```bash
      +----------------------+------+-----------------+----------+------+
      |          ID          | NAME |     ADDRESS     | RESERVED | USED |
      +----------------------+------+-----------------+----------+------+
      | e2l46k8conff******** |      | {{ external-ip-examples.0 }}  | false    | true |
      +----------------------+------+-----------------+----------+------+
      ```

      Значение `false` параметра `RESERVED` для IP-адреса с `ID` `e2l46k8conff********` показывает, что этот адрес динамический.
  1. Сделайте адрес статическим, используя ключ `--reserved=true` и идентификатор (`ID`) IP-адреса:

      ```bash
      yc vpc address update --reserved=true <идентификатор_IP-адреса>
      ```

      Результат:

      ```bash
      id: e2l46k8conff********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-05-23T09:36:46Z"
      external_ipv4_address:
        address: {{ external-ip-examples.0 }}
        zone_id: {{ region-id }}-b
        requirements: {}
      reserved: true
      used: true
      ```

      Параметр `reserved` принял значение `true`, теперь IP-адрес статический.
  1. Сохраните IP-адрес, он потребуется в дальнейшем.

- API {#api}

  Воспользуйтесь методом REST API [update](../../vpc/api-ref/Address/update.md) для ресурса [Address](../../vpc/api-ref/Address/index.md) или вызовом gRPC API [AddressService/Update](../../vpc/api-ref/grpc/address_service.md#Update).

{% endlist %}

## Настройте Hystax Acura Backup {#setup-hystax-acura}

1. Откройте в [консоли управления]({{ link-console-main }}) страницу ВМ с Hystax Acura Backup и найдите ее публичный IP-адрес.
1. Введите в браузере публичный IP-адрес ВМ с Hystax Acura Backup. Откроется экран начальной настройки.

   {% note info %}

   После первоначального запуска ВМ с Hystax Acura Backup происходит процесс установки, который может занять более 20 минут.

   {% endnote %}

   По умолчанию на ВМ с Hystax Acura установлен самоподписанный сертификат. 

1. На открывшейся странице заполните следующие поля:
   * **Organization** — название вашей организации.
   * **Admin user login** — логин администратора.
   * **Password** — пароль администратора.
   * **Confirm password** — пароль администратора повторно.
1. Нажмите кнопку **Next**.
1. Задайте настройки подключения к {{ yandex-cloud }}:
    * **Service account ID** — идентификатор сервисного аккаунта (получен на шаге [Создайте сервисный аккаунт](#create-sa)).
    * **Key ID** — идентификатор авторизованного ключа сервисного аккаунта (получен на шаге [Создайте сервисный аккаунт](#create-sa)).
    * **Private key** — закрытый ключ сервисного аккаунта (получен на шаге [Создайте сервисный аккаунт](#create-sa)).

      {% note info %}

      {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}
 
      {% endnote %}

    * **Default folder ID** — [идентификатор](../../resource-manager/operations/folder/get-id.md) вашего каталога.
    * **Availability zone** — зона доступности, в которой находится ВМ с Hystax Acura Backup (получена на шаге [Создайте ВМ с Hystax Acura Backup](#create-acura-vm)).
    * **Hystax Service Subnet** — идентификатор подсети, к которой подключена ВМ с Hystax Acura Backup (получен на шаге [Создайте ВМ с Hystax Acura Backup](#create-acura-vm).
    * **S3 Host** — `{{ s3-storage-host }}`.
    * **S3 Port** — `443`.
    * **Enable HTTPS** — включите опцию HTTPS-соединения.
    * **S3 Access Key ID** — идентификатор ключа доступа (получен на шаге [Создайте сервисный аккаунт](#create-sa)).
    * **S3 Secret Access Key** — секретный ключ (получен на шаге [Создайте сервисный аккаунт](#create-sa)).
    * **S3 Bucket** — имя бакета для хранения резервных копий ВМ (получено на шаге [Создайте бакет](#create-bucket)).
    * **Hystax Acura Control Panel Public IP** — замените значение на публичный IP-адрес ВМ с Hystax Acura Backup (получен на шаге [Создайте ВМ с Hystax Acura Backup](#create-acura-vm)).
    * **Additional parameters** — дополнительные параметры. Оставьте поле без изменений.
1. Нажмите кнопку **Next**.

Hystax Acura Backup автоматически проверит доступ к вашему облаку. Если все выполнено верно, вы сможете войти в административную панель с помощью логина и пароля, заданных ранее.

## Подготовьте и установите агент на ВМ {#prepare-agent}

Чтобы установить агент на ВМ, резервные копии которых нужно создать:
1. Откройте административную панель Hystax Acura Backup. Нажмите на логотип Hystax.
1. На панели слева нажмите кнопку **Download agents**.
1. Выберите тип агента для нужной ОС:
   * VMware.
   * Windows.
   * Linux.
1. Нажмите кнопку **Next**.
1. Скачайте и установите агент на ВМ, резервные копии которых нужно создать:

   {% list tabs group=operating_system %}

   - VMware {#vmware}

     1. В выпадающем списке выберите группу ВМ, для которой будут подготовлены агенты, например `Default`.
     1. Выберите **New VMware vSphere** и заполните поля:
        * **Platform Name** — имя платформы.
        * **Endpoint** — публичный IP-адрес ESXi, на котором будет развернут агент репликации.
        * **Login** — логин (пользователь должен иметь права Администратора).
        * **Password** — пароль.

        Нажмите **Next**.
     1. Нажмите кнопку **Download Agent** и дождитесь окончания загрузки агента.
     1. Разверните загруженный OVA-файл с агентом в вашем кластере на ВМ, резервные копии которых нужно создать.
     1. Запустите ВМ с агентом.

   - Windows {#windows}

     1. В выпадающем списке выберите группу ВМ, для которой будут подготовлены агенты, например `Default`.
     1. Нажмите **Next**.
     1. Нажмите кнопку **Download Agent** и дождитесь окончания загрузки агента.
     1. Распакуйте архив и установите агент из файла `hwragent.msi` на ВМ, резервные копии которых нужно создать.

   - Linux {#linux}

     1. В выпадающем списке выберите группу ВМ, для которой будут подготовлены агенты, например `Default`.
     1. Выберите тип дистрибутива Linux:
        * **CentOS/RHEL (.rpm package)** — CentOS или ОС на базе Red Hat.
        * **Debian/Ubuntu (.deb package)** — Ubuntu или Debian.
     1. Выберите способ установки драйвера:
        * **Pre-built** — установка бинарного файла драйвера.
        * **DKMS** — компиляция во время установки.
     1. Нажмите **Next**.
     1. Будут сгенерированы команды для установки агента на ВМ. Выполните команды, следуя инструкциям для вашего дистрибутива и способа установки.

   {% endlist %}

ВМ будут отображены в целевой группе административной панели Hystax Acura Backup через несколько минут после установки агента.

## Создайте резервную копию ВМ {#start-protection}

После установки агента на защищаемые ВМ они появятся в списке со статусом `Unprotected`.

Чтобы включить защиту ВМ:
1. Откройте административную панель Hystax Acura Backup. Нажмите на логотип Hystax.
1. В блоке **Machines Groups** разверните группу ВМ, например `Default`.
1. В списке ВМ справа нажмите кнопку ![image](../../_assets/options.svg).
1. В меню **Edit replication settings** настройте расписание репликации для группы ВМ по часам, дням, неделям или беспрерывную защиту, в разделе **Volume type** укажите тип диска для восстановления: `network-hdd`, `network-ssd` или `network-ssd-nonreplicated`. 
1. В меню **Edit retention settings** укажите срок хранения резервных копий. Подробнее см. в [документации Hystax](https://hystax.com/documentation/dr/dr_overview.html#edit-replication-settings-schedule).
1. Выберите **Start Protection**.

Начнется процесс репликации ВМ. Реплика ВМ будет включать в себя все данные исходной ВМ, поэтому репликация может занять продолжительное время (зависит от размера диска исходной ВМ). Статус репликации будет отображаться в столбце **Status** блока **Machines Groups**. После окончания процесса они будут переведены в статус `Protected`.

## Создайте план восстановления {#create-recovery-plan}

План аварийного восстановления (DR plan) содержит описание ВМ и сетевые настройки. План определяет, какие машины будут восстановлены в ваше облако, а также конфигурацию ВМ, подсеть и IP-адрес. План можно сгенерировать автоматически или создать вручную:

{% list tabs group=instructions %}

- Автоматически {#auto}

  1. Откройте административную панель Hystax Acura Backup. Нажмите на логотип Hystax.
  1. Отметьте нужные ВМ в списке, затем нажмите кнопку **Bulk actions** и выберите **Generate DR plan**. Также план можно сгенерировать для группы ВМ, нажав кнопку ![image](../../_assets/options.svg) в заголовке группы.
  1. В поле **Name** введите название: `Plan-1`.
  1. В блоке **Subnets** справа укажите параметры подсети, в которой будут запущены ВМ после восстановления:  
      * В поле **Subnet ID** укажите идентификатор подсети.
      * В поле **CIDR** укажите [CIDR](../../vpc/concepts/network.md#subnet) подсети.
  1. Разверните описание ВМ и отредактируйте поле **Flavor name** (параметры вновь создаваемой ВМ) следующим образом: `<platform>-<cpu>-<ram>-<core_fraction>`. Например `3-8-16-100`.
      
      Где: 
      * `platform` — [платформа](../../compute/concepts/vm-platforms.md#standard-platforms) ВМ, например: `1`, `2` или `3`. 
      * `cpu` — количество vCPU.
      * `ram` — объем RAM.
      * `core_fraction` — уровень производительности vCPU.
  1. В поле **Port ip** укажите новый IP-адрес ВМ из выбранной подсети.
  1. Нажмите **Save**.

- Вручную {#manual}

  1. Откройте административную панель Hystax Acura Backup. Нажмите на логотип Hystax.
  1. Нажмите кнопку **Add DR Plan**.
  1. В поле **Name** введите название: `Plan-1`.
  1. В блоке **Devices & Ranks** нажмите кнопку ![image](../../_assets/options.svg). В открывшемся меню нажмите **Add machine**. Выберите группу ВМ, например `Default`. Выберите ВМ, которую следует добавить в план восстановления. Повторите действия для всех ВМ, которые следует восстановить.
  1. В блоке **Subnets** справа укажите параметры подсети, в которой будут запущены ВМ после восстановления:  
      * В поле **Subnet ID** укажите идентификатор подсети.
      * В поле **CIDR** укажите [CIDR](../../vpc/concepts/network.md#subnet) подсети.
  1. Разверните описание ВМ и отредактируйте поле **Flavor name** (параметры вновь создаваемой ВМ) следующим образом: `<platform>-<cpu>-<ram>-<core_fraction>`. Например `3-8-16-100`.
      
      Где: 
      * `platform` — [платформа](../../compute/concepts/vm-platforms.md#standard-platforms) ВМ, например: `1`, `2` или `3`. 
      * `cpu` — количество vCPU.
      * `ram` — объем RAM.
      * `core_fraction` — уровень производительности vCPU.
  1. В поле **Port ip** укажите новый IP-адрес ВМ из выбранной подсети.
  1. Нажмите **Save**.

{% endlist %}

{% note warning %}

Убедитесь, что для каждой ВМ указан правильный IP-адрес.

{% endnote %}

## Запустите восстановление {#run-recover}

Для восстановления ВМ из резервных копий Hystax Acura Backup создаст в облаке новую ВМ с Hystax Acura Cloud Agent, которая будет выполнять все дальнейшие операции в вашем облаке.

Чтобы запустить восстановление ВМ из резервных копий:
1. Откройте административную панель Hystax Acura Backup. Нажмите на логотип Hystax.
1. В блоке **DR plans** выберите созданный ранее план. При необходимости разверните план и внесите изменения.
1. Нажмите кнопку **Run Recover**.
1. В поле **Cloud Site Name** введите имя, например `Cloud-Site-from-Plan-1`.
1. Убедитесь, что в блоке **Final DR plan** в списке находятся все требуемые ресурсы и нажмите кнопку **Run Recover**.

    На административной панели Hystax Acura Backup появится блок **Cloud Sites**. Процесс восстановления ВМ может занять длительное время. Статус восстановления будет отображаться в столбце **Status** блока **Machines**. Дождитесь, когда статус восстановления перейдет в состояние `Running`.

1. Откройте [консоль управления]({{ link-console-main }}) и проверьте, что требуемые ресурсы успешно восстановлены.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ Hystax Acura Backup.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) вспомогательные ВМ Hystax Cloud Agent.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) восстановленные ВМ.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт для Hystax Acura Backup.
1. [Удалите](../../vpc/operations/address-delete.md) зарезервированный публичный статический IP-адрес. 
