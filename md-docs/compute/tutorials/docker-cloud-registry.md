# Запуск Docker-образа на виртуальной машине с помощью Yandex Cloud Registry

В этом руководстве вы развернете [Docker-образ](../../cloud-registry/concepts/artifacts/docker.md) из [реестра](../../cloud-registry/concepts/registry.md) Yandex Cloud Registry и запустите контейнер на [виртуальной машине](../concepts/vm.md) Yandex Compute Cloud.

Чтобы запустить Docker-образ на виртуальной машине:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте реестр Cloud Registry](#create-registry).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте авторизованный ключ сервисного аккаунта](#create-authorized-key).
1. [Создайте облачную сеть и подсеть](#create-network).
1. [Создайте ВМ](#create-vm).
1. [Соберите Docker-образ и загрузите в Cloud Registry](#create-image).
1. [Загрузите Docker-образ на ВМ](#run).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для запуска Docker-образа входят:

* Плата за постоянно запущенную ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за хранение созданных образов ([тарифы Yandex Cloud Registry](../../cloud-registry/pricing.md)).
* Плата за исходящий трафик из Yandex Cloud в интернет ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).


### Создайте пару ключей SSH {#create-ssh}

Подготовьте [SSH-ключ](../../glossary/ssh-keygen.md) для [доступа к ВМ](../operations/vm-connect/ssh.md).

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
  
      ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh_generate_key.png)
  
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

    Дополнительные настройки Docker в OS Linux описаны в [документации разработчика](https://docs.docker.com/engine/install/linux-postinstall/).

    Если вы работаете на компьютере с графическим интерфейсом, вы также можете [установить](https://docs.docker.com/desktop/install/linux-install/) Docker Desktop для Linux.

- macOS {#macos}

  [Скачайте](https://docs.docker.com/get-docker/) и установите дистрибутив Docker Desktop для macOS. Подробная информация доступна в [документации разработчика](https://docs.docker.com/desktop/install/mac-install/).

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

    Дополнительные настройки Docker в ОС Windows описаны в [документации разработчика](https://docs.docker.com/desktop/install/windows-install/).

{% endlist %}


## Создайте реестр Cloud Registry {#create-registry}

Создайте реестр для хранения Docker-образов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать реестр.
  1. Перейдите в сервис **Cloud Registry**.
  1. Нажмите **Создать реестр**.
  1. Выберите формат ![image](../../_assets/console-icons/logo-docker.svg) **Docker**.
  1. Выберите тип реестра **Local**.
  1. Укажите имя реестра. Требования к имени:

      * длина — от 3 до 62 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания реестра:

      ```bash
      yc cloud-registry registry create --help
      ```

  1. Создайте реестр:

      ```bash
      yc cloud-registry registry create \
        --name docker-ycr \
        --description "Created with CLI" \
        --registry-kind docker \
        --registry-type local
      ```

      Результат:

      ```text
      id: cn191rncdrhd********
      folder_id: b1g681qpemb4********
      name: docker-ycr
      kind: DOCKER
      type: LOCAL
      status: ACTIVE
      description: Created with CLI
      created_at: "2025-12-12T04:56:32.681439Z"
      modified_at: "2025-12-12T04:56:34.171714Z"
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../cloud-registry/api-ref/Registry/create.md) для ресурса [Registry](../../cloud-registry/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../cloud-registry/api-ref/grpc/Registry/create.md).

{% endlist %}


## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого вы будете скачивать Docker-образ на ВМ. Назначьте ему [роль](../../cloud-registry/security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` на созданный реестр.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `docker-puller`.
  1. Нажмите **Создать**.
  1. Перейдите в сервис **Cloud Registry**.
  1. Выберите ранее созданный реестр.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/persons.svg) **Права доступа**.
  1. Нажмите **Назначить роли**.
  1. В открывшемся окне выберите сервисный аккаунт `docker-puller`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `cloud-registry.artifacts.puller`.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  1. Создайте сервисный аккаунт:

      ```bash
      yc iam service-account create --name docker-puller
      ```

      Результат:

      ```text
      id: ajelabcde12f********
      folder_id: b0g12ga82bcv********
      created_at: "2020-11-30T14:32:18.900092Z"
      name: docker-puller
      ```

  1. Назначьте роль `cloud-registry.artifacts.puller` сервисному аккаунту:

      ```bash
      yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
        --role cloud-registry.artifacts.puller \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где `--subject` — идентификатор сервисного аккаунта `docker-puller`.

      Результат:

      ```text
      ...1s...done (5s)
      ```

- API {#api}

  1. Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).
  1. Чтобы назначить роль сервисному аккаунту на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../cloud-registry/api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../cloud-registry/api-ref/Registry/index.md).

{% endlist %}

## Создайте авторизованный ключ сервисного аккаунта {#create-authorized-key}

Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта `docker-puller`. Авторизованный ключ позволит сервисному аккаунту получать IAM-токен для аутентификации в API Yandex Cloud.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Identity and Access Management**.
  1. В открывшемся списке выберите сервисный аккаунт `docker-puller`.
  1. На панели сверху нажмите ![plus](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите `Создать авторизованный ключ`.
  1. Нажмите **Создать**.
  1. В открывшемся окне нажмите **Скачать файл с ключами** и нажмите **Закрыть**.

  В результате на ваш компьютер скачается файл `authorized_key.json`, содержащий авторизованный ключ. Ключ понадобится позднее для настройки Docker на ВМ.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam key create \
    --service-account-name docker-puller \
    -o authorized_key.json
  ```

  Результат:

  ```text
  id: ajetn5b1efv2********
  service_account_id: ajefbp899mcl********
  created_at: "2025-12-17T04:57:16.241850455Z"
  key_algorithm: RSA_2048
  ```

  В результате на ваш компьютер скачается файл `authorized_key.json`, содержащий авторизованный ключ. Ключ понадобится позднее для настройки Docker на ВМ.

- API {#api}

  Воспользуйтесь методом REST API [create](../../iam/api-ref/Key/create.md) для ресурса [Key](../../iam/api-ref/Key/index.md) или вызовом gRPC API [KeyService/Create](../../iam/api-ref/grpc/Key/create.md).

{% endlist %}


## Создайте облачную сеть и подсеть {#create-network}

Создайте [облачную сеть](../../vpc/concepts/network.md) и [подсеть](../../vpc/concepts/network.md#subnet), в которой будет расположена ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Нажмите **Создать сеть**.
  1. В поле **Имя** укажите `docker-ycr-network`.
  1. В поле **Дополнительно** отключите опцию **Создать подсети**.
  1. Нажмите **Создать сеть**.
  1. Выберите созданную сеть `docker-ycr-network`.
  1. Справа вверху нажмите ![image](../../_assets/console-icons/nodes-right.svg) **Создать подсеть**.
  1. В поле **Имя** укажите `docker-ycr-subnet-ru-central1-b`.
  1. В поле **Зона доступности** выберите зону доступности `ru-central1-b`.
  1. В поле **CIDR** укажите `192.168.1.0/24`.
  1. Нажмите **Создать подсеть**.

- CLI {#cli}

  1. Создайте облачную сеть `docker-ycr-network`:

      ```bash
      yc vpc network create docker-ycr-network
      ```

      Результат:

      ```text
      id: enp1gg8kr3pv********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:08:11Z"
      name: docker-ycr-network
      default_security_group_id: enppne4l2eg5********
      ```

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсеть в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-b`:

      ```bash
      yc vpc subnet create docker-ycr-subnet-ru-central1-b \
        --zone ru-central1-b \
        --network-name docker-ycr-network \
        --range 192.168.1.0/24
      ```

      Результат:

      ```text
      id: e2li9tcgi7ii********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:11:16Z"
      name: docker-ycr-subnet-ru-central1-b
      network_id: enp1gg8kr3pv********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).
  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


## Создайте ВМ {#create-vm}

Создайте ВМ с публичным IP-адресом и привяжите к ней созданный сервисный аккаунт.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Compute Cloud**.
  1. Нажмите **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** выберите один из образов и версию операционной системы на базе Linux.
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ.
  1. В блоке **Сетевые настройки**:
      * В поле **Подсеть** выберите ранее созданные сеть и подсеть.
      * В поле **Публичный IP-адрес** оставьте значение **Автоматически**, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud.

  1. В блоке **Доступ** укажите данные для доступа на ВМ:
      * В поле **Логин** введите имя пользователя.
      * В поле **SSH-ключ** вставьте содержимое файла [открытого ключа](../operations/vm-connect/ssh.md#creating-ssh-keys).

  1. В блоке **Общая информация** задайте имя ВМ: `docker-vm`.
  1. В блоке **Дополнительно** выберите созданный сервисный аккаунт `docker-puller`.
  1. Нажмите **Создать ВМ**.

- CLI {#cli}

  Создайте ВМ в каталоге по умолчанию:

  ```bash
  yc compute instance create \
    --name docker-vm \
    --zone ru-central1-b \
    --network-interface subnet-name=docker-ycr-subnet-ru-central1-b,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts \
    --ssh-key <путь_к_файлу_открытого_SSH-ключа> \
    --service-account-name docker-puller
  ```

  Где:

  * `--name` — имя ВМ.
  * `--zone` — зона доступности, которая соответствует подсети.
  * `subnet-name` — имя ранее созданной подсети.
  * `image-family` — [семейство образов](../concepts/image.md#family).
  * `--ssh-key` — путь до публичного SSH-ключа.
  * `--service-account-name` — имя сервисного аккаунта.

  Результат:

  ```text
  id: epd6kj8giu79********
  folder_id: b1g681qpemb4********
  created_at: "2025-12-12T16:14:50Z"
  name: docker-vm
  zone_id: ru-central1-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epdvqn83lud9********
    auto_delete: true
    disk_id: epdvqn83lud9********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:**:**:**:**
      subnet_id: e2l8hdblgki4********
      primary_v4_address:
        address: 192.168.1.7
        one_to_one_nat:
          address: 158.***.**.***
          ip_version: IPV4
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  gpu_settings: {}
  fqdn: epd6kj8giu79********.auto.internal
  scheduling_policy: {}
  service_account_id: ajes3g9rg94s********
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V2
  application: {}
  ```

- API {#api}

  Воспользуйтесь методом REST API [Create](../api-ref/Instance/create.md) для ресурса [Instance](../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../api-ref/grpc/Instance/create.md).

{% endlist %}


## Соберите Docker-образ и загрузите в Cloud Registry {#create-image}

Соберите Docker-образ и загрузите его в реестр.

{% list tabs group=programming_language %}

- Bash {#bash}

  1. [Аутентифицируйтесь](../../cloud-registry/operations/docker/authentication.md) в Cloud Registry.
  1. Создайте файл Dockerfile:

      ```bash
      echo "FROM ubuntu:latest" > Dockerfile
      echo "CMD echo 'Hello World'" >> Dockerfile
      ```

  1. Соберите Docker-образ:

      ```bash
      docker build . -t registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
      ```

      Где `<идентификатор_реестра>` — идентификатор созданного [ранее](#create-registry) реестра.

      Результат:

      ```text
      ...
      Successfully built db45********
      Successfully tagged registry.yandexcloud.net/cn1k31pgpovl********/ubuntu:hello
      ```

  1. Загрузите Docker-образ в реестр:

      ```bash
      docker push registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
      ```

      Результат:

      ```text
      e8bc********: Pushed 
      hello: digest: sha256:96d... size: 529
      ```

{% endlist %}


## Загрузите Docker-образ на ВМ {#run}

Настройте окружение на ВМ, скачайте Docker-образ и запустите его.

{% list tabs group=programming_language %}

- Bash {#bash}

  1. [Подключитесь](../operations/vm-connect/ssh.md) к ВМ по SSH.
  1. [Установите](../../cli/quickstart.md#install) CLI и перезапустите терминал:

      ```bash
      curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
      exec -l $SHELL
      ```

  1. Создайте файл `key.json` и скопируйте в него содержимое файла авторизованного ключа сервисного аккаунта `docker-puller`:

      ```bash
      sudo nano key.json
      ```

  1. Настройте CLI для сервисного аккаунта:

      ```bash
      yc config profile create docker-puller
      yc config set service-account-key key.json
      yc config set folder-id <идентификатор_каталога>
      ```

      В качестве `folder-id` укажите идентификатор каталога, в котором находится реестр.

      Результат:

      ```text
      Profile 'docker-puller' created and activated
      ```

  1. Установите Docker:

      ```bash
      sudo apt update
      sudo apt install docker.io
      ```

  1. Добавьте текущего пользователя в группу `docker` и отключитесь от ВМ:

      ```bash
      sudo usermod -aG docker $USER
      exit
      ```

  1. Заново [подключитесь](../operations/vm-connect/ssh.md) к ВМ по SSH.
  1. Настройте Docker:

      ```bash
      mkdir -p ~/.docker
      cat > ~/.docker/config.json <<'EOF'
      {
        "credHelpers": {
          "registry.yandexcloud.net": "yc"
        }
      }
      EOF

      sudo tee /usr/local/bin/docker-credential-yc >/dev/null <<'EOF'
      #!/usr/bin/env bash
      exec yc cloud-registry docker-credential "$@"
      EOF

      sudo chmod +x /usr/local/bin/docker-credential-yc
      ```

  1. Загрузите Docker-образ на ВМ:

      ```bash
      docker pull registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
      ```

      Результат:

      ```text
      hello: Pulling from cn191rncdrhd********/ubuntu
      02de********: Pull complete
      Digest: sha256:96d...
      Status: Downloaded newer image for registry.yandexcloud.net/cn191rncdrhd********/ubuntu:hello
      registry.yandexcloud.net/cn191rncdrhd********/ubuntu:hello
      ```

  1. Запустите Docker-образ:

      ```bash
      docker run registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
      ```

      Результат:

      ```text
      Hello World
      ```

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы не [платить](#paid-resources) за ресурсы, которые вам больше не нужны, удалите их:

1. [Удалите](../operations/vm-control/vm-delete.md) ВМ.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
1. Удалите [сеть](../../vpc/operations/network-delete.md) и [подсети](../../vpc/operations/subnet-delete.md).
1. Удалите [Docker-образ](../../cloud-registry/concepts/artifacts/docker.md) из реестра.
1. Удалите [реестр](../../cloud-registry/concepts/registry.md).


#### Полезные ссылки {#see-also}

* [Работа с Cloud Registry](../../cloud-registry/operations/index.md)
* [Создание ВМ с Container Optimized Image](../../cos/tutorials/vm-create.md)