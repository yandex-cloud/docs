# Масштабирование группы виртуальных машин по расписанию с помощью консоли управления, CLI и API

Чтобы настроить [масштабирование группы виртуальных машин по расписанию](index.md), выполните следующие шаги:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте группу ВМ](#create-ig).
1. [Создайте ресурсы Cloud Functions](#create-sf-resources).
1. [Проверьте масштабирование группы ВМ](#test-scale).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

В качестве примера будет использоваться [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) с именем `example-folder`.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за [диски](../../concepts/disk.md) и постоянно запущенные [ВМ](../../concepts/vm.md) ([тарифы Compute Cloud](../../pricing.md));
* плата за вызовы [функции](../../../functions/concepts/function.md), вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы Cloud Functions](../../../functions/pricing.md)).

## Создайте вспомогательные ресурсы {#create-aux-resources}

### Создайте сервисный аккаунт {#create-sa}

[Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) будет привязан к группе ВМ Compute Cloud и функции Cloud Functions.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md): `vm-scale-scheduled-sa`.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роли](../../../iam/concepts/access-control/roles.md):
     * `compute.editor` — для управления группой ВМ.
     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу.
     * `functions.functionInvoker` — для запуска функции Cloud Functions.
  1. Нажмите **Создать**.

- CLI {#cli}

  1. Создайте сервисный аккаунт:

     ```bash
     yc iam service-account create --name vm-scale-scheduled-sa \
       --folder-name example-folder
     ```

     Результат:

     ```yaml
     id: ajeab0cnib1p********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:44:35.989446Z"
     name: vm-scale-scheduled-sa
     ```

     Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).
  1. Назначьте сервисному аккаунту [роли](../../../iam/concepts/access-control/roles.md):
     * `compute.editor` — для управления группой ВМ:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role compute.editor \
         --folder-name example-folder
       ```

     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role iam.serviceAccounts.user \
         --folder-name example-folder
       ```

     * `functions.functionInvoker` — для запуска функции Cloud Functions:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role functions.functionInvoker \
         --folder-name example-folder
       ```

     Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  1. Создайте сервисный аккаунт `vm-scale-scheduled-sa`. Для этого воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге [роли](../../../iam/concepts/access-control/roles.md):
     * `compute.admin` — для управления группой ВМ.
     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу.
     * `functions.functionInvoker` — для запуска функции Cloud Functions.

     Для этого воспользуйтесь методом REST API [setAccessBindings](../../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

### Создайте облачную сеть {#create-network}

Группа ВМ будет размещена в [облачной сети](../../../vpc/concepts/network.md#network) [Yandex Virtual Private Cloud](../../../vpc/index.md) и ее [подсетях](../../../vpc/concepts/network.md#subnet).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Справа сверху нажмите **Создать сеть**.
  1. В поле **Имя** укажите `vm-scale-scheduled-network`.
  1. Выберите опцию **Создать подсети**.
  1. Нажмите **Создать сеть**.

- CLI {#cli}

  1. Создайте сеть `vm-scale-scheduled-network`:

     ```bash
     yc vpc network create --name vm-scale-scheduled-network \
       --folder-name example-folder
     ```

     Результат:

     ```yaml
     id: enpabce123hd********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:55:50.004472Z"
     name: vm-scale-scheduled-network
     ```

     Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/network/create.md).
  1. Создайте подсеть `vm-scale-scheduled-subnet-a` в [зоне доступности](../../../overview/concepts/geo-scope.md) `ru-central1-a`:

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-a \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.1.0/24 \
       --zone ru-central1-a
     ```

     Результат:

     ```yaml
     id: e1lnabc23r1c********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:56:51.859345Z"
     name: vm-scale-scheduled-subnet-a
     network_id: enpabce123hd********
     zone_id: ru-central1-a
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```

     Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/create.md).
  1. Создайте подсеть `vm-scale-scheduled-network-b` в зоне доступности `ru-central1-b`:

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-b \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.2.0/24 \
       --zone ru-central1-b
     ```

     Результат:

     ```yaml
     id: b1csa2b3clid********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:57:48.934429Z"
     name: vm-scale-scheduled-subnet-b
     network_id: enpabce123hd********
     zone_id: ru-central1-b
     v4_cidr_blocks:
     - 192.168.2.0/24
     ```

- API {#api}

  1. Создайте сеть `vm-scale-scheduled-network` с помощью метода REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызова gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).
  1. Создайте подсети `vm-scale-scheduled-subnet-a` в зоне доступности `ru-central1-a` и `vm-scale-scheduled-subnet-b` в зоне `ru-central1-b` с помощью метода REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызова gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}

## Создайте группу виртуальных машин {#create-ig}

Группа ВМ будет создана с ручным масштабированием, чтобы ее размером могла управлять функция Cloud Functions.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Справа сверху нажмите **Создать группу виртуальных машин**.
  1. В блоке **Базовые параметры**:
     * В поле **Имя** укажите `vm-scale-scheduled-ig`.
     * Выберите **Сервисный аккаунт** `vm-scale-scheduled-sa`.
  1. В блоке **Распределение** в поле **Зона доступности** выберите `ru-central1-a` и `ru-central1-b`.
  1. В блоке **Шаблон виртуальной машины** нажмите **Задать** и в открывшемся окне:
     * В блоке **Образ загрузочного диска** на вкладке **Образ загрузочного диска** выберите [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts).
     * В блоке **Вычислительные ресурсы** укажите следующие настройки:
       * **Платформа** — `Intel Ice Lake`.
       * **vCPU** — `2`.
       * **Гарантированная доля vCPU** — `20%`.
       * **RAM** — `2 ГБ`.
     * В блоке **Сетевые настройки**:
       * В поле **Сеть** выберите `vm-scale-scheduled-network`.
       * В поле **Публичный адрес** выберите `Без адреса`.
     * В блоке **Доступ**:
       * В поле **Сервисный аккаунт** выберите `vm-scale-scheduled-sa`.
       * В поле **Логин** укажите имя пользователя, который будет создан на ВМ. Придумайте имя самостоятельно.
       * В поле **SSH-ключ** вставьте содержимое файла открытого ключа [SSH](../../../glossary/ssh-keygen.md). Создать пару ключей можно по [инструкции](../../operations/vm-connect/ssh.md#creating-ssh-keys).
     * Нажмите **Сохранить**.
  1. В блоке **В процессе создания и обновления разрешено** укажите следующие настройки:
     * **Добавлять выше целевого значения** — `2`. 
     * **Уменьшать относительно целевого значения** — `2`.
     * **Одновременно создавать** — `2`.
     * **Одновременно останавливать** — `2`.
  1. В блоке **Масштабирование**:
     * В поле **Тип** выберите `Фиксированный`.
     * Укажите **Размер** `2`.
  1. Нажмите **Создать**.

- CLI {#cli}

  1. Получите идентификаторы ресурсов, созданных ранее:
     * Идентификатор сервисного аккаунта `vm-scale-scheduled-sa`:

       ```bash
       yc iam service-account get vm-scale-scheduled-sa \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: ajeab0cnib1p********
       ```

       Подробнее о команде `yc iam service-account get` см. в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/get.md).
     * Идентификатор сети `vm-scale-scheduled-network`:

       ```bash
       yc vpc network get vm-scale-scheduled-network \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: enpabce123hd********
       ```

       Подробнее о команде `yc vpc network get` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/network/get.md).
     * Идентификатор подсети `vm-scale-scheduled-subnet-a`:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-a \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: e1lnabc23r1c********
       ```

       Подробнее о команде `yc vpc subnet get` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/get.md).
     * Идентификатор подсети `vm-scale-scheduled-subnet-b`:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-b \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: b1csa2b3clid********
       ```

       Подробнее о команде `yc vpc subnet get` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/get.md).
  1. Получите идентификатор последней версии публичного образа [Ubuntu 20.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts):

     ```bash
     yc compute image get-latest-from-family ubuntu-2004-lts \
       --folder-id standard-images | grep "^id"
     ```

     Результат:

     ```yaml
     id: fd83n3uou8m0********
     ```

     Подробнее о команде `yc compute image get-latest-from-family` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/get-latest-from-family.md).
  1. Вставьте полученные идентификаторы в файл `specification.yaml` со спецификацией группы ВМ:

     ```yaml
     name: vm-scale-scheduled-ig
     service_account_id: <идентификатор_сервисного_аккаунта>
     allocation_policy:
        zones:
          - zone_id: ru-central1-a
          - zone_id: ru-central1-b
     instance_template:
       platform_id: standard-v3
       resources_spec:
         memory: 2G
         cores: 2
         core_fraction: 20
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           type_id: network-hdd
           size: 15G
           image_id: <идентификатор_последней_версии_Ubuntu_20.04_LTS>
       network_interface_specs:
        - network_id: <идентификатор_сети>
          subnet_ids:
            - <идентификатор_подсети_в_зоне_ru-central1-a>
            - <идентификатор_подсети_в_зоне_ru-central1-b>
          primary_v4_address_spec: {}
     scale_policy:
       fixed_scale:
         size: 2
     deploy_policy:
       max_unavailable: 2
       max_creating: 2
       max_expansion: 2
       max_deleting: 2
     ```

  1. Создайте группу ВМ с именем `vm-scale-scheduled-ig` по спецификации `specification.yaml`:

     ```bash
     yc compute instance-group create --file specification.yaml \
       --folder-name example-folder
     ```

     Результат:

     ```text
     done (2m18s)
     id: cl0kabcquk1g********
     folder_id: b0g12ga82bcv********
     ...
     service_account_id: ajeab0cnib1p********
     status: ACTIVE
     ```

- API {#api}

  1. Получите идентификаторы ресурсов, созданных ранее:
     * Идентификатор сервисного аккаунта `vm-scale-scheduled-sa` — с помощью метода REST API [get](../../../iam/api-ref/ServiceAccount/get.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызова gRPC API [ServiceAccountService/Get](../../../iam/api-ref/grpc/ServiceAccount/get.md).
     * Идентификатор сети `vm-scale-scheduled-network` — с помощью метода REST API [get](../../../vpc/api-ref/Network/get.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызова gRPC API [NetworkService/Get](../../../vpc/api-ref/grpc/Network/get.md).
     * Идентификаторы подсетей `vm-scale-scheduled-subnet-a` и `vm-scale-scheduled-subnet-b` — с помощью метода REST API [get](../../../vpc/api-ref/Subnet/get.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызова gRPC API [SubnetService/Get](../../../vpc/api-ref/grpc/Subnet/get.md).
  1. Получите идентификатор последней версии публичного образа [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts) в семействе `standard-images` с помощью метода REST API [getLatestByFamily](../../api-ref/Image/getLatestByFamily.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/GetLatestByFamily](../../api-ref/grpc/Image/getLatestByFamily.md).
  1. Вставьте полученные идентификаторы в файл `specification.yaml` со спецификацией группы ВМ:

     ```yaml
     name: vm-scale-scheduled-ig
     service_account_id: <идентификатор_сервисного_аккаунта>
     allocation_policy:
        zones:
          - zone_id: ru-central1-a
          - zone_id: ru-central1-b
     instance_template:
       platform_id: standard-v3
       resources_spec:
         memory: 2G
         cores: 2
         core_fraction: 20
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           type_id: network-hdd
           size: 15G
           image_id: <идентификатор_последней_версии_Ubuntu_20.04_LTS>
       network_interface_specs:
        - network_id: <идентификатор_сети>
          subnet_ids:
            - <идентификатор_подсети_в_зоне_ru-central1-a>
            - <идентификатор_подсети_в_зоне_ru-central1-b>
          primary_v4_address_spec: {}
     scale_policy:
       fixed_scale:
         size: 2
     deploy_policy:
       max_unavailable: 2
       max_creating: 2
       max_expansion: 2
       max_deleting: 2
     ```

  1. Создайте группу ВМ с именем `vm-scale-scheduled-ig` по спецификации `specification.yaml` с помощью метода REST API [createFromYaml](../../instancegroup/api-ref/InstanceGroup/createFromYaml.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/CreateFromYaml](../../instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md).

{% endlist %}

## Создайте ресурсы Cloud Functions {#create-sf-resources}

### Создайте функцию {#create-function}

Функция будет содержать код с командами Yandex Cloud CLI, которые изменяют группу ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Cloud Functions**.
  1. Справа сверху нажмите **Создать функцию**.
  1. В поле **Имя** укажите `vm-scale-scheduled-function`.
  1. Нажмите **Создать**.
  1. Выберите среду выполнения **Bash**.
  1. Включите опцию **Добавить файлы с примерами кода**.
  1. Нажмите **Продолжить**.
  1. В блоке **Редактор** выберите файл `handler.sh`.
  1. Вставьте вместо содержимого файла следующий код:

     ```bash
     # Get ID and current size of the instance group
     IG_SPEC=$(yc compute instance-group get --name $IG_NAME --folder-id $FOLDER_ID --format json)
     IG_ID=$(jq -r ".id" <<< $IG_SPEC)
     IG_SIZE=$(jq -r ".scale_policy.fixed_scale.size" <<< $IG_SPEC)
     
     # Calculate new size for the instance group
     if [ $IG_SIZE = $IG_BASE_SIZE ]; then
         IG_SIZE="$(($IG_BASE_SIZE + 1))"
     else
         IG_SIZE=$IG_BASE_SIZE
     fi
     
     # Update the instance group
     yc compute instance-group update --id $IG_ID --scale-policy-fixed-scale-size $IG_SIZE
     ```

  1. В блоке **Параметры**:
     * В поле **Таймаут** укажите значение `60`.
     * В поле **Сервисный аккаунт** выберите `vm-scale-scheduled-sa`.
     * В блоке **Переменные окружения** добавьте следующие переменные:
       * `IG_NAME` = `vm-scale-scheduled-ig`.
       * `IG_BASE_SIZE` = `2`.
       * `FOLDER_ID` = идентификатор каталога. Получить идентификатор можно по [инструкции](../../../resource-manager/operations/folder/get-id.md).
  1. В правом верхнем углу нажмите **Сохранить изменения**.

- CLI {#cli}

  1. Создайте файл `handler.sh` со следующим кодом:

     ```bash
     # Get ID and current size of the instance group
     IG_SPEC=$(yc compute instance-group get --name $IG_NAME --folder-id $FOLDER_ID --format json)
     IG_ID=$(jq -r ".id" <<< $IG_SPEC)
     IG_SIZE=$(jq -r ".scale_policy.fixed_scale.size" <<< $IG_SPEC)
     
     # Calculate new size for the instance group
     if [ $IG_SIZE = $IG_BASE_SIZE ]; then
         IG_SIZE="$(($IG_BASE_SIZE + 1))"
     else
         IG_SIZE=$IG_BASE_SIZE
     fi
     
     # Update the instance group
     yc compute instance-group update --id $IG_ID --scale-policy-fixed-scale-size $IG_SIZE
     ```

  1. Создайте функцию:
 
     ```bash
     yc serverless function create vm-scale-scheduled-function \
       --folder-name example-folder
     ```

     Результат:

     ```text
     done (1s)
     id: d4e7d67ikvmq********
     folder_id: b1g9hv2loamq********
     ...
     log_group_id: ckgij6l0845h********
     http_invoke_url: https://functions.yandexcloud.net/d4e7d67ikvmq********
     status: ACTIVE
     ```

  1. Создайте версию функции:

     ```bash
     yc serverless function version create --folder-name example-folder \
       --function-name vm-scale-scheduled-function --runtime bash \
       --source-path ./handler.sh --entrypoint "handler.sh" \
       --execution-timeout 60s \
       --service-account-id <идентификатор_сервисного_аккаунта> \
       --environment \
         IG_NAME=vm-scale-scheduled-ig,IG_BASE_SIZE=2,FOLDER_ID=<идентификатор_каталога>
     ```

     Где:
     * Опция `--service-account-id` — идентификатор сервисного аккаунта `vm-scale-schedule-sa`. Получить идентификатор можно по инструкции в шаге [Создайте группу ВМ](#create-ig), на вкладке **CLI**.
     * Переменная `FOLDER_ID` в опции `--environment` — идентификатор каталога. Получить идентификатор можно по [инструкции](../../../resource-manager/operations/folder/get-id.md).

     Результат:

     ```text
     done (1s)
     id: d4efmv9n3qf1********
     function_id: d4e7d67ikvmq********
     ...
       FOLDER_ID: b1g9hv2loamq********
       IG_BASE_SIZE: "2"
       IG_NAME: vm-scale-scheduled-ig
     ```

- API {#api}

  1. Создайте функцию `vm-scale-scheduled-function` с помощью метода REST API [create](../../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../../functions/functions/api-ref/Function/index.md) или вызова gRPC API [FunctionService/Create](../../../functions/functions/api-ref/grpc/Function/create.md). Из ответных данных получите идентификатор созданной функции.
  1. Создайте версию функции с помощью метода REST API [createVersion](../../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../../functions/functions/api-ref/Function/index.md) или вызова gRPC API [FunctionService/CreateVersion](../../../functions/functions/api-ref/grpc/Function/createVersion.md). Версия функции должна иметь следующий код:

     ```bash
     # Get ID and current size of the instance group
     IG_SPEC=$(yc compute instance-group get --name $IG_NAME --folder-id $FOLDER_ID --format json)
     IG_ID=$(jq -r ".id" <<< $IG_SPEC)
     IG_SIZE=$(jq -r ".scale_policy.fixed_scale.size" <<< $IG_SPEC)
     
     # Calculate new size for the instance group
     if [ $IG_SIZE = $IG_BASE_SIZE ]; then
         IG_SIZE="$(($IG_BASE_SIZE + 1))"
     else
         IG_SIZE=$IG_BASE_SIZE
     fi
     
     # Update the instance group
     yc compute instance-group update --id $IG_ID --scale-policy-fixed-scale-size $IG_SIZE
     ```

{% endlist %}

### Создайте триггер {#create-trigger}

[Триггер](../../../functions/concepts/trigger/index.md) определяет условия запуска функции. Для запуска по расписанию используется [триггер-таймер](../../../functions/concepts/trigger/timer.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Справа сверху нажмите **Создать триггер**.
  1. В блоке **Базовые параметры**:
     * В поле **Имя** укажите `vm-scale-scheduled-trigger`.
     * В поле **Тип** выберите `Таймер`.
     * В поле **Запускаемый ресурс** выберите `Функция`.
  1. В блоке **Настройки таймера** в поле **Cron-выражение** укажите `*/2 * * * ? *` — триггер будет срабатывать каждые две минуты, например, в 09:58, 10:00, 10:02, 10:04 и т. д.
  1. В блоке **Настройки функции**:
     * В поле **Функция** укажите `vm-scale-scheduled-function`.
     * В поле **Тег версии функции** выберите `$latest`.
     * Выберите **Сервисный аккаунт** `vm-scale-scheduled-sa`.
  1. В блоке **Настройки Dead Letter Queue** очистите поле **Сервисный аккаунт** (`Не выбрано`).
  1. Нажмите **Создать триггер**.

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc serverless trigger create timer --folder-name example-folder \
    --name vm-scale-scheduled-trigger \
    --cron-expression "*/2 * * * ? *" \
    --invoke-function-name vm-scale-scheduled-function \
    --invoke-function-tag '$latest' \
    --invoke-function-service-account-name vm-scale-scheduled-sa
  ```

  Результат:

  ```yaml
  id: a1s22pb0v5i4********
  folder_id: b1g9hv2loamq********
  created_at: "2022-04-06T14:56:54.253709098Z"
  ...
        function_tag: $latest
        service_account_id: aje9s4pud13h********
  status: ACTIVE
  ```

