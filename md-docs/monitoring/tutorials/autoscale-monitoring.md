# Автоматическое масштабирование группы виртуальных машин для обработки сообщений из очереди Yandex Message Queue


Сценарий описывает интеграцию между сервисами Yandex Compute Cloud, [Yandex Message Queue](https://yandex.cloud/ru/services/message-queue) и [Yandex Monitoring](https://yandex.cloud/ru/services/monitoring). 

В сценарии создается [группа виртуальных машин](../../compute/concepts/instance-groups/index.md). Все ВМ в группе обрабатывают сообщения из одной очереди Message Queue (для примера — получают их и через некоторое время удаляют). Количество сообщений в очереди записывается в метрику Monitoring, и группа ВМ [автоматически масштабируется](../../compute/concepts/instance-groups/scale.md#auto-scale) по этой метрике. 

Для масштабирования выбрана [деликатная стратегия остановки](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy): ВМ останавливаются самостоятельно после обработки всех сообщений и только после этого удаляются из группы при уменьшении ее размера. Это гарантирует, что ВМ не будут  удалены принудительно и обработают последние сообщения, даже если очередь опустеет до конца обработки.

Чтобы выполнить сценарий:

1. [Подготовьте окружение](#prepare).
1. [Создайте очередь в Message Queue](#create-queue).
1. [Создайте образ с приложением](#create-image).
1. [Создайте группу виртуальных машин](#create-ig).
1. [Проверьте масштабирование группы виртуальных машин](#test-autoscale).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

В качестве примера в сценарии будет использоваться каталог с именем `example-folder`.

### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры входят:

* плата за использование виртуальных машин и хранение [образа](../../compute/concepts/image.md) (см. [тарифы Compute Cloud](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик с ВМ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md));
* плата за запросы к очереди (см. [тарифы Message Queue](../../message-queue/pricing.md)).

## Подготовьте окружение {#prepare}

### Создайте вспомогательные ресурсы Yandex Cloud {#create-aux-resources}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте сервисный аккаунт `queue-autoscale-sa` и назначьте ему роль `editor` в каталоге `example-folder`:
  
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Identity and Access Management**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. В поле **Имя** укажите `queue-autoscale-sa`.
     1. Нажмите значок ![](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `editor`.
     1. Нажмите кнопку **Создать**.
     
  1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для работы сервисного аккаунта с Message Queue и сохраните его в файл `access_key`:
  
     1. В списке сервисных аккаунтов выберите `queue-autoscale-sa`.
     1. Нажмите ![](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать статический ключ доступа**.
     1. В поле **Описание** укажите `Message Queue`.
     1. Нажмите кнопку **Создать**.
     1. Вставьте идентификатор ключа и секретный ключ в файл `access_key` в следующем формате:
     
        ```yaml
        access_key:
          key_id: <идентификатор_ключа>
        secret: <секретный_ключ>
        ```
        
  1. Создайте облачную сеть `queue-autoscale-network`:
  
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Virtual Private Cloud**.
     1. Нажмите кнопку **Создать сеть**.
     1. В поле **Имя** укажите `queue-autoscale-network`.
     1. Отключите опцию **Создать подсети**.
     1. Нажмите кнопку **Создать сеть**.
     
  1. Создайте подсеть `queue-autoscale-subnet-d` в зоне `ru-central1-d`:
  
     1. В списке сетей выберите `queue-autoscale-network`.
     1. Нажмите кнопку ![](../../_assets/console-icons/plus.svg) **Создать подсеть**.
     1. Укажите параметры подсети:
     
        * **Имя** — `queue-autoscale-subnet-d`.
        * **Зона доступности** — `ru-central1-d`.
        * **CIDR** — `192.168.1.0/24`.
        
     1. Нажмите кнопку **Создать подсеть**.

- CLI {#cli}

  1. Создайте сервисный аккаунт `queue-autoscale-sa`:
  
     ```bash
     yc iam service-account create --name queue-autoscale-sa
     ```
     
     Где `--name` — имя сервисного аккаунта: `queue-autoscale-sa`.
     
     Результат:
     
     ```
     id: aje6brh817ro********
     folder_id: b0g12ga82bcv********
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
     
  1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для работы сервисного аккаунта с Message Queue и сохраните его в файл `access_key`:
    
     ```bash
     yc iam access-key create \
       --service-account-name queue-autoscale-sa \
       --description "Message Queue" \
     | tee access_key
     ```
    
     Где:

     * `--service-account-name` — имя сервисного аккаунта, созданного на шаге 1: `queue-autoscale-sa`.
     * `--description` — описание ключа.
     
     Результат:
     
     ```
     access_key:
       id: ajevb6bx51w3********
       service_account_id: aje6brh817ro********
       created_at: "2021-10-04T16:25:19.143847764Z"
       description: Message Queue
       key_id: g3VybpVKdq_Y********
     secret: WVUqnwmC4LSUep0GTKGkbcht9K3Xav7V********
     ```
     
  1. Создайте облачную сеть `queue-autoscale-network`:
  
     ```bash
     yc vpc network create queue-autoscale-network
     ```

     Результат:

     ```text
     id: enpabce123hd********
     folder_id: b0g12ga82bcv********
     created_at: "2021-10-04T16:28:15.905337847Z"
     name: queue-autoscale-network
     ```

  1. Создайте подсеть `queue-autoscale-subnet-d` в зоне `ru-central1-d`:

     ```bash
     yc vpc subnet create queue-autoscale-subnet-d \
       --network-name queue-autoscale-network 
       --range 192.168.1.0/24 
       --zone ru-central1-d
     ```
     
     Где:

     * `--network-name` — имя сети, в которой создается подсеть: `queue-autoscale-network`.
     * `--range` — CIDR подсети.
     * `--zone` — зона доступности, в которой создается подсеть: `ru-central1-d`.

     Результат:

     ```text
     id: e1lnabc23r1c********
     folder_id: b0g12ga82bcv********
     created_at: "2021-10-04T16:29:12.450858436Z"
     name: queue-autoscale-subnet-d
     network_id: enpabce123hd********
     zone_id: ru-central1-d
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```
     
- API {#api}

  1. Создайте сервисный аккаунт `queue-autoscale-sa` с помощью вызова gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) или метода REST API [create](../../iam/api-ref/ServiceAccount/create.md). В ответных данных будет указан идентификатор сервисного аккаунта.
  1. Назначьте сервисному аккаунту роль `editor` в каталоге `example-folder` с помощью вызова gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) или метода REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md). В теле запроса укажите идентификатор сервисного аккаунта.
  1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для работы сервисного аккаунта с Message Queue и сохраните его в файл `access_key`:
  
     1. Используйте вызов gRPC API [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md) или метод REST API [create](../../iam/awscompatibility/api-ref/AccessKey/create.md).
     1. Вставьте идентификатор ключа и секретный ключ в файл `access_key` в следующем формате:
          
        ```yaml
        access_key:
          key_id: <идентификатор_ключа>
        secret: <секретный_ключ>
        ```
        
  1. Создайте облачную сеть `queue-autoscale-network` с помощью вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) или метода REST API [create](../../vpc/api-ref/Network/create.md). В ответных данных будет указан идентификатор сети.
  1. Создайте подсеть `queue-autoscale-subnet-d` в зоне `ru-central1-d` с CIDR `192.168.1.0/24` с помощью вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) или метода REST API [create](../../vpc/api-ref/Subnet/create.md). В теле запроса укажите идентификатор сети.
  
{% endlist %}

### Настройте AWS CLI {#setup-aws-cli}

{% note info %}

С помощью AWS CLI выполняется последний шаг сценария — [проверка масштабирования группы виртуальных машин](#test-autoscale). Поэтому его нужно установить и настроить, даже если вы не будете использовать его для других шагов.

{% endnote %}

1. Скачайте и установите AWS CLI, как описано в его [документации](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).
1. Настройте AWS CLI для работы с Yandex Cloud:
  
   1. Создайте в домашнем каталоге файл `.aws/credentials` и укажите в нем статический ключ доступа, полученный ранее, и его идентификатор:
           
      ```
      [default]
          aws_access_key_id     = <идентификатор_ключа>
          aws_secret_access_key = <секретный_ключ>
      ```
        
   1. Создайте в домашнем каталоге файл `.aws/config` и укажите в нем регион по умолчанию `ru-central1`:
           
      ```
      [default]
          region = ru-central1
      ```

## Создайте очередь в Message Queue {#create-queue}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте очередь `queue-autoscale-queue`:
  
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Message Queue**.
     1. Нажмите кнопку **Создать очередь**.
     1. В поле **Имя** укажите `queue-autoscale-queue`.
     1. Нажмите кнопку **Создать**.
  
  1. Сохраните URL очереди в файл `queue`:
  
     1. В списке очередей выберите `queue-autoscale-queue`.
     1. Скопируйте **URL** очереди.
     1. Вставьте URL в файл `queue` в следующем формате:
     
        ```yaml
        QueueUrl: <URL_очереди>
        ``` 

- AWS CLI {#cli}

  1. Создайте очередь `queue-autoscale-queue` и сохраните ее URL в файл `queue`:
  
     ```bash
     aws sqs create-queue \
       --endpoint https://message-queue.api.cloud.yandex.net \
       --queue-name queue-autoscale-queue \
       --output yaml \
     | tee queue
     ```
     
     Где:

     * `--endpoint` — корневой URL API Message Queue: `https://message-queue.api.cloud.yandex.net`.
     * `--queue-name` — имя очереди: `queue-autoscale-queue`.
     
     Результат:
     
     ```yaml
     QueueUrl: https://message-queue.api.cloud.yandex.net/b1gvlrnlei4l********/dj6000000003********/queue-autoscale-queue
     ```
     
- API {#api}

  1. Создайте очередь `queue-autoscale-queue` с помощью метода API [CreateQueue](../../message-queue/api-ref/queue/CreateQueue.md). В ответных данных будет указан URL очереди.
  1. Вставьте URL очереди в файл `queue` в следующем формате:
          
     ```yaml
     QueueUrl: <URL_очереди>
     ```

{% endlist %}

## Создайте образ с приложением {#create-image}

1. Если у вас еще не установлен Packer, скачайте и установите его по [инструкции](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) на официальном сайте. Также вы можете скачать дистрибутив Packer для вашей платформы из [зеркала](https://hashicorp-releases.yandexcloud.net/packer/).

   {% note info %}
   
   Для работы с Yandex Cloud требуется Packer версии не ниже 1.5.
   
   {% endnote %}

1. Настройте [плагин Yandex Compute Builder](https://developer.hashicorp.com/packer/plugins/builders/yandex):

    1. Создайте файл `config.pkr.hcl` со следующим содержанием:
        
        ```hcl
        packer {
          required_plugins {
            yandex = {
              version = ">= 1.1.2"
              source  = "github.com/hashicorp/yandex"
            }
          }
        }
        ```
        
    1. Установите плагин:

        ```bash
        packer init <путь_к_файлу_config.pkr.hcl>
        ```

        Результат:

        ```text
        Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
        ```

1. Скачайте [архив с файлами для образа](https://storage.yandexcloud.net/doc-files/queue-autoscale-server.zip) (ZIP, 3 КБ) и распакуйте его:

   ```bash
   wget https://storage.yandexcloud.net/doc-files/queue-autoscale-server.zip
   unzip queue-autoscale-server.zip
   ```
   
1. В файле `server-packer.json` измените объект в массиве `builders`:

   * В поле `service_account_id` укажите идентификатор сервисного аккаунта `queue-autoscale-sa`.
   
     {% cut "Как узнать идентификатор сервисного аккаунта" %}
     
     {% list tabs group=instructions %}

     - Консоль управления {#console}

       1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
       1. Перейдите в сервис **Identity and Access Management**.
       1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
       1. В открывшемся списке выберите сервисный аккаунт `queue-autoscale-sa`.
       1. Скопируйте **Идентификатор** сервисного аккаунта.

     - CLI {#cli}
     
       Выполните следующую команду:
       
       ```bash
       yc iam service-account get queue-autoscale-sa
       ```
       
       Результат:
       
       ```
       id: aje6brh817ro********
       folder_id: b0g12ga82bcv********
       created_at: "2021-10-04T16:19:10.153346507Z"
       name: queue-autoscale-sa
       ```
     
     - API {#api}
     
       Воспользуйтесь методом REST API [list](../../iam/api-ref/ServiceAccount/list.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/List](../../iam/api-ref/grpc/ServiceAccount/list.md).
     
     {% endlist %}
     
     {% endcut %}
     
   * В поле `folder_id` укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) в Yandex Cloud.
     
   * В поле `subnet_id` укажите идентификатор подсети `queue-autoscale-subnet-d`.
   
     {% cut "Как узнать идентификатор подсети" %}
     
     {% list tabs group=instructions %}
     
     - Консоль управления {#console}
     
       1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
       1. Перейдите в сервис **Virtual Private Cloud**.
       1. Перейдите на вкладку ![image](../../_assets/console-icons/nodes-right.svg) **Подсети**.
       1. В списке подсетей найдите `queue-autoscale-subnet-d` и скопируйте ее **Идентификатор**.
            
     - CLI {#cli}
     
       Выполните следующую команду:
       
       ```bash
       yc vpc subnet get queue-autoscale-subnet-d
       ```
       
       Результат:
       
       ```
       id: e1lnabc23r1c********
       folder_id: b0g12ga82bcv********
       created_at: "2021-10-04T16:29:12.450858436Z"
       name: queue-autoscale-subnet-d
       network_id: enpabce123hd********
       zone_id: ru-central1-d
       v4_cidr_blocks:
       - 192.168.1.0/24
       ```
       
     - API {#api}
     
       Воспользуйтесь методом REST API [list](../../vpc/api-ref/Subnet/list.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../../vpc/api-ref/grpc/Subnet/list.md).
     
     {% endlist %}
     
     {% endcut %}

1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для работы сервисного аккаунта с Compute Cloud и сохраните его в файл `key.json`:

   {% list tabs group=instructions %}
   
   - CLI {#cli}

     ```bash
     yc iam key create \
       --service-account-name queue-autoscale-sa \
       --description "Compute Cloud" \
       --output key.json
     ```
    
     Где:

     * `--service-account-name` — имя сервисного аккаунта, созданного ранее: `queue-autoscale-sa`.
     * `--description` — описание ключа.
     * `--output` — путь к файлу, в который нужно сохранить ключ: `key.json`.
  
     Результат:
       
     ```
     id: ajevh3a0hrqf********
     service_account_id: aje6brh817ro********
     created_at: "2021-10-04T16:35:19.057777570Z"
     description: Compute Cloud
     key_algorithm: RSA_2048
     ```
     
   - API {#api}

     Воспользуйтесь методом REST API [create](../../iam/api-ref/Key/create.md) для ресурса [Key](../../iam/api-ref/Key/index.md) или вызовом gRPC API [KeyService/Create](../../iam/api-ref/grpc/Key/create.md).

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
   --> builder: A disk image was created: queue-autoscale-image-v1633354734 (id: fd8hlbuhjc4m********) with family name queue-autoscale-image
   ```

## Создайте группу виртуальных машин {#create-ig}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Нажмите кнопку **Создать группу виртуальных машин**.
  1. В блоке **Базовые параметры**:
  
     * В поле **Имя** укажите `queue-autoscale-ig`.
     * Выберите **Сервисный аккаунт** `queue-autoscale-sa`.
     
  1. В блоке **Распределение** в поле **Зона доступности** выберите`ru-central1-d`.
  1. В блоке **Шаблон виртуальной машины** нажмите **Задать** и в открывшемся окне:
  
     1. В блоке **Образ загрузочного диска** перейдите на вкладку **Пользовательский** и нажмите **Выбрать**.
     1. В открывшемся окне выберите созданный образ в качестве загрузочного диска:
     
        1. Перейдите на вкладку **Образ**.
        1. Выберите образ, имя которого начинается на `queue-autoscale-image`.
        1. Нажмите кнопку **Применить**.
        
     1. В блоке **Сетевые настройки**:
     
        * В поле **Сеть** выберите `queue-autoscale-network`.
        * В поле **Публичный адрес** выберите `Автоматически`, чтобы ВМ имели доступ в интернет и могли получать сообщения из очереди.
        
     1. В блоке **Доступ**:
     
        * В поле **Сервисный аккаунт** выберите `queue-autoscale-sa`.
        * Укажите логин и содержимое [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для подключения к ВМ.
        
     1. Нажмите кнопку **Сохранить**.
     
  1. В блоке **В процессе создания и обновления разрешено** укажите следующие значения:
  
     * **Одновременно останавливать** — `1`.
     * **Останавливать машины по стратегии** — `Ручная`.
     
  1. В блоке **Масштабирование** укажите следующие значения:
  
     * **Тип** — `Автоматический`.
     * **Тип автомасштабирования** — `Региональное`.
     * **Минимальное количество ВМ в зоне** — `0`.
     * **Максимальный размер группы** — `5`.
     * **Промежуток измерения нагрузки** — `60 секунд`.
     * **Время на разогрев ВМ** — `0 минут`.
     * **Период стабилизации** — `5 минут`.
     * **Начальный размер группы** — `1`.
     
  1. В блоке **Метрики** укажите следующие значения:
  
     * **Метрика** — `Yandex Monitoring`.
     * **Идентификатор каталога** — `message-queue`.
     * **Имя метрики** — `queue.messages.stored_count`.
     * **Метки** — ключ `queue`, значение `queue-autoscale-queue`.
     * **Тип метрики** — `GAUGE`.
     * **Тип правила** — `WORKLOAD`.
     * **Целевое значение** — `5`.
     
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. Получите идентификатор образа, созданного ранее:
  
     ```bash
     yc compute image get-latest-from-family queue-autoscale-image 
     ```
     
     Результат:
     
     ```
     id: fd8hlbuhjc4m********
     folder_id: b0g12ga82bcv********
     created_at: "2021-10-04T16:38:54.345168059Z"
     name: queue-autoscale-image-v1633354734
     description: Image for autoscaling an instance group based on the size of a queue
     family: queue-autoscale-image
     storage_size: "3858759680"
     min_disk_size: "5368709120"
     product_ids:
     - f2e6fnj3erf1********
     status: READY
     os:
       type: LINUX
     ```
     
  1. Измените файл со спецификацией группы ВМ `spec.yaml`:
  
     * В поле `folder_id` укажите идентификатор каталога в Yandex Cloud.
     * В поле `image_id` укажите идентификатор созданного образа.
     * В поле `network_id` укажите идентификатор сети `queue-autoscale-network`, а в поле `subnet_ids` — идентификатор подсети `queue-autoscale-subnet-d`.
     
       {% cut "Как узнать идентификатор сети" %}
            
       {% list tabs group=instructions %}
               
       - CLI {#cli}
        
         Выполните команду:
          
         ```bash
         yc vpc network get queue-autoscale-network
         ```
          
         Результат:
          
         ```
         id: enpabce123hd********
         folder_id: b0g12ga82bcv********
         created_at: "2021-10-04T16:28:15.905337847Z"
         name: queue-autoscale-network
         ```
        
       - Консоль управления {#console}
        
         1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
         1. Перейдите в сервис **Virtual Private Cloud**.
         1. В списке сетей найдите `queue-autoscale-network` и скопируйте ее **Идентификатор**.
          
       - API {#api}
        
         Воспользуйтесь методом REST API [list](../../vpc/api-ref/Network/list.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/List](../../vpc/api-ref/grpc/Network/list.md).
        
       {% endlist %}
        
       {% endcut %}
     
     * В поле `service_account_id` укажите идентификатор сервисного аккаунта `queue-autoscale-sa`.
     
     Как получить идентификаторы ресурсов (кроме образа и сети), см. в шаге 3 раздела [Создайте образ с приложением](#create-image).
     
  1. Создайте группу ВМ `queue-autoscale-ig` по спецификации:
  
     ```bash
     yc compute instance-group create --file spec.yaml
     ```
     
     Где `--file` — путь к файлу со спецификацией группы ВМ: `spec.yaml`.
     
- API {#api}

  1. Получите идентификатор образа из семейства `queue-autoscale-image`, созданного ранее, с помощью вызова gRPC API [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/Image/getLatestByFamily.md) или метода REST API [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md).
  1. Измените файл со спецификацией группы виртуальных `spec.yaml`:
    
     * В поле `folder_id` укажите идентификатор каталога в Yandex Cloud.
     * В поле `image_id` укажите идентификатор созданного образа.
     * В поле `network_id` укажите идентификатор сети `queue-autoscale-network`, а в поле `subnet_ids` — идентификатор подсети `queue-autoscale-subnet-d`.
     
       {% cut "Как узнать идентификатор сети" %}
            
       {% list tabs group=instructions %}
          
       - Консоль управления {#console}
        
         1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
         1. Перейдите в сервис **Virtual Private Cloud**.
         1. В списке сетей найдите `queue-autoscale-network` и скопируйте ее **Идентификатор**.
               
       - CLI {#cli}
        
         Выполните следующую команду:
          
         ```bash
         yc vpc network get queue-autoscale-network
         ```
          
         Результат:
          
         ```
         id: enpabce123hd********
         folder_id: b0g12ga82bcv********
         created_at: "2021-10-04T16:28:15.905337847Z"
         name: queue-autoscale-network
         ```
         
       - API {#api}
        
         Воспользуйтесь методом REST API [list](../../vpc/api-ref/Network/list.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/List](../../vpc/api-ref/grpc/Network/list.md).

       {% endlist %}
        
       {% endcut %}
       
     * В поле `service_account_id` укажите идентификатор сервисного аккаунта `queue-autoscale-sa`.
     
     Как получить идентификаторы ресурсов (кроме образа и сети), см. в шаге 3 раздела [Создайте образ с приложением](#create-image).
     
  1. Создайте группу ВМ `queue-autoscale-ig` по спецификации `spec.yaml` с помощью вызова gRPC API [InstanceGroupService/CreateFromYaml](../../compute/instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) или метода REST API [createFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md).

{% endlist %}

## Проверьте масштабирование группы виртуальных машин {#test-autoscale}

1. Измените файл `messages.sh`: в параметре `--queue-url` укажите URL очереди из файла `queue`.
1. Запустите файл `messages.sh`. Начнется поочередная отправка 100 сообщений в очередь `queue-autoscale-queue`.
1. Откройте дашборды в Yandex Monitoring:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. Откройте дашборд с информацией о группе ВМ:
     
        1. В [Monitoring](https://monitoring.yandex.cloud) выберите сервисный дашборд **Compute — Instance Groups**.
        1. В поле **Instance Group ID** выберите `queue-autoscale-ig`.
     
     1. Откройте дашборд с информацией об очереди:
     
        1. В [Monitoring](https://monitoring.yandex.cloud) выберите сервисный дашборд **Message Queue**.
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
1. [Удалите](../../vpc/operations/subnet-delete.md) подсеть `queue-autoscale-subnet-d`.
1. [Удалите](../../vpc/operations/network-delete.md) сеть `queue-autoscale-network`.
1. [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт `queue-autoscale-sa`.