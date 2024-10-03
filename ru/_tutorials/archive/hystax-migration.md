# Миграция в {{ yandex-cloud }} с помощью Hystax Acura

Вы можете мигрировать вашу облачную инфраструктуру с другой облачной платформы в {{ yandex-cloud }} с помощью Hystax Acura. Для миграции в вашем облаке нужно создать ВМ с Hystax Acura, под управлением которой будет настраиваться и осуществляться миграция. Саму миграцию будет выполнять служебная ВМ с Hystax Acura Cloud Agent, которая перенесет мигрируемые ВМ в ваше облако. Перед миграцией ВМ будут созданы реплики ВМ, которые будут использованы в процессе миграции для развертывания инфраструктуры.

Чтобы произвести миграцию:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт и авторизованный ключ](#create-sa).
1. [Настройте разрешения сетевого трафика](#network-settings).
1. [Создайте ВМ с Hystax Acura](#create-acura-vm).
1. [Настройте Hystax Acura](#setup-hystax-acura).
1. [Подготовьте Hystax Acura Cloud Agent](#prepare-agent).
1. [Создайте реплики ВМ](#create-replicas).
1. [Создайте план миграции](#prepare-migration-plan).
1. [Запустите миграцию](#start-migration).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% note info %}

Обратите внимание, что оплачиваться и учитываться в [квотах]({{ link-console-quotas }}) будут как инфраструктура для Hystax Acura и Hystax Acura Cloud Agent, так и все мигрированные ВМ.
* ВМ для Hystax Acura использует 8 ядер vCPU, 16 ГБ памяти и диск на 200 ГБ.
* ВМ для Hystax Acura Cloud Agent использует 2 ядра vCPU, 4 ГБ памяти и диск на 8 ГБ.

{% endnote %}

В стоимость ресурсов для использования Hystax Acura Live Migration входят:
* Плата за диски и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за хранение образов (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за каждую проведенную миграцию (см. [описание продукта](/marketplace/products/hystax/hystax-acura-live-cloud-migration) в {{ marketplace-name }}).

## Создайте сервисный аккаунт и авторизованный ключ {#create-sa}

Приложение Hystax Acura Live Migration будет выполнять действия от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `hystax-acura-account` с ролями `editor`, `marketplace.meteringAgent`.
1. [Создайте](../../iam/operations/authorized-key/create.md) авторизованный ключ для сервисного аккаунта.

Сохраните для использования на последующих шагах:
1. Идентификатор сервисного аккаунта.
1. Идентификатор авторизованного ключа для сервисного аккаунта.
1. Приватную часть авторизованного ключа для сервисного аккаунта.

## Настройте разрешения сетевого трафика {#network-settings}

Настройте разрешения сетевого трафика в [группе безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group). Если группа безопасности недоступна, для ВМ будет разрешен любой входящий и исходящий трафик.

Если группа безопасности доступна, [добавьте](../../vpc/operations/security-group-add-rule.md) в нее следующие правила:

Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
--- | --- | --- | --- | --- | ---
Входящий | `http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `https` | `4443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `vmware` | `902` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `vmware` | `902` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `iSCSI` | `3260` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `udp` | `12201` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `tcp` | `15000` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `vmware` | `902` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `vmware` | `902` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `iSCSI` | `3260` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Исходящий | `udp` | `12201` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

Сохраните идентификатор группы безопасности. Он понадобится при создании ВМ с Hystax Acura.

## Создайте ВМ с Hystax Acura {#create-acura-vm}

Создайте ВМ с загрузочным диском из образа [Hystax Acura Live Migration to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
      * В списке публичных образов выберите [Hystax Acura Live Cloud Migration to {{ yandex-cloud }}](/marketplace/products/hystax/hystax-acura-live-cloud-migration) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** укажите размер загрузочного [диска](../../compute/concepts/disk.md): `200 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите конфигурацию с `8 vCPU` и `16 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**: 

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

              * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
              * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
              * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * Если доступен список **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**, выберите [группу безопасности](../../vpc/concepts/security-groups.md#default-security-group), для которой ранее настраивали разрешения сетевого трафика. Если такого списка нет, для ВМ будет разрешен любой входящий и исходящий трафик.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например, `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `hystax-acura-vm`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите сервисный аккаунт `hystax-acura-account`, созданный ранее.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

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

        В данном случае используйте `image_id` из [описания продукта](/marketplace/products/hystax/hystax-acura-live-cloud-migration) в {{ marketplace-name }}.

   * `service-account-id` — идентификатор сервисного аккаунта, [созданного ранее](#create-sa).

     Получить список можно с помощью команды `yc iam service-account list`.
   * `ssh-key` — путь к файлу [открытого ключа SSH](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

{% endlist %}

## Настройте Hystax Acura {#setup-hystax-acura}

1. Откройте в [консоли управления]({{ link-console-main }}) страницу ВМ `hystax-acura-vm` и найдите ее публичный IP-адрес.
1. Введите в браузере публичный IP-адрес ВМ `hystax-acura-vm`. Откроется экран начальной настройки Hystax Acura.

   {% note info %}

   После первоначального запуска ВМ с Hystax Acura Live Cloud Migration происходит процесс установки, который может занять более 20 минут.

   {% endnote %}

1. По умолчанию на ВМ с Hystax Acura установлен самоподписанный сертификат.
1. Когда появится запрос на заполнение полей, укажите следующие значения:
   * **Огранизация** — название вашей организации.
   * **Логин пользователя-администратора** — адрес электронной почты для входа в административную панель.
   * **Пароль** — пароль администратора.
   * **Подтвердите пароль** — пароль администратора повторно.
1. Нажмите кнопку **Далее**.
1. Задайте настройки подключения к {{ yandex-cloud }}:
   * **ID сервисного аккаунта** — идентификатор сервисного аккаунта.
   * **ID ключа** — идентификатор авторизованного ключа сервисного аккаунта.
   * **Приватный ключ** — приватный ключ сервисного аккаунта.

     {% note info %}

     {% include [hystax-auth-key-newlines](../_tutorials_includes/hystax-auth-key-newlines.md) %}

     {% endnote %}

   * **ID каталога по умолчанию** — идентификатор вашего каталога.
   * **Зона доступности** — зона доступности, в которой находится ВМ `hystax-acura-vm`.
   * **Служебная подсеть Hystax** — идентификатор подсети, к которой подключена ВМ `hystax-acura-vm`.
   * **Хост S3** — `{{ s3-storage-host }}`.
   * **Порт S3** — `443`.
   * **Включить HTTPS** — включите опцию HTTPS-соединения.
   * **Публичный IP-адрес панели управления Hystax Acura** — публичный IP-адрес ВМ `hystax-acura-vm`. Замените значение, установленное в поле, на IP-адрес, полученный на шаге 1.
   * **Дополнительные параметры** — дополнительные параметры. Оставьте поле без изменений.
1. Нажмите кнопку **Далее**.

Hystax Acura автоматически проверит доступ к вашему облаку. Если все выполнено верно, вы сможете войти в административную панель с помощью указанного адреса электронной почты и пароля.

## Подготовьте и установите агенты для миграции {#prepare-agent}

Агенты устанавливаются на ВМ, которые предстоит мигрировать в {{ yandex-cloud }}. Чтобы получить и установить агент:
1. Если миграция производится с VMware ESXi, Microsoft Hyper-V или иного гипервизора, отличного от KVM, то перед миграцией [установите virtio-драйверы](../../compute/operations/image-create/custom-image#virtio) на виртуальную машину.
1. В административной панели Hystax Acura выберите вкладку **Загрузка агента**.
1. Выберите один из типов агентов для ОС:
   * VMware.
   * Windows.
   * Linux.

   Нажмите кнопку **Далее**.
1. Скачайте и установите агент на ваши ВМ, которые предстоит мигрировать:

   {% list tabs group=operating_system %}

   - VMware {#vmware}

     1. Выберите **Новая VMware vSphere** и заполните поля:
        * **Имя платформы** — имя платформы.
        * **IP-адрес хоста** — IP-адрес хоста VMware ESXi, на котором будет развернут агент репликации.
        * **Логин** — логин.
        * **Пароль** — пароль.

        Нажмите **Далее**.
     1. Нажмите кнопку **Загрузка агента** и дождитесь окончания загрузки агента.
     1. Разверните загруженный OVA-файл с агентом на ВМ в вашем кластере.
     1. Запустите машины с агентом.

   - Windows {#windows}

     1. Нажмите **Длалее**.
     1. Нажмите кнопку **Загрузка агента** и дождитесь окончания загрузки агента.
     1. Распакуйте архив и установите агент из файла `hwragent.msi` на ВМ, которые требуется мигрировать.

   - Linux {#linux}

     1. Выберите тип дистрибутива Linux:
        * **CentOS/RHEL (.rpm package)** — CentOS или ОС на базе Red Hat.
        * **Debian/Ubuntu (.deb package)** — Ubuntu или Debian.
     1. Выберите способ установки драйвера:
        * **Pre-built** — установка бинарного файла драйвера.
        * **DKMS** — компиляция во время установки.
     1. Нажмите **Далее**.
     1. Будут сгенерированы команды для установки агента на ВМ. Выполните команды, следуя инструкциям для вашего дистрибутива и способа установки.

   {% endlist %}

ВМ будет отображена в целевой группе через несколько минут после установки агента.

## Создайте реплики ВМ {#create-replicas}

{% note alert %}

При запуске репликации Hystax Acura создаст в облаке новую ВМ с Hystax Acura Cloud Agent, которая будет выполнять все операции в вашем облаке.

{% endnote %}

Запустите репликацию:
1. Нажмите на логотип Hystax.
1. В блоке **Группы машин** отметьте ВМ, реплики которых надо создать.
1. В меню редактирования репликации можно указать дополнительные параметры тома `network-ssd`.
1. Нажмите кнопку **Групповые действия** и в открывшемся меню выберите **Запуск репликации**.

Реплика ВМ будет включать в себя все данные исходной ВМ, поэтому репликация может занять продолжительное время (около 40 минут). Статус репликации будет отображаться в столбце **Статус** блока **Группы машин**. Дождитесь статуса `Synced` и убедитесь, что в вашем каталоге в списке ВМ сервиса {{ compute-name }} появились реплики выбранных машин.

## Создайте план миграции {#prepare-migration-plan}

После перехода реплицирующихся ВМ в состояние `Synced` можно создать план миграции. План миграции определяет, какие машины будут перенесены в ваше облако и порядок их запуска после переноса.
1. Нажмите кнопку **Add Migration plan**.
1. Введите имя плана миграции: `YC Migration`.
1. В блоке **Devices & Ranks** нажмите ![options](../../_assets/options.svg). В открывшемся меню выберите **Add machine** → группу ВМ → ВМ, которую следует добавить в план миграции. Повторите действия для всех ВМ, которые следует мигрировать.
1. В полях **Subnet ID** и **CIDR** укажите идентификатор и CIDR подсети, к которой будут подключены ВМ после миграции.
1. Разверните описание устройства и отредактируйте поле **Flavor name** (параметры создаваемой ВМ) следующим образом: `<platform>-<cpu>-<ram>-<core_fraction>`. Например, `2-8-16-100`.
1. В поле **Port ip** укажите новый IP-адрес ВМ из текущей подсети.
1. Нажмите кнопку **Save**.

## Запустите миграцию {#start-migration}

По созданному плану выполните миграцию:
1. Откройте вкладку **Migrate**.
1. Выберите план `YC Migration` и нажмите **Next**.
1. Задайте имя `CloudSite` в поле **Cloud Site Name**.
1. Убедитесь, что в списке находятся все требуемые ресурсы и нажмите кнопку **Run migration**.

Процесс миграции может занять около 10 минут. Статус готовности мигрируемой ВМ к работе будет отображаться в столбце **Status** блока **Machines**. Дождитесь статуса `Running` и убедитесь, что все требуемые ресурсы перенесены и ваши приложения готовы к работе. Если мигрированная инфраструктура работает как ожидается, нажмите кнопку **Detach** на странице **CloudSite** и подтвердите отсоединение.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за инфраструктуру для миграции:
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `hystax-acura-vm`.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) вспомогательные ВМ `cloud-agent`.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт `hystax-acura-account`.

Если вы зарезервировали публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