- API {#api}

  Используйте метод REST API [create](../../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../../functions/triggers/api-ref/Trigger/index.md) или вызов gRPC API [TriggerService/Create](../../../functions/triggers/api-ref/grpc/Trigger/create.md), чтобы создать триггер типа `timer` с cron-выражением `*/2 * * * ? *`, связанный с функцией `vm-scale-scheduled-function` версии `$latest` и сервисным аккаунтом `vm-scale-scheduled-sa`.

{% endlist %}

## Проверьте масштабирование группы ВМ {#test-scale}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите группу `vm-scale-scheduled-ig`.
  1. Убедитесь, что в блоке **Виртуальные машины** каждые две минуты изменяется количество ВМ: увеличивается с 2 до 3, затем уменьшается с 3 до 2 и т. д. Также вы можете проверить обновление группы на вкладке ![image](../../../_assets/console-icons/list-check.svg) **Операции**.

- CLI {#cli}

  Несколько раз выполните следующую команду:

  ```bash
  yc compute instance-group get vm-scale-scheduled-ig \
    --folder-name example-folder
  ```

  Результат:

  ```yaml
  id: cl1l0ljqbmkp********
  folder_id: b1g9hv2loamq********
  created_at: "2022-03-28T13:24:20.693Z"
  ...
  managed_instances_state:
    target_size: "2"
    running_actual_count: "2"
  ...
  ```

  Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

- API {#api}

  Несколько раз получите информацию о группе ВМ `vm-scale-scheduled-ig` с помощью метода REST API [get](../../instancegroup/api-ref/InstanceGroup/get.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Get](../../instancegroup/api-ref/grpc/InstanceGroup/get.md). Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../functions/operations/trigger/trigger-delete.md) триггер.
1. [Удалите](../../../functions/operations/function/function-delete.md) функцию.
1. [Удалите](../../operations/instance-groups/delete.md) группу ВМ.

#### Полезные ссылки {#see-also}

* [Масштабирование группы виртуальных машин по расписанию с помощью Terraform](terraform.md).