[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > [Базовая инфраструктура](../../infrastructure/index.md) > Инструменты > [Запуск Docker-образа на виртуальной машине](index.md) > Terraform

# Запуск Docker-образа на виртуальной машине с помощью Terraform

Чтобы [запустить Docker-образ на ВМ](index.md) с использованием реестра [Yandex Container Registry](../../../container-registry/index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Соберите и загрузите Docker-образ в Container Registry](#create-image).
1. [Загрузите Docker-образ на ВМ](#run).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за постоянно запущенную ВМ ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование динамического или статического [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за хранение Docker-образа в реестре и исходящий трафик ([тарифы Yandex Container Registry](../../../container-registry/pricing.md)).


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


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:
1. [Установите Terraform](../terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-run-docker-on-vm) с конфигурационными файлами:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-run-docker-on-vm.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должнен появиться файл `run-docker-on-vm-config.tf` с конфигурацией создаваемой инфраструктуры.

    - Вручную {#manual}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `run-docker-on-vm.tf`:

          {% cut "Содержимое файла run-docker-on-vm.tf" %}

          ```hcl
          # Объявление переменных для конфиденциальных параметров
          
          locals {
            zone             = "<зона_доступности_по_умолчанию>"
            username         = "<имя_пользователя_ВМ>"
            ssh_key_path     = "<путь_к_публичному_SSH-ключу>"
            target_folder_id = "<идентификатор_каталога_для_размещения_ВМ>"
            registry_name    = "<имя_реестра>"
            sa_name          = "<имя_сервисного_аккаунта>"
            network_name     = "<имя_облачной_сети>"
            subnet_name      = "<имя_подсети>"
            vm_name          = "<имя_виртуальной_машины>"
            image_id         = "<идентификатор_образа>"
          }
          
          # Настройка провайдера
          
          terraform {
            required_providers {
              yandex    = {
                source  = "yandex-cloud/yandex"
                version = ">= 0.47.0"
              }
            }
          }
          
          provider "yandex" {
            zone = local.zone
          }
          
          # Создание репозитория Сontainer Registry
          
          resource "yandex_container_registry" "my-registry" {
            name       = local.registry_name
            folder_id  = local.target_folder_id
          }
          
          # Создание сервисного аккаунта
          
          resource "yandex_iam_service_account" "registry-sa" {
            name      = local.sa_name
            folder_id = local.target_folder_id
          }
          
          # Назначение роли сервисному аккаунту
          
          resource "yandex_resourcemanager_folder_iam_member" "registry-sa-role-images-puller" {
            folder_id = local.target_folder_id
            role      = "container-registry.images.puller"
            member    = "serviceAccount:${yandex_iam_service_account.registry-sa.id}"
          }
          
          # Создание облачной сети
          
          resource "yandex_vpc_network" "docker-vm-network" {
            name = local.network_name
          }
          
          # Создание подсети
          
          resource "yandex_vpc_subnet" "docker-vm-network-subnet-a" {
            name           = local.subnet_name
            zone           = local.zone
            v4_cidr_blocks = ["192.168.1.0/24"]
            network_id     = yandex_vpc_network.docker-vm-network.id
          }
          
          # Создание загрузочного диска
          
          resource "yandex_compute_disk" "boot-disk" {
            name     = "bootvmdisk"
            type     = "network-hdd"
            zone     = local.zone
            size     = "10"
            image_id = local.image_id
          }
          
          # Создание ВМ
          
          resource "yandex_compute_instance" "docker-vm" {
            name               = local.vm_name
            platform_id        = "standard-v3"
            zone               = local.zone
            service_account_id = "${yandex_iam_service_account.registry-sa.id}"
          
            resources {
              cores  = 2
              memory = 2
            }
          
            boot_disk {
              disk_id = yandex_compute_disk.boot-disk.id
            }
          
            network_interface {
              subnet_id = "${yandex_vpc_subnet.docker-vm-network-subnet-a.id}"
              nat       = true
            }
          
            metadata = {
              user-data = "#cloud-config\nusers:\n  - name: ${local.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${local.ssh_key_path}")}"
            }
          }
          ```

          {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform смотрите в документации провайдера:

    * [Реестр](../../../container-registry/concepts/registry.md) — [yandex_container_registry](../../../terraform/resources/container_registry.md).
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
    * [Привязка прав доступа к каталогу](../../../iam/concepts/access-control/index.md#access-bindings) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
    * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
    * [Диск](../../../compute/concepts/disk.md) — [yandex_compute_disk](../../../terraform/resources/compute_disk.md).
    * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).

1. В блоке `locals` задайте параметры создаваемых ресурсов:
    * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
    * `username` — имя пользователя, который будет создан на ВМ.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее в разделе [Создание пары ключей SSH](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `target_folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором будет находиться ВМ.
    * `registry_name` — имя реестра Container Registry.
    * `sa_name` — имя сервисного аккаунта.
    * `network_name` — имя облачной сети.
    * `subnet_name` — имя подсети.
    * `vm_name` — имя ВМ.
    * `image_id` — идентификатор образа, из которого будет создана ВМ. Подробнее в разделе [Получить список публичных образов](../../../compute/operations/images-with-pre-installed-software/get-list.md).

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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

После создания инфраструктуры [соберите и загрузите Docker-образ в Container Registry](#create-image).


## Соберите и загрузите Docker-образ в Container Registry {#create-image}

Пример ниже разработан для выполнения в операционных системах MacOS и Linux. Чтобы выполнить его в системе Windows, [ознакомьтесь](../../../overview/concepts/console-syntax-guide.md) с особенностями работы с Bash в Microsoft Windows.

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

      1. Если у вас еще нет OAuth-токена, получите его по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).
      1. Выполните команду:

          ```bash
          echo <OAuth-токен> | docker login --username oauth --password-stdin cr.yandex
          ```

          Результат:

          ```text
          Login Succeeded
          ```

    - IAM-токен {#iam-token}

      {% note info %}

      У IAM-токена короткое [время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) — не более  12 часов. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

      {% endnote %}

      1. [Получите](../../../iam/operations/iam-token/create.md) IAM-токен.
      1. Выполните команду:

          ```bash
          yc iam create-token | docker login --username iam --password-stdin cr.yandex
          ```

          Результат:

          ```text
          ...
          Login Succeeded
          ```

    - Docker credential helper {#docker}

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
          
          Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo`, читайте в [официальной документации Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).
          
          {% endnote %}

      1. Проверьте, что Docker сконфигурирован.

          В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

          ```json
          "cr.yandex": "yc"
          ```

      1. Docker готов к использованию, например, для [загрузки Docker-образов](../../../container-registry/operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

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
    docker build . -t cr.yandex/${REGISTRY_ID}/ubuntu:hello -f .dockerfile
    ```

    Результат:

    ```text
    ...
    Successfully built b68ee9b6b1af
    Successfully tagged cr.yandex/crpmnjr98tm5********/ubuntu:hello
    ```

1. Загрузите собранный Docker-образ в Container Registry:

    ```bash
    docker push cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```

    Результат:

    ```text
    The push refers to repository [cr.yandex/crpc9qeoft23********/ubuntu]
    cc9d18e90faa: Pushed
    0c2689e3f920: Pushed
    47dde53750b4: Pushed
    hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928******** size: 943
    ```


## Загрузите Docker-образ на ВМ {#run}

1. [Подключитесь по SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ.
1. [Установите и настройте](../../../container-registry/operations/configure-docker.md) Docker на ВМ.
1. Пройдите [аутентификацию](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) от имени сервисного аккаунта, привязанного к этой машине:

    ```bash
    curl --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
    cut -f1 -d',' | \
    cut -f2 -d':' | \
    tr -d '"' | \
    docker login --username iam --password-stdin cr.yandex
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
    docker pull cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```

    Результат:

    ```text
    hello: Pulling from crpc9qeoft23********/ubuntu
    6a5697faee43: Pulling fs layer
    ba13d3bc422b: Pulling fs layer
    ...
    Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928********
    Status: Downloaded newer image for cr.yandex/crpc9qeoft23********/ubuntu:hello
    cr.yandex/crpc9qeoft23********/ubuntu:hello
    ```


## Проверьте результат {#check-out}

На ВМ запустите Docker-образ:

```bash
docker run cr.yandex/${REGISTRY_ID}/ubuntu:hello
```

Результат:

```text
Hi, I'm inside
```


## Как удалить созданные ресурсы {#clear-out}

Чтобы удалить инфраструктуру и перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `run-docker-on-vm-config.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

## Полезные ссылки {#see-also}

* [Запуск Docker-образа на виртуальной машине с помощью консоли управления, CLI и API](console.md)