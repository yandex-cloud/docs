# Создание виртуальной машины Linux

Создайте [ВМ](../concepts/vm.md) Linux с помощью сервиса {{ compute-name }} в консоли управления {{ yandex-cloud }} и подключитесь к ней.

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Если у вас еще нет пары SSH-ключей, [создайте их](../operations/vm-connect/ssh.md#creating-ssh-keys).

## Создайте ВМ {#create-vm}

{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../concepts/vm.md), необходима _минимальная_ [роль](../security/index.md#compute-editor) `compute.editor` на [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
1. Перейдите в сервис **{{ compute-name }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../concepts/image.md) и версию операционной системы на базе Linux.

    Если вы хотите создать ВМ из существующего загрузочного диска, перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** и выберите нужный загрузочный диск. Нажмите ![image](../../_assets/console-icons/pencil.svg) напротив имени диска, если вы хотите изменить его настройки.

1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../concepts/disk.md):

    * Выберите [тип диска](../concepts/disk.md#disks_types).
    * Задайте нужный размер диска.
    * (Опционально) Чтобы [зашифровать](../concepts/encryption.md) загрузочный или дополнительный диск, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** справа от имени диска нажмите значок ![image](../../_assets/console-icons/pencil.svg) и задайте параметры шифрования для диска:
      
      * Выберите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
      * В поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../kms/concepts/key.md), которым вы хотите зашифровать диск. Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.
      
      Для создания зашифрованного диска нужна [роль](../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
      
      {% note warning %}
      
      Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
      
      {% endnote %}
      
      Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
      
      {% note alert %}
      
      Если удалить ключ или его [версию](../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../kms/concepts/version.md#version-distruct).
      
      {% endnote %}

        Если вы создаете ВМ из существующего загрузочного диска, измените настройки этого диска на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** вверху формы.

1. (Опционально) Добавьте дополнительный [диск](../concepts/disk.md):
   
   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
   * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}**. Вы можете выбрать существующий диск или создать новый диск — пустой или из снимка / образа.
   
       Например, чтобы создать новый пустой диск:
   
       * Выберите `Создать новый`.
       * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`.
       * Укажите имя диска.
       * Выберите [тип диска](../concepts/disk.md#disks_types).
       * Задайте нужные размер диска и размер блока.
       * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
       * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
1. (Опционально) Подключите [файловое хранилище](../concepts/filesystem.md):
   
   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
   
       * В открывшемся окне выберите **Файловое хранилище** и в появившемся списке выберите хранилище, которое требуется подключить.
   
       * Нажмите кнопку **Добавить файловое хранилище**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите одну из готовых конфигураций или создайте свою. Чтобы создать свою конфигурацию:
   
   * Перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**.
   * Выберите [платформу](../concepts/vm-platforms.md).
   * Укажите [гарантированную долю](../concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
   * При необходимости включите [программно ускоренную сеть](../concepts/software-accelerated-network.md).
   * При необходимости сделайте ВМ [прерываемой](../concepts/preemptible-vm.md).
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   
   * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.
   
       * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
       * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:
   
           * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
           * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
           * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
   
   * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:
   
       * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}. В этом случае можно включить [защиту от DDoS-атак](../../vpc/ddos-protection/index.md) при помощи опции ниже.
       * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../vpc/operations/set-static-ip.md).
       * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.
   
   * Выберите [подходящие группы безопасности](../../vpc/concepts/security-groups.md):
   
       * Чтобы подключаться к виртуальной машине по `SSH`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `22`.
   
       * Чтобы подключаться к виртуальной машине по `RDP`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `3389`.
       
       Если оставить поле пустым, виртуальной машине будет автоматически назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group), позволяющая подключаться к ВМ по `SSH` и `RDP`.
   
   * Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите способ назначения внутренних адресов:
   
       * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов, доступных в выбранной подсети.
       * `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` — чтобы задать внутренний IP-адрес ВМ вручную.
       * При необходимости включите опцию **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**. Опция доступна, если ранее в настройках публичного адреса вы выбрали автоматический способ назначения адреса.
   
   * (Опционально) Создайте записи для ВМ в [зоне DNS](../../dns/concepts/dns-zone.md):
   
       * Разверните блок **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** и нажмите **{{ ui-key.yacloud.dns.button_add-record }}**.
       * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `{{ ui-key.yacloud.dns.label_auto-select-zone }}`.
         Вы можете добавить несколько записей во [внутренние зоны](../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../dns/concepts/compute-integration.md).
       * Чтобы создать еще одну запись, нажмите кнопку **{{ ui-key.yacloud.dns.button_add-record }}**.
   
   Если вы хотите добавить на ВМ дополнительный [сетевой интерфейс](../concepts/network.md), нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-network-interface }}** и в появившемся блоке настроек нового интерфейса повторите действия, описанные выше в этом шаге. На одну ВМ можно добавить до восьми сетевых интерфейсов.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
   
   * Выберите **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**, чтобы [подключаться](../operations/vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [{{ oslogin }}](../../organization/concepts/os-login.md) в {{ org-full-name }}.
   
       Используя {{ oslogin }}, вы сможете подключаться к ВМ по SSH-ключам и SSH-сертификатам с помощью стандартного SSH-клиента или [интерфейса командной строки {{ yandex-cloud }}](../../cli/quickstart.md). {{ oslogin }} позволяет ротировать SSH-ключи, используемые для доступа к ВМ, и является наиболее [безопасным](../../security/domains/iaas-checklist.md#vm-security) вариантом доступа.
   
   * Если доступ по {{ oslogin }} вам не подходит, выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:
   
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
   
           {% note alert %}
   
           Не используйте логин `root` или другие [имена, зарезервированные ОС](https://github.com/canonical/subiquity/blob/main/reserved-usernames). Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
   
           {% endnote %}
   
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
         
         Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
         
         1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
         1. Задайте имя SSH-ключа.
         1. Выберите вариант:
         
             * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
             * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
             * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
             
               При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
         
         1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
         
         SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
   
   Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../concepts/metadata/sending-metadata.md) данные этих пользователей в блоке **{{ ui-key.yacloud.common.metadata }}**. С помощью метаданных вы также можете [установить дополнительное ПО](../operations/vm-create/create-with-cloud-init-scripts.md) на ВМ при ее создании.
   
   В публичных образах Linux, предоставляемых {{ yandex-cloud }}, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.
1. (Опционально) Включите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}** и в поле **{{ ui-key.yacloud.backup.title_select-vm-backup-policies-row }}** выберите или создайте [политику резервного копирования](../../backup/concepts/policy.md), чтобы автоматически создавать резервные копии ВМ с помощью сервиса [{{ backup-name }}](../../backup/index.md).
   
   Чтобы создать новую ВМ с подключением к {{ backup-name }}, вашему аккаунту должна быть назначена [роль](../../backup/security/index.md#backup-user) `backup.user` или выше на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете ВМ.
   
   {% note info %}
   
   Если у вашего аккаунта нет назначенной роли `backup.user` или выше, вы можете подключить ВМ к {{ backup-name }} с помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), которому назначена такая роль. 
   
   Для этого разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите подходящий сервисный аккаунт. При необходимости [создайте](../../iam/operations/sa/create.md) новый сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../backup/security/index.md#backup-user) `backup.user`.
   
   {% endnote %}
   
   {% note tip %}
   
   Установка агента {{ backup-name }} является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента {{ backup-name }} увеличить ресурсы ВМ.
   
   {% endnote %}
   
   Подробнее читайте в разделе [{#T}](../../backup/concepts/vm-connection.md).    
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

    {% note info %}
    
    Имя виртуальной машины используется для генерации [внутреннего FQDN](../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
    
    {% endnote %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:
   
   * (Опционально) Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
   * (Опционально) Разрешите доступ к [серийной консоли](../concepts/serial-console.md).
   * (Опционально) Чтобы настроить поставку [системных метрик Linux](../../monitoring/operations/unified-agent/linux_metrics.md) и дополнительных метрик ваших приложений, в блоке **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** и выберите:
     * **{{ monitoring-full-name }}** — [установить агент](../../monitoring/concepts/data-collection/unified-agent/index.md) для сбора дополнительных метрик ВМ и приложений.
     * **{{ managed-prometheus-name }}** — [установить и настроить агент](../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) для сбора дополнительных метрик ВМ и приложений в формате {{ prometheus-name }}:
        * Выберите или создайте воркспейс, в котором будут храниться метрики.
        * (Опционально) Опишите в формате JSON [параметры поставки](../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) собственных метрик.
   * (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../concepts/placement-groups.md) ВМ.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../vpc/concepts/address.md) и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation см. на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._

## Подключитесь к ВМ {#connect-to-vm}

# Подключиться к виртуальной машине Linux по SSH

Для подключения к [ВМ](../concepts/vm.md) по [SSH](../../glossary/ssh-keygen.md) используется пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Этот способ безопаснее, чем подключение по логину и паролю.

Чтобы другой пользователь мог подключиться к ВМ, добавьте для него SSH-ключ по [инструкции](#vm-authorized-keys).

{% note info %}

При создании ВМ с доступом по [{{ oslogin }}](../operations/vm-connect/os-login.md) указывайте SSH-ключи в [метаданных](../concepts/metadata/sending-metadata.md). Так вы сможете [подключиться к ВМ по SSH](#vm-connect), даже если отключите для нее доступ по {{ oslogin }}.

{% endnote %}

Чтобы подключиться к ВМ Linux по SSH:

1. [Создайте пару SSH-ключей](#creating-ssh-keys).
1. [Скопируйте открытый ключ](#copy-key) в поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** на странице создания ВМ.
1. [Подключитесь к ВМ](#vm-connect).


Обучающее видео поможет вам подключиться к ВМ Linux по SSH:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvujof7tlqigs4ufgs?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=0Q4kivQo0g4&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=10&pp=iAQB).



- Windows 10/11 {#windows}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvfxj66n2cs7nlgbzd?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=M7m75y80VFM&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=11&pp=iAQB).



- Windows 7/8 {#windows7-8}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvmhu4vhxduzmdtmdk?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=rNA-bEbSHZ8&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=12&pp=iAQB).



{% endlist %}


## Создание пары ключей SSH {#creating-ssh-keys}

{% list tabs group=operating_system %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет [создана](../operations/vm-create/create-linux-vm.md) ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** нажмите **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
  1. В открывшемся окне выберите `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` и нажмите **{{ ui-key.yacloud.common.add }}**.
  
      При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
  
      SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
  
  {% cut "Предупреждение UNPROTECTED PRIVATE KEY FILE" %}
      
  В Unix-подобных системах после распаковки закрытого ключа в папку `.ssh` ему назначаются слишком высокие права. Из-за этого при подключении к ВМ возникает предупреждение `UNPROTECTED PRIVATE KEY FILE`. Чтобы сократить права, выполните команду:
  
  ```bash
  chmod 600 <путь_к_файлу_закрытого_ключа>
  ```
      
  {% endcut %}

- Linux/macOS {#linux-macos}

  1. Откройте терминал.
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```bash
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в директории `/home/<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 10/11 {#windows}

  Если у вас еще не установлен [OpenSSH](https://ru.wikipedia.org/wiki/OpenSSH), установите его по [инструкции](https://learn.microsoft.com/ru-ru/windows-server/administration/openssh/openssh_install_firstuse).
  
  1. Запустите `cmd.exe` или `powershell.exe` (предварительно обновите PowerShell).
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```shell
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в папку `C:\Users\<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 7/8 {#windows7-8}

  Создайте ключи с помощью приложения PuTTY:
  
  1. [Скачайте](https://www.putty.org) и установите PuTTY.
  1. Добавьте папку с PuTTY в переменную `PATH`:
  
      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите кнопку **ОК**.
  
  1. Запустите приложение PuTTYgen.
  1. В качестве типа генерируемой пары выберите **EdDSA**. Нажмите **Generate** и поводите курсором в поле выше до тех пор, пока не закончится создание ключа.
  
      ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh_generate_key.png)
  
  1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
  1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
  1. Нажмите кнопку **Save public key** и сохраните открытый ключ в файле `<имя_ключа>.pub`.

{% endlist %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к ВМ будет невозможно.

{% endnote %}

## Копирование открытого ключа в буфер обмена {#copy-key}

[Созданный ранее](#creating-ssh-keys) открытый ключ имеет следующий формат:

```text
<тип_ключа> <тело_открытого_ключа> <опциональный_комментарий>
```

Пример:

> ```text
> ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK********+gRPCz user@Desktop
> ```

{% note tip %}

Блок `<опциональный_комментарий>` не используется при SSH-подключении, вы можете не копировать его.

{% endnote %}

Откройте файл `<имя_ключа>.pub` с помощью любого текстового редактора, например Notepad, и скопируйте из него ключ. Ключ должен быть записан одной строкой (не должно быть переносов и разрывов строки).

Ключ можно скопировать и с помощью командной строки:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  В терминале скопируйте ключ одним из следующих способов:

    * Вручную. Для этого выведите на экран содержимое файла:

        ```bash
        cat <путь_к_файлу_ключа>/<имя_ключа>.pub
        ```

        Открытый ключ будет выведен на экран. Скопируйте его в буфер обмена.

    * При помощи соответствующей команды:

        * Для Linux: `cat <путь_к_файлу_ключа>/<имя_ключа>.pub | xclip -selection clipboard`.
        * Для macOS: `cat <путь_к_файлу_ключа>/<имя_ключа>.pub | pbcopy`.

        Указанные выше команды копируют все содержимое файла, в том числе опциональный комментарий.

- Windows {#windows}

  1. Запустите `cmd.exe` или `powershell.exe`.
  1. Скопируйте ключ одним из следующих способов:

      * Вручную. Для этого выведите на экран содержимое файла:

          ```shell
          type <путь_к_файлу_ключа>\<имя_ключа>.pub
          ```

          Открытый ключ будет выведен на экран. Скопируйте его в буфер обмена.

      * При помощи соответствующей команды:

          ```shell
          type <путь_к_файлу_ключа>\<имя_ключа>.pub | clip
          ```

          Указанная выше команда копирует все содержимое файла, в том числе опциональный комментарий.

{% endlist %}

После этого вставьте открытый ключ в поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** при создании ВМ через [консоль управления]({{ link-console-main }}).

## Подключение к ВМ {#vm-connect}

Вы можете подключиться к ВМ в статусе `RUNNING` по протоколу SSH. Для инициализации всех служб после [запуска](../operations/vm-control/vm-stop-and-start.md#start) ВМ может потребоваться время. Если возникла ошибка соединения, попробуйте снова через несколько минут.

[Группы безопасности](../../vpc/concepts/security-groups.md) ВМ должны разрешать входящий трафик по протоколу TCP на порт 22.

Для подключения необходимо указать [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ. Публичный IP-адрес можно узнать в консоли управления, в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ. Если вы создали ВМ только с внутренним IP-адресом, [привяжите к ней публичный IP-адрес](../operations/vm-control/vm-attach-public-ip.md).

Также можно использовать [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) и [FQDN](../../vpc/concepts/address.md#fqdn) для установки SSH-соединения между ВМ внутри одной [облачной сети](../../vpc/concepts/network.md#network) {{ yandex-cloud }}.

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  В терминале выполните команду:

  ```bash
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где:
  * `<имя_пользователя>` — имя учетной записи пользователя ВМ. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.
  * `<публичный_IP-адрес_ВМ>` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) виртуальной машины для доступа к ней через интернет.
  
      Публичный IP-адрес ВМ можно узнать в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** сетевого интерфейса в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../cli/quickstart.md) `yc compute instance get <имя_ВМ>`.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```bash
  ssh -i <путь_к_ключу/имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
  ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в терминале слово `yes` и нажмите **Enter**.

- Windows 10/11 {#windows}

  Убедитесь, что учетная запись Windows обладает правами на чтение файлов в папке с ключами.

  Для подключения к ВМ в командной строке выполните команду:

  ```shell
  ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  Где:
  
  * `<имя_пользователя>` — имя учетной записи пользователя ВМ. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.
  * `<публичный_IP-адрес_ВМ>` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) виртуальной машины для доступа к ней через интернет.

      Публичный IP-адрес ВМ можно узнать в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** сетевого интерфейса в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../cli/quickstart.md) `yc compute instance get <имя_ВМ>`.

  Если у вас несколько закрытых ключей, укажите нужный:

  ```shell
  ssh -i <путь_к_ключу\имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>
  ```

  При первом подключении к ВМ появится предупреждение о неизвестном хосте:

  ```text
  The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
  ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
  Are you sure you want to continue connecting (yes/no/[fingerprint])?
  ```

  Введите в командной строке `yes` и нажмите **Enter**.

