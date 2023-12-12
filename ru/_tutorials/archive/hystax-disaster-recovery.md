# Защита от сбоев с помощью Hystax Acura

Вы можете защитить вашу инфраструктуру с помощью решения Hystax Acura, вне зависимости от размещения ресурсов.

Поддерживаемые платформы:
* Облачные сервисы.
* Гипервизоры.
* Физические серверы.

Чтобы начать, создайте ВМ с [Hystax Acura Disaster Recovery](/marketplace/products/hystax/hystax-acura-disaster-recovery), которая управляет процессами репликации и восстановления. Постоянную и периодическую репликацию выполняют вспомогательные ВМ Hystax Cloud Agent. Подробное описание архитектуры см. в [документации](https://hystax.com/documentation/dr/solution_description.html#architecture).

Для запуска Hystax Acura Disaster Recovery выполните следующие шаги:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт и авторизованный ключ](#create-sa).
1. [Настройте разрешения сетевого трафика](#network-settings).
1. [Создайте ВМ с Hystax Acura](#create-acura-vm).
1. [Настройте Hystax Acura](#setup-hystax-acura).
1. [Подготовьте и установите агенты для аварийного восстановления](#prepare-agent).
1. [Включите репликацию](#start-protection).
1. [Подготовьте подсети для запуска ВМ](#prepare-network).
1. [Создайте план аварийного восстановления](#disaster-recovery-plan).
1. [Проведите учения](#run-tests).
1. [Проведите аварийное восстановление](#run-recover).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% note info %}

Обратите внимание, что оплачиваться и учитываться в [квотах]({{ link-console-quotas }}) будут как инфраструктура для Hystax Acura, так и все восстановленные ВМ.
* ВМ для Hystax Acura Disaster Recovery использует 8 ядер vCPU, 16 ГБ памяти и диск на 200 ГБ.
* Вспомогательные ВМ Hystax Cloud Agent используют 2 ядра vCPU, 4 ГБ памяти и диск на 10 ГБ. Одна ВМ Hystax Cloud Agent может одновременно обслуживать до 6 реплицируемых дисков. В случае, если дисков больше 6, автоматически будут созданы дополнительные ВМ Hystax Cloud Agent.

{% endnote %}

В стоимость ресурсов для использования Hystax Acura Disaster Recovery входят:
* Плата за диски и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за хранение образов (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за каждую защищаемую ВМ (см. [описание продукта](/marketplace/products/hystax/hystax-acura-disaster-recovery) в {{ marketplace-name }}).


## Создайте сервисный аккаунт и авторизованный ключ {#create-sa}

Приложение Hystax Acura Disaster Recovery будет выполнять действия от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `hystax-acura-account` с ролями `editor`, `marketplace.meteringAgent`.
1. [Создайте](../../iam/operations/authorized-key/create.md) авторизованный ключ для сервисного аккаунта.

Сохраните для использования на последующих шагах:
1. Идентификатор сервисного аккаунта.
1. Идентификатор авторизованного ключа для сервисного аккаунта.
1. Приватную часть авторизованного ключа для сервисного аккаунта.

## Настройте разрешения сетевого трафика {#network-settings}

Настройте разрешения сетевого трафика в [группе безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group). Если группа безопасности не доступна, для ВМ будет разрешен любой входящий и исходящий трафик.

Если группа безопасности доступна, [добавьте](../../vpc/operations/security-group-add-rule.md) в нее следующие правила:

Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
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

Сохраните идентификатор группы безопасности. Он понадобится при создании ВМ с Hystax Acura.

## Создайте ВМ с Hystax Acura {#create-acura-vm}

Создайте ВМ с загрузочным диском из образа `Hystax Acura Disaster Recovery to {{ yandex-cloud }}`.

### Запустите ВМ

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
     * Введите имя `hystax-acura-vm` и описание ВМ.
     * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}**.
      * В списке публичных образов выберите [Hystax Acura Disaster Recovery to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-disaster-recovery) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** укажите размер диска `200 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите:
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `8`.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `16 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     * Выберите в списке облачную сеть и [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, нажмите кнопку **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}** и создайте ее.

       Для этого в открывшемся окне выберите каталог, укажите имя подсети, выберите зону доступности и укажите CIDR. Затем нажмите кнопку **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
     * Если доступен список **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**, выберите [группу безопасности](../../vpc/concepts/security-groups.md#default-security-group), для которой ранее настраивали разрешения сетевого трафика. Если такого списка нет, для ВМ будет разрешен любой входящий и исходящий трафик.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
     * Выберите сервисный аккаунт `hystax-acura-account`, созданный ранее.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя для доступа через [SSH](../../glossary/ssh-keygen.md), например, `yc-user`.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте [открытый ключ SSH](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   В терминале выполните следующую команду:

   ```bash
   yc compute instance create \
     --name hystax-acura-vm \
     --zone <зона доступности> \
     --cores 8 \
     --memory 16 \
     --network-interface subnet-id=<идентификатор подсети>,nat-ip-version=ipv4,security-group-ids=<идентификатор группы безопасности, если группа была настроена ранее> \
     --create-boot-disk name=hystax-acura-disk,size=200,image-id=<идентификатор образа Hystax Acura> \
     --service-account-id <идентификатор сервисного аккаунта> \
     --ssh-key ~/.ssh/id_ed25519.pub
     ```

   Где:

   * `name` — имя ВМ, например, `hystax-acura-vm`.
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), например, `{{ region-id }}-a`.
   * `cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
   * `memory` — [размер оперативной памяти](../../compute/concepts/vm.md) ВМ.
   * `network-interface` — описание сетевого интерфейса ВМ:
     * `subnet-id` — подсеть, к которой будет подключена ВМ.

       Получить список подсетей можно с помощью команды `yc vpc subnet list`.
     * `nat-ip-version=ipv4` — подключить публичный IP-адрес.
     * `security-group-ids` — группы безопасности.

       Получить список групп можно с помощью команды `yc vpc security-group list`. Если параметр не указывать, будет назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).
   * `create-boot-disk` — создать для ВМ новый диск:
      * `name` — имя диска, например, `hystax-acura-disk`.
      * `size` — размер диска.
      * `image-id` — идентификатор образа диска.

        В данном случае используйте `image_id` из [описания продукта](/marketplace/products/hystax/hystax-acura-disaster-recovery) в {{ marketplace-name }}.

   * `service-account-id` — идентификатор сервисного аккаунта, [созданного ранее](#create-sa).

     Получить список можно с помощью команды `yc iam service-account list`.
   * `ssh-key` — путь к файлу [открытого ключа SSH](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

{% endlist %}

### Сделайте IP-адрес статическим

ВМ создаются с динамическим публичным IP-адресом. Так как ВМ с Hystax Acura может быть перезагружена, сделайте IP-адрес статическим.

{% list tabs %}

- Консоль управления

  Чтобы изменить тип публичного IP-адреса с динамического на статический:
  1. В [консоли управления]({{ link-console-main }}) откройте страницу каталога, в котором вы работаете.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке адреса ВМ с Hystax Acura.
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_static }}**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить тип публичного IP-адреса с динамического на статический:

  1. Просмотрите описание команд CLI для изменения атрибутов адреса:

     ```bash
     yc vpc address update --help
     ```

  1. Получите список адресов:

     ```bash
     yc vpc address list
     ```

     Результат:

     ```bash
     +----------------------+------+-----------------+----------+------+
     |          ID          | NAME |     ADDRESS     | RESERVED | USED |
     +----------------------+------+-----------------+----------+------+
     | e2l46k8conff8n6ru1jl |      | {{ external-ip-examples.0 }}  | false    | true |
     +----------------------+------+-----------------+----------+------+
     ```

     Значение `false` параметра `RESERVED` для IP-адреса с `ID` `e2l46k8conff8n6ru1jl` показывает, что этот адрес динамический.
  1. Сделайте адрес статическим, используя ключ `--reserved=true` и `ID` адреса:

     ```bash
     yc vpc address update --reserved=true e2l46k8conff8n6ru1jl
     ```

     Результат:

     ```bash
     id: e2l46k8conff8n6ru1jl
     folder_id: b1g7gvsi89m34pipa3ke
     created_at: "2023-06-02T09:36:46Z"
     external_ipv4_address:
       address: {{ external-ip-examples.0 }}
       zone_id: {{ region-id }}-b
       requirements: {}
     reserved: true
     used: true
     ```

     Параметр `reserved` принял значение `true`, теперь IP-адрес статический.

{% endlist %}

## Настройте Hystax Acura {#setup-hystax-acura}

1. Откройте в [консоли управления]({{ link-console-main }}) страницу ВМ `hystax-acura-vm` и найдите ее публичный IP-адрес.
1. Введите в браузере публичный IP-адрес ВМ `hystax-acura-vm`. Откроется экран начальной настройки Hystax Acura.

   {% note info %}

   После первоначального запуска ВМ с Hystax Acura Disaster Recovery происходит процесс установки, который может занять более 20 минут.

   {% endnote %}

1. По умолчанию на ВМ с Hystax Acura установлен самоподписанный сертификат.
1. На открывшейся странице заполните следующие поля:
   * **Organization** — название вашей организации.
   * **Admin user login** — адрес электронной почты для входа в административную панель.
   * **Password** — пароль администратора.
   * **Confirm password** — пароль администратора повторно.
1. Нажмите кнопку **Next**.
1. Задайте настройки подключения к {{ yandex-cloud }}:
   * **Service Account id** — идентификатор сервисного аккаунта.
   * **Key id** — идентификатор авторизованного ключа сервисного аккаунта.
   * **Private Key** — закрытая часть авторизованного ключа сервисного аккаунта.

     {% note info %}

     {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}

     {% endnote %}
     
   * **Default Folder id** — идентификатор вашего каталога.
   * **Zone** — зона доступности.
   * **Hystax Service Subnet** — идентификатор подсети, к которой подключена ВМ `hystax-acura-vm`.
   * **S3 Host** — `{{ s3-storage-host }}`.
   * **S3 Port** — `443`.
   * **Enable HTTPS** — включите опцию HTTPS-соединения.
   * **Hystax Acura Control Panel Public IP** — публичный IP-адрес ВМ с Hystax Acura. Замените значение, установленное в поле, на IP-адрес, полученный на шаге 1.
1. Нажмите кнопку **Next**.

Hystax Acura автоматически проверит доступ к вашему облаку. Если все выполнено верно, вы сможете войти в административную панель с помощью своего адреса электронной почты и пароля.

## Подготовьте и установите агенты для аварийного восстановления {#prepare-agent}

Агенты устанавливаются на ВМ, восстановление которых будет происходить в {{ yandex-cloud }}. Чтобы получить и установить агент:
1. В административной панели Hystax Acura нажмите на логотип Hystax в левом верхнем углу.
1. В блоке **Machines Groups** создайте группу защищаемых ВМ, например, `Prod-Web`.
1. Перейдите на вкладку **Download agents**.
1. Выберите один из трех типов агентов для ОС:
   * VMware.
   * Windows.
   * Linux.

   Нажмите кнопку **Next**.
1. Скачайте и установите агент на ваши ВМ, которые предстоит защитить:

   {% list tabs group=operating_system %}

   - VMware {#vmware}

     1. В выпадающем списке выберите группу ВМ, для которой будут подготовлены агенты, например, `Prod-Web`.
     1. Выберите **New VMware vSphere** и заполните поля:
        * **Platform Name** — имя платформы.
        * **Endpoint** — публичный IP-адрес ESXi.
        * **Login** — логин (пользователь должен иметь права Администратора).
        * **Password** — пароль.

        Нажмите **Next**.
     1. Нажмите кнопку **Download Agent** и дождитесь окончания загрузки агента.
     1. Разверните загруженный OVA-файл с агентом на хосте ESXi.
     1. Запустите ВМ с агентом.

   - Windows {#windows}

     1. В выпадающем списке выберите группу ВМ, для которой будут подготовлены агенты, например, `Prod-Web`.
     1. Нажмите **Next**.
     1. Нажмите кнопку **Download Agent** и дождитесь окончания загрузки агента.
     1. Распакуйте архив и установите агент из файла `hwragent.msi` на ВМ, которые требуется защитить.

   - Linux {#linux}

     1. В выпадающем списке выберите группу ВМ, для которой будут подготовлены агенты, например, `Prod-Web`.
     1. Выберите тип дистрибутива Linux:
        * **CentOS/RHEL (.rpm package)** — CentOS или ОС на базе Red Hat.
        * **Debian/Ubuntu (.deb package)** — Ubuntu или Debian.
     1. Выберите способ установки драйвера:
        * **Pre-built** — установка бинарного файла драйвера.
        * **DKMS** — компиляция во время установки.
     1. Нажмите **Next**.
     1. Будут сгенерированы команды для установки агента на ВМ. Выполните команды, следуя инструкциям для вашего дистрибутива и способа установки.

   {% endlist %}

## Включите репликацию {#start-protection}

После установки агента на защищаемые ВМ они появятся в списке со статусом `Unprotected`.

Чтобы включить репликацию ВМ:
1. Откройте административную панель Hystax Acura. Нажмите на логотип Hystax.
1. В блоке **Machines Groups** разверните группу ВМ, например, `Prod-Web`.
1. В списке ВМ справа нажмите кнопку ![image](../../_assets/options.svg).
1. Настройте расписание репликации и срок хранения снимков с помощью опций **Edit replication schedule** и **Edit retention policies**. Подробнее см. в [документации Hystax](https://hystax.com/documentation/dr/dr_overview.html#edit-replication-settings-schedule).
1. Выберите **Start Protection**.

Начнется процесс репликации ВМ. После окончания процесса они будут переведены в статус `Protected`.

## Подготовьте подсети для запуска ВМ {#prepare-network}

При запуске процесса восстановления будет создан Cloud site — инфраструктура для работы вашего приложения в {{ yandex-cloud }}, которая включает [подсети](../../vpc/concepts/network.md#subnet) и восстановленные ВМ.

Создайте подсети, CIDR которых будет содержать IP-адреса ваших ВМ.

Например, если вы защищаете две ВМ с IP-адресами `10.155.0.23` и `192.168.0.3`, создайте две подсети с CIDR `10.155.0.0/16` и `192.168.0.0/24`. Подсети должны находиться в одной [зоне доступности](../../overview/concepts/geo-scope.md) с ВМ Hystax Acura Disaster Recovery.

Чтобы создать подсети:

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в каталоге, где требуется создать подсеть.
  1. Нажмите на имя облачной сети.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
  1. Укажите название подсети, например, `net-b-155`.
  1. Выберите зону доступности из выпадающего списка, например, `{{ region-id }}-b`.
  1. Введите CIDR подсети, например, `10.155.0.0/16`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

  Сохраните **Идентификаторы** созданных подсетей. Они понадобятся при создании плана аварийного восстановления (DR plan).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите список облачных сетей:

     ```bash
     yc vpc network list
     ```

     Результат:

     ```bash
     +----------------------+----------------+
     |          ID          |      NAME      |
     +----------------------+----------------+
     | enplum7a98s1t0lhasi8 |    network     |
     +----------------------+----------------+
     ```

  1. Выберите `NAME` или `ID` требуемой облачной сети. Создайте подсеть:

     ```bash
     yc vpc subnet create \
       --name net-b-155 \
       --network-name network \
       --zone {{ region-id }}-b \
       --range 10.155.0.0/16
     ```

  1. Чтобы посмотреть список подсетей, выполните команду:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```bash
      +----------------------+-------------+----------------------+----------------+---------------+------------------+
      |          ID          |    NAME     |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+-------------+----------------------+----------------+---------------+------------------+
      | e2lgjspicv43ainspl0n | net-b-155   | enplum7a98s1t0lhasi8 |                | {{ region-id }}-b | [10.155.0.0/16]  |
      | e2l8g5u9ijd1sursv2ov | net-b-192   | enplum7a98s1t0lhasi8 |                | {{ region-id }}-b | [192.168.0.0/24] |
      | e2l1hqsrpp932ik74aic | net-b       | enplum7a98s1t0lhasi8 |                | {{ region-id }}-b | [192.168.1.0/24] |
      +----------------------+-------------+----------------------+----------------+---------------+------------------+
      ```

      Сохраните `ID` созданных подсетей. Они понадобятся при создании плана аварийного восстановления (DR plan).

{% endlist %}

Подробнее см. в разделе [Пошаговые инструкции](../../vpc/operations/subnet-create.md) документации {{ vpc-name }}.

## Создайте план аварийного восстановления {#disaster-recovery-plan}

План аварийного восстановления (DR plan) содержит описание ВМ и сетевые настройки. План можно сгенерировать автоматически или создать вручную.

{% list tabs %}

- Сгенерировать

  Чтобы сгенерировать DR plan автоматически:
  1. Откройте административную панель Hystax Acura. Нажмите на логотип Hystax.
  1. Отметьте нужные ВМ в списке, затем нажмите кнопку **Bulk actions** и выберите **Generate DR plan**. Также план можно сгенерировать для группы ВМ, нажав кнопку ![image](../../_assets/options.svg) в заголовке группы.
  1. В поле **Name** введите название: `Plan-1`.
  1. В блоке **Subnets** справа укажите параметры подсетей, созданных ранее: **Subnet ID** и **CIDR**.
  1. Нажмите **Save**.

- Вручную

  Чтобы создать DR plan вручную:
  1. Откройте административную панель Hystax Acura. Нажмите на логотип Hystax.
  1. Нажмите кнопку **Add DR Plan**.
  1. В поле **Name** введите название: `Plan-1`.
  1. Используйте один из режимов:
     * `Basic` — создание плана со стандартными настройками.
     * `Expert` — создание плана с гибкими настройками с использованием формата JSON (см. [подробное описание синтаксиса](https://hystax.com/documentation/dr/dr_overview.html#id2)).
  1. Добавьте ВМ с помощью кнопки ![image](../../_assets/options.svg). При необходимости укажите порядок их инициализации с помощью опции **Move to another Rank**.
  1. При необходимости измените параметры создаваемых ВМ в поле **Flavor name** следующим образом: `<platform>-<cpu>-<ram>-<core_fraction>`. Например, `2-8-16-100`.
  1. В блоке **Subnets** справа укажите параметры подсетей, созданных ранее: **Subnet ID** и **CIDR**.
  1. Нажмите **Save**.

  {% note warning %}

  Убедитесь, что для каждой ВМ указан правильный IP-адрес.

  {% endnote %}

{% endlist %}

## Проведите учения {#run-tests}

Регулярные учения позволяют проверить готовность к сбоям, а также заранее внести изменения в конфигурацию.

Чтобы провести тест без остановки главной инфраструктуры:
1. Откройте административную панель Hystax Acura. Нажмите на логотип Hystax.
1. В верхней навигационной панели выберите **Run test Cloud Site**.
1. Отметьте в списке планы аварийного восстановления. При необходимости разверните план и внесите изменения.
1. Нажмите **Next**.
1. В поле **Cloud Site Name** введите имя, например, `Cloud-Site-from-Plan-1`.
1. В поле **Restore point time** откройте календарь и выберите время точки восстановления, из которой будут созданы ВМ.
1. В блоке **Final DR plan** проверьте актуальность и корректность плана.
1. Нажмите **Run Recover**.

В административной панели Hystax Acura появится блок **Cloud Sites**. Дождитесь, когда `Cloud-Site-from-Plan-1` перейдет в состояние `Running`.

Откройте [консоль управления]({{ link-console-main }}) и проверьте, что требуемые ресурсы успешно перенесены и приложения готовы к работе.

## Проведите аварийное восстановление {#run-recover}

Порядок аварийного восстановления ничем не отличается от тестового:
1. Откройте административную панель Hystax Acura. Нажмите на логотип Hystax.
1. В верхней навигационной панели выберите **Run Cloud Site**.

Повторите шаги [тестового восстановления](#run-tests).

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `hystax-acura-vm`.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) вспомогательные ВМ `cloud-agent`.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт `hystax-acura-account`.

Если вы зарезервировали публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).