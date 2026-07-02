[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Практические руководства](index.md) > Бэкенд на Serverless > Запуск контейнерного приложения в Yandex Serverless Containers

# Запуск контейнерного приложения в Yandex Serverless Containers


С помощью этого руководства вы сможете развернуть контейнер с приложением в сервисе [Serverless Containers](../index.md) для администрирования СУБД MongoDB.

СУБД развернута на виртуальной машине [Yandex Compute Cloud](../../compute/index.md), контейнер с приложением хранится в реестре [Yandex Container Registry](../../container-registry/index.md), чувствительные данные зашифрованы с помощью [Yandex Lockbox](../../lockbox/index.md), а безопасный доступ к приложению реализован через API-шлюз [Yandex API Gateway](../../api-gateway/index.md). Вся инфраструктура контейнерного приложения располагается в одном каталоге.

Чтобы развернуть контейнерное приложение:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#sa-create).
1. [Создайте облачную сеть и подсеть](#create-network).
1. [Настройте группу безопасности](#configure-sg).
1. [Создайте виртуальную машину Compute Cloud с MongoDB](#create-vm).
1. [Создайте секрет Yandex Lockbox и версию](#secret-create).
1. [Создайте реестр Container Registry](#create-registry).
1. [Загрузите Docker-образ в Container Registry](#push-image).
1. [Создайте контейнер Serverless Containers](#create-container).
1. [Создайте API-шлюз API Gateway](#create-api-gw).
1. [Проверьте работу приложения](#check-app).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки приложения входит:

* плата за постоянно запущенную ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за хранение секретов ([тарифы Yandex Lockbox](../../lockbox/pricing.md));
* плата за хранение Docker-образа ([тарифы Yandex Container Registry](../../container-registry/pricing.md));
* плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик ([тарифы Serverless Containers](../pricing.md));
* плата за запросы к API-шлюзу ([тарифы Yandex API Gateway](../../api-gateway/pricing.md));
* плата за запись и хранение данных в [лог-группе](../../logging/concepts/log-group.md) ([тарифы Yandex Cloud Logging](../../logging/pricing.md)).


## Создайте сервисный аккаунт {#sa-create}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) и назначьте ему [роли](../../iam/concepts/access-control/roles.md) на каталог, в котором будет размещаться инфраструктура контейнерного приложения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором будет размещаться инфраструктура контейнерного приложения.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта — `mongo-express`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли `container-registry.images.puller`, `lockbox.payloadViewer` и `serverless-containers.containerInvoker`.
  1. Нажмите **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт с именем `mongo-express`:

      ```bash
      yc iam service-account create --name mongo-express
      ```

      Результат:

      ```text
      id: aje3pdqm1cul********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:31:06.911280565Z"
      name: mongo-express
      ```

  1.  Назначьте сервисному аккаунту роли `container-registry.images.puller`, `lockbox.payloadViewer` и `serverless-containers.containerInvoker` на каталог, в котором будет размещаться контейнер:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role container-registry.images.puller \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role lockbox.payloadViewer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role serverless-containers.containerInvoker \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или идентификатор каталога, в котором будет размещаться контейнер.
      * `--subject serviceAccount` — идентификатор сервисного аккаунта `mongo-express`.

      Результат:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: container-registry.images.puller
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount

      effective_deltas:
        - action: ADD
          access_binding:
            role_id: lockbox.payloadViewer
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount

      effective_deltas:
        - action: ADD
          access_binding:
            role_id: serverless-containers.containerInvoker
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount
      ```

- API {#api}

  1. Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Чтобы назначить сервисному аккаунту роли на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}


## Создайте облачную сеть и подсеть {#create-network}

Создайте [облачную сеть](../../vpc/concepts/network.md) и [подсеть](../../vpc/concepts/network.md#subnet), в которых будет располагаться ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Нажмите **Создать сеть**.
  1. В поле **Имя** укажите `mongo-express-network`.
  1. В поле **Дополнительно** выберите опцию **Создать подсети**.
  1. Нажмите **Создать сеть**.
  1. На панели слева выберите ![subnets](../../_assets/vpc/subnets.svg) **Подсети**.
  1. Нажмите **Создать подсеть**.
  1. В поле **Имя** укажите `mongo-express-subnet-ru-central1-b`.
  1. В поле **Зона доступности** выберите зону доступности `ru-central1-b`.
  1. В поле **Сеть** выберите облачную сеть `mongo-express-network`.
  1. В поле **CIDR** укажите `192.168.1.0/24`.
  1. Нажмите **Создать подсеть**.

- CLI {#cli}

  1. Создайте облачную сеть:

      ```bash
      yc vpc network create \
        --name mongo-express-network
      ```

      Результат:

      ```text
      id: enp1b4okmg57********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-13T12:57:02Z"
      name: mongo-express-network
      default_security_group_id: enphs1omp6m4********
      ```

      Сохраните идентификатор группы безопасности по умолчанию, указанный в поле `default_security_group_id`.

  1. Создайте подсеть:

      ```bash
      yc vpc subnet create \
         --name mongo-express-subnet-ru-central1-b \
         --zone ru-central1-b \
         --network-id <идентификатор_сети> \
         --range 192.168.1.0/24
      ```

      Где:

      * `--name` — название подсети.
      * `--zone` — зона доступности.
      * `--network-id` — идентификатор сети `mongo-express-network`.
      * `--range` — список IPv4-адресов, откуда или куда будет поступать трафик.

      Результат:

      ```text
      id: e2l9i0eaq32t********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T09:27:37Z"
      name: mongo-express-subnet-ru-central1-b
      network_id: enp1b4okmg57********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

- API {#api}

  1. Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) и передайте в запросе:

      * Идентификатор каталога, в котором будет размещаться сеть.
      * Имя новой сети `mongo-express-network` в параметре `name`.

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


## Настройте группу безопасности {#configure-sg}

Настройте [группу безопасности](../../vpc/concepts/security-groups.md) по умолчанию в созданной [ранее](#create-network) облачной сети.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Группы безопасности**.
  1. Напротив группы безопасности, созданной по умолчанию для сети `mongo-express-network`, нажмите ![image](../../_assets/options.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Правила** перейдите на вкладку **Исходящий трафик**.
  1. Нажмите **Добавить правило** и создайте правило по таблице:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Назначение /<br/>Источник | CIDR блоки |
      | --- | --- | --- | --- | --- | --- |
      | `Входящий` | `any` | `27017` | `Любой` | `CIDR` | `0.0.0.0/0` |

  1. Нажмите **Сохранить**.

- CLI {#cli}

  Добавьте правило в группу безопасности:

  ```bash
  yc vpc security-group update-rules <идентификатор_группы_безопасности> \
    --add-rule "direction=ingress,port=27017,protocol=any,v4-cidrs=[0.0.0.0/0,0.0.0.0/0]"
  ```

  Где `<идентификатор_группы_безопасности>` — значение `default_security_group_id`, полученное на предыдущем шаге.

  Результат:

  ```text
  id: enpmal7qcb1q********
  folder_id: b1g681qpemb4********
  created_at: "2025-06-14T09:24:47Z"
  name: default-sg-enpeiqghds1j********
  description: Default security group for network
  network_id: enpeiqghds1j********
  status: ACTIVE
  rules:
    ...
    - id: enprm96de4ec********
      direction: INGRESS
      ports:
        from_port: "27017"
        to_port: "27017"
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
          - 0.0.0.0/0
  default_for_network: true
  ```

- API {#api}

  Чтобы добавить правило в группу безопасности, воспользуйтесь методом REST API [updateRules](../../vpc/api-ref/SecurityGroup/updateRules.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/UpdateRules](../../vpc/api-ref/grpc/SecurityGroup/updateRules.md) и передайте в запросе:

    * Идентификатор группы безопасности, в которую будут добавлены правила, в параметре `securityGroupId`.

        Чтобы узнать идентификатор группы безопасности, воспользуйтесь методом REST API [list](../../vpc/api-ref/SecurityGroup/list.md) для ресурса [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/List](../../vpc/api-ref/grpc/SecurityGroup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

    * Новые правила группы безопасности в массиве `additionRuleSpecs[]`:

        * Направление трафика — `ingress`.
        * Имя протокола передачи трафика в параметре `additionRuleSpecs[].protocolName` — `any`.
        * Список CIDR и масок подсетей в параметре `additionRuleSpecs[].cidrBlocks.v4CidrBlocks[]` — `[0.0.0.0/0,0.0.0.0/0]`.
        * Первый порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.fromPort` — `0`.
        * Последний порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.toPort` — `65535`.

{% endlist %}


## Создайте виртуальную машину с MongoDB {#create-vm}

Рекомендуем использовать [ВМ](../../compute/concepts/vm.md) в минимальной конфигурации.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска**:

      1. Перейдите на вкладку **Container Solution** и нажмите **Настроить**.
      1. В открывшемся окне перейдите на вкладку **Docker-compose** и укажите спецификацию Docker-контейнера:

          ```yaml
          version: '3.1'

          services:
            mongo:
              image: mongo
              restart: always
              environment:
                MONGO_INITDB_ROOT_USERNAME: mongo_db_user
                MONGO_INITDB_ROOT_PASSWORD: <пароль>
              ports:
                - 27017:27017
          ```

          В значении параметра `MONGO_INITDB_ROOT_PASSWORD` задайте пароль, который будет использоваться для доступа к БД. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/). Сохраните пароль, он понадобится вам на следующих шагах.

      1. Нажмите **Применить**.

  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите подсеть `mongo-express-subnet-ru-central1-b`.
      * В поле **Публичный IP-адрес** выберите `Автоматически`.

  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:

      * В поле **Логин** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ: `mongo-vm`.
  1. Нажмите **Создать ВМ**.

  Дождитесь перехода ВМ в статус `Running` и сохраните ее публичный IP-адрес — он потребуется для подключения к БД.

- CLI {#cli}

  1. [Подготовьте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../glossary/ssh-keygen.md) на ВМ.
  1. Подготовьте файл спецификации Docker-контейнера `docker-spec.yaml`:

      ```yaml
      version: '3.1'

      services:
        mongo:
          image: mongo
          restart: always
          environment:
            MONGO_INITDB_ROOT_USERNAME: mongo_db_user
            MONGO_INITDB_ROOT_PASSWORD: <пароль>
          ports:
            - 27017:27017
      ```

      В значении параметра `MONGO_INITDB_ROOT_PASSWORD` задайте пароль, который будет использоваться для доступа к БД. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/). Сохраните пароль, он понадобится вам на следующих шагах.

  1. Выполните команду:

      ```bash
      yc compute instance create-with-container \
        --docker-compose-file docker-spec.yaml \
        --name mongo-vm \
        --zone ru-central1-b \
        --network-interface subnet-name=mongo-express-subnet-ru-central1-b,nat-ip-version=ipv4 \
        --ssh-key <путь_к_файлу_открытого_ключа> \
        --create-boot-disk size=30
      ```

      Где:

      * `--docker-compose-file` — путь к [файлу спецификации](../../cos/concepts/coi-specifications.md#coi-spec) Docker-контейнера.
      * `--name` — имя ВМ.
      * `--zone` — зона доступности.
      * `--network-interface` — сетевые настройки ВМ.
      * `--ssh-key` — путь к файлу открытого ключа SSH, например `./ssh-key.pub`. Имя пользователя по умолчанию для доступа по SSH — `yc-user`.
      * `--create-boot-disk size` — размер загрузочного диска. Должен быть не менее 30 ГБ.

      Результат:

      ```text
      id: epde18u4mahl********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-vm
      ...
      ```

{% endlist %}


## Создайте секрет Yandex Lockbox {#secret-create}

В [секрете Yandex Lockbox](../../lockbox/concepts/secret.md) в зашифрованном виде будут храниться данные для аутентификации.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Lockbox**.
  1. Нажмите **Создать секрет**.
  1. В поле **Имя** введите имя секрета — `mongodb-creds`.
  1. В поле **Ключ** введите `login`.
  1. В поле **Значение** введите логин пользователя БД — `mongo_db_user`.

  1. Нажмите **Добавить ключ/значение** и укажите второй секрет:

      * В поле **Ключ** введите `password`.
      * В поле **Значение** введите пароль для доступа к БД — значение `MONGO_INITDB_ROOT_PASSWORD` из [спецификации Docker-контейнера](#create-vm).

  1. Нажмите **Создать**.

- CLI {#cli}

   Создайте секрет `mongodb-creds`:

    ```bash
    yc lockbox secret create \
      --name mongodb-creds \
      --payload "[{'key': 'login', 'text_value': 'mongo_db_user'},{'key': 'password', 'text_value': '<пароль>'}]"
    ```

    Где:

    * `--name` — имя секрета.
    * `--payload` — содержимое секрета в виде массива YAML или JSON.
    * `<пароль>` — значение `MONGO_INITDB_ROOT_PASSWORD` из [спецификации Docker-контейнера](#create-vm).

    Результат:

    ```text
    id: e6q6nbjfu9m2********
    folder_id: b1qt6g8ht345********
    created_at: "2023-02-08T10:34:06.601Z"
    name: mongodb-creds
    status: ACTIVE
    current_version:
      id: e6q0s9airqca********
      secret_id: e6q6nbjfu9m2********
      created_at: "2023-02-08T10:34:06.601Z"
      status: ACTIVE
      payload_entry_keys:
        - login
        - password
    ```

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}


## Создайте реестр Container Registry {#create-registry}

В [реестре](../../container-registry/concepts/registry.md) Container Registry будет храниться Docker-образ приложения `mongo-express`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Container Registry**.
  1. Нажмите **Создать реестр**.
  1. Задайте имя реестра `app-registry`.
  1. Нажмите **Создать реестр**.

- CLI {#cli}

  Создайте реестр `app-registry`:

  ```bash
  yc container registry create --name app-registry
  ```

  Результат:

  ```text
  id: crpd50616s9a********
  folder_id: b1g88tflru0e********
  name: app-registry
  status: ACTIVE
  created_at: "2023-02-08T10:34:06.601Z"
  ```

- API {#api}

  Чтобы создать реестр, воспользуйтесь методом REST API [create](../../container-registry/api-ref/Registry/create.md) для ресурса [Registry](../../container-registry/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/CreateRegistryRequest](../../container-registry/api-ref/grpc/Registry/create.md).

{% endlist %}


## Загрузите Docker-образ в реестр {#push-image}

1. Зарегистрируйтесь на [Docker Hub](https://hub.docker.com/).
1. Установите Docker:

    * [Версия для Windows](https://docs.docker.com/desktop/install/windows-install/).
    * [Версия для Linux](https://docs.docker.com/desktop/install/linux-install/).
    * [Версия для Mac](https://docs.docker.com/desktop/install/mac-install/).

1. [Скачайте](https://hub.docker.com/_/mongo-express) образ `mongo-express`:

    ```bash
    docker pull mongo-express
    ```

    Результат выполнения команды:

    ```text
    Using default tag: latest
    latest: Pulling from library/mongo-express
    6a428f9f83b0: Pull complete
    ...
    e60224d64a04: Pull complete
    Digest: sha256:dcfcf89bf91238ff129469a5a94523b3025913dcc41597d72d4d5f4a********
    Status: Downloaded newer image for mongo-express:latest
    docker.io/library/mongo-express:latest
    ```

1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md) в Container Registry с помощью Docker credential helper:

    {% list tabs group=instructions %}

    - CLI {#cli}

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

      1. Проверьте, что Docker сконфигурирован — в конфигурационном файле `${HOME}/.docker/config.json` должна появиться строка:

          ```json
          "cr.yandex": "yc"
          ```

      Docker готов к использованию.

    {% endlist %}

1. [Загрузите](../../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Присвойте загруженному образу `mongo-express` URL вида `cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

          ```bash
          docker tag mongo-express \
          cr.yandex/<идентификатор_реестра>/mongo-express:mongo-tag
          ```

      1. Загрузите образ `mongo-express` в реестр:

          ```bash
          docker push cr.yandex/<идентификатор_реестра>/mongo-express:mongo-tag
          ```

          Результат:

          ```text
          \The push refers to repository [cr.yandex/crpbr3qaut47********/mongo-express]
          7c550ce9591d: Pushed
          ...
          aedc3bda2944: Pushed
          mongo-tag: digest: sha256:c641... size: 1993
          ```

    {% endlist %}


## Создайте контейнер Serverless Containers {#create-container}

Чтобы запустить приложение в Yandex Cloud, создайте [контейнер](../concepts/container.md) и его [ревизию](../concepts/container.md#revision).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Serverless Containers**.
  1. Нажмите **Создать контейнер**.
  1. Введите имя контейнера `mongo-express-container`.
  1. Нажмите **Создать**.
  1. Перейдите на вкладку **Редактор**.

      1. В блоке **Ресурсы** укажите объем RAM — `1024 МБ`.
      1. В блоке **Параметры образа**:

          1. В поле **URL образа** укажите URL Docker-образа, загруженного [ранее](#push-image).
          1. В поле **Переменные окружения** добавьте переменные:

              * `ME_CONFIG_BASICAUTH_USERNAME` — оставьте значение пустым.
              * `ME_CONFIG_BASICAUTH_PASSWORD` — оставьте значение пустым.
              * `VCAP_APP_PORT` — укажите порт `8080`.
              * `ME_CONFIG_MONGODB_SERVER` — укажите публичный адрес ВМ, полученный [ранее](#create-vm).

          1. В поле **Секреты Lockbox** укажите секреты:

              * `ME_CONFIG_MONGODB_AUTH_USERNAME` — укажите секрет с ключом `login`.
              * `ME_CONFIG_MONGODB_AUTH_PASSWORD` — укажите секрет с ключом `password`.

        1. В блоке **Настройки**:

            1. В поле **Сервисный аккаунт** укажите `mongo-express`.
            1. В поле **Таймаут** укажите `15`.

  1. Нажмите **Создать ревизию**.

- CLI {#cli}

  1. Создайте контейнер:

      ```bash
      yc serverless container create --name mongo-express-container
      ```

      Результат:

      ```text
      id: bba3fva6ka5g********
      folder_id: b1gqvft7kjk3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-express-container
      url: https://bba3fva6ka5g********.containers.yandexcloud.net/
      status: ACTIVE
      ```

  1. Создайте ревизию контейнера:

      ```bash
      yc serverless container revision deploy \
        --container-name mongo-express-container \
        --cores 1 \
        --memory 1GB \
        --image cr.yandex/<идентификатор_реестра>/mongo-express:mongo-tag \
        --environment ME_CONFIG_BASICAUTH=false \
        --environment VCAP_APP_PORT=8080 \
        --environment ME_CONFIG_MONGODB_SERVER=<публичный_адрес_ВМ> \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_USERNAME,key=login,id=<идентификатор_секрета> \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_PASSWORD,key=password,id=<идентификатор_секрета> \
        --service-account-id <идентификатор_сервисного_аккаунта_mongo-express> \
        --network-id <идентификатор_сети> \
        --execution-timeout 15s \
        --concurrency 1
      ```

      Где:

      * `--image` — URL Docker-образа `mongo-express`, загруженного [ранее](#push-image).
      * `--environment` — переменные окружения:

          * `ME_CONFIG_BASICAUTH` — укажите значение `false`.
          * `VCAP_APP_PORT` — укажите порт `8080`.
          * `ME_CONFIG_MONGODB_SERVER` — укажите публичный адрес ВМ, полученный [ранее](#create-vm).

      * `--secret environment-variable` — секреты `ME_CONFIG_MONGODB_AUTH_USERNAME` и `ME_CONFIG_MONGODB_AUTH_PASSWORD`, созданные [ранее](#secret-create).
      * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md) `mongo-express`, созданного [ранее](#sa-create).
      * `--network-id` — идентификатор сети `mongo-express-network`.

      Результат:

      ```text
      id: bbas0ktemln9********
      container_id: bbai45hrl5et********
      created_at: "2025-06-14T10:18:06.791Z"
      image:
        image_url: cr.yandex/crpbr3qaut47********/mongo-express:mongo-tag
        image_digest: sha256:c641....
        environment:
          ME_CONFIG_BASICAUTH: "false"
          ME_CONFIG_MONGODB_SERVER: 89.169.***.***
          VCAP_APP_PORT: "8080"
      resources:
        memory: "1073741824"
        cores: "1"
        core_fraction: "100"
      execution_timeout: 15s
      concurrency: "1"
      service_account_id: ajeldi88vl73********
      status: ACTIVE
      secrets:
        - id: e6qfi832v2j8********
          version_id: e6qj9a9oifme********
          key: login
          environment_variable: ME_CONFIG_MONGODB_AUTH_USERNAME
        - id: e6qfi832v2j8********
          version_id: e6qj9a9oifme********
          key: password
          environment_variable: ME_CONFIG_MONGODB_AUTH_PASSWORD
      log_options:
        folder_id: b1g681qpemb4********
      runtime:
        http: {}
      ```

- API {#api}

  1. Чтобы создать контейнер, воспользуйтесь методом REST API [create](../containers/api-ref/Container/create.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Create](../containers/api-ref/grpc/Container/create.md).
  1. Чтобы создать ревизию контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}


## Создайте API-шлюз API Gateway {#create-api-gw}

Создайте [API-шлюз](../../api-gateway/concepts/index.md) с расширением `x-yc-apigateway-integration:serverless_containers`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **API Gateway**.
  1. Нажмите **Создать API-шлюз**.
  1. В поле **Имя** введите название API-шлюза — `mongo-express-gw`.
  1. В блок **Спецификация** добавьте спецификацию:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      paths:
        /{proxy+}:
          x-yc-apigateway-any-method:
            x-yc-apigateway-integration:
              type: serverless_containers
              container_id: <идентификатор_контейнера>
              service_account_id: <идентификатор_сервисного_аккаунта>
            parameters:
            - explode: false
              in: path
              name: proxy
              required: false
              schema:
                default: '-'
                type: string
              style: simple
      ```

      Где:

      * `container_id` — идентификатор контейнера `mongo-express-container`.
      * `service_account_id` — идентификатор сервисного аккаунта `mongo-express`.

  1. Нажмите **Создать**.
  1. Откройте созданный API-шлюз и скопируйте ссылку из поля **Служебный домен**.

- CLI {#cli}

  1. Подготовьте файл спецификации API по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

      {% cut "Спецификация" %}

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      paths:
        /{proxy+}:
          x-yc-apigateway-any-method:
            x-yc-apigateway-integration:
              type: serverless_containers
              container_id: <идентификатор_контейнера>
              service_account_id: <идентификатор_сервисного_аккаунта>
            parameters:
            - explode: false
              in: path
              name: proxy
              required: false
              schema:
                default: '-'
                type: string
              style: simple
      ```

      Где:

      * `container_id` — идентификатор контейнера `mongo-express-container`.
      * `service_account_id` — идентификатор сервисного аккаунта `mongo-express`.

      {% endcut %}

  1. Укажите параметры и создайте API-шлюз с помощью команды:

      ```bash
      yc serverless api-gateway create \
          --name mongo-express-gw \
          --spec=<путь_к_файлу_спецификации>
      ```

      Результат:

      ```text
      id: d5d63uh1h26g********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:23:19.682Z"
      name: mongo-express-gw
      status: ACTIVE
      domain: d5d63uh1h26g********.********.apigw.yandexcloud.net
      connectivity: {}
      log_options:
        folder_id: b1g681qpemb4********
      execution_timeout: 300s
      ```

      Сохраните ссылку, указанную в поле `domain`.

- API {#api}

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md).

{% endlist %}


## Проверьте работу приложения {#check-app}

Перейдите по ссылке вида `d5d63uh1h26g********.********.apigw.yandexcloud.net`, полученной на предыдущем шаге. Откроется административная панель MongoDB.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз `mongo-express-gw`.
1. [Удалите](../operations/delete.md) контейнер `mongo-express-container`.
1. [Удалите](../../container-registry/operations/docker-image/docker-image-delete.md) образ из реестра `app-registry`.
1. [Удалите](../../container-registry/operations/registry/registry-delete.md) реестр `app-registry`.
1. [Удалите](../../lockbox/operations/secret-delete.md) секрет `mongodb-creds`.
1. [Удалите](../../storedoc/operations/cluster-delete.md) ВМ `mongo-vm`.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт `mongo-express`.