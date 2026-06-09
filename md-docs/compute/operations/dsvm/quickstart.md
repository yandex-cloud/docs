# Создание виртуальной машины из публичного образа DSVM

Создайте ВМ DSVM с помощью сервиса {{ compute-name }} в консоли управления {{ yandex-cloud }} и подключитесь к ней по протоколу [SSH](../../../glossary/ssh-keygen.md).

{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../../concepts/vm.md), необходима _минимальная_ [роль](../../security/index.md#compute-editor) `compute.editor` на [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../../resource-manager/operations/folder/create.md).
1. Если у вас еще нет пары SSH-ключей, [создайте их](../vm-connect/ssh.md#creating-ssh-keys).

## Создать ВМ из публичного образа DSVM {#create-dsvm}

Чтобы создать виртуальную машину из публичного образа[DSVM](https://yandex.cloud/ru/marketplace/products/yc/dsvm):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** выберите образ [DSVM](https://yandex.cloud/ru/marketplace/products/yc/dsvm).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../concepts/disk.md):

      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужный размер диска.

  1. (Опционально) Подключите [файловое хранилище](../../concepts/filesystem.md):
     
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
     
         * В открывшемся окне выберите **Файловое хранилище** и в появившемся списке выберите хранилище, которое требуется подключить.
     
         * Нажмите кнопку **Добавить файловое хранилище**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите одну из готовых конфигураций или создайте свою. Чтобы создать свою конфигурацию:
     
     * Перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**.
     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите [гарантированную долю](../../concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
     * При необходимости включите [программно ускоренную сеть](../../concepts/software-accelerated-network.md).
     * При необходимости сделайте ВМ [прерываемой](../../concepts/preemptible-vm.md).
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
     
     Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../concepts/metadata/sending-metadata.md) данные этих пользователей в блоке **{{ ui-key.yacloud.common.metadata }}**. С помощью метаданных вы также можете [установить дополнительное ПО](../vm-create/create-with-cloud-init-scripts.md) на ВМ при ее создании.
     
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
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

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

  Виртуальная машина появится в списке. При создании виртуальной машине назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}

## Подключиться к ВМ по протоколу SSH {#first-login}

Вы можете подключиться к ВМ по протоколу SSH, когда она будет запущена (в статусе `RUNNING`). Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

Подробнее по подключение по протоколу SSH читайте в разделе [Подключение к ВМ](../../quickstart/quick-create-linux.md#connect-to-vm).

После подключения в приветственном сообщении вы увидите команды для активации окружения и запуска [Jupyter Notebook](http://jupyter.org/index.html) и [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/):

```text
#####################################################################
Welcome to Yandex Data Science Virtual Machine
Image Build: ...

Please use one of the following commands to activate
the environment with the framework of your choice:
    for Python2 ______________________ source activate py27
    for Python3 ______________________ source activate py36

Packages installed in each environment:
    catboost, xgboost, lightgbm,
    tensorflow, pytorch,
    jupyter, matplotlib,
    numpy, scipy, scikit-learn

To run public {{ jlab }}Lab execute:
    jupyter lab --no-browser

To run public {{ jlab }} notebook execute:
    jupyter notebook --no-browser

Description and help:
    https://yandex.cloud/ru/docs/compute/operations/dsvm/

#####################################################################
```