- Windows 7/8 {#windows7-8}

  Установите соединение с помощью приложения PuTTY:
  1. Запустите приложение Pageant.
     1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
     1. В контекстном меню выберите пункт **Add key**.
     1. Выберите сгенерированный PuTTY приватный ключ в формате `.ppk`. Если для ключа задан пароль, введите его.
  1. Запустите приложение PuTTY.
     1. В поле **Host Name (or IP address)** введите [публичный IP-адрес ВМ](../../vpc/concepts/address.md#public-addresses), к которой вы хотите подключиться. Укажите порт `22` и тип соединения **SSH**.
        
        Публичный IP-адрес ВМ можно узнать в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** сетевого интерфейса в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../cli/quickstart.md) `yc compute instance get <имя_ВМ>`.

        ![ssh_add_ip](../../_assets/compute/ssh-putty/ssh_add_ip.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth**.
     1. Установите флаг **Allow agent forwarding**.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/authentication_parameters.png)

     1. Откройте в дереве слева пункт **Connection** → **SSH** → **Auth** → **Credentials**.

     1. В поле **Private key file for authentication** выберите файл с приватным ключом.

        ![ssh_choose_private_key](../../_assets/compute/ssh-putty/ssh_choose_private_key.png)

     1. Вернитесь в меню **Sessions**. В поле **Saved sessions** введите любое название для сессии и нажмите кнопку **Save**. Настройки сессии сохранятся под указанным именем. Вы сможете использовать этот профиль сессии для подключения с помощью Pageant.

        ![ssh_save_session](../../_assets/compute/ssh-putty/ssh_save_session.png)

     1. Нажмите кнопку **Open**. Если вы подключаетесь к ВМ в первый раз, может появиться предупреждение о неизвестном хосте:

        ![ssh_unknown_host_warning](../../_assets/compute/ssh-putty/ssh_unknown_host_warning.png)

        Нажмите кнопку **Accept**. Откроется окно терминала с предложением ввести логин пользователя, от имени которого устанавливается соединение. Введите имя пользователя, которое вы указали при создании ВМ, и нажмите **Enter**. Если ВМ создавалась через CLI, то пользователь по умолчанию — `yc-user`.

        Если все настроено верно, будет установлено соединение с сервером.

        ![ssh_login](../../_assets/compute/ssh-putty/ssh_login.png)

  Если вы сохранили профиль сессии в PuTTY, в дальнейшем для установки соединения можно использовать Pageant:
  1. Нажмите правой кнопкой мыши на значок Pageant на панели задач.
  1. Выберите пункт меню **Saved sessions**.
  1. В списке сохраненных сессий выберите нужную сессию.

- {{ cloud-shell-full-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели слева нажмите ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.dashboard.DashboardPage.ServicesSection.title_ur39b }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** или найдите его с помощью строки поиска на дашборде.
  1. Перейдите в ВМ, к которой хотите подключиться.
  1. Убедитесь, что ВМ находится в статусе `Running`. Если ВМ не запущена, в правом верхнем углу нажмите ![image](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.compute.instances.button_gr-action-start }}** и дождитесь перехода ВМ в статус `Running`.
  1. Справа вверху нажмите ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-ssh }}**.
  1. Введите логин пользователя. По умолчанию введен логин, указанный при создании ВМ.
  1. Вставьте содержимое или загрузите файл закрытого SSH-ключа.
  1. Нажмите **{{ ui-key.yacloud.compute.components.SshViaPrivateKeyDialog.connect-via-private-key_6DKKe }}**.
  
  Внизу откроется терминал ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.cloud-shell.label_service }}** с открытым подключением к ВМ по SSH.
  
  Чтобы закрыть подключение, нажмите ![image](../../_assets/console-icons/xmark.svg) или используйте команду `exit`.

