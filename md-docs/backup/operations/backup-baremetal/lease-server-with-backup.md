# Арендовать сервер {{ baremetal-full-name }} с подключением к {{ backup-name }}


Вы можете создавать резервные копии [серверов](../../../baremetal/concepts/servers.md) {{ baremetal-name }} с поддерживаемыми операционными системами на базе Linux: {#os-support}

* CentOS 7;
* Debian 11;
* Ubuntu 16.04 LTS;
* Ubuntu 18.04 LTS;
* Ubuntu 20.04 LTS;
* Ubuntu 22.04 LTS;
* Ubuntu 24.04 LTS.

Чтобы подключить сервер к {{ backup-full-name }}, необходима [роль](../../security/index.md#backup-user) `backup.user` или выше.

{% note warning %}

С 1 августа 2026 года роли [`baremetal.editor`](../../../baremetal/security/index.md#baremetal-editor) и [`baremetal.admin`](../../../baremetal/security/index.md#baremetal-admin) получают новый набор разрешений, позволяющий подключать серверы {{ baremetal-name }} к сервису {{ backup-full-name }}, а также привязывать и отвязывать их от [политик резервного копирования](../../concepts/policy.md).

Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](../../../iam/concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](../../../iam/operations/access-policies/assign.md).

{% endnote %}

## Аренда сервера {#server-rent}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите арендовать сервер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}** и в открывшемся окне выберите вариант `{{ ui-key.yacloud_components.baremetal.StockConfigurations }}` и подходящую [конфигурацию](../../../baremetal/concepts/server-configurations.md) сервера {{ baremetal-name }}.
     
     Чтобы выбрать подходящую вам конфигурацию сервера, нажмите на блок с именем этой конфигурации в центральной части экрана.
     
     {% note info %}
     
     Чтобы быстрее подобрать подходящую конфигурацию, вы можете воспользоваться фильтром с аппаратными характеристиками конфигураций в правой части экрана.
     
     {% endnote %}
     
     {% note tip %}
     
     Вы можете снизить стоимость аренды сервера в некоторых конфигурациях, заказав его [сборку](../../../baremetal/concepts/server-custom-configurations.md#assembly).
     
     Чтобы воспользоваться скидкой, в блоке с нужной конфигурацией наведите курсор на **{{ ui-key.yacloud_components.baremetal.assemblyDiscountLabel }}** ![circle-info.svg](../../../_assets/console-icons/circle-info.svg) и во всплывающем окне нажмите ![person-nut-hex.svg](../../../_assets/console-icons/person-nut-hex.svg) **{{ ui-key.yacloud_components.baremetal.goToAssembly }}**.
     
     При заказе сервера со сборкой воспользуйтесь приведенной ниже инструкцией, чтобы задать необходимые параметры сервера. При этом сервер станет доступен вам не сразу, а после завершения сборки (в течение четырех календарных дней) и по более низкой цене.
     
     {% endnote %}
  1. В блоках **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, **{{ ui-key.yacloud.baremetal.title_section-location }}** и **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** убедитесь, что параметры выбранной конфигурации сервера соответствуют вашим потребностям.
     
     Если выбранные параметры вам не подходят, нажмите значок ![arrow-left](../../../_assets/console-icons/arrow-left.svg) в блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, чтобы вернуться к выбору конфигурации.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** выберите [период](../../../baremetal/concepts/servers.md#server-lease), на который вы хотите арендовать сервер: `1 день`, `1 месяц`, `3 месяца`, `6 месяцев` или `1 год`.
     
     По окончании указанного периода аренда сервера будет автоматически продлена на такой же период. Прервать аренду в течение указанного периода аренды нельзя, но можно [отказаться](../../../baremetal/operations/servers/server-lease-cancel.md) от дальнейшего продления аренды сервера.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-count_jPgTg }}** выберите количество серверов данной конфигурации, которое вы хотите арендовать.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите вариант `{{ ui-key.yacloud.baremetal.field_choose-marketplace-os }}` и [операционную систему, поддерживаемую в {{ backup-name }}](#os-support).
  1. (Опционально) В блоке **{{ ui-key.yacloud.baremetal.title_section-disk }}** настройте разметку [дисков](../../../baremetal/concepts/disks/disk-types.md):
     
     1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
     1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![icon](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.
     
         Чтобы самостоятельно собрать [RAID](../../../baremetal/concepts/disks/raid.md)-массивы и настроить разделы дисков, нажмите кнопку **{{ ui-key.yacloud.baremetal.action_destroy-raid }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

      {% note info %}
      
      Параметры разметки диска важны для дальнейшего восстановления сервера из резервной копии. Подробнее см. в инструкции [{#T}](../backup-vm/recover.md).
      
      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** в разделе **Интерфейс 1** выберите [приватную подсеть](../../../baremetal/concepts/private-network.md#private-subnet) в той [зоне доступности](../../../overview/concepts/geo-scope.md), в которой вы арендуете сервер.
     
     Если в зоне доступности арендуемого сервера еще нет приватной подсети или вы хотите создать новую приватную подсеть, нажмите кнопку **{{ ui-key.yacloud.common.create }}** и в открывшемся окне задайте параметры подсети по инструкции [{#T}](../../../baremetal/operations/subnet-create.md).
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** в разделе **Интерфейс 1**:
     
     * В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите способ назначения публичного адреса:
     
         * `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}` — чтобы назначить случайный IP-адрес. Если необходимо получить IP-адрес при создании сервера через запрос к DHCP-серверу, включите опцию **{{ ui-key.yacloud.baremetal.label_public-ip-via-dhcp }}**.
     
         * `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}` — чтобы назначить IP-адрес из диапазона адресов [выделенной публичной подсети](../../../baremetal/concepts/public-network.md#public-subnet).
         
             В появившемся поле выберите публичную подсеть или нажмите кнопку **{{ ui-key.yacloud.baremetal.action_create-public-subnet-from-server }}**, чтобы [заказать](../../../baremetal/operations/reserve-public-subnet.md) новую.
         
             {% note warning %}
         
             В выделенной публичной подсети [отсутствует](../../../baremetal/concepts/dhcp.md#dhcp-public-subnet) DHCP-сервер, поэтому на сетевом интерфейсе сервера, подключенного к такой подсети, необходимо вручную настраивать статический IP-адрес из диапазона публичных IP-адресов, доступных в выбранной публичной подсети, а также задать адрес шлюза по умолчанию.
         
             {% endnote %}
     
     * В поле **{{ ui-key.yacloud.baremetal.servers.BandwidthRow.bandwidthTitle_wvZra }}** выберите пакет [потребления трафика сервера](../../../baremetal/concepts/network-restrictions.md#bandwidth-for-pubic-network). Доступные пакеты потребления трафика:
       
       * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan10Tb_2BFQU }}`;
       * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan100Tb_4AB2b }}`.
       
       {% note info %}
       
       Возможность выбора пакетов трафика доступна только для конфигураций с публичным IP-адресом и с сетевыми картами со скоростью соединения 10 Гбит/с и выше.
       
       Уменьшить емкость подключения до 10 ТБ в сутки можно будет не раньше, чем через 24 часа после начала аренды сервера.
       
       {% endnote %}
     
     Чтобы [агент {{ backup-name }}](../../concepts/agent.md) мог обмениваться данными с серверами [провайдера резервного копирования](../../concepts/index.md#providers), на сервере должен быть обеспечен сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }} согласно таблице: {#ip-access}
     
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
     
     При установке [агента {{ backup-name }}](../../concepts/agent.md) на ВМ или сервер {{ baremetal-name }} может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
     После установки агента {{ backup-name }} вы можете удалить это правило.
     
     Для доступа к ВМ по протоколу [SSH](../../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
     
     {% endnote %}
  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      1. В поле **{{ ui-key.yacloud.baremetal.field_password }}** воспользуйтесь одним из вариантов создания пароля для root-пользователя:
      
          * Чтобы сгенерировать пароль для root-пользователя, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-plain }}` и нажмите кнопку **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.
      
              {% note warning %}
              
              Этот вариант предусматривает ответственность пользователя за безопасность пароля. Сохраните сгенерированный пароль в надежном месте: он не сохраняется в {{ yandex-cloud }}, и после заказа сервера вы не сможете посмотреть его.
              
              {% endnote %}
      
          * Чтобы использовать пароль root-пользователя, сохраненный в [секрете](../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-lockbox }}`:
      
              В полях **{{ ui-key.yacloud.baremetal.label_lockbox-name }}**, **{{ ui-key.yacloud.baremetal.label_lockbox-version }}** и **{{ ui-key.yacloud.baremetal.label_lockbox-key }}** выберите соответственно секрет, его версию и ключ, в которых сохранен ваш пароль.
              
              Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать его.
      
              Этот вариант позволяет вам как задать собственный пароль (тип секрета `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`), так и использовать пароль, сгенерированный автоматически (тип секрета `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-generated }}`).
      
      1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
      
          Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
          
          1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
          1. Задайте имя SSH-ключа.
          1. Выберите вариант:
          
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
              
                При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
          
          1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
          
          SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. Включите резервное копирование сервера в {{ backup-name }}:

      1. Включите опцию **{{ ui-key.yacloud.baremetal.title_section-server-backups }}**.
      1. Выберите [политику резервного копирования](../../concepts/policy.md) или [создайте](../policy-vm/create.md) новую.
      1. Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с назначенными ролями [`baremetal.editor`](../../../baremetal/security/index.md#baremetal-editor) и [`backup.user`](../../security/index.md#backup-user) или [создайте](../../../iam/operations/sa/create.md) новый.

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}**:
     
       1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** введите имя сервера. Требования к имени:
     
           * длина — от 3 до 63 символов;
           * может содержать строчные буквы латинского алфавита, цифры и дефисы;
           * первый символ — буква, последний — не дефис.
     
       1. (Опционально) В поле **{{ ui-key.yacloud.baremetal.field_description }}** добавьте описание сервера.
       1. (Опционально) В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** задайте [метки](../../../resource-manager/concepts/labels.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

Подробнее об аренде сервера см. в [документации {{ baremetal-name }}](../../../baremetal/operations/servers/server-lease.md).

{% note info %}

Если для организации дискового пространства защищаемого ресурса вы используете [LVM](https://ru.wikipedia.org/wiki/LVM), ознакомьтесь с [особенностями](../../concepts/backup.md#lvm) восстановления ресурсов с LVM в {{ backup-name }}.

{% endnote %}