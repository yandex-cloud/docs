# Запуск Docker-образа на виртуальной машине с помощью консоли управления, CLI и API

Чтобы запустить [Docker-образ на ВМ](index.md) с использованием реестра [{{ container-registry-full-name }}](../../index.md), выполните следующие шаги:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте реестр {{ container-registry-name }}](#create-registry).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте ВМ {{ compute-name }}](#create-vm).
1. [Соберите и загрузите Docker-образ в {{ container-registry-name }}](#create-image).
1. [Загрузите Docker-образ на ВМ](#run).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование динамического или статического [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за хранение Docker-образа в реестре и исходящий трафик (см. [тарифы {{ container-registry-full-name }}](../../pricing.md)).


### Создайте пару ключей SSH {#create-ssh}

Подготовьте [SSH-ключ](../../../glossary/ssh-keygen.md) для [доступа к ВМ](../../../compute/operations/vm-connect/ssh.md).

{% list tabs group=operating_system %}

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
  
      ![ssh_generate_key](../../../_assets/compute/ssh-putty/ssh_generate_key.png)
  
  1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
  1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
  1. Нажмите кнопку **Save public key** и сохраните открытый ключ в файле `<имя_ключа>.pub`.

{% endlist %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к ВМ будет невозможно.

{% endnote %}


### Установите и настройте Docker {#configure-docker}

{% list tabs group=operating_system %}

- Linux {#linux}

    1. Установите Docker Engine. Воспользуйтесь [инструкцией](https://docs.docker.com/engine/install/#supported-platforms) по установке и запуску Docker для вашей операционной системы.

    1. После завершения установки добавьте текущего пользователя в группу `docker`:

        ```bash
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
        ```

    Чтобы группы успешно обновились, может потребоваться войти в ОС заново или перезагрузить компьютер.

    Информацию о дополнительных настройках Docker в OS Linux см. в [документации разработчика](https://docs.docker.com/engine/install/linux-postinstall/).

    Если вы работаете на компьютере с графическим интерфейсом, вы также можете [установить](https://docs.docker.com/desktop/install/linux-install/) Docker Desktop для Linux.

- macOS {#macos}

  [Скачайте](https://docs.docker.com/get-docker/) и установите дистрибутив Docker Desktop для macOS. Подробную информацию см. в [документации разработчика](https://docs.docker.com/desktop/install/mac-install/).

- Windows {#windows}

    1. [Скачайте](https://docs.docker.com/get-docker/) и установите дистрибутив Docker Desktop для Windows.

    1. После завершения установки добавьте текущего пользователя в группу `docker-users`:

        1. От имени администратора откройте оснастку **Управление компьютером**:

            ```powershell
            compmgmt.msc
            ```
        
        1. Раскройте меню **Управление компьютером (локальным)** → **Служебные программы** → **Локальные пользователи и группы** → **Группы** и откройте группу `docker-users`.
        1. Нажмите кнопку **Добавить** и добавьте нужного пользователя в группу.
        1. Нажмите **ОК**.
    1. Запустите Docker Desktop и убедитесь, что статус приложения — `running`.

    Информацию о дополнительных настройках Docker в OS Windows см. в [документации разработчика](https://docs.docker.com/desktop/install/windows-install/).

{% endlist %}


## Создайте реестр {{ container-registry-name }} {#create-registry}

[Создайте](../../operations/registry/registry-create.md) реестр в {{ container-registry-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан реестр.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Задайте имя реестра. Требования к имени:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
  1. (Опционально) В блоке **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:
  
  
      * Отключите опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}**, чтобы не сканировать Docker-образы при загрузке в репозиторий.
      * Отключите опцию **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}** или настройте периодичность сканирования.
  
        {% note warning %}
        
        Автоматическое сканирование Docker-образов повышает безопасность реестра. Настройки сканирования уязвимостей по умолчанию соответствуют [Стандарту по защите облачной инфраструктуры {{ yandex-cloud }}](../../../security/standard/app-security.md#pipeline-recommendations).
        
        {% endnote %}
  
  1. (Опционально) Добавьте метки.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Убедитесь, что в каталоге еще не создан реестр:
  
      ```bash
      yc container registry list
      ```
  
      Результат:
  
      ```text
      +----+------+-----------+
      | ID | NAME | FOLDER ID |
      +----+------+-----------+
      +----+------+-----------+
      ```
  
      Если в каталоге уже есть реестр, посмотрите, как можно его изменить, в разделе [{#T}](../../operations/registry/registry-update.md).
  
  1. Создайте реестр:
  
      * с автоматическим сканированием уязвимостей:
  
  
          ```bash
          yc container registry create --name my-reg --secure
          ```
  
        {% note warning %}
        
        Автоматическое сканирование Docker-образов повышает безопасность реестра. Настройки сканирования уязвимостей по умолчанию соответствуют [Стандарту по защите облачной инфраструктуры {{ yandex-cloud }}](../../../security/standard/app-security.md#pipeline-recommendations).
        
        {% endnote %}
  
      * без автоматического сканирования уязвимостей:
  
          ```bash
          yc container registry create --name my-reg
          ```
  
      Результат:
  
      ```text
      done
      id: crpd50616s9a********
      folder_id: b1g88tflru0e********
      name: my-reg
      status: ACTIVE
      created_at: "2019-01-09T14:34:06.601Z"
      ```
  
      Требования к имени реестра:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
      Параметр `--name` необязательный, можно создать реестр без имени и обращаться к нему по идентификатору. Поле `name` пользовательское, оно используется при листинге в {{ yandex-cloud }} CLI и не используется в Docker CLI.
  1. Проверьте, что реестр создался:
  
      ```bash
      yc container registry list
      ```
  
      Результат:
  
      ```text
      +----------------------+--------+----------------------+
      |          ID          |  NAME  |      FOLDER ID       |
      +----------------------+--------+----------------------+
      | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
      +----------------------+--------+----------------------+
      ```

- API {#api}

  Чтобы создать реестр, воспользуйтесь методом [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md).

{% endlist %}


## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) и назначьте ему [роль](../../../iam/concepts/access-control/roles.md) `{{ roles-cr-puller }}` на реестр, созданный ранее:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md): `images-puller`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_dashboard }}**.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}** и добавьте сервисный аккаунт, указав его идентификатор.
  1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите роль `{{ roles-cr-puller }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Посмотрите описание команды CLI для создания сервисного аккаунта:

      ```bash
      yc iam service-account create --help
      ```

  1. Создайте сервисный аккаунт:

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      ```bash
      yc iam service-account create --name images-puller
      ```

      Результат:

      ```text
      id: ajelabcde12f********
      folder_id: b0g12ga82bcv********
      created_at: "2020-11-30T14:32:18.900092Z"
      name: myservice-acc
      ```

  1. Назначьте роль `{{ roles-cr-puller }}` сервисному аккаунту:

      ```bash
      yc container registry add-access-binding <имя_или_идентификатор_реестра> \
        --role {{ roles-cr-puller }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где `--subject` — идентификатор сервисного аккаунта (например: `ajelabcde12f********`), которому назначается роль.

- API {#api}

  1. Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

  1. Чтобы назначить роль сервисному аккаунту на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

{% endlist %}


## Создайте виртуальную машину {{ compute-name }} {#create-vm}

Создайте ВМ с публичным IP-адресом и привяжите к ней созданный сервисный аккаунт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../../compute/operations/images-with-pre-installed-software/get-list.md) и версию операционной системы на базе Linux.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** задайте нужный [тип](../../../compute/concepts/disk.md#disks-types) и размер загрузочного [диска](../../../compute/concepts/disk.md).

      Если вы хотите добавить на ВМ новый дополнительный диск или подключить существующий, нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

      Также вы можете [создать ВМ из существующего диска](../../../compute/operations/vm-create/create-from-disks.md).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../../vpc/concepts/network.md#network) или [подсети](../../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../../vpc/operations/subnet-create.md).
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее. Чтобы не назначать публичный IP-адрес, выберите `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * При необходимости разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и включите защиту от DDoS-атак.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
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

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../../compute/concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите созданный на предыдущем шаге [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания ВМ:

      ```bash
      yc compute instance create --help
      ```

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ.
  1. Выберите в {{ marketplace-name }} один из публичных [образов](../../../compute/operations/images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7)).

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
      * `FAMILY` — идентификатор [семейства образов](../../../compute/concepts/image.md#family), к которому относится образ.
      * `PRODUCT IDS` — идентификаторы [продуктов](../../../marketplace/concepts/product.md) {{ marketplace-full-name }}, связанных с образом.
      * `STATUS` — текущий статус образа. Может принимать одно из значений:
      
          * `STATUS_UNSPECIFIED` — статус образа не определен.
          * `CREATING` — образ в процессе создания.
          * `READY` — образ готов к использованию.
          * `ERROR` — образ нельзя использовать из-за возникшей с ним проблемы.
          * `DELETING` — образ в процессе удаления.

  1. Посмотрите список доступных подсетей:

      ```bash
      yc vpc subnet list
      ```

      Результат:

      ```text
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      | b0c6n43f9lgh******** | default-{{ region-id }}-d     | enpe3m3fa00u******** |                | {{ region-id }}-d     | [10.130.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b     | [10.129.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.128.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

  1. Создайте ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=default-{{ region-id }}-b,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
        --service-account-name service-acc
      ```

      Где:

      * `--name` — имя ВМ.

        {% note info %}
        
        Имя виртуальной машины используется для генерации [внутреннего FQDN](../../../compute/concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
        
        {% endnote %}

      * `--zone` — зона доступности, которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной подсети.
      * `image-family` — [семейство образов](../../../compute/concepts/image.md#family), например `centos-7`. Эта опция позволит установить последнюю версию операционной системы из указанного семейства.
      * Публичный IP. Чтобы создать ВМ без публичного IP, исключите опцию `nat-ip-version=ipv4`.
      * `--ssh-key` — путь до публичного SSH-ключа. Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.
      * `--service-account-name` — имя сервисного аккаунта, созданного на предыдущем шаге.

      В результате будет создана ВМ `first-instance`.

- API {#api}

  Создайте ВМ с помощью метода REST API [Create](../../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md):

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ.
  1. Получите [{{ iam-full-name }}-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:

      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.

  1. [Получите идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога.
  1. Получите информацию об образе, из которого надо создать ВМ (идентификатор образа и минимальный размер диска):

      * Если вы знаете [семейство образа](../../../compute/concepts/image.md#family), получите информации о последнем образе в этом семействе:

          ```bash
          export IAM_TOKEN=CggaATEVAgA...
          export FAMILY=ubuntu-1804
          curl --header "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
          ```

      * Вы можете получить информацию об образе из [списка публичных образов](../../../compute/operations/images-with-pre-installed-software/get-list.md).

  1. Получите идентификатор подсети и идентификатор зоны доступности. В запросе укажите идентификатор каталога, в котором создана подсеть:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      export FOLDER_ID=b1gvmob95yys********
      curl --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
      {
        "subnets": [
          {
            "v4CidrBlocks": [
              "10.130.0.0/24"
            ],
          "id": "b0c6n43ftldh********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-09-23T12:15:00Z",
          "name": "default-{{ region-id }}-b",
          "description": "Auto-created default subnet for zone {{ region-id }}-b",
          "networkId": "enpe3m3faglu********",
          "zoneId": "{{ region-id }}-b"
        },
        ...
        ]}
      ```

  1. Создайте файл с телом запроса на создание ВМ, например `body.json`:

      ```json
      {
        "folderId": "b1gvmob95yys********",
        "name": "instance-demo-no-pwauth",
        "zoneId": "{{ region-id }}-b",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "2147483648",
          "cores": "2"
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
        },
        "bootDiskSpec": {
          "diskSpec": {
            "size": "2621440000",
            "imageId": "fd8rc75pn12f********"
          }
        },
        "networkInterfaceSpecs": [
          {
            "subnetId": "b0c6n43ftldh********",
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
          }
        ],
        "serviceAccountId": "ajelabcde12f********"
      }
      ```

      Где:

      * `folderId` — идентификатор каталога.
      * `name` — имя, которое будет присвоено ВМ при создании.
      * `zoneId` — зона доступности, которая соответствует выбранной подсети.
      * `platformId` — [платформа](../../../compute/concepts/vm-platforms.md).
      * `resourceSpec` — ресурсы, доступные ВМ. Значения должны соответствовать выбранной платформе.
      * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [{#T}](../../../compute/concepts/vm-metadata.md).
      * `bootDiskSpec` — настройки загрузочного диска. Укажите идентификатор выбранного образа и размер диска. Размер диска должен быть не меньше минимального размера диска, указанного в информации об образе.
      * `networkInterfaceSpecs` — настройки сети:

        * `subnetId` — идентификатор выбранной подсети.
        * `primaryV4AddressSpec` — IP-адрес, который будет присвоен ВМ. Чтобы добавить [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ, укажите:

            ```yaml
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```

      * `serviceAccountId` — идентификатор созданного на предыдущем шаге сервисного аккаунта.

      Подробнее про формат тела запроса в [справочнике API](../../../compute/api-ref/Instance/create.md).

  1. Создайте ВМ:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/instances
      ```

{% endlist %}

После создания ВМ [соберите и загрузите Docker-образ в {{ container-registry-name }}](#create-image). 


## Соберите и загрузите Docker-образ в {{ container-registry-name }} {#create-image}

Пример ниже разработан для выполнения в операционных системах MacOS и Linux. Чтобы выполнить его в системе Windows, [ознакомьтесь]({{ link-docs }}/overview/concepts/console-syntax-guide) с особенностями работы с Bash в Microsoft Windows.

1. Откройте терминал.
1. Для удобства выполнения команд добавьте переменные:

    * Имя пользователя и публичный IP-адрес вашей ВМ — в переменную `${PUBLIC_IP}`:

        ```bash
        export PUBLIC_IP=<имя_пользователя>@<публичный_IP-адрес_ВМ>
        ```

    * Идентификатор реестра, созданного ранее, в формате `crpc9qeoft23********` — в переменную `${REGISTRY_ID}`:

        ```bash
        export REGISTRY_ID=<идентификатор_реестра>
        ```

1. Аутентифицируйтесь от своего имени:

    {% list tabs group=registry_auth %}

    - OAuth-токен {#oauth-token}

      {% note info "Аутентификация по OAuth-токенам устарела" %}
      
      В будущем этот способ аутентификации перестанет поддерживаться. Рассмотрите использование [IAM-токенов](../../../iam/concepts/authorization/iam-token.md) или [API-ключей](../../../iam/concepts/authorization/api-key.md).
      
      {% endnote %}

      1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
      1. Выполните команду:

          ```bash
          echo <OAuth-токен> | docker login --username oauth --password-stdin {{ registry }}
          ```

          Результат:

          ```text
          Login Succeeded
          ```

    - IAM-токен {#iam-token}

      {% note info %}

      У IAM-токена короткое [время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) — не более  {{ iam-token-lifetime }}. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

      {% endnote %}

      1. [Получите](../../../iam/operations/iam-token/create.md) {{ iam-short-name }}-токен.
      1. Выполните команду:

          ```bash
          yc iam create-token | docker login --username iam --password-stdin {{ registry }}
          ```

          Результат:

          ```text
          ...
          Login Succeeded
          ```

    - Docker Credential helper {#docker}

      1. Если у вас еще нет профиля для CLI, [создайте его](../../../cli/quickstart.md#initialize).
      1. Сконфигурируйте Docker для использования `docker-credential-yc`:

          ```bash
          yc container registry configure-docker
          ```

          Результат:

          ```text
          Credential helper is configured in '/home/<user>/.docker/config.json'
          ```

          Настройки сохраняются в профиле текущего пользователя.

          {% note warning %}

          Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

          {% endnote %}

      1. Проверьте, что Docker сконфигурирован.

          В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

          ```json
          "{{ registry }}": "yc"
          ```

      1. Docker готов к использованию, например, для [загрузки Docker-образов](../../operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

    {% endlist %}

1. Создайте файл Dockerfile:

    ```bash
    touch .dockerfile
    ```

1. Откройте Dockerfile текстовым редактором, например:

    ```bash
    nano .dockerfile
    ```

1. Добавьте туда следующие строки:

    ```text
    FROM ubuntu:latest
    CMD echo "Hi, I'm inside"
    ```

1. Соберите Docker-образ:

    ```bash
    docker build . -t {{ registry }}/${REGISTRY_ID}/ubuntu:hello -f .dockerfile
    ```

    Результат:

    ```text
    ...
    Successfully built b68ee9b6b1af
    Successfully tagged {{ registry }}/crpmnjr98tm5********/ubuntu:hello
    ```

1. Загрузите собранный Docker-образ в {{ container-registry-name }}:

    ```bash
    docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
    ```

    Результат:

    ```text
    The push refers to repository [{{ registry }}/crpc9qeoft23********/ubuntu]
    cc9d18e90faa: Pushed
    0c2689e3f920: Pushed
    47dde53750b4: Pushed
    hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928******** size: 943
    ```


## Загрузите Docker-образ на ВМ {#run}

1. [Подключитесь по SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ.
1. [Установите и настройте](../../operations/configure-docker.md) Docker на ВМ.
1. Пройдите [аутентификацию](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) от имени сервисного аккаунта, привязанного к этой машине:

    ```bash
    curl --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
    cut -f1 -d',' | \
    cut -f2 -d':' | \
    tr -d '"' | \
    docker login --username iam --password-stdin {{ registry }}
    ```

    Результат:

    ```text
    Login Succeeded
    ```

1. Для удобства выполнения команд добавьте идентификатор реестра, созданного ранее, в переменную `${REGISTRY_ID}`:

    ```bash
    export REGISTRY_ID=<идентификатор_реестра>
    ```

1. Скачайте Docker-образ на ВМ:

    ```bash
    docker pull {{ registry }}/${REGISTRY_ID}/ubuntu:hello
    ```

    Результат:

    ```text
    hello: Pulling from crpc9qeoft23********/ubuntu
    6a5697faee43: Pulling fs layer
    ba13d3bc422b: Pulling fs layer
    ...
    Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928********
    Status: Downloaded newer image for {{ registry }}/crpc9qeoft23********/ubuntu:hello
    {{ registry }}/crpc9qeoft23********/ubuntu:hello
    ```


## Проверьте результат {#check-out}

На ВМ запустите Docker-образ:

```bash
docker run {{ registry }}/${REGISTRY_ID}/ubuntu:hello
```

Результат:

```text
Hi, I'm inside
```


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
1. [Удалите](../../operations/docker-image/docker-image-delete.md) Docker-образ.
1. [Удалите](../../operations/registry/registry-delete.md) реестр.

#### См. также {#see-also}

* [{#T}](terraform.md)