{% endlist %}

О решении проблем при подключении читайте в разделе [Вопросы и ответы](../qa/connection.md).

## Добавление SSH-ключей для других пользователей {#vm-authorized-keys}

Вы можете добавить SSH-ключи для другого пользователя ВМ. Для этого нужно создать нового пользователя и добавить для него файл с авторизованными ключами.

Чтобы создать одновременно нескольких пользователей с ключами, используйте [метаданные](../concepts/metadata/sending-metadata.md).

Чтобы настроить пользователей изнутри ВМ, воспользуйтесь инструкцией:

1. [Подключитесь](#vm-connect) к ВМ от имени пользователя, которого вы указали при создании ВМ в консоли управления.

    {% note info %}

    Получить информацию о ВМ вместе с пользовательскими метаданными можно с помощью команды:

    ```bash
    yc compute instance get --full <имя_ВМ>
    ```

    {% endnote %}

1. Создайте нового пользователя `testuser` и укажите для него оболочку `bash` для использования по умолчанию:

    ```bash
    sudo useradd -m -d /home/testuser -s /bin/bash testuser
    ```

1. Переключитесь на созданного пользователя:

    ```bash
    sudo su - testuser
    ```

1. Создайте папку `.ssh` в домашней директории нового пользователя:

    ```bash
    mkdir .ssh
    ```

1. Создайте в папке `.ssh` файл `authorized_keys`:

    ```bash
    touch .ssh/authorized_keys
    ```

1. Добавьте в файл `authorized_keys` публичный ключ нового пользователя:

    ```bash
    echo "<публичный_ключ>" >> /home/testuser/.ssh/authorized_keys
    ```

    Где `<публичный_ключ>` — содержимое файла [публичного ключа](#creating-ssh-keys) для доступа к ВМ по SSH.

1. Измените права доступа к файлу `authorized_keys` и каталогу `.ssh`:

    ```bash
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
    ```

1. Отключитесь от ВМ командой `exit`.
1. [Перезапустите ВМ](../operations/vm-control/vm-stop-and-start.md#restart).
1. Проверьте подключение для нового пользователя:

   ```bash
   ssh testuser@<публичный_IP-адрес_ВМ>
   ```

   Где `<публичный_IP-адрес_ВМ>` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) виртуальной машины для доступа к ней через интернет.

   Публичный IP-адрес ВМ можно узнать в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** сетевого интерфейса в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../cli/quickstart.md) `yc compute instance get <имя_ВМ>`.

#### Что дальше {#what-is-next}

* [Узнайте, как работать с {{ yandex-cloud }} изнутри ВМ](../operations/vm-connect/auth-inside-vm.md).

#### См. также {#see-also}

* [{#T}](../operations/vm-connect/cloud-shell.md)
* [{#T}](../operations/vm-connect/rdp.md)
* [{#T}](../operations/vm-connect/powershell.md)
* [{#T}](../operations/vm-connect/os-login.md)

## Настройте серийную консоль {#serial-console}

Через [серийную консоль](../concepts/serial-console.md) можно подключиться к ВМ вне зависимости от состояния [сети](../../vpc/concepts/network.md#network) или операционной системы (например, при проблемах с загрузкой или доступом по [SSH](../../glossary/ssh-keygen.md)).

Доступ к ВМ через серийную консоль необходимо настроить заранее.

## Удалите виртуальную машину {#delete-vm}

Если вы больше не планируете работать с созданной ВМ, [удалите ее](../operations/vm-control/vm-delete.md).

## Что дальше {#what-is-next}

* Посмотрите [сценарии создания веб-сервисов в {{ yandex-cloud }}](../../tutorials/applied/index.md#web).
* Узнайте, [как работать с ВМ](../operations/index.md).
* Узнайте, [как создать ВМ с GPU](../operations/vm-create/create-vm-with-gpu.md).
* Прочитайте [ответы на часто задаваемые вопросы](../qa/general.md).