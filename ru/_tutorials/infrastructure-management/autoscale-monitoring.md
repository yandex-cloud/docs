# Автоматическое масштабирование группы виртуальных машин для обработки сообщений из очереди {{ message-queue-full-name }}

Сценарий описывает интеграцию между сервисами {{ compute-full-name }}, [{{ message-queue-full-name }}](https://cloud.yandex.ru/services/message-queue) и [{{ monitoring-full-name }}](https://cloud.yandex.ru/services/monitoring). 

В сценарии создается [группа виртуальных машин](../../compute/concepts/instance-groups/index.md). Все ВМ в группе обрабатывают сообщения из одной очереди {{ message-queue-name }} (для примера — получают их и через некоторое время удаляют). Количество сообщений в очереди записывается в метрику {{ monitoring-name }}, и группа ВМ [автоматически масштабируется](../../compute/concepts/instance-groups/scale.md#auto-scale) по этой метрике. 

Для масштабирования выбрана [деликатная стратегия остановки](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy): ВМ останавливаются самостоятельно после обработки всех сообщений и только после этого удаляются из группы при уменьшении ее размера. Это гарантирует, что ВМ не будут  удалены принудительно и обработают последние сообщения, даже если очередь опустеет до конца обработки.

Чтобы выполнить сценарий:

1. [Подготовьте окружение](#prepare).
1. [Создайте очередь в {{ message-queue-name }}](#create-queue).
1. [Создайте образ с приложением](#create-image).
1. [Создайте группу виртуальных машин](#create-ig).
1. [Проверьте масштабирование группы виртуальных машин](#test-autoscale).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

В качестве примера в сценарии будет использоваться каталог с именем `example-folder`.

### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры входят:

* плата за использование виртуальных машин и хранение [образа](../../compute/concepts/image.md) (см. [тарифы {{ compute-name }}](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик с ВМ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md));
* плата за запросы к очереди (см. [тарифы {{ message-queue-name }}](../../message-queue/pricing.md)).

## Подготовьте окружение {#prepare}

### Создайте вспомогательные ресурсы {{ yandex-cloud }} {#create-aux-resources}

{% list tabs %}

- Консоль управления

  1. Создайте сервисный аккаунт `queue-autoscale-sa` и назначьте ему роль `editor` в каталоге `example-folder`:
  
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. Перейдите на вкладку **Сервисные аккаунты** и нажмите кнопку **Создать сервисный аккаунт**.
     1. Укажите **Имя** сервисного аккаунта: `queue-autoscale-sa`.
     1. Нажмите **Добавить роль** и выберите роль `editor`.
     1. Нажмите кнопку **Создать**.
     
  1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для работы сервисного аккаунта с {{ message-queue-name }} и сохраните его в файл `access_key`:
  
     1. В списке сервисных аккаунтов выберите `queue-autoscale-sa`.
     1. Нажмите кнопку **Создать новый ключ**.
     1. Выберите пункт **Создать статический ключ доступа**.
     1. Укажите **Описание** ключа: `Message Queue`.
     1. Нажмите кнопку **Создать**.
     1. Вставьте идентификатор ключа и секретный ключ в файл `access_key` в следующем формате:
     
        ```yaml
        access_key:
          key_id: <идентификатор ключа>
        secret: <секретный ключ>
        ```
        
  1. Создайте облачную сеть `queue-autoscale-network`:
  
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ vpc-name }}**.
     1. Нажмите кнопку **Создать сеть**.
     1. Укажите **Имя** сети: `queue-autoscale-network`.
     1. Отключите опцию **Создать подсети**.
     1. Нажмите кнопку **Создать сеть**.
     
  1. Создайте подсеть `queue-autoscale-subnet-a` в зоне `{{ region-id }}-a`:
  
     1. В списке сетей выберите `queue-autoscale-network`.
     1. Нажмите кнопку **Добавить подсеть**.
     1. Укажите параметры подсети:
     
        * **Имя** — `queue-autoscale-subnet-a`.
        * **Зона** — `{{ region-id }}-a`.
        * **CIDR** — `192.168.1.0/24`.
        
     1. Нажмите кнопку **Создать подсеть**.

- CLI

  1. Создайте сервисный аккаунт `queue-autoscale-sa`:
  
     ```bash
     yc iam service-account create --name queue-autoscale-sa
     ```
     
     Где `--name` — имя сервисного аккаунта: `queue-autoscale-sa`.
     
     Результат:
     
     ```
     id: aje6brh817ro8o6vo6tv
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2021-10-04T16:19:10.153346507Z"
     name: queue-autoscale-sa
     ```
     
  1. Назначьте сервисному аккаунту роль `editor` в каталоге `example-folder`:
  
     ```bash
     yc resource-manager folder add-access-binding example-folder \
       --service-account-name queue-autoscale-sa \
       --role editor
     ```
     
     Где:

     * `--service-account-name` — имя сервисного аккаунта, созданного на шаге 1: `queue-autoscale-sa`.
     * `--role` — назначаемая роль: `editor`.
     
     Результат:
     
     ```
     done (1s)
     ```
     
  1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для работы сервисного аккаунта с {{ message-queue-name }} и сохраните его в файл `access_key`:
    
     ```bash
     yc iam access-key create \
       --service-account-name queue-autoscale-sa \
       --description "{{ message-queue-name }}" \
     | tee access_key
     ```
    
     Где:

     * `--service-account-name` — имя сервисного аккаунта, созданного на шаге 1: `queue-autoscale-sa`.
     * `--description` — описание ключа.
     
     Результат:
     
     ```
     access_key:
       id: ajevb6bx51w3wnep9clq
       service_account_id: aje6brh817ro8o6vo6tv
       created_at: "2021-10-04T16:25:19.143847764Z"
       description: {{ message-queue-name }}
       key_id: g3VybpVKdq_YiFEmDIht
     secret: WVUqnwmC4LSUep0GTKGkbcht9K3Xav7VSOeD_mRG
     ```
     
  1. Создайте облачную сеть `queue-autoscale-network`:
  
     ```bash
     yc vpc network create queue-autoscale-network
     ```

     Результат:

     ```bash
     id: enpabce123hde4ft1r3t
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2021-10-04T16:28:15.905337847Z"
     name: queue-autoscale-network
     ```

  1. Создайте подсеть `queue-autoscale-subnet-a` в зоне `{{ region-id }}-a`:

     ```bash
     yc vpc subnet create queue-autoscale-subnet-a \
       --network-name queue-autoscale-network 
       --range 192.168.1.0/24 
       --zone {{ region-id }}-a
     ```
     
     Где:

     * `--network-name` — имя сети, в которой создается подсеть: `queue-autoscale-network`.
     * `--range` — CIDR подсети.
     * `--zone` — зона доступности, в которой создается подсеть: `{{ region-id }}-a`.

     Результат:

     ```bash
     id: e1lnabc23r1c9d0efoje
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2021-10-04T16:29:12.450858436Z"
     name: queue-autoscale-subnet-a
     network_id: enpabce123hde4ft1r3t
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```
     
- API

  1. Создайте сервисный аккаунт `queue-autoscale-sa` с помощью вызова gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) или метода REST API [create](../../iam/api-ref/ServiceAccount/create.md). В ответных данных будет указан идентификатор сервисного аккаунта.
  1. Назначьте сервисному аккаунту роль `editor` в каталоге `example-folder` с помощью вызова gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/folder_service.md#UpdateAccessBindings) или метода REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md). В теле запроса укажите идентификатор сервисного аккаунта.
  1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для работы сервисного аккаунта с {{ message-queue-name }} и сохраните его в файл `access_key`:
  
     1. Используйте вызов gRPC API [AccessKeyService/Create](../../iam/api-ref/grpc/access_key_service.md#Create) или метод REST API [create](../../iam/api-ref/AccessKey/create.md).
     1. Вставьте идентификатор ключа и секретный ключ в файл `access_key` в следующем формате:
          
        ```yaml
        access_key:
          key_id: <идентификатор ключа>
        secret: <секретный ключ>
        ```
        
  1. Создайте облачную сеть `queue-autoscale-network` с помощью вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create) или метода REST API [create](../../vpc/api-ref/Network/create.md). В ответных данных будет указан идентификатор сети.
  1. Создайте подсеть `queue-autoscale-subnet-a` в зоне `{{ region-id }}-a` с CIDR `192.168.1.0/24` с помощью вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create) или метода REST API [create](../../vpc/api-ref/Subnet/create.md). В теле запроса укажите идентификатор сети.
  
{% endlist %}

### Настройте AWS CLI {#setup-aws-cli}

{% note info %}

С помощью AWS CLI выполняется последний шаг сценария — [проверка масштабирования группы виртуальных машин](#test-autoscale). Поэтому его нужно установить и настроить, даже если вы не будете использовать его для других шагов.

{% endnote %}

1. Скачайте и установите AWS CLI, как описано в его [документации](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).
1. Настройте AWS CLI для работы с {{ yandex-cloud }}:
  
   1. Создайте в домашнем каталоге файл `.aws/credentials` и укажите в нем статический ключ доступа, полученный ранее, и его идентификатор:
           
      ```
      [default]
          aws_access_key_id     = <идентификатор ключа>
          aws_secret_access_key = <секретный ключ>
      ```
        
   1. Создайте в домашнем каталоге файл `.aws/config` и укажите в нем регион по умолчанию `{{ region-id }}`:
           
      ```
      [default]
          region = {{ region-id }}
      ```

## Создайте очередь в {{ message-queue-name }} {#create-queue}

{% list tabs %}

- Консоль управления

  1. Создайте очередь `queue-autoscale-queue`:
  
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ message-queue-name }}**.
     1. Нажмите кнопку **Создать очередь**.
     1. Укажите **Имя** очереди: `queue-autoscale-queue`.
     1. Нажмите кнопку **Создать**.
  
  1. Сохраните URL очереди в файл `queue`:
  
     1. В списке очередей выберите `queue-autoscale-queue`.
     1. Скопируйте **URL** очереди.
     1. Вставьте URL в файл `queue` в следующем формате:
     
        ```yaml
        QueueUrl: <URL очереди>
        ``` 

- AWS CLI
     
  1. Создайте очередь `queue-autoscale-queue` и сохраните ее URL в файл `queue`:
  
     ```bash
     aws sqs create-queue \
       --endpoint https://message-queue.{{ api-host }} \
       --queue-name queue-autoscale-queue \
       --output yaml \
     | tee queue
     ```
     
     Где:

     * `--endpoint` — корневой URL API {{ message-queue-name }}: `https://message-queue.{{ api-host }}`.
     * `--queue-name` — имя очереди: `queue-autoscale-queue`.
     
     Результат:
     
     ```yaml
     QueueUrl: https://message-queue.{{ api-host }}/b1gvlrnlei4l5idm9cbj/dj6000000003n58805qi/queue-autoscale-queue
     ```
     
- API

  1. Создайте очередь `queue-autoscale-queue` с помощью метода API [CreateQueue](../../message-queue/api-ref/queue/CreateQueue.md). В ответных данных будет указан URL очереди.
  1. Вставьте URL очереди в файл `queue` в следующем формате:
          
     ```yaml
     QueueUrl: <URL очереди>
     ```

{% endlist %}

## Создайте образ с приложением {#create-image}

1. Если у вас еще не установлен Packer, скачайте и установите его по [инструкции](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) на официальном сайте.

   {% note info %}
   
   Для работы с {{ yandex-cloud }} требуется Packer версии не ниже 1.5.
   
   {% endnote %}
 
1. Скачайте [архив с файлами для образа](https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip) (ZIP, 3 КБ) и распакуйте его:

   ```bash
   wget https://{{ s3-storage-host }}/doc-files/queue-autoscale-server.zip
   unzip queue-autoscale-server.zip
   ```
   
1. В файле `server-packer.json` измените объект в массиве `builders`:

   * В поле `service_account_id` укажите идентификатор сервисного аккаунта `queue-autoscale-sa`.
   
     {% cut "Как узнать идентификатор сервисного аккаунта" %}
     
     {% list tabs %}
     
     - Консоль управления
     
       1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
       1. Перейдите на вкладку **Сервисные аккаунты**.
       1. В списке сервисных аккаунтов выберите `queue-autoscale-sa`.
       1. Скопируйте **Идентификатор** сервисного аккаунта.
     
     - CLI
     
       Выполните следующую команду:
       
       ```bash
       yc iam service-account get queue-autoscale-sa
       ```
       
       Результат:
       
       ```
       id: aje6brh817ro8o6vo6tv
       folder_id: b0g12ga82bcv0cdeferg
       created_at: "2021-10-04T16:19:10.153346507Z"
       name: queue-autoscale-sa
       ```
     
     - API
     
       Используйте вызов gRPC API [ServiceAccountService/List](../../iam/api-ref/grpc/service_account_service.md#List) или метод REST API [list](../../iam/api-ref/ServiceAccount/list.md).
     
     {% endlist %}
     
     {% endcut %}
     
   * В поле `folder_id` укажите идентификатор каталога в {{ yandex-cloud }}.
   
     {% cut "Как узнать идентификатор каталога" %}
     
     {% list tabs %}
     
     - Консоль управления
     
       В [консоли управления]({{ link-console-main }}) найдите каталог `example-folder` в списке и скопируйте его **Идентификатор**.
     
     - CLI
     
       Выполните следующую команду:
       
       ```bash
       yc resource-manager folder get example-folder
       ```
       
       Результат:
       
       ```
       id: b1g9hv2loamqfnbul7d9
       cloud_id: b1g2y61sxwqxrtw34qtq
       created_at: "2021-10-04T13:21:32.788067492Z"
       name: example-folder
       status: ACTIVE
       ```
       
     - API
     
       Используйте вызов gRPC API [FolderService/List](../../resource-manager/api-ref/grpc/folder_service.md#List) или метод REST API [list](../../resource-manager/api-ref/Folder/list.md).
     
     {% endlist %}
     
     {% endcut %}
     
   * В поле `subnet_id` укажите идентификатор подсети `queue-autoscale-subnet-a`.
   
     {% cut "Как узнать идентификатор подсети" %}
     
     {% list tabs %}
     
     - Консоль управления
     
       1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
       1. В списке сервисов выберите **{{ vpc-name }}**.
       1. Перейдите на вкладку **Подсети**.
       1. В списке подсетей найдите `queue-autoscale-subnet-a` и скопируйте ее **Идентификатор**.
            
     - CLI
     
       Выполните следующую команду:
       
       ```bash
       yc vpc subnet get queue-autoscale-subnet-a
       ```
       
       Результат:
       
       ```
       id: e1lnabc23r1c9d0efoje
       folder_id: b0g12ga82bcv0cdeferg
       created_at: "2021-10-04T16:29:12.450858436Z"
       name: queue-autoscale-subnet-a
       network_id: enpabce123hde4ft1r3t
       zone_id: {{ region-id }}-a
       v4_cidr_blocks:
       - 192.168.1.0/24
       ```
       
     - API
     
       Используйте вызов gRPC API [SubnetService/List](../../vpc/api-ref/grpc/subnet_service.md#List) или метод REST API [list](../../vpc/api-ref/Subnet/list.md).
     
     {% endlist %}
     
     {% endcut %}

1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для работы сервисного аккаунта с {{ compute-name }} и сохраните его в файл `key.json`:

   {% list tabs %}
   
   - CLI

     ```bash
     yc iam key create \
       --service-account-name queue-autoscale-sa \
       --description "{{ compute-name }}" \
       --output key.json
     ```
    
     Где:

     * `--service-account-name` — имя сервисного аккаунта, созданного ранее: `queue-autoscale-sa`.
     * `--description` — описание ключа.
     * `--output` — путь к файлу, в который нужно сохранить ключ: `key.json`.
  
     Результат:
       
     ```
     id: ajevh3a0hrqf65scefug
     service_account_id: aje6brh817ro8o6vo6tv
     created_at: "2021-10-04T16:35:19.057777570Z"
     description: {{ compute-name }}
     key_algorithm: RSA_2048
     ```
     
   {% endlist %}
     
1. Выполните команду для создания образа:

   ```bash
   packer build server-packer.json
   ```
   
   Результат:
   
   ```
   ...
   Build 'builder' finished after 2 minutes 48 seconds.
   
   ==> Wait completed after 2 minutes 48 seconds
   
   ==> Builds finished. The artifacts of successful builds are:
   --> builder: A disk image was created: queue-autoscale-image-v1633354734 (id: fd8hlbuhjc4mssrvknkv) with family name queue-autoscale-image
   ```

## Создайте группу виртуальных машин {#create-ig}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. Перейдите на вкладку **Группы виртуальных машин** и нажмите кнопку **Создать группу**.
  1. Укажите **Базовые параметры** группы ВМ:
  
     * **Имя** — `queue-autoscale-ig`.
     * **Сервисный аккаунт** — `queue-autoscale-sa`.
     
  1. В блоке **Распределение** выберите зону доступности `{{ region-id }}-a`.
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать** и настройте шаблон:
  
     1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **Пользовательские** и нажмите кнопку **Выбрать**.
     1. В открывшемся окне выберите созданный образ в качестве загрузочного диска:
     
        1. Перейдите на вкладку **Образ**.
        1. Выберите образ, имя которого начинается на `queue-autoscale-image`.
        1. Нажмите кнопку **Применить**
        
     1. В блоке **Сетевые настройки**:
     
        * Выберите **Сеть** `queue-autoscale-network`. Подсеть `queue-autoscale-subnet-a` будет выбрана автоматически.
        * В поле **Публичный адрес** выберите **Автоматически**, чтобы ВМ имели доступ в интернет и могли получать сообщения из очереди.
        
     1. В блоке **Доступ**:
     
        * Выберите **Сервисный аккаунт** `queue-autoscale-sa`.
        * Укажите логин и содержимое [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для подключения к ВМ.
        
     1. Нажмите кнопку **Сохранить**.
     
  1. В блоке **В процессе создания и обновления разрешено** укажите следующие значения:
  
     * **Одновременно останавливать** — `1`.
     * **Останавливать машины по стратегии** — **Деликатная**.
     
  1. В блоке **Масштабирование** укажите следующие значения:
  
     * **Тип** — **Автоматический**.
     * **Тип автомасштабирования** — **Региональное**.
     * **Минимальное количество ВМ в зоне** — 0.
     * **Максимальный размер группы** — 5.
     * **Промежуток измерения нагрузки** — 60 секунд.
     * **Время на разогрев ВМ** — 0 минут.
     * **Период стабилизации** — 5 минут.
     * **Начальный размер группы** — 1.
     
  1. В блоке **Метрики** укажите следующие значения:
  
     * **Метрика** — **Пользовательская**.
     * **Идентификатор сервиса** — `message-queue`.
     * **Имя метрики** — `queue.messages.stored_count`.
     * **Метки** — ключ `queue`, значение `queue-autoscale-queue`.
     * **Тип метрики** — `GAUGE`.
     * **Тип правила** — `WORKLOAD`.
     * **Целевое значение** — 5.
     
  1. Нажмите кнопку **Создать**.

- CLI

  1. Получите идентификатор образа, созданного ранее:
  
     ```bash
     yc compute image get-latest-from-family queue-autoscale-image 
     ```
     
     Результат:
     
     ```
     id: fd8hlbuhjc4mssrvknkv
     folder_id: b0g12ga82bcv0cdeferg
     created_at: "2021-10-04T16:38:54.345168059Z"
     name: queue-autoscale-image-v1633354734
     description: Image for autoscaling an instance group based on the size of a queue
     family: queue-autoscale-image
     storage_size: "3858759680"
     min_disk_size: "5368709120"
     product_ids:
     - f2e6fnj3erf1sropamjr
     status: READY
     os:
       type: LINUX
     ```
     
  1. Измените файл со спецификацией группы ВМ `spec.yaml`:
  
     * В поле `folder_id` укажите идентификатор каталога в {{ yandex-cloud }}.
     * В поле `image_id` укажите идентификатор созданного образа.
     * В поле `network_id` укажите идентификатор сети `queue-autoscale-network`, а в поле `subnet_ids` — идентификатор подсети `queue-autoscale-subnet-a`.
     
       {% cut "Как узнать идентификатор сети" %}
            
       {% list tabs %}
               
       - CLI
        
         Выполните команду:
          
         ```bash
         yc vpc network get queue-autoscale-network
         ```
          
         Результат:
          
         ```
         id: enpabce123hde4ft1r3t
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-10-04T16:28:15.905337847Z"
         name: queue-autoscale-network
         ```
        
       - Консоль управления
        
         1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
         1. В списке сервисов выберите **{{ vpc-name }}**.
         1. В списке сетей найдите `queue-autoscale-network` и скопируйте ее **Идентификатор**.
          
       - API
        
         Используйте вызов gRPC API [NetworkService/List](../../vpc/api-ref/grpc/network_service.md#List) или метод REST API [list](../../vpc/api-ref/Network/list.md).
        
       {% endlist %}
        
       {% endcut %}
     
     * В поле `service_account_id` укажите идентификатор сервисного аккаунта `queue-autoscale-sa`.
     
     Как получить идентификаторы ресурсов (кроме образа и сети), см. в шаге 3 раздела [Создайте образ с приложением](#create-image).
     
  1. Создайте группу ВМ `queue-autoscale-ig` по спецификации:
  
     ```bash
     yc compute instance-group create --file spec.yaml
     ```
     
     Где `--file` — путь к файлу со спецификацией группы ВМ: `spec.yaml`.
     
- API

  1. Получите идентификатор образа из семейства `queue-autoscale-image`, созданного ранее, с помощью вызова gRPC API [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/image_service.md#GetLatestByFamily) или метода REST API [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md).
  1. Измените файл со спецификацией группы виртуальных `spec.yaml`:
    
     * В поле `folder_id` укажите идентификатор каталога в {{ yandex-cloud }}.
     * В поле `image_id` укажите идентификатор созданного образа.
     * В поле `network_id` укажите идентификатор сети `queue-autoscale-network`, а в поле `subnet_ids` — идентификатор подсети `queue-autoscale-subnet-a`.
     
       {% cut "Как узнать идентификатор сети" %}
            
       {% list tabs %}
          
       - API
        
         Используйте вызов gRPC API [NetworkService/List](../../vpc/api-ref/grpc/network_service.md#List) или метод REST API [list](../../vpc/api-ref/Network/list.md).
        
       - Консоль управления
        
         1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
         1. В списке сервисов выберите **{{ vpc-name }}**.
         1. В списке сетей найдите `queue-autoscale-network` и скопируйте ее **Идентификатор**.
               
       - CLI
        
         Выполните следующую команду:
          
         ```bash
         yc vpc network get queue-autoscale-network
         ```
          
         Результат:
          
         ```
         id: enpabce123hde4ft1r3t
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-10-04T16:28:15.905337847Z"
         name: queue-autoscale-network
         ```
        
       {% endlist %}
        
       {% endcut %}
       
     * В поле `service_account_id` укажите идентификатор сервисного аккаунта `queue-autoscale-sa`.
     
     Как получить идентификаторы ресурсов (кроме образа и сети), см. в шаге 3 раздела [Создайте образ с приложением](#create-image).
     
  1. Создайте группу ВМ `queue-autoscale-ig` по спецификации `spec.yaml` с помощью вызова gRPC API [InstanceGroupService/CreateFromYaml](../../compute/api-ref/grpc/instance_group_service.md#CreateFromYaml) или метода REST API [createFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md).

{% endlist %}

## Проверьте масштабирование группы виртуальных машин {#test-autoscale}

1. Измените файл `messages.sh`: в параметре `--queue-url` укажите URL очереди из файла `queue`.
1. Запустите файл `messages.sh`. Начнется поочередная отправка 100 сообщений в очередь `queue-autoscale-queue`.
1. Откройте дашборды в {{ monitoring-full-name }}:

   {% list tabs %}
   
   - Консоль управления
   
     1. Откройте дашборд с информацией о группе ВМ:
     
        1. В [{{ monitoring-name }}]({{ link-monitoring }}) выберите сервисный дашборд **Compute — Instance Groups**.
        1. В поле **Instance Group ID** выберите `queue-autoscale-ig`.
     
     1. Откройте дашборд с информацией об очереди:
     
        1. В [{{ monitoring-name }}]({{ link-monitoring }}) выберите сервисный дашборд **Message Queue**.
        1. В поле **Queue ID** выберите `queue-autoscale-queue`.
        
   {% endlist %}
   
1. По данным дашбордов убедитесь, что последовательно произошли следующие события:

   1. Очередь `queue-autoscale-queue` заполнилась 100 сообщениями (дашборд **Message Queue**, графики **Sent messages, count** и **Messages in queue, count**).
   1. ВМ из группы `queue-autoscale-ig` стали получать сообщения (график **Received messages, count**) и удалять их из очереди (графики **Deleted messages, count** и **Messages in queue, count**).
   1. По мере обработки сообщений группа ВМ увеличилась с одной до пяти машин, а по окончании обработки — стала пустой (дашборд **Compute — Instance Groups**, график **Number of instances in zone B**).

## Удалите созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/instance-groups/delete.md) группу виртуальных машин `queue-autoscale-ig`.
1. [Удалите](../../compute/operations/image-control/delete.md) образ из семейства `queue-autoscale-image`.
1. [Удалите](../../message-queue/operations/message-queue-delete-queue.md) очередь `queue-autoscale-queue`.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсеть `queue-autoscale-subnet-a`.
1. [Удалите](../../vpc/operations/network-delete.md) сеть `queue-autoscale-network`.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт `queue-autoscale-sa`.
