# Арендовать сервер в своей конфигурации

Вы можете сами [сконфигурировать](../../concepts/server-configurations.md#custom) ваш сервер. Для этого:

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

## Арендуйте сервер {#server-lease}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите арендовать сервер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}** и в открывшемся окне выберите вариант `{{ ui-key.yacloud_components.baremetal.CustomConfiguration }}`. В открывшемся окне настройте конфигурацию сервера:

      {% note tip %}

      Вы можете создать свою конфигурацию не с нуля, а на основе [шаблона](../../concepts/server-custom-configurations.md#templates) конфигурации {{ baremetal-full-name }}, изменив в нем нужные вам аппаратные характеристики арендуемого сервера.

      Чтобы создать свою конфигурацию на основе шаблона, в блоке **{{ ui-key.yacloud_components.baremetal.prefillWithTemplate }}** выберите подходящий шаблон, используя кнопки навигации ![chevron-left](../../../_assets/console-icons/chevron-left.svg) и ![chevron-right](../../../_assets/console-icons/chevron-right.svg). Чтобы быстрее найти подходящий вариант, нажмите **{{ ui-key.yacloud_components.baremetal.allTemplates }}** и в открывшемся списке выберите нужный шаблон, при необходимости воспользовавшись фильтром.

      {% endnote %}

      1. В блоке **{{ ui-key.yacloud_components.baremetal.cpuTitle }}** выберите устраивающий вас CPU.

          При необходимости воспользуйтесь фильтром по производителю, количеству ядер и тактовой частоте доступных процессоров.
      1. В блоке **{{ ui-key.yacloud_components.baremetal.ramLabel }}** укажите тип и объем доступной на сервере памяти RAM.
      1. В блоке **{{ ui-key.yacloud_components.baremetal.disks }}** добавьте на сервер группу [дисковых устройств](../../concepts/disks/disk-types.md) определенного типоразмера:

          1. В поле **{{ ui-key.yacloud_components.baremetal.type }}** выберите тип дискового устройства.
          1. В появившемся поле **{{ ui-key.yacloud_components.baremetal.size }}** выберите размер дисков в создаваемой группе.
          1. В появившемся поле **{{ ui-key.yacloud_components.baremetal.amount }}** выберите количество дисков в группе.

          На сервере должна быть как минимум одна группа, состоящая не менее чем из двух дисков.

          Вы можете добавить на сервер дополнительные группы дисков других типоразмеров. Для этого нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.baremetal.addDiskButton }}**.
      1. В блоке **{{ ui-key.yacloud_components.baremetal.networkLabel }}** выберите скорость соединения сетевых карт сервера в [публичной](../../concepts/public-network.md) и [приватной](../../concepts/private-network.md) сетях, а также наличие на сервере [групп агрегирования](../../concepts/mc-lag.md) MC-LAG.
      1. В блоке **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** выберите [пул серверов](../../concepts/servers.md#server-pools), в котором будет расположен сервер.
      1. В блоке **{{ ui-key.yacloud_components.baremetal.withReserve }}** выберите, будет ли на сервере [резервирование питания](../../concepts/servers.md#server-power-supply).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.continue }}**.
  1. В открывшемся окне настройте параметры сервера:

      1. В блоках **{{ ui-key.yacloud.baremetal.title_section-server-config }}** и **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}** убедитесь, что параметры выбранной конфигурации сервера соответствуют вашим потребностям.

          Если выбранные параметры вам не подходят, нажмите значок ![arrow-left](../../../_assets/console-icons/arrow-left.svg) в блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, чтобы вернуться к настройке конфигурации.
      1. В поле **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}** выберите [период](../../concepts/servers.md#server-lease), на который вы хотите арендовать сервер: `1 месяц` или `1 год`.
      
          По окончании указанного периода аренда сервера будет автоматически продлена на такой же период. Прервать аренду в течение указанного периода аренды нельзя, но можно [отказаться](server-lease-cancel.md) от дальнейшего продления аренды сервера.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите:
         
         * `{{ ui-key.yacloud.baremetal.field_choose-marketplace-os }}` — чтобы установить на сервер один из доступных [публичных образов](../../concepts/images.md#marketplace-images) ОС в {{ marketplace-full-name }}.
         * `{{ ui-key.yacloud.baremetal.field_choose-no-os }}` — чтобы арендовать сервер без операционной системы.
         
             [Установить](reinstall-os-from-own-image.md) операционную систему из [собственного ISO-образа](../../concepts/images.md#user-images) вы сможете позднее.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-disk }}** настройте разметку дисков:

          1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.

              Чтобы самостоятельно собрать [RAID](../../concepts/disks/raid.md)-массивы и настроить разделы дисков, нажмите кнопку ![square-plus](../../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.baremetal.action_add-to-raid }}**.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** в разделе **Интерфейс 1** выберите [приватную подсеть](../../concepts/private-network.md#private-subnet) в той [зоне доступности](../../../overview/concepts/geo-scope.md), в которой вы арендуете сервер.
         
         Если в зоне доступности арендуемого сервера еще нет приватной подсети или вы хотите создать новую приватную подсеть, нажмите кнопку **{{ ui-key.yacloud.common.create }}** и в открывшемся окне задайте параметры подсети по инструкции [{#T}](../subnet-create.md).
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}** в разделе **Интерфейс 2**:
         
         * В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите способ назначения публичного адреса:
         
             * `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}` — чтобы назначить случайный IP-адрес. Если необходимо получить IP-адрес при создании сервера через запрос к DHCP-серверу, включите опцию **{{ ui-key.yacloud.baremetal.label_public-ip-via-dhcp }}**.
         
             * `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}` — чтобы назначить IP-адрес из диапазона адресов [выделенной публичной подсети](../../concepts/public-network.md#public-subnet).
             
                 В появившемся поле выберите публичную подсеть или нажмите кнопку **{{ ui-key.yacloud.baremetal.action_create-public-subnet-from-server }}**, чтобы [заказать](../reserve-public-subnet.md) новую.
             
                 {% note warning %}
             
                 В выделенной публичной подсети [отсутствует](../../concepts/dhcp.md#dhcp-public-subnet) DHCP-сервер, поэтому на сетевом интерфейсе сервера, подключенного к такой подсети, необходимо вручную настраивать статический IP-адрес из диапазона публичных IP-адресов, доступных в выбранной публичной подсети, а также задать адрес шлюза по умолчанию.
             
                 {% endnote %}
         
             * `{{ ui-key.yacloud.baremetal.label_public-ip-no }}` — чтобы не назначать публичный IP-адрес.
         
         * В поле **{{ ui-key.yacloud.baremetal.servers.BandwidthRow.bandwidthTitle_wvZra }}** выберите пакет [потребления трафика сервера](../../concepts/network-restrictions.md#bandwidth-for-pubic-network). Доступные пакеты потребления трафика:
           
           * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan10Tb_2BFQU }}`;
           * `{{ ui-key.yacloud.baremetal.servers.BandwidthRow.plan100Tb_4AB2b }}`.
           
           {% note info %}
           
           Возможность выбора пакетов трафика доступна только для конфигураций с публичным IP-адресом и с сетевыми картами со скоростью соединения 10 Гбит/с и выше.
           
           Уменьшить емкость подключения до 10 ТБ в сутки можно будет не раньше, чем через 24 часа после начала аренды сервера.
           
           {% endnote %}
      1. Если вы устанавливаете на сервер операционную систему из публичного образа в {{ marketplace-short-name }}, в блоке **{{ ui-key.yacloud.baremetal.title_server-access }}** задайте параметры доступа к серверу:

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
      
      1. (Опционально) Включите резервное копирование сервера в [{{ backup-full-name }}](../../../backup/index.md):

          1. Включите опцию **{{ ui-key.yacloud.baremetal.title_section-server-backups }}**.
          1. Выберите [политику резервного копирования](../../../backup/concepts/policy.md) или [создайте](../../../backup/operations/policy-vm/create.md) новую.
          1. Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с назначенными ролями [`baremetal.editor`](../../security/index.md#baremetal-editor) и [`backup.user`](../../../backup/security/index.md#backup-user) или [создайте](../../../iam/operations/sa/create.md) новый.

          Подробнее см. в инструкции [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).
      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}**:
         
           1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** введите имя сервера. Требования к имени:
         
               * длина — от 3 до 63 символов;
               * может содержать строчные буквы латинского алфавита, цифры и дефисы;
               * первый символ — буква, последний — не дефис.
         
           1. (Опционально) В поле **{{ ui-key.yacloud.baremetal.field_description }}** добавьте описание сервера.
           1. (Опционально) В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** задайте [метки](../../../resource-manager/concepts/labels.md).
      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}

В результате сервер перейдет в [статус](../../concepts/servers.md#server-status) `PROVISIONING`. Сервису {{ baremetal-full-name }} потребуется до пяти календарных дней, чтобы собрать запрошенную вами конфигурацию и запустить сервер, после чего он перейдет в статус `RUNNING`.