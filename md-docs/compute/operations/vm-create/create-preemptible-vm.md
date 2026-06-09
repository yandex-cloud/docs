# Сделать виртуальную машину прерываемой


Вы можете [создать прерываемую](#create-preemptible) [ВМ](../../concepts/vm.md) или [изменить тип](#preemptible-to-regular) существующей ВМ.

{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../../concepts/vm.md), необходима _минимальная_ [роль](../../security/index.md#compute-editor) `compute.editor` на [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}

## Создать прерываемую ВМ {#create-preemptible}

Чтобы создать [прерываемую ВМ](../../concepts/preemptible-vm.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана прерываемая ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../concepts/image.md) и версию операционной системы.

      Если вы хотите создать ВМ из существующего загрузочного диска, перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** и выберите нужный загрузочный диск. Нажмите ![image](../../../_assets/console-icons/pencil.svg) напротив имени диска, если вы хотите изменить его настройки.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться прерываемая ВМ.
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../concepts/disk.md):

      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужный размер диска.
      * (Опционально) Чтобы [зашифровать](../../concepts/encryption.md) загрузочный или дополнительный диск, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** справа от имени диска нажмите значок ![image](../../../_assets/console-icons/pencil.svg) и задайте параметры шифрования для диска:
        
        * Выберите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
        * В поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../../kms/concepts/key.md), которым вы хотите зашифровать диск. Чтобы [создать](../../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.
        
        Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
        
        {% note warning %}
        
        Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
        
        {% endnote %}
        
        Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
        
        {% note alert %}
        
        Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
        
        {% endnote %}

      Если вы создаете ВМ из существующего загрузочного диска, измените настройки этого диска на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** вверху формы.
  1. (Опционально) Добавьте дополнительный [диск](../../concepts/disk.md):
     
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
     * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}**. Вы можете выбрать существующий диск или создать новый диск — пустой или из снимка / образа.
     
         Например, чтобы создать новый пустой диск:
     
         * Выберите `Создать новый`.
         * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`.
         * Укажите имя диска.
         * Выберите [тип диска](../../concepts/disk.md#disks_types).
         * Задайте нужные размер диска и размер блока.
         * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional_vt356 }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete_qZn4x }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
         * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
  1. (Опционально) Подключите [файловое хранилище](../../concepts/filesystem.md):
     
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
     
         * В открывшемся окне выберите **Файловое хранилище** и в появившемся списке выберите хранилище, которое требуется подключить.
     
         * Нажмите кнопку **Добавить файловое хранилище**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**.
      * Выберите [платформу](../../concepts/vm-platforms.md).
      * Укажите [гарантированную долю](../../concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
      * В поле **{{ ui-key.yacloud.component.compute.resources.field_advanced }}** включите опцию **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
      * (Опционально) Включите [программно ускоренную сеть](../../concepts/software-accelerated-network.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.
     
         * У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
         * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:
     
             * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
             * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
             * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
     
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:
     
         * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}. В этом случае можно включить [защиту от DDoS-атак](../../../vpc/ddos-protection/index.md) при помощи опции ниже.
         * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../../vpc/operations/set-static-ip.md).
         * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.
     
     * Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md):
     
         * Чтобы подключаться к виртуальной машине по `SSH`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `22`.
     
         * Чтобы подключаться к виртуальной машине по `RDP`, группа безопасности должна разрешать входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `3389`.
         
         Если оставить поле пустым, виртуальной машине будет автоматически назначена [группа безопасности по умолчанию](../../../vpc/concepts/security-groups.md#default-security-group), позволяющая подключаться к ВМ по `SSH` и `RDP`.
     
     * Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите способ назначения внутренних адресов:
     
         * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов, доступных в выбранной подсети.
         * `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` — чтобы задать внутренний IP-адрес ВМ вручную.
         * При необходимости включите опцию **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**. Опция доступна, если ранее в настройках публичного адреса вы выбрали автоматический способ назначения адреса.
     
     * (Опционально) Создайте записи для ВМ в [зоне DNS](../../../dns/concepts/dns-zone.md):
     
         * Разверните блок **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** и нажмите **{{ ui-key.yacloud.dns.button_add-record }}**.
         * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `{{ ui-key.yacloud.dns.label_auto-select-zone }}`.
           Вы можете добавить несколько записей во [внутренние зоны](../../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../../dns/concepts/compute-integration.md).
         * Чтобы создать еще одну запись, нажмите кнопку **{{ ui-key.yacloud.dns.button_add-record }}**.
     
     Если вы хотите добавить на ВМ дополнительный [сетевой интерфейс](../../concepts/network.md), нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-network-interface }}** и в появившемся блоке настроек нового интерфейса повторите действия, описанные выше в этом шаге. На одну ВМ можно добавить до восьми сетевых интерфейсов.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
     
     * Выберите **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**, чтобы [подключаться](../vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [{{ oslogin }}](../../../organization/concepts/os-login.md) в {{ org-full-name }}.
     
         Используя {{ oslogin }}, вы сможете подключаться к ВМ по SSH-ключам и SSH-сертификатам с помощью стандартного SSH-клиента или [интерфейса командной строки {{ yandex-cloud }}](../../../cli/quickstart.md). {{ oslogin }} позволяет ротировать SSH-ключи, используемые для доступа к ВМ, и является наиболее [безопасным](../../../security/domains/iaas-checklist.md#vm-security) вариантом доступа.
     
     * Если доступ по {{ oslogin }} вам не подходит, выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:
     
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     
             {% note alert %}
     
             Не используйте логин `root` или другие [имена, зарезервированные ОС](https://github.com/canonical/subiquity/blob/main/reserved-usernames). Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
     
             {% endnote %}
     
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
           
           Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
           
           1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
           1. Задайте имя SSH-ключа.
           1. Выберите вариант:
           
               * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
               * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
               * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
               
                 При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
           
           1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
           
           SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
     
     Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../concepts/metadata/sending-metadata.md) данные этих пользователей в блоке **{{ ui-key.yacloud.common.metadata }}**. С помощью метаданных вы также можете [установить дополнительное ПО](create-with-cloud-init-scripts.md) на ВМ при ее создании.
     
     В публичных образах Linux, предоставляемых {{ yandex-cloud }}, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.
  1. (Опционально) Включите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}** и в поле **{{ ui-key.yacloud.backup.title_select-vm-backup-policies-row }}** выберите или создайте [политику резервного копирования](../../../backup/concepts/policy.md), чтобы автоматически создавать резервные копии ВМ с помощью сервиса [{{ backup-name }}](../../../backup/index.md).
     
     Чтобы создать новую ВМ с подключением к {{ backup-name }}, вашему аккаунту должна быть назначена [роль](../../../backup/security/index.md#backup-user) `backup.user` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете ВМ.
     
     {% note info %}
     
     Если у вашего аккаунта нет назначенной роли `backup.user` или выше, вы можете подключить ВМ к {{ backup-name }} с помощью [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), которому назначена такая роль. 
     
     Для этого разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите подходящий сервисный аккаунт. При необходимости [создайте](../../../iam/operations/sa/create.md) новый сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../../backup/security/index.md#backup-user) `backup.user`.
     
     {% endnote %}
     
     {% note tip %}
     
     Установка агента {{ backup-name }} является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента {{ backup-name }} увеличить ресурсы ВМ.
     
     {% endnote %}
     
     Подробнее читайте в разделе [{#T}](../../../backup/concepts/vm-connection.md). 
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя прерываемой ВМ:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:
     
     * (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
     * (Опционально) Разрешите доступ к [серийной консоли](../../concepts/serial-console.md).
     * (Опционально) Чтобы настроить поставку [системных метрик Linux](../../../monitoring/operations/unified-agent/linux_metrics.md) и дополнительных метрик ваших приложений, в блоке **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** и выберите:
       * **{{ monitoring-full-name }}** — [установить агент](../../../monitoring/concepts/data-collection/unified-agent/index.md) для сбора дополнительных метрик ВМ и приложений.
       * **{{ managed-prometheus-name }}** — [установить и настроить агент](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) для сбора дополнительных метрик ВМ и приложений в формате {{ prometheus-name }}:
          * Выберите или создайте воркспейс, в котором будут храниться метрики.
          * (Опционально) Опишите в формате JSON [параметры поставки](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) собственных метрик.
     * (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../../concepts/placement-groups.md) ВМ.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Прерываемая ВМ появится в списке.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания прерываемой ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на прерываемую ВМ.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) [{{ marketplace-full-name }}](../../../marketplace/index.md) на базе ОС Linux (например, [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7)).

     Чтобы получить список доступных образов с помощью CLI, выполните команду:
     
     ```bash
     yc compute image list --folder-id standard-images
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     |          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ...
     | fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
     | fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
     | fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
     ...
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ```
     
     Где:
     
     * `ID` — идентификатор образа.
     * `NAME` — имя образа.
     * `FAMILY` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится образ.
     * `PRODUCT IDS` — идентификаторы [продуктов](../../../marketplace/concepts/product.md) {{ marketplace-full-name }}, связанных с образом.
     * `STATUS` — текущий статус образа. Может принимать одно из значений:
     
         * `STATUS_UNSPECIFIED` — статус образа не определен.
         * `CREATING` — образ в процессе создания.
         * `READY` — образ готов к использованию.
         * `ERROR` — образ нельзя использовать из-за возникшей с ним проблемы.
         * `DELETING` — образ в процессе удаления.

  1. Создайте прерываемую ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute instance create \
       --name first-preemptible-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --preemptible \
       --create-boot-disk image-folder-id=standard-images,image-family=centos-7,kms-key-id=<идентификатор_ключа> \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     {% note info %}
     
     Если вы используете CLI версии 0.92.0 или ниже, в команде также нужно указать [платформу](../../concepts/vm-platforms.md) ВМ: `--platform standard-v3`. Узнать версию CLI можно с помощью команды `yc version`, установить последнюю версию — с помощью команды `yc components update`.
     
     {% endnote %}

     Где:
     * `--name` — имя прерываемой ВМ. Требования к имени:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

       {% note info %}
       
       Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
       
       {% endnote %}

     * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), которая соответствует выбранной [подсети](../../../vpc/concepts/network.md#subnet).
     * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
         * `subnet-name` — имя выбранной подсети.
         * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

         Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), задайте параметр `--network-interface` необходимое количество раз. На одну ВМ можно добавить до восьми сетевых интерфейсов.

     * `--preemptible` — выбор прерываемого типа ВМ.
     * `--create-boot-disk` — настройки загрузочного диска ВМ:
         * `image-family` — [семейство образов](../../concepts/image.md#family), например, `centos-7`. Эта опция позволит установить последнюю версию ОС из указанного семейства.
         * `kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного загрузочного диска. Необязательный параметр.

           Для создания зашифрованного диска нужна [роль](../../../kms/security/index.md#kms-keys-user) `kms.keys.user` или выше.
           
           {% note warning %}
           
           Задать настройки шифрования можно только при создании диска. Шифрование диска нельзя будет отключить или изменить. Также нельзя будет включить шифрование для уже созданного диска.
           
           {% endnote %}

           Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.
           
           {% note alert %}
           
           Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).
           
           {% endnote %}

     * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на прерываемой ВМ будет автоматически создан пользователь `yc-user`.

         При создании ВМ из публичного образа [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) обязательно передавайте в ВМ SSH-ключ, поскольку доступ по протоколу SSH с использованием логина и пароля для таких образов по умолчанию отключен.

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<имя_диска>"
       type     = "<тип_диска>"
       zone     = "<зона_доступности>"
       size     = "<размер_диска>"
       image_id = "<идентификатор_образа>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "preemptible-vm"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = <количество_ядер_vCPU>
         memory = <объем_RAM_ГБ>
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
       }

       scheduling_policy {
         preemptible = true
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<зона_доступности>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:
     * `yandex_compute_disk` — описание загрузочного [диска](../../concepts/disk.md):
       * `name` — имя диска.
       * `type` — [тип](../../concepts/disk.md#disks_types) создаваемого диска.
       * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
       * `size` — размер диска в ГБ.
       * `image_id` — идентификатор [образа](../../concepts/image.md) для прерываемой ВМ. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         Идентификаторы образа также можно посмотреть в [консоли управления]({{ link-console-main }}) при создании ВМ или в [{{ marketplace-name }}](https://yandex.cloud/ru/marketplace) на странице образа в блоке **Идентификаторы продукта**.

     * `yandex_compute_instance` — описание прерываемой ВМ:
       * `name` — имя прерываемой ВМ.
       * `allow_stopping_for_update` — разрешение на остановку работы виртуальной машины для внесения изменений. Установите значение `true`, если планируете изменять сетевые настройки или вычислительные ресурсы ВМ с помощью {{ TF }}. Значение по умолчанию `false`.
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — зона доступности, в которой будет находиться прерываемая ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные прерываемой ВМ. Значения должны соответствовать выбранной платформе.
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска.
       * `network_interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ. Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.

           Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), задайте блок `network_interface` необходимое количество раз.

       * `metadata` — в метаданных необходимо передать открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) на прерываемую ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
       * `scheduling_policy` — политика планирования. Чтобы создать прерываемую ВМ, укажите `preemptible = true`.
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена прерываемая ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).
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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

{% endlist %}

При создании виртуальной машине назначаются [IP-адрес](../../../vpc/concepts/address.md#public-addresses) и [доменное имя](../../../vpc/concepts/address.md#fqdn) (FQDN).

## Сменить тип ВМ {#preemptible-to-regular}

Чтобы сменить тип ВМ, например, сделать ВМ непрерываемой:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится прерываемая ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. В строке с нужной ВМ нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**. Статус ВМ изменится на `Stopped`.
  1. В строке с нужной ВМ нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выключите опцию **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. Справа сверху нажмите ![image](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.common.start }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для остановки ВМ:

     ```bash
     yc compute instance stop --help
     ```

  1. Получите список всех ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance list
     ```
     
     Результат:
     ```text
     +----------------------+-----------------+---------------+---------+----------------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
     +----------------------+-----------------+---------------+---------+----------------------+
     | fhm0b28lgfp4******** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
     | fhm9gk85nj7g******** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
     +----------------------+-----------------+---------------+---------+----------------------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Остановите ВМ:

     ```bash
     yc compute instance stop <имя_или_идентификатор_ВМ>
     ```

     Результат:

     ```text
     done (15s)
     ```

  1. Измените параметры ВМ:

     ```bash
     yc compute instance update <имя_или_идентификатор_ВМ> \
       --preemptible=false
     ```

     Результат:

     ```text
     done (1s)
     id: fhm0b28lgfp4********
     folder_id: b1ghgf288nvg********
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

  1. Вновь запустите ВМ:

     ```bash
     yc compute instance start <имя_или_идентификатор_ВМ>
     ```

     Результат:

     ```text
     done (11s)
     id: fhm0b28lgfp4********
     folder_id: b1ghgf288nvg********
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Найдите в конфигурационном файле описание политики планирования ВМ, которую нужно сделать непрерываемой:

     ```hcl
     scheduling_policy {
       preemptible = true
     }
     ```

  1. Удалите поле `scheduling_policy` со значением `preemptible = true`.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md). В теле запроса в блоке `schedulingPolicy` укажите `"preemptible": false`.

{% endlist %}

Тарификация ВМ после этого изменится. Подробнее о [тарификации ВМ](../../pricing.md#prices-instance-resources).

#### См. также {#see-also}

* [{#T}](../vm-connect/ssh.md).
* [{#T}](../../tutorials/nodejs-cron-restart-vm.md).
* [{#T}](../../tutorials/hpc-on-preemptible.md).
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md).