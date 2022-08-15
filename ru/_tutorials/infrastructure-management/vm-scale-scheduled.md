# Масштабирование группы виртуальных машин по расписанию

Создайте [группу виртуальных машин](../../compute/concepts/instance-groups/index.md) {{ compute-full-name }} и настройте для нее масштабирование по расписанию. Размером группы ВМ будет управлять [функция](../../functions/concepts/function.md) {{ sf-full-name }}, запускаемая по [таймеру](../../functions/concepts/trigger/timer.md).

Чтобы настроить масштабирование группы ВМ с помощью штатных инструментов — через консоль управления, с помощью [интерфейса командной строки](../../cli/index.yaml) (CLI) или [API](../../api-design-guide/index.yaml):

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте вспомогательные ресурсы](#create-aux-resources).
1. [Создайте группу виртуальных машин](#create-ig).
1. [Создайте ресурсы {{ sf-name }}](#create-sf-resources).
1. [Проверьте масштабирование группы ВМ](#test-scale).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для масштабирования группы ВМ можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

В качестве примера будет использоваться каталог с именем `example-folder`.

### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры входят:

* использование виртуальных машин (см. [тарифы {{ compute-name }}](../../compute/pricing.md));
* вызовы функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).

## Создайте вспомогательные ресурсы {#create-aux-resources}

### Создайте сервисный аккаунт {#create-sa}

[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) будет привязан к группе ВМ {{ compute-name }} и функции {{ sf-name }}.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Выберите вкладку **Сервисные аккаунты**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите **Имя** `vm-scale-scheduled-sa`.
  1. В поле **Роли в каталоге** добавьте следующие [роли](../../iam/concepts/access-control/roles.md):
 
     * `compute.admin` — для управления группой ВМ.
     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу.
     * `serverless.functions.invoker` — для запуска функции {{ sf-name }}.
   
  1. Нажмите кнопку **Создать**.

- CLI

  1. Создайте сервисный аккаунт:

     ```bash
     yc iam service-account create --name vm-scale-scheduled-sa \
       --folder-name example-folder
     ```

     Результат:

     ```yaml
     id: ajeab0cnib1pdefe21dm
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2022-03-15T09:44:35.989446Z"
     name: vm-scale-scheduled-sa
     ```
     
     Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/service-account/create.md).

  1. Назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):

     * `compute.admin` — для управления группой ВМ: 

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role compute.admin
       ```

     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role iam.serviceAccounts.user
       ```
       
     * `serverless.functions.invoker` — для запуска функции {{ sf-name }}:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role serverless.functions.invoker
       ```

     Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API

  Воспользуйтесь методами:

  1. [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount`, чтобы создать сервисный аккаунт `vm-scale-scheduled-sa`;
  1. [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса `Folder`, чтобы назначить сервисному аккаунту в текущем каталоге роли:

     * `compute.admin` — для управления группой ВМ.
     * `iam.serviceAccounts.user` — для привязки сервисного аккаунта к ВМ, входящим в группу.
     * `serverless.functions.invoker` — для запуска функции {{ sf-name }}.

{% endlist %}

### Создайте облачную сеть {#create-network}

Группа ВМ будет размещена в [облачной сети](../../vpc/concepts/network.md) {{ vpc-full-name }} и ее подсетях.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. Нажмите кнопку **Создать сеть**.
  1. Введите **Имя** `vm-scale-scheduled-network`.
  1. Выберите дополнительную опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.

- CLI

  1. Создайте сеть `vm-scale-scheduled-network`:
 
     ```bash
     yc vpc network create --name vm-scale-scheduled-network \
       --folder-name example-folder
     ```
 
     Результат:
 
     ```yaml
     id: enpabce123hde4ft1r3t
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2022-03-15T09:55:50.004472Z"
     name: vm-scale-scheduled-network
     ```

     Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).
 
  1. Создайте подсеть `vm-scale-scheduled-subnet-a` в зоне `ru-central1-a`:
 
     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-a \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.1.0/24 \
       --zone ru-central1-a
     ```
 
     Результат:
 
     ```yaml
     id: e1lnabc23r1c9d0efoje
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2022-03-15T09:56:51.859345Z"
     name: vm-scale-scheduled-subnet-a
     network_id: enpabce123hde4ft1r3t
     zone_id: ru-central1-a
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```

     Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).
  
  1. Создайте подсеть `vm-scale-scheduled-network-b` в зоне `ru-central1-b`:
 
     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-b \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.2.0/24 \
       --zone ru-central1-b
     ```
 
     Результат:
 
     ```yaml
     id: b1csa2b3clideftjb121
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2022-03-15T09:57:48.934429Z"
     name: vm-scale-scheduled-subnet-b
     network_id: enpabce123hde4ft1r3t
     zone_id: ru-central1-b
     v4_cidr_blocks:
     - 192.168.2.0/24
     ```

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API

  1. Создайте сеть `vm-scale-scheduled-network` с помощью метода [create](../../vpc/api-ref/Network/create.md) для ресурса `Network`.
 
  1. Создайте подсети `vm-scale-scheduled-subnet-a` в зоне `ru-central1-a` и `vm-scale-scheduled-subnet-b` в зоне `ru-central1-b` с помощью метода [create](../../vpc/api-ref/Subnet/create.md) для ресурса `Subnet`.

{% endlist %}

## Создайте группу виртуальных машин {#create-ig}

Группа ВМ будет создана с ручным [масштабированием](../../compute/concepts/instance-groups/scale.md), чтобы ее размером могла управлять функция {{ sf-name }}.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Нажмите кнопку **Создать группу**.
  1. В блоке **Базовые параметры**:
     
     * Введите **Имя** группы `vm-scale-scheduled-ig`.
     * Выберите **Сервисный аккаунт** `vm-scale-scheduled-sa`.
   
  1. В блоке **Распределение** выберите **Зоны доступности** `ru-central1-a` и `ru-central1-b`.
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать**:
     
     * В блоке **Выбор образа/загрузочного диска** на вкладке **Операционные системы** выберите **Ubuntu 20.04**.
     * В блоке **Вычислительные ресурсы** укажите следующие настройки:
       
       * **Платформа** — Intel Ice Lake.
       * **vCPU** — 2.
       * **Гарантированная доля vCPU** — 20%.
       * **RAM** — 2 ГБ.
      
     * В блоке **Сетевые настройки** 
       
       * Выберите **Сеть** `vm-scale-scheduled-network`.
       * В поле **Публичный адрес** выберите `Без адреса`.
      
     * В блоке **Доступ**:
       
       * Выберите **Сервисный аккаунт** `vm-scale-scheduled-sa`.
       * В поле **Логин** укажите имя пользователя, который будет создан на ВМ. Придумайте имя самостоятельно.
       * В поле **SSH-ключ** вставьте содержимое файла открытого ключа SSH. Создать пару ключей можно по [инструкции](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
      
     * Нажмите кнопку **Сохранить**.
   
  1. В блоке **В процессе создания и обновления разрешено** укажите следующие настройки:
 
     * **Добавлять выше целевого значения** — `2`. 
     * **Уменьшать относительно целевого значения** — `2`.
     * **Одновременно создавать** — `2`.
     * **Одновременно останавливать** — `2`.
 
  1. В блоке **Масштабирование**:
 
     * Выберите **Тип** `Фиксированный`.
     * Введите **Размер** `2`.
 
  1. Нажмите кнопку **Создать**.

- CLI
 
  1. Получите идентификаторы ресурсов, созданных ранее:
     
     * Идентификатор сервисного аккаунта `vm-scale-scheduled-sa`:
 
       ```bash 
       yc iam service-account get vm-scale-scheduled-sa \
         --folder-name example-folder | grep "^id"
       ```
     
       Результат:
   
       ```yaml
       id: ajeab0cnib1pdefe21dm
       ```

       Подробнее о команде `yc iam service-account get` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/service-account/get.md).
       
     * Идентификатор сети `vm-scale-scheduled-network`:

       ```bash 
       yc vpc network get vm-scale-scheduled-network \
         --folder-name example-folder | grep "^id"
       ```
       
       Результат:
       
       ```yaml
       id: enpabce123hde4ft1r3t
       ```

       Подробнее о команде `yc vpc network get` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/get.md).

     * Идентификатор подсети `vm-scale-scheduled-subnet-a`:

       ```bash 
       yc vpc subnet get vm-scale-scheduled-subnet-a \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: e1lnabc23r1c9d0efoje
       ```

       Подробнее о команде `yc vpc subnet get` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/get.md).

     * Идентификатор подсети `vm-scale-scheduled-subnet-b`:

       ```bash 
       yc vpc subnet get vm-scale-scheduled-subnet-b \
         --folder-name example-folder | grep "^id"
       ```

       Результат:

       ```yaml
       id: b1csa2b3clideftjb121
       ```

       Подробнее о команде `yc vpc subnet get` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/get.md).

  1. Получите идентификатор последней версии публичного образа Ubuntu 20.04 LTS:

     ```bash
     yc compute image get-latest-from-family ubuntu-2004-lts \
       --folder-id standard-images | grep "^id"
     ```

     Результат:

     ```yaml
     id: fd83n3uou8m03iq9gavu
     ```
     
     Подробнее о команде `yc compute image get-latest-from-family` см. в [справочнике CLI](../../cli/cli-ref/managed-services/compute/image/get-latest-from-family.md).
     
 
  1. Вставьте полученные идентификаторы в файл `specification.yaml` со спецификацией группы виртуальных машин:
 
     {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}
 
  1. Создайте группу ВМ с именем `vm-scale-scheduled-ig` по спецификации `specification.yaml`:
 
      ```bash
      yc compute instance-group create --file specification.yaml \
        --folder-name example-folder
      ```
 
     Результат:
 
      ```bash
      done (2m18s)
      id: cl0kabcquk1gomdefbkk
      folder_id: b0g12ga82bcv0cdeferg
      ...
      service_account_id: ajeab0cnib1pdefe21dm
      status: ACTIVE
      ```

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API

  1. Получите идентификаторы ресурсов, созданных ранее:
     
     * Идентификатор сервисного аккаунта `vm-scale-scheduled-sa` — с помощью вызова gRPC API [ServiceAccountService/Get](../../iam/api-ref/grpc/service_account_service.md#Get) или метода REST API [get](../../iam/api-ref/ServiceAccount/get.md).
     * Идентификатор сети `vm-scale-scheduled-network` — с помощью вызова gRPC API [NetworkService/Get](../../vpc/api-ref/grpc/network_service.md#Get) или метода REST API [get](../../vpc/api-ref/Network/get.md).
     * Идентификаторы подсетей `vm-scale-scheduled-subnet-a` и `vm-scale-scheduled-subnet-b` — с помощью вызовов gRPC API [SubnetService/Get](../../vpc/api-ref/grpc/subnet_service.md#Get) или метода REST API [get](../../vpc/api-ref/Subnet/get.md).
   
  1. Получите идентификатор последней версии публичного образа `ubuntu-2004-lts` в семействе `standard-images` с помощью вызова gRPC API [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/image_service.md#GetLatestByFamily) или метода REST API [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md).

  1. Вставьте полученные идентификаторы в файл `specification.yaml` со спецификацией группы виртуальных машин:

     {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}
     
  1. Создайте группу ВМ с именем `vm-scale-scheduled-ig` по спецификации `specification.yaml` с помощью вызова gRPC API [InstanceGroupService/CreateFromYaml](../../compute/api-ref/grpc/instance_group_service.md#CreateFromYaml) или метода REST API [createFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md).

{% endlist %}

## Создайте ресурсы {{ sf-name }} {#create-sf-resources}

### Создайте функцию {#create-function}

Функция будет содержать код с командами [CLI {{ yandex-cloud }}](../../cli/index.yaml), которые изменяют группу ВМ.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Выберите сервис **{{ sf-name }}**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите **Имя** `vm-scale-scheduled-function`.
  1. Нажмите кнопку **Создать**.
  1. Выберите среду выполнения **Bash**.
  1. Включите опцию **Добавить файлы с примерами кода**.
  1. Нажмите кнопку **Продолжить**.
  1. В блоке **Редактор** выберите файл `handler.sh`.
  1. Вставьте вместо содержимого файла следующий код:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}
     
  1. В блоке **Параметры**: 
     
     * В поле **Таймаут, с** укажите значение `60`.
     * В поле **Сервисный аккаунт** выберите `vm-scale-scheduled-sa`.
     * В поле **Переменные окружения** добавьте следующие переменные:

       * `IG_NAME` = `vm-scale-scheduled-ig`.
       * `IG_BASE_SIZE` = `2`.
       * `FOLDER_ID` = идентификатор каталога. Получить идентификатор можно по [инструкции](../../resource-manager/operations/folder/get-id.md).

  1. В правом верхнем углу нажмите кнопку **Создать версию**.

- CLI

  1. Создайте файл `handler.sh` со следующим кодом:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

  1. Создайте функцию:
 
     ```bash
     yc serverless function create vm-scale-scheduled-function \
       --folder-name example-folder
     ```
     
     Результат:
 
     ```
     done (1s)
     id: d4e7d67ikvmqk5uoim47
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2022-04-01T13:48:27.705Z"
     name: vm-scale-scheduled-function
     log_group_id: ckgij6l0845hsdc9khiq
     http_invoke_url: https://functions.yandexcloud.net/d4e7d67ikvmqk5uoim47
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
 
     * Опция `--service-account-id` — идентификатор сервисного аккаунта `vm-scale-schedule-sa`. Получить идентификатор можно по инструкции в шаге [Создайте группу виртуальных машин](#create-ig), на вкладке **CLI**.
     * Переменная `FOLDER_ID` в опции `--environment` — идентификатор каталога. Получить идентификатор можно по [инструкции](../../resource-manager/operations/folder/get-id.md).
 
     Результат:
 
     ```
     done (1s)
     id: d4efmv9n3qf1ptjtlof3
     function_id: d4e7d67ikvmqk5uoim47
     created_at: "2022-04-01T14:04:29.523Z"
     runtime: bash
     entrypoint: handler.sh
     resources:
     memory: "134217728"
     execution_timeout: 60s
     service_account_id: aje9s4pud13hfhk1bfgn
     image_size: "4096"
     status: ACTIVE
     tags:
     - $latest
     log_group_id: ckgij6l0845hsdc9khiq
     environment:
       FOLDER_ID: b1g9hv2loamqfnbul7d9
       IG_BASE_SIZE: "2"
       IG_NAME: vm-scale-scheduled-ig
     ```

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API

  1. Создайте функцию `vm-scale-scheduled-function` с помощью вызова gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/function_service.md#Create) или метода REST API [create](../../functions/functions/api-ref/Function/create.md). Из ответных данных получите идентификатор созданной функции.
  1. Создайте версию функции с помощью вызова gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion) или метода REST API [createVersion](../../functions/functions/api-ref/Function/createVersion.md). Версия функции должна иметь следующий код:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}
 
{% endlist %}

### Создайте триггер {#create-trigger}

[Триггер](../../functions/concepts/trigger/index.md) определяет условия запуска функции. Для запуска по расписанию используется [триггер-таймер](../../functions/concepts/trigger/timer.md).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Выберите сервис **{{ sf-name }}**.
  1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:
     
     * Введите **Имя** `vm-scale-scheduled-trigger`.
     * Выберите **Тип** `Таймер`.
     * В поле **Запускаемый ресурс** выберите `Функция`.
   
  1. В блоке **Настройки таймера** укажите **Cron-выражение** `*/2 * * * ? *` — триггер будет срабатывать каждые две минуты, например в 09:58, 10:00, 10:02, 10:04 и т. д.
  1. В блоке **Настройки функции**:
 
     * Выберите **Функцию** `vm-scale-scheduled-function`.
     * Выберите **Тег версии функции** `$latest`.
     * Выберите **Сервисный аккаунт** `vm-scale-scheduled-sa`.
 
  1. В блоке **Настройки Dead Letter Queue** очистите поле **Сервисный аккаунт** (`Не выбрано`).
  1. Нажмите кнопку **Создать триггер**.

- CLI

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

  ```
  id: a1s22pb0v5i4q432hi0p
  folder_id: b1g9hv2loamqfnbul7d9
  created_at: "2022-04-06T14:56:54.253709098Z"
  name: vm-scale-scheduled-trigger
  rule:
    timer:
      cron_expression: "*/2 * * * ? *"
      invoke_function_with_retry:
        function_id: d4e7d67ikvmqk5uoim47
        function_tag: $latest
        service_account_id: aje9s4pud13hfhk1bfgn
  status: ACTIVE
  ```

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

- API

  Используйте вызов gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create) или метод REST API [create](../../functions/triggers/api-ref/Trigger/create.md), чтобы создать триггер типа `timer` с cron-выражением `*/2 * * * ? *`, связанный с функцией `vm-scale-scheduled-function` версии `$latest` и сервисным аккаунтом `vm-scale-scheduled-sa`.

{% endlist %}

## Проверьте масштабирование группы ВМ {#test-scale}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Выберите группу `vm-scale-scheduled-ig`.
  1. Убедитесь, что в блоке **Состояния виртуальных машин** каждые две минуты изменяется количество ВМ: увеличивается с 2 до 3, затем уменьшается с 3 до 2 и т. д. Также вы можете проверить обновление группы на вкладке ![image](../../_assets/mdb/operations.svg) **Операции**.
  

- CLI

  Несколько раз выполните следующую команду:

  ```bash
  yc compute instance-group get vm-scale-scheduled-ig \
    --folder-name example-folder
  ```
  
  Результат:

  ```
  id: cl1l0ljqbmkp8k1f902l
  folder_id: b1g9hv2loamqfnbul7d9
  created_at: "2022-03-28T13:24:20.693Z"
  name: vm-scale-scheduled-ig
  ...
  managed_instances_state:
    target_size: "2"
    running_actual_count: "2"
  ...
  ```
  
  Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

- API

  Несколько раз получите информацию о группе ВМ `vm-scale-scheduled-ig` с помощью вызова gRPC API [InstanceGroupService/Get](../../compute/api-ref/grpc/instance_group_service.md#Get) или метода REST API [get](../../compute/api-ref/InstanceGroup/get.md). Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите триггер](../../functions/operations/trigger/trigger-delete.md) `vm-scale-scheduled-trigger`.
1. [Удалите функцию](../../functions/operations/function/function-delete.md) `vm-scale-scheduled-function`.
1. [Удалите группу ВМ](../../compute/operations/instance-groups/delete.md) `vm-scale-scheduled-ig`.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

Чтобы настроить масштабирование группы ВМ с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:
   
   {% list tabs %}
   
   - Готовый архив
 
     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/vm-scale-scheduled-terraform.zip) (2 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `vm-scale-scheduled.tf` и архив с кодом функции {{ sf-name }} `vm-scale-scheduled-function.zip`.

   - Создание вручную

     1. Создайте папку для файлов.
     1. Создайте в папке:

        * Конфигурационный файл `vm-scale-scheduled.tf`:
  
          {% cut "vm-scale-scheduled.tf" %}
     
          {% include [vm-scale-scheduled-tf-config](../../_includes/instance-groups/vm-scale-scheduled-tf-config.md) %}
     
          {% endcut %}
     
        * Файл с кодом функции {{ sf-name }} `handler.sh`:
       
          {% cut "handler.sh" %}
 
          {% note warning %}
 
          Если вы создаете файл в Windows, убедитесь, что переносы строк имеют формат Unix: `\n`, а не `\r\n`. Заменить переносы можно в текстовом редакторе, например [Notepad++](https://notepad-plus-plus.org/), или с помощью утилиты [dos2unix](https://waterlan.home.xs4all.nl/dos2unix.html) или [Tofrodos](https://www.thefreecountry.com/tofrodos/).
 
          {% endnote %}
       
          {% include [vm-scale-scheduled-function-code](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}
       
          {% endcut %}
 
     1. Создайте в папке архив `vm-scale-scheduled-function.zip`, содержащий файл `handler.sh`. После этого удалите файл `handler.sh` вне архива.
 
   {% endlist %}
   
1. В файле `vm-scale-scheduled.tf` вставьте в блок `locals` следующие значения:

   * `token` — [OAuth-токен](../../iam/concepts/authorization/oauth-token.md) (если вы используете [аккаунт на Яндексе](../../iam/concepts/index.md#passport)) или [IAM-токен](../../iam/concepts/authorization/iam-token.md) (если вы используете аккаунт на Яндексе или [федеративный аккаунт](../../iam/concepts/index.md#saml-federation)) для доступа к {{ yandex-cloud }}. Время жизни IAM-токена — максимум 12 часов, но не больше времени жизни cookie у федерации.
   * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), в котором будут создаваться ресурсы.
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут создаваться ресурсы.
   * `username` — имя пользователя, который будет создан на ВМ. Придумайте имя самостоятельно.
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Создать пару ключей можно по [инструкции](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
 
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Проверьте масштабирование группы ВМ](#test-scale).


