# Управлять доступом к серийной консоли

[Серийная консоль](../../concepts/serial-console.md) позволяет получить доступ к [виртуальной машине](../../concepts/vm.md) вне зависимости от состояния [сети](../../../vpc/concepts/network.md#network) или операционной системы.

Чтобы [управлять](index.md) доступом к серийной консоли, необходима [роль](../../security/index.md) `compute.admin` или `{{ roles-editor }}`.

По умолчанию доступ к серийной консоли виртуальных машин {{ compute-name }} запрещен.

{% note warning %}

Оцените риск разрешения доступа к ВМ через серийную консоль, учитывая следующие факторы:

* ВМ будет доступна для управления из интернета даже при отсутствии у нее внешнего IP-адреса.

    При наличии необходимых [прав](../../security/index.md) доступа к ВМ подключиться к серийной консоли сможет пользователь, успешно аутентифицированный в [консоли управления]({{ link-console-main }}) {{ yandex-cloud }}.
    
    Доступ к серийной консоли ВМ из клиентского приложения [SSH](../vm-connect/ssh.md) (например, Putty) или [CLI](../../../cli/index.md) также возможен путем аутентификации с помощью SSH-ключа. Поэтому необходимо защитить SSH-ключ от несанкционированного доступа, а также всегда завершать веб-сессию для снижения рисков ее перехвата.

* Сессия работы с серийной консолью будет доступна одновременно всем пользователям, имеющим право доступа к серийной консоли. Действия одного пользователя будут видны другим пользователям, если в это время они просматривают вывод серийной консоли.
* Незавершенная сессия работы с серийной консолью может быть использована другим пользователем.

Мы рекомендуем разрешать доступ к серийной консоли только в случае крайней необходимости, выдавать такой доступ узкому кругу доверенных лиц и использовать стойкие пароли для доступа к ВМ.

После завершения использования серийной консоли не забудьте [запретить](index.md#disable) доступ к ней.

{% endnote %}

## Разрешить доступ к серийной консоли {#enable}

Вы можете разрешить доступ к серийной консоли как при создании новой виртуальной машины, так и изменив существующую ВМ.

### Создать новую ВМ с разрешенным доступом к серийной консоли {#turn-on-for-new-instance}

Чтобы разрешить доступ к серийной консоли при создании новой виртуальной машины на основе публичного [образа](../images-with-pre-installed-software/get-list.md) из [{{ marketplace-full-name }}](../../../marketplace/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../concepts/image.md) {{ marketplace-full-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите одну из готовых конфигураций или создайте свою.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
      * Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md). Если оставить поле пустым, то виртуальной машине будет автоматически назначена группа безопасности по умолчанию.
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
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.
  2. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию. В приведенном примере будет создана ВМ на основе публичного [образа](../images-with-pre-installed-software/get-list.md) из [{{ marketplace-full-name }}](../../../marketplace/index.md) на базе операционной системы [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin):

      ```bash
      yc compute instance create \
        --name sample-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-id=<идентификатор_подсети>,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2404-lts-oslogin,auto-delete=true \
        --metadata enable-oslogin=false,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
      ```

      Где:

      * `--name` — имя ВМ. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

          {% note info %}
          
          Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
          
          {% endnote %}

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет создана виртуальная машина.
      * `--network-interface` — сетевые настройки создаваемой ВМ:

          * `subnet-id` — [идентификатор подсети](../../../vpc/operations/subnet-get-info.md) в зоне доступности, в которой создается виртуальная машина.
      * `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:

          * `enable-oslogin` — параметр, отвечающий за доступ к ВМ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Возможные значения:

              * `true` — чтобы включить доступ к ВМ по {{ oslogin }}. В этом случае доступ по SSH-ключу, заданному через метаданные, будет невозможен.
              * `false` — чтобы отключить доступ к ВМ по {{ oslogin }}. Доступ к ВМ будет возможен только по SSH-ключу, заданному через метаданные.
          * `serial-port-enable=1` — параметр, разрешающий доступ к ВМ через серийную консоль.
          * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.

      Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

{% endlist %}

### Разрешить доступ к серийной консоли для существующей ВМ {#turn-on-for-current-instance}

Чтобы разрешить доступ к серийной консоли для существующей виртуальной машины:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная виртуальная машина.

  2. Перейдите в сервис **{{ compute-name }}**.

  3. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  4. В списке виртуальных машин в строке с нужной ВМ нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

     1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}**.
     2. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Измените ВМ, указав в команде ее [имя или идентификатор](../vm-info/get-info.md#outside-instance):

      ```bash
      yc compute instance update <имя_или_идентификатор_ВМ> \
        --metadata enable-oslogin=<true|false>,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
      ```

      Где `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:

      * `enable-oslogin` — параметр, отвечающий за доступ к ВМ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Возможные значения:

          * `true` — чтобы включить доступ к ВМ по {{ oslogin }}. В этом случае доступ по SSH-ключу, заданному через метаданные, будет невозможен.
          * `false` — чтобы отключить доступ к ВМ по {{ oslogin }}. Доступ к ВМ будет возможен только по SSH-ключу, заданному через метаданные.
      * `serial-port-enable=1` — параметр, разрешающий доступ к ВМ через серийную консоль.
      * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.

     Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

{% endlist %}

## Запретить доступ к серийной консоли {#disable}

По умолчанию доступ к серийной консоли для всех вновь создаваемых виртуальных машин {{ compute-name }} запрещен.

Чтобы запретить доступ к серийной консоли для существующей виртуальной машины:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная виртуальная машина.

  2. Перейдите в сервис **{{ compute-name }}**.

  3. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  4. В списке виртуальных машин в строке с нужной ВМ нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

     1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** отключите опцию **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}**.
     2. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Измените ВМ, указав в команде ее [имя или идентификатор](../vm-info/get-info.md#outside-instance):

      ```bash
      yc compute instance update <имя_или_идентификатор_ВМ> \
        --metadata enable-oslogin=<true|false>,serial-port-enable=0,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
      ```

      Где `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:

      * `enable-oslogin` — параметр, отвечающий за доступ к ВМ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Возможные значения:

          * `true` — чтобы включить доступ к ВМ по {{ oslogin }}. В этом случае доступ по SSH-ключу, заданному через метаданные, будет невозможен.
          * `false` — чтобы отключить доступ к ВМ по {{ oslogin }}. Доступ к ВМ будет возможен только по SSH-ключу, заданному через метаданные.
      * `serial-port-enable=0` — параметр, запрещающий доступ к ВМ через серийную консоль.
      * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.

      Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/serial-console.md)
* [{#T}](connect-ssh.md)
* [{#T}](windows-sac.md)