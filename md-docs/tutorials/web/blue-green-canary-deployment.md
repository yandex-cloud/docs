# Организация сине-зеленого и канареечного развертывания версий веб-сервиса


Настройте архитектуру веб-сервиса, которая позволит переключаться между версиями по распространенным схемам развертывания: с помощью [сине-зеленого развертывания](https://martinfowler.com/bliki/BlueGreenDeployment.html) (blue-green deployment) и [канареечного развертывания](https://martinfowler.com/bliki/CanaryRelease.html) (canary deployment). 

Обе схемы используют пару бэкендов: «синий» и «зеленый». Сначала на одном из бэкендов (например, на «синем») размещается стабильная версия, доступная пользователям, а другой («зеленый») используется для тестирования следующей версии. Когда тестирование окончено, бэкенды меняются ролями: 

* При сине-зеленом развертывании весь пользовательский трафик одномоментно перераспределяется с одного бэкенда на другой.
* При канареечном развертывании переключение происходит постепенно, начиная с части пользователей.

После этого основным становится «зеленый» бэкенд, а на «синем» бэкенде можно тестировать следующую версию сервиса. Также, пока на «синем» бэкенде остается предыдущая версия, на нее можно откатить сервис, снова поменяв бэкенды ролями.

В данном руководстве в качестве бэкендов используются бакеты Yandex Object Storage, а за переключение между ними отвечает L7-балансировщик Yandex Application Load Balancer. Запросы пользователей передаются балансировщику через сеть распространения контента Yandex Cloud CDN, чтобы сократить время доставки контента.

В качестве примеров будут использованы доменные имена `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example`.

Для выполнения шагов можно использовать различные [поддерживаемые инструменты](#supported-tools).

Чтобы построить архитектуру для сине-зеленого и канареечного развертывания:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Добавьте сертификат в Certificate Manager](#add-certificate)
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте бакеты в Object Storage](#create-buckets).
1. [Загрузите файлы сервиса в бакеты](#upload-files).
1. [Создайте группы бэкендов в Application Load Balancer](#create-l7backend).
1. [Создайте HTTP-роутер и виртуальные хосты](#create-route-hosts).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Настройте DNS для сервиса](#configure-dns).
1. [Проверьте работу сервиса и переключение между версиями](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Поддерживаемые инструменты {#supported-tools}

Бо́льшую часть шагов можно выполнить с помощью любого из стандартных инструментов: [консоли управления](https://console.yandex.cloud), интерфейсов командной строки (CLI) [Yandex Cloud](../../cli/index.md) и [AWS](../../storage/tools/aws-cli.md), Terraform и [API Yandex Cloud](../../api-design-guide/index.md). В каждом шаге перечислены поддерживаемые для него инструменты.

Некоторые инструменты поддерживаются не для всех шагов:

* Через CLI и Terraform сейчас нельзя:
  * [создать группу бэкендов в Application Load Balancer с бакетами в качестве бэкендов](#create-l7backend);
  * получить доменное имя CDN-балансировщика при [настройке DNS для сервиса](#configure-dns);
  * отключать и включать кеширование CDN-ресурса при [проверке работы сервиса и переключения между версиями](#check).
* Через API сейчас нельзя получить доменное имя CDN-балансировщика при [настройке DNS для сервиса](#configure-dns).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

В качестве примера будет использоваться каталог с именем `example-folder`.


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение данных в Object Storage, операции с ними и исходящий трафик ([тарифы Object Storage](../../storage/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика ([тарифы Application Load Balancer](../../application-load-balancer/pricing.md));
* плата за исходящий трафик с CDN-серверов ([тарифы Cloud CDN](../../cdn/pricing.md));
* плата за публичные DNS-запросы и DNS-зоны, если вы используете Yandex Cloud DNS ([тарифы Cloud DNS](../../dns/pricing.md)).

## Добавьте сертификат в Certificate Manager {#add-certificate}

Поддерживаются сертификаты из [Yandex Certificate Manager](../../certificate-manager/index.md). Вы можете [выпустить новый сертификат Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md) или [загрузить собственный](../../certificate-manager/operations/import/cert-create.md).

Сертификат должен находиться в том же [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором расположен ваш CDN-ресурс.

Для сертификата Let's Encrypt® пройдите [проверку прав](../../certificate-manager/operations/managed/cert-validate.md) на домен, который указан в сертификате.


## Создайте облачную сеть и подсети {#create-network}

Все ресурсы будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
    1. Перейдите в сервис **Virtual Private Cloud**.
    1. Справа сверху нажмите кнопку **Создать сеть**.
    1. В поле **Имя** укажите `canary-network`.
    1. В поле **Дополнительно** выберите опцию **Создать подсети**.
    1. Нажмите кнопку **Создать сеть**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сеть `canary-network`:

     ```bash
     yc vpc network create canary-network
     ```

     Результат:

     ```
     id: enptrcle5q3d********
     folder_id: b1g9hv2loamq********
     created_at: "2021-11-03T09:25:03Z"
     name: canary-network
     default_security_group_id: enpbsnnop4ak********
     ```

     Подробнее о команде `yc vpc network create` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсети во всех зонах доступности:

     * В `ru-central1-a`:

       ```bash
       yc vpc subnet create canary-subnet-ru-central1-a \
         --zone ru-central1-a \
         --network-name canary-network \
         --range 10.1.0.0/16
       ```

       Результат:

       ``` 
       id: e9bnnssj8sc8********
       folder_id: b1g9hv2loamq********
       created_at: "2021-11-03T09:27:00Z"
       name: canary-subnet-ru-central1-a
       network_id: enptrcle5q3d********
       zone_id: ru-central1-a
       v4_cidr_blocks:
       - 10.1.0.0/16
       ```

     * В `ru-central1-b`:

       ```bash
       yc vpc subnet create canary-subnet-ru-central1-b \
         --zone ru-central1-b \
         --network-name canary-network \
         --range 10.2.0.0/16
       ```

       Результат:

       ``` 
       id: e2lghukd9iqo********
       folder_id: b1g9hv2loamq********
       created_at: "2021-11-03T09:27:39Z"
       name: canary-subnet-ru-central1-b
       network_id: enptrcle5q3d********
       zone_id: ru-central1-b
       v4_cidr_blocks:
       - 10.2.0.0/16
       ```

     * В `ru-central1-d`:

       ```bash
       yc vpc subnet create canary-subnet-ru-central1-d \
         --zone ru-central1-d \
         --network-name canary-network \
         --range 10.3.0.0/16
       ```

       Результат:

       ``` 
       id: b0c3pte4o2kn********
       folder_id: b1g9hv2loamq********
       created_at: "2021-11-03T09:28:08Z"
       name: canary-subnet-ru-central1-d
       network_id: enptrcle5q3d********
       zone_id: ru-central1-d
       v4_cidr_blocks:
       - 10.3.0.0/16
       ```

     Подробнее о команде `yc vpc subnet create` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры сети `canary-network` и ее подсетей `canary-subnet-ru-central1-a`, `canary-subnet-ru-central1-b` и `canary-subnet-ru-central1-d`:

     ```hcl
     resource "yandex_vpc_network" "canary-network" {
       name = "canary-network"
     }

     resource "yandex_vpc_subnet" "canary-subnet-a" {
       name           = "canary-subnet-ru-central1-a"
       zone           = "ru-central1-a"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }

     resource "yandex_vpc_subnet" "canary-subnet-b" {
       name           = "canary-subnet-ru-central1-b"
       zone           = "ru-central1-b"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.2.0.0/16"]
     }

     resource "yandex_vpc_subnet" "canary-subnet-d" {
       name           = "canary-subnet-ru-central1-d"
       zone           = "ru-central1-d"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.3.0.0/16"]
     }
     ```

     Подробнее в описаниях ресурсов [yandex_vpc_network](../../terraform/resources/vpc_network.md) и [yandex_vpc_subnet](../../terraform/resources/vpc_subnet.md) в документации провайдера Terraform.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API {#api}

  1. Создайте сеть `canary-network` с помощью вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) или метода REST API [create](../../vpc/api-ref/Network/create.md).
  1. Создайте подсети `canary-subnet-ru-central1-a`, `canary-subnet-ru-central1-b` и `canary-subnet-ru-central1-d` в трех [зонах доступности](../../overview/concepts/geo-scope.md) с помощью вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) или метода REST API [create](../../vpc/api-ref/Subnet/create.md).

{% endlist %}

## Создайте бакеты в Object Storage {#create-buckets}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Object Storage**.
  1. Создайте «синий» бакет для стабильной версии бэкенда:

     1. Справа сверху нажмите кнопку **Создать бакет**.
     1. В поле **Имя** укажите имя бакета.
     1. В полях **Чтение объектов** и **Чтение списка объектов** выберите `Для всех`.
     1. Нажмите кнопку **Создать бакет**.

  1. Таким же образом создайте «зеленый» бакет для тестовой версии бэкенда.

- AWS CLI {#cli}

  1. Создайте «синий» бакет для стабильной версии бэкенда:

     ```bash
     aws --endpoint-url https://storage.yandexcloud.net \
       s3 mb s3://<имя_синего_бакета>
     ```

     Результат:

     ```
     make_bucket: s3://<имя_синего_бакета>
     ```

  1. Включите публичный доступ к чтению объектов и их списка:

     ```bash
     aws --endpoint-url https://storage.yandexcloud.net \
       s3api put-bucket-acl \
       --bucket <имя_синего_бакета> \
       --acl public-read
     ```

  1. Аналогично создайте «зеленый» бакет для тестовой версии бэкенда и включите публичный доступ к нему.

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../storage/security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  1. Опишите в конфигурационном файле параметры для создания сервисного аккаунта и ключа доступа:

     ```hcl
     ...
     // Создание сервисного аккаунта
     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }
     
     // Назначение роли сервисному аккаунту
     resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }
     
     // Создание статического ключа доступа
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }
     ```

  1. Добавьте в конфигурационный файл параметры «синего» (стабильная версия бэкенда) и «зеленого» (тестовая версия бэкенда) бакетов:

     ```hcl
     ...

     resource "yandex_storage_bucket" "canary-bucket-blue" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_синего_бакета>"
       acl        = "public-read"
     }

     resource "yandex_storage_bucket" "canary-bucket-green" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_зеленого_бакета>"
       acl        = "public-read"
     }
     ```

     Подробнее о ресурсе `yandex_storage_bucket` смотрите в [документации](../../terraform/resources/storage_bucket.md) провайдера Terraform.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API {#api}

  Используйте метод REST API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}

## Загрузите файлы сервиса в бакеты {#upload-files}

1. Создайте два файла с одним и тем же названием `index.html`. Они будут представлять разные версии сервиса: один — версию 1, другой — версию 2.

   {% cut "Пример файла index.html версии 1" %}

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>Version 1</title>
     </head>
     <body>
       <p>Version 1 is working</p>
     </body>
   </html>
   ```

   {% endcut %}

   {% cut "Пример файла index.html версии 2" %}

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>Version 2</title>
     </head>
     <body>
       <p>Version 2 is working</p>
     </body>
   </html>
   ```

   {% endcut %}

1. Загрузите файлы в бакеты:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Object Storage**.
     1. Выберите «синий» бакет.
     1. Нажмите кнопку **Загрузить** и выберите для загрузки файл `index.html` версии 1.
     1. Таким же образом загрузите в «зеленый» бакет файл `index.html` версии 2.

   - AWS CLI {#cli}

     1. Загрузите в «синий» бакет файл `index.html` версии 1:

        ```bash
        aws --endpoint-url https://storage.yandexcloud.net \
          s3 cp v1/index.html s3://<имя_синего_бакета>/index.html
        ```

        Результат:

        ```
        upload: v1/index.html to s3://<имя_синего_бакета>/index.html
        ```

     1. Загрузите в «зеленый» бакет файл `index.html` версии 2:

        ```bash
        aws --endpoint-url https://storage.yandexcloud.net \
          s3 cp v2/index.html s3://<имя_зеленого_бакета>/index.html
        ```

        Результат:

        ```
        upload: v2/index.html to s3://<имя_зеленого_бакета>/index.html
        ```

   - Terraform {#tf}

     1. Добавьте в конфигурационный файл параметры файлов `v1/index.html` и `v2/index.html`, загружаемых в бакеты «синий» и «зеленый» соответственно:

        ```hcl
        ...

        resource "yandex_storage_object" "canary-bucket-blue-index" {
          bucket = "<имя_синего_бакета>"
          key    = "index.html"
          source = "v1/index.html"
        }

        resource "yandex_storage_bucket" "canary-bucket-green-index" {
          bucket = "<имя_зеленого_бакета>"
          key    = "index.html"
          source = "v2/index.html"
        }
        ```

        Подробнее о ресурсе `yandex_storage_object` смотрите в [документации](../../terraform/resources/storage_object.md) провайдера Terraform.

     1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

           ```bash
           terraform plan
           ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

     1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

           ```bash
           terraform apply
           ```

        1. Подтвердите создание ресурсов.

   - API {#api}

     Используйте метод REST API [upload](../../storage/s3/api-ref/object/upload.md).

   {% endlist %}

## Создайте группу безопасности {#create-security-group}

[Группы безопасности](../../vpc/concepts/security-groups.md) содержат правила, которые разрешают L7-балансировщику получать входящий трафик и отправлять его на бакеты-бэкенды.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **Группы безопасности**.
  1. Справа сверху нажмите кнопку **Создать группу безопасности**.
  1. В поле **Имя** укажите `canary-sg`.
  1. В поле **Сеть** выберите `canary-network`.
  1. В блоке **Правила** создайте правила по инструкции под таблицей:

      | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>назначение | CIDR блоки |
      | --- | --- | --- | --- | --- | --- |
      | `Исходящий` | `any` | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |
      | `Входящий` | `ext-http` | `80` | `TCP` | `CIDR` | `0.0.0.0/0` |
      | `Входящий` | `ext-https` | `443` | `TCP` | `CIDR` | `0.0.0.0/0` |
      | `Входящий` | `healthchecks` | `30080` | `TCP` | `Проверки состояния балансировщика` | — |

     1. Перейдите на вкладку **Исходящий трафик** или **Входящий трафик**.
     1. Нажмите кнопку **Добавить правило**.
     1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
     1. В поле **Протокол** укажите нужный протокол или оставьте `Любой`.
     1. В поле **Назначение** или **Источник** выберите назначение правила:

        * `CIDR` — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
        * `Проверки состояния балансировщика` — правило, которое позволяет балансировщику проверять состояние ВМ.

     1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.

  1. Нажмите кнопку **Сохранить**.

- Yandex Cloud CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc vpc security-group create canary-sg \
    --network-name canary-network \
    --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks
  ```

  Результат:

  ```
  id: enpd133ngcnr********
  folder_id: b1g9hv2loamq********
  created_at: "2021-11-03T10:26:16Z"
  name: canary-sg
  network_id: enptrcle5q3d********
  status: ACTIVE
  rules:
  - id: enpkgrpi2gsi********
    direction: EGRESS
    protocol_name: ANY
    protocol_number: "-1"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpgssij0i16********
    direction: INGRESS
    ports:
      from_port: "80"
      to_port: "80"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enp0bft67j9l********
    direction: INGRESS
    ports:
      from_port: "443"
      to_port: "443"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpmorcimu65********
    direction: INGRESS
    ports:
      from_port: "30080"
      to_port: "30080"
    protocol_name: TCP
    protocol_number: "6"
    predefined_target: loadbalancer_healthchecks
  ```

  Подробнее о команде `yc vpc security-group create` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

- Terraform {#tf}

  1. Добавьте в конфигурационный файл параметры группы безопасности `canary-sg`:

     ```hcl
     resource "yandex_vpc_security_group" "canary-sg" {
       name       = "canary-sg"
       network_id = yandex_vpc_network.canary-network.id

       egress {
         protocol       = "ANY"
         port           = "ANY"
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         protocol       = "TCP"
         port           = 80
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         protocol       = "TCP"
         port           = 443
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         protocol          = "TCP"
         port              = 30080
         predefined_target = "loadbalancer_healthchecks"
       }
     }
     ```

     Подробнее о параметрах ресурсов в Terraform смотрите в [документации провайдера](../../terraform/resources/vpc_security_group.md).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API {#api}

  Используйте вызов gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md) или метод REST API [create](../../vpc/api-ref/SecurityGroup/create.md).

  Чтобы добавить правило для проверок состояния балансировщика, используйте параметр `loadbalancer_healthchecks` в поле [SecurityGroupRuleSpec.target.predefined_target](../../vpc/api-ref/grpc/SecurityGroup/create.md#yandex.cloud.vpc.v1.SecurityGroupRuleSpec) для gRPC API или в поле [predefinedTarget](../../vpc/api-ref/SecurityGroup/create.md#yandex.cloud.vpc.v1.CreateSecurityGroupRequest) для REST API.

{% endlist %}

## Создайте группы бэкендов в Application Load Balancer {#create-l7backend}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте группу бэкендов `canary-bg-production` с бэкендами `canary-backend-blue` и `canary-backend-green`:

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Application Load Balancer**.
     1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов**.
     1. Справа сверху нажмите кнопку **Создать группу бэкендов**.
     1. В поле **Имя** укажите `canary-bg-production`.
     1. Создайте бэкенд `canary-backend-blue`:
         1. В блоке **Бэкенды** нажмите **Добавить**.
         1. В поле **Имя** укажите `canary-backend-blue`.
         1. В поле **Вес** укажите `100`.
         1. В поле **Тип** выберите `Бакет`.
         1. В поле **Бакет** выберите «синий» бакет.
     1. Создайте бэкенд `canary-backend-green`:
         1. В блоке **Бэкенды** нажмите **Добавить**.
         1. В поле **Имя** укажите `canary-backend-green`.
         1. В поле **Вес** укажите `0`.
         1. В поле **Тип** выберите `Бакет`.
         1. В поле **Бакет** выберите «зеленый» бакет.
     1. Нажмите кнопку **Создать**.

  1. Аналогично создайте группу бэкендов `canary-bg-staging`. Для бэкенда `canary-backend-blue` установите вес `0`, для `canary-backend-green` — `100`.
  
  Если вы будете выполнять следующие шаги с помощью Terraform, скопируйте идентификаторы групп бэкендов `canary-bg-production` и `canary-bg-staging` со вкладки ![image](../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов**.

- API {#api}

  Используйте вызов gRPC API [BackendGroupService/Create](../../application-load-balancer/api-ref/grpc/BackendGroup/create.md) или метод REST API [create](../../application-load-balancer/api-ref/BackendGroup/create.md).

{% endlist %} 

## Создайте HTTP-роутер и виртуальные хосты {#create-route-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **HTTP-роутеры**.
  1. Справа сверху нажмите кнопку **Создать HTTP-роутер**.
  1. В поле **Имя** укажите `canary-router`.
  1. Создайте виртуальный хост `canary-vh-production`:

     1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
     1. В поле **Имя** укажите `canary-vh-production`.
     1. В поле **Authority** укажите `cdn.yandexcloud.example`.
     1. Нажмите кнопку **Добавить маршрут**.
     1. В поле **Имя** укажите `canary-route-production`.
     1. В поле **Путь** выберите `Начинается с` и укажите путь `/`.
     1. В списке **Методы HTTP** выберите `GET`.
     1. В поле **Действие** оставьте `Маршрутизация`.
     1. В списке **Группа бэкендов** выберите `canary-bg-production`.

  1. Создайте виртуальный хост `canary-vh-staging`:

     * **Имя** — `canary-vh-production`.
     * **Authority** — `cdn-staging.yandexcloud.example`.
     * **Имя** маршрута — `canary-route-staging`.
     * **Группа бэкендов** — `canary-bg-staging`.
     * Остальные параметры — как у `canary-vh-production`.

  1. Нажмите кнопку **Создать**.

- Yandex Cloud CLI {#cli}

  1. Создайте HTTP-роутер `canary-router`:

     ```bash
     yc alb http-router create canary-router
     ```

     Результат:

     ```
     id: ds7qd0vj01dj********
     name: canary-router
     folder_id: b1g9hv2loamq********
     created_at: "2021-11-03T10:31:41.027649223Z"
     ```

     Подробнее о команде `yc alb http-router create` сомтрите в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/http-router/create.md).

  1. Создайте виртуальный хост `canary-vh-production`:

     ```bash
     yc alb virtual-host create canary-vh-production \
       --http-router-name canary-router \
       --authority cdn.yandexcloud.example
     ```

     Результат:

     ```
     done (1s)
     name: canary-vh-production
     authority:
     - cdn.yandexcloud.example
     ```

     Подробнее о команде `yc alb virtual-host create` смотрите в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).

  1. Создайте маршрут `canary-route-production` в виртуальном хосте `canary-vh-production`:

     ```bash
     yc alb virtual-host append-http-route canary-route-production \
       --http-router-name canary-router \
       --virtual-host-name canary-vh-production \
       --prefix-path-match "/" \
       --backend-group-name canary-bg-production
     ```

     Результат:

     ```
     done (1s)
     name: canary-vh-production
     authority:
     - cdn.yandexcloud.example
     routes:
     - name: canary-route-production
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: ds7pbm5fj2v0********
     ```

     Подробнее о команде `yc alb virtual-host append-http-route` смотрите в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

  1. Создайте виртуальный хост `canary-vh-staging`:

     ```bash
     yc alb virtual-host create canary-vh-staging \
       --http-router-name canary-router \
       --authority cdn-staging.yandexcloud.example
     ```

     Результат:

     ```
     done (1s)
     name: canary-vh-staging
     authority:
     - cdn-staging.yandexcloud.example
     ```

  1. Создайте маршрут `canary-route-staging` в виртуальном хосте `canary-vh-staging`:

     ```bash
     yc alb virtual-host append-http-route canary-route-staging \
       --http-router-name canary-router \
       --virtual-host-name canary-vh-staging \
       --prefix-path-match "/" \
       --backend-group-name canary-bg-staging
     ```

     Результат:

     ```
     done (1s)
     name: canary-vh-staging
     authority:
     - cdn-staging.yandexcloud.example
     routes:
     - name: canary-route-staging
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: ds765atleota********
     ```

- Terraform {#tf}

  1. Добавьте в конфигурационный файл параметры HTTP-роутера `canary-router`, его виртуальных хостов и маршрутов:

     ```hcl
     ...

     resource "yandex_alb_http_router" "canary-router" {
       name = "canary-router"
     }

     resource "yandex_alb_virtual_host" "canary-vh-production" {
       name           = "canary-vh-production"
       http_router_id = ${yandex_alb_http_router.canary-router.id}
       authority      = "cdn.yandexcloud.example"

       route {
         name = "canary-route-production"
         http_route {
           http_route_action {
             backend_group_id = "<идентификатор_группы_бэкендов_canary-bg-production>"
           }
         }
       }  
     }

     resource "yandex_alb_virtual_host" "canary-vh-staging" {
       name           = "canary-vh-staging"
       http_router_id = ${yandex_alb_http_router.canary-router.id}
       authority      = "cdn-staging.yandexcloud.example"

       route {
         name = "canary-route-staging"
         http_route {
           http_route_action {
             backend_group_id = "<идентификатор_группы_бэкендов_canary-bg-staging>"
           }
         }
       }  
     }
     ```

     Подробнее в описаниях ресурсов [yandex_alb_http_router](../../terraform/resources/alb_http_router.md) и [yandex_alb_virtual_host](../../terraform/resources/alb_virtual_host.md) в документации провайдера Terraform.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API {#api}

  1. Создайте HTTP-роутер `canary-router` с помощью вызова gRPC API [HttpRouterService/Create](../../application-load-balancer/api-ref/grpc/HttpRouter/create.md) или метода REST API [create](../../application-load-balancer/api-ref/HttpRouter/create.md).
  1. Создайте виртуальные хосты `canary-vh-production` и `canary-vh-staging`, привязанные к роутеру, и их маршруты с помощью вызова gRPC API [VirtualHostService/Create](../../application-load-balancer/api-ref/grpc/VirtualHost/create.md) или метода REST API [create](../../application-load-balancer/api-ref/VirtualHost/create.md).

{% endlist %}

## Создайте L7-балансировщик {#create-balancer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Application Load Balancer**.
  1. Справа сверху нажмите кнопку **Создать L7-балансировщик**.
  1. В поле **Имя** укажите `canary-balancer`.
  1. В блоке **Сетевые настройки**:

     1. В поле **Сеть** выберите `canary-network`.
     1. В поле **Группы безопасности** выберите `canary-sg`. Если этого поля нет, для балансировщика будет разрешен любой входящий и исходящий трафик.

  1. В блоке **Размещение** выберите три подсети для узлов балансировщика — `canary-subnet-ru-central1-a`, `canary-subnet-ru-central1-b` и `canary-subnet-ru-central1-d` — и включите передачу трафика в эти подсети.
  1. В блоке **Обработчики** нажмите **Добавить обработчик** и задайте настройки обработчика:

     1. В поле **Имя** укажите `canary-listener`.
     1. В блоке **Публичный IP-адрес**:
        * В поле **Порт** укажите `80`.
        * В поле **Тип** выберите `Автоматически`.

     1. В поле **HTTP-роутер** выберите `canary-router`.
  1. Нажмите кнопку **Создать**.

- Yandex Cloud CLI {#cli}

  1. Получите идентификаторы подсетей сети `canary-network`:

     ```bash
     yc vpc network list-subnets canary-network
     ```

     Результат:

     ```
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     |          ID          |            NAME             |      FOLDER ID       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |     RANGE     |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     | e9bnnssj8sc8******** | canary-subnet-ru-central1-d | b1g9hv2loamq******** | enptrcle5q3d******** |                | ru-central1-d | [10.1.0.0/16] |
     | e2lghukd9iqo******** | canary-subnet-ru-central1-b | b1g9hv2loamq******** | enptrcle5q3d******** |                | ru-central1-b | [10.2.0.0/16] |
     | b0c3pte4o2kn******** | canary-subnet-ru-central1-a | b1g9hv2loamq******** | enptrcle5q3d******** |                | ru-central1-a | [10.3.0.0/16] |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     ```

     Подробнее о команде `yc vpc network list-subnets` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/list-subnets.md).

  1. Получите идентификатор группы безопасности `canary-sg`:

     ```bash
     yc vpc security-group get canary-sg | grep "^id"
     ```

     Результат:

     ```
     id: enpd133ngcnr********
     ```

     Подробнее о команде `yc vpc security-group get` смотрите в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/security-group/get.md).

  1. Создайте балансировщик `canary-balancer`:

     ```bash
     yc alb load-balancer create canary-balancer \
       --network-name canary-network \
       --security-group-id <идентификатор_группы_безопасности_canary-sg> \
       --location zone=ru-central1-a,subnet-id=<идентификатор_подсети_canary-subnet-ru-central1-a> \
       --location zone=ru-central1-b,subnet-id=<идентификатор_подсети_canary-subnet-ru-central1-b> \
       --location zone=ru-central1-d,subnet-id=<идентификатор_подсети_canary-subnet-ru-central1-d>
     ```

     Результат:

     ```
     done (3m0s)
     id: ds77q7v39b4u********
     name: canary-balancer
     folder_id: b1g9hv2loamq********
     status: ACTIVE
     region_id: ru-central1
     network_id: enptrcle5q3d********
     allocation_policy:
       locations:
       - zone_id: ru-central1-d
         subnet_id: b0c3pte4o2kn********
       - zone_id: ru-central1-b
         subnet_id: e2lghukd9iqo********
       - zone_id: ru-central1-a
         subnet_id: e9bnnssj8sc8********
     log_group_id: ckg23vr4dlks********
     security_group_ids:
     - enpd133ngcnr********
     created_at: "2021-11-03T10:55:49.134935148Z"
     ```

     Подробнее о команде `yc alb load-balancer create` смотрите в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/create.md).

  1. Добавьте к балансировщику обработчик:

     ```bash
     yc alb load-balancer add-listener \
       --name canary-balancer \
       --listener-name canary-listener \
       --external-ipv4-endpoint port=80 \
       --http-router-name canary-router
     ```

     Результат:

     ```
     done (43s)
     id: ds77q7v39b4u********
     name: canary-balancer
     folder_id: b1g9hv2loamq********
     status: ACTIVE
     region_id: ru-central1
     network_id: enptrcle5q3d********
     listeners:
     - name: canary-listener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 84.252.133.149
         ports:
         - "80"
       http:
         handler:
           http_router_id: ds7qd0vj01dj********
     allocation_policy:
       locations:
       - zone_id: ru-central1-d
         subnet_id: b0c3pte4o2kn********
       - zone_id: ru-central1-b
         subnet_id: e2lghukd9iqo********
       - zone_id: ru-central1-a
         subnet_id: e9bnnssj8sc8********
     log_group_id: ckg23vr4dlks********
     security_group_ids:
     - enpd133ngcnr********
     created_at: "2021-11-03T10:55:49.134935148Z"
     ```

     Подробнее о команде `yc alb load-balancer add-listener` смотрите в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/add-listener.md).

- Terraform {#tf}

  1. Добавьте в конфигурационный файл параметры L7-балансировщика `canary-balancer`:

     ```hcl
     ...

     resource "yandex_alb_load_balancer" "canary-balancer" {
       name               = "canary-balancer"
       network_id         = ${yandex_vpc_network.canary-network.id}
       security_group_ids = [ ${yandex_vpc_security_group.canary-sg.id} ]

       allocation_policy {
         location {
           zone_id   = "ru-central1-a"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-ru-central1-a.id}
         }

         location {
           zone_id   = "ru-central1-b"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-ru-central1-b.id}
         }

         location {
           zone_id   = "ru-central1-d"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-ru-central1-d.id}
         }
       }

       listener {
         name = "canary-listener"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [80]
         }
         http {
           handler {
             http_router_id = ${yandex_alb_http_router.canary-router.id}
           }
         }
       }
     }
     ```

     Подробнее о ресурсе `yandex_alb_load_balancer` смотрите в [документации](../../terraform/resources/alb_load_balancer.md) провайдера Terraform.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API {#api}

  Используйте вызов gRPC API [LoadBalancerService/Create](../../application-load-balancer/api-ref/grpc/LoadBalancer/create.md) или метод REST API [create](../../application-load-balancer/api-ref/LoadBalancer/create.md).

{% endlist %}

## Создайте CDN-ресурс {#create-cdn-resource}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Cloud CDN**.
  1. Нажмите кнопку **Создать ресурс**.
  1. Задайте основные настройки CDN-ресурса:
      * В блоке **Контент**:
        * Включите **Доступ к контенту**.
        * В поле **Запрос контента** выберите `Из одного источника`.
        * В поле **Тип источника** выберите `L7-балансировщик`.
        * В поле **L7-балансировщик** выберите `canary-balancer`.
        * В поле **IP-адрес** выберите IP-адрес, назначенный балансировщику (будет единственным в списке).
        * В поле **Протокол для источников** выберите `HTTP`.
        * В поле **Доменное имя** укажите `cdn.yandexcloud.example`.
        * Нажмите кнопку **Добавить доменное имя** и укажите `cdn-staging.yandexcloud.example`.

          {% note alert %}

          Первое доменное имя, `cdn.yandexcloud.example`, станет основным, и его будет невозможно изменить после создания CDN-ресурса.

          {% endnote %}

      * В блоке **Дополнительно**:
        * В поле **Переадресация клиентов** выберите `С HTTP на HTTPS`.
        * В поле **Тип сертификата** укажите `Сертификат из Certificate Manager` и выберите [сертификат](#add-certificate) для доменных имен `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example`.
        * В поле **Заголовок Host** выберите `Как у клиента`.
  1. Нажмите **Продолжить**.
  1. В разделе **Кеширование** в блоке **CDN** включите опцию **Кеширование в CDN**.
  1. Нажмите **Продолжить**.
  1. В разделах **HTTP-заголовки и методы** и **Дополнительно** оставьте настройки по умолчанию и нажмите **Продолжить**.

- Yandex Cloud CLI {#cli}

  1. Создайте группу источников `canary-origin-group`, указав IP-адрес балансировщика:
      
      ```bash
      yc cdn origin-group create --name "canary-origin-group" \
        --origin source=<IP-адрес_балансировщика>:80,enabled=true
      ```

      Результат:
      
      ```
      id: "90748"
      folder_id: b1geoelk7fld********
      name: canary-origin-group
      use_next: true
      origins:
      - id: "562449"
        origin_group_id: "90748"
        source: 51.250.10.216:80
        enabled: true
      ```

      Подробнее о команде `yc cdn origin-group create` смотрите в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/origin-group/create.md).


  1. Скопируйте идентификатор группы источников `origin_group_id` из предыдущего шага и создайте CDN-ресурс, выполнив команду:

      ```bash
      yc cdn resource create \
        --cname cdn.yandexcloud.example \
        --origin-group-id <идентификатор_группы_источников> \
        --secondary-hostnames cdn-staging.yandexcloud.example \
        --origin-protocol http \
        --cert-manager-ssl-cert-id <идентификатор_сертификата> \
        --forward-host-header
      ```

      Результат:
      
      ```
      id: bc843k2yinvq********
      folder_id: b1ge1elk72ld********
      cname: cdn.yandexcloud.example
      ...
      active: true
      ...
      ...
      secondary_hostnames:
      - cdn-staging.yandexcloud.example
      ...
      ```

      Подробнее о команде `yc cdn resource create` смотрите в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/resource/create.md).

  1. Включите переадресацию клиентов для ресурса:

     ```bash
     yc cdn resource update <идентификатор_ресурса> --redirect-http-to-https
     ```

- Terraform {#tf}

  1. Добавьте в конфигурационный файл параметры CDN-ресурсов:
      
      ```hcl
      ...

      resource "yandex_cdn_origin_group" "my_group" {
        name     = "canary-origin-group"
        use_next = true
        origin {
         source = "<IP-адрес_балансировщика>:80"
         backup = false
        }
      }

      resource "yandex_cdn_resource" "my_resource" {

          cname               = "cdn.yandexcloud.example"
          active              = true
          origin_protocol     = "http"
          secondary_hostnames = ["cdn-staging.yandexcloud.example"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
          ssl_certificate {
            type                   = "certificate_manager"
            certificate_manager_id = "<идентификатор_сертификата>"
          }
          options {
              edge_cache_settings    = "345600"
              browser_cache_settings = "1800"
              ignore_cookie          = true
              ignore_query_params    = false
          }

      }
      ```

      Подробнее в описаниях ресурсов [yandex_cdn_origin_group](../../terraform/resources/cdn_origin_group.md) и [yandex_cdn_resource](../../terraform/resources/cdn_resource.md) в документации провайдера Terraform.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

  1. Включите переадресацию клиентов для ресурса. Добавьте в начало блока `options` для CDN-ресурса следующее поле:

      ```hcl
      ...
      options {
        redirect_https_to_http = true
      ...
      ```

  1. Выполните проверку с помощью команды:

      ```bash
      terraform plan
      ```

     Если конфигурация описана верно, в терминале отобразится список обновляемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  
  1. Если ошибок нет, выполните команду:

      ```bash
      terraform apply
      ```

  1. Подтвердите обновление ресурса: введите в терминал слово `yes` и нажмите **Enter**.
      
  После этого для ресурса будет включена переадресация.

- API {#api}

  Используйте вызов gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md) или метод REST API [create](../../cdn/api-ref/Resource/create.md).

{% endlist %}

## Настройте DNS для сервиса {#configure-dns}

Доменные имена `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example` должны быть связаны с CDN-ресурсом с помощью записей [DNS](../../glossary/dns.md).

Чтобы настроить DNS:

1. Получите доменное имя CDN-балансировщика:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. В списке CDN-ресурсов выберите ресурс с основным доменным именем `cdn.yandexcloud.example`.
     1. Из блока **Настройки DNS** внизу страницы скопируйте доменное имя вида `e1b83ae3********.topology.gslb.yccdn.ru`.

   {% endlist %}

1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
1. Создайте или измените CNAME-записи для `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example` таким образом, чтобы они указывали на скопированное доменное имя:

   ```
   cdn CNAME e1b83ae3********.topology.gslb.yccdn.ru
   cdn-staging CNAME e1b83ae3********.topology.gslb.yccdn.ru
   ```

   {% note info %}
   
   Не используйте ресурсную запись [ANAME](../../dns/concepts/resource-record.md#aname) с доменными именами для раздачи контента, поскольку в таком случае конечный пользователь получит ответ от CDN-сервера, не связанного с геолокацией пользователя. Ответ всегда будет одинаков для всех пользователей.
   
   {% endnote %} 

   Если вы пользуетесь Cloud DNS, настройте запись по следующей инструкции:

   {% cut "Инструкция по настройке DNS-записей для Cloud DNS" %}

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. Откройте [консоль управления](https://console.yandex.cloud).
     1. Перейдите в сервис **Cloud DNS**.
     1. Если у вас нет публичной зоны DNS, создайте ее:

        1. Нажмите кнопку **Создать зону**.
        1. В поле **Зона** укажите доменное имя сайта с точкой в конце: `yandexcloud.example.`
        1. В поле **Тип** выберите `Публичная`.
        1. В поле **Имя** укажите `canary-dns-zone`.
        1. Нажмите кнопку **Создать**.

     1. Создайте в зоне CNAME-запись для `cdn.yandexcloud.example`:

        1. Выберите зону `canary-dns-zone`.
        1. Нажмите кнопку **Создать запись**.
        1. В поле **Имя** укажите `cdn`.
        1. В поле **Тип** укажите `CNAME`.
        1. В поле **Значение** вставьте скопированное значение вида `e1b83ae3********.topology.gslb.yccdn.ru`.
        1. Нажмите кнопку **Создать**.

     1. Аналогично создайте в той же зоне CNAME-запись для `cdn-staging.yandexcloud.example`. В поле **Имя** укажите `cdn-staging`.

   - Yandex Cloud CLI {#cli}

     1. Если у вас нет публичной зоны DNS, создайте ее:

        ```bash
        yc dns zone create \
          --name canary-dns-zone \
          --zone yandexcloud.example. \
          --public-visibility
        ```

        Результат:

        ```
        id: dns4rq4taddd********
        folder_id: b1g9hv2loamq********
        created_at: "2021-11-03T11:03:28.847Z"
        name: canary-dns-zone
        zone: yandexcloud.example.
        public_visibility: {}
        ```

        Подробнее о команде `yc dns zone create` смотрите в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/create.md).

     1. Создайте в зоне CNAME-записи для `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example` со скопированным значением вида `e1b83ae3********.topology.gslb.yccdn.ru`:

        ```bash
        yc dns zone add-records \
          --name canary-dns-zone \
          --record "cdn CNAME e1b83ae3********.topology.gslb.yccdn.ru" \
          --record "cdn-staging CNAME e1b83ae3********.topology.gslb.yccdn.ru"
        ```

        Подробнее о команде `yc dns zone add-records` смотрите в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

   - Terraform {#tf}

     1. Добавьте в конфигурационный файл параметры DNS-зоны `canary-dns-zone` и CNAME-записей в ней:

        ```
        ...

        resource "yandex_dns_zone" "canary-dns-zone" {
          zone   = "yandexcloud.example."
          name   = "canary-dns-zone"
          public = true
        }

        resource "yandex_dns_recordset" "canary-recordset-production" {
          zone_id = ${yandex_dns_zone.canary-dns-zone.id}
          name    = "cdn"
          type    = "CNAME"
          data    = ["<скопированное_значение_вида_e1b83ae3********.topology.gslb.yccdn.ru>"]
        }

        resource "yandex_dns_recordset" "canary-recordset-staging" {
          zone_id = ${yandex_dns_zone.canary-dns-zone.id}
          name    = "cdn-staging"
          type    = "CNAME"
          data    = ["<скопированное_значение_вида_e1b83ae3********.topology.gslb.yccdn.ru"]
        }
        ```

        Подробнее в описаниях ресурсов [yandex_dns_zone](../../terraform/resources/dns_zone.md) и [yandex_dns_recordset](../../terraform/resources/dns_recordset.md) в документации провайдера Terraform.

     1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

           ```bash
           terraform plan
           ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

     1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

           ```bash
           terraform apply
           ```

        1. Подтвердите создание ресурсов.

   - API {#api}

     1. Создайте DNS-зону `canary-dns-zone` с помощью вызова gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md) или метода REST API [create](../../dns/api-ref/DnsZone/create.md).
     1. Добавьте в зону CNAME-записи `cdn` и `cdn-staging` со скопированным значением вида `e1b83ae3********.topology.gslb.yccdn.ru` с помощью вызова gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md) или метода REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md).

   {% endlist %}

   {% endcut %}

На обновление записей на DNS-серверах может потребоваться несколько часов. После этого вы сможете проверить работу сервиса.

## Проверьте работу сервиса и переключение между версиями {#check}

### Первая проверка {#check-one}

Проверьте, что доменному имени `cdn.yandexcloud.example` соответствует версия 1, а `cdn-staging.yandexcloud.example` — версия 2:

1. Откройте в браузере адрес `https://cdn.yandexcloud.example/index.html`. Вы должны увидеть страницу с указанием на версию 1.
1. Удалите из кеша CDN-ресурса файл `index.html`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Контент**.
     1. Нажмите кнопку **Очистить кеш**.
     1. В поле **Тип очистки** выберите `Выборочная`.
     1. Укажите путь к загруженному файлу: `/index.html`.
     1. Нажмите кнопку **Очистить кеш**.

   - Yandex Cloud CLI {#cli}

     1. Получите идентификатор созданного CDN-ресурса:

        ```bash
        yc cdn resource list
        ```

        Результат:

        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkh******** | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
        |                      |                          | nanos:434085000                | nanos:434115000                |        | default_value:345600}                     |
        |                      |                          |                                |                                |        | cache_http_headers:{value:"accept-ranges" |
        |                      |                          |                                |                                |        | value:"cache-control" value:"connection"  |
        |                      |                          |                                |                                |        | value:"content-encoding"                  |
        |                      |                          |                                |                                |        | value:"content-length"                    |
        |                      |                          |                                |                                |        | value:"content-type"                      |
        |                      |                          |                                |                                |        | value:"date" value:"etag"                 |
        |                      |                          |                                |                                |        | value:"expires" value:"keep-alive"        |
        |                      |                          |                                |                                |        | value:"last-modified" value:"server"      |
        |                      |                          |                                |                                |        | value:"vary"} stale:{enabled:true         |
        |                      |                          |                                |                                |        | value:"error" value:"updating"}           |
        |                      |                          |                                |                                |        | allowed_http_methods:{value:"GET"         |
        |                      |                          |                                |                                |        | value:"POST" value:"HEAD"                 |
        |                      |                          |                                |                                |        | value:"OPTIONS"}                          |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        ```

        Подробнее о команде `yc cdn resource list` смотрите в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/resource/list.md).

     1. Удалите файл из кеша:

        ```bash
        yc cdn cache purge \
          --resource-id <идентификатор_CDN-ресурса> \
          --path "/index.html"
        ```

        Подробнее о команде `yc cdn cache purge` смотрите в [справочнике CLI](../../cli/cli-ref/cdn/cli-ref/cache/purge.md).

   - API {#api}

     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API [ResourceService/List](../../cdn/api-ref/grpc/Resource/list.md) или метода REST API [list](../../cdn/api-ref/Resource/list.md).
     1. Удалите файл `index.html` из кеша с помощью вызова gRPC API [CacheService/Purge](../../cdn/api-ref/grpc/Cache/purge.md) или метода [purge](../../cdn/api-ref/Cache/purge.md). 

   {% endlist %}

1. Откройте в браузере адрес `https://cdn-staging.yandexcloud.example/index.html`. Вы должны увидеть страницу с указанием на версию 2.

### Канареечное развертывание версии 2 {#canary-v2}

1. Отключите кеширование CDN-ресурса и удалите из кеша файл `index.html`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**.
     1. Нажмите кнопку **Редактировать**.
     1. Отключите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.

   - API {#api}

     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API [ResourceService/List](../../cdn/api-ref/grpc/Resource/list.md) или метода REST API [list](../../cdn/api-ref/Resource/list.md).
     1. Отключите кеширование с помощью вызова gRPC API [ResourceService/Update](../../cdn/api-ref/grpc/Resource/update.md) или метода REST API [list](../../cdn/api-ref/Resource/update.md). 

   {% endlist %}

1. Удалите из кеша файл `index.html`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Контент**.
     1. Нажмите кнопку **Очистить кеш**.
     1. В поле **Тип очистки** выберите `Выборочная`.
     1. Укажите путь к загруженному файлу: `/index.html`.
     1. Нажмите кнопку **Очистить кеш**.

   - Yandex Cloud CLI {#cli}

     1. Получите идентификатор созданного CDN-ресурса:

        ```bash
        yc cdn resource list
        ```

        Результат:

        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkh******** | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
        |                      |                          | nanos:434085000                | nanos:434115000                |        | default_value:345600}                     |
        |                      |                          |                                |                                |        | cache_http_headers:{value:"accept-ranges" |
        |                      |                          |                                |                                |        | value:"cache-control" value:"connection"  |
        |                      |                          |                                |                                |        | value:"content-encoding"                  |
        |                      |                          |                                |                                |        | value:"content-length"                    |
        |                      |                          |                                |                                |        | value:"content-type"                      |
        |                      |                          |                                |                                |        | value:"date" value:"etag"                 |
        |                      |                          |                                |                                |        | value:"expires" value:"keep-alive"        |
        |                      |                          |                                |                                |        | value:"last-modified" value:"server"      |
        |                      |                          |                                |                                |        | value:"vary"} stale:{enabled:true         |
        |                      |                          |                                |                                |        | value:"error" value:"updating"}           |
        |                      |                          |                                |                                |        | allowed_http_methods:{value:"GET"         |
        |                      |                          |                                |                                |        | value:"POST" value:"HEAD"                 |
        |                      |                          |                                |                                |        | value:"OPTIONS"}                          |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        ```

     1. Удалите файл из кеша:

        ```bash
        yc cdn cache purge \
          --resource-id <идентификатор_CDN-ресурса> \
          --path "/index.html"
        ```

   - API {#api}

     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API [ResourceService/List](../../cdn/api-ref/grpc/Resource/list.md) или метода REST API [list](../../cdn/api-ref/Resource/list.md).
     1. Удалите файл `index.html` из кеша с помощью вызова gRPC API [CacheService/Purge](../../cdn/api-ref/grpc/Cache/purge.md) или метода [purge](../../cdn/api-ref/Cache/purge.md). 

   {% endlist %}

1. Настройте группу бэкендов `canary-bg-production` так, чтобы 20% трафика доменного имени `cdn.yandexcloud.example` приходилось на бэкенд `canary-backend-green` с версией 2:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Application Load Balancer**.
     1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов**.
     1. Выберите `canary-bg-production`.
     1. Для бэкенда `canary-backend-blue` установите вес 80 вместо 100:

        1. В блоке **Бэкенды** найдите бэкенд `canary-backend-blue`, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
        1. В поле **Вес** укажите `80`.
        1. Нажмите **Сохранить**.

     1. Аналогично для бэкенда `canary-backend-green` установите вес 20 вместо 0.
     1. Нажмите кнопку **Сохранить**.

   - Yandex Cloud CLI {#cli}

     1. Для бэкенда `canary-backend-blue` установите вес 80 вместо 100:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-blue \
          --weight 80
        ```

        Результат:

        ```
        done (1s)
        id: ds7l9puc18c9********
        name: canary-bg-production
        folder_id: b1g9hv2loamq********
        http:
          backends:
          - name: canary-backend-blue
            backend_weight: "80"
            storage_bucket:
              bucket: <имя_синего_бакета>
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

        Подробнее о команде `yc alb backend-group update-http-backend` смотрите в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/backend-group/update-http-backend.md).

     1. Для бэкенда `canary-backend-green` установите вес 20 вместо 0:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-green \
          --weight 20
        ```

        Результат:

        ```
        done (1s)
        id: ds7l9puc18c9********
        name: canary-bg-production
        folder_id: b1g9hv2loamq********
        http:
          backends:
          - name: canary-backend-green
            backend_weight: "20"
            storage_bucket:
              bucket: <имя_зеленого_бакета>
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

   - API {#api}

     Используйте вызов gRPC API [BackendGroupService/UpdateBackend](../../application-load-balancer/api-ref/grpc/BackendGroup/updateBackend.md) или метод REST API [updateBackend](../../application-load-balancer/api-ref/BackendGroup/updateBackend.md).

   {% endlist %}

1. Несколько раз откройте в браузере адрес `https://cdn.yandexcloud.example/index.html`. Примерно в 20% случаев вы должны увидеть страницу с указанием на версию 2, в остальных случаях — на версию 1.
1. Аналогично шагам 1–2 настройте и проверьте следующие распределения трафика между бэкендами:

   1. В группе бэкендов `canary-bg-production` — по 50% трафика на оба бэкенда.
   1. В группе бэкендов `canary-bg-production` — весь трафик на бэкенд `canary-backend-green`.
   1. В группе бэкендов `canary-bg-staging` (доменное имя `cdn-staging.yandexcloud.example`) — весь трафик на бэкенд `canary-backend-blue`.

1. Снова включите кеширование:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**.
     1. Нажмите кнопку **Редактировать**.
     1. Включите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.

   - API {#api}

     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API [ResourceService/List](../../cdn/api-ref/grpc/Resource/list.md) или метода REST API [list](../../cdn/api-ref/Resource/list.md).
     1. Включите кеширование с помощью вызова gRPC API [ResourceService/Update](../../cdn/api-ref/grpc/Resource/update.md) или метода REST API [list](../../cdn/api-ref/Resource/update.md).

   {% endlist %}

### Сине-зеленое развертывание для отката к версии 1 {#blue-green-v1-rollback}

1. Отключите кеширование CDN-ресурса и удалите из кеша файл `index.html`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**.
     1. Нажмите кнопку **Редактировать**.
     1. Отключите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.

   - API {#api}

     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API [ResourceService/List](../../cdn/api-ref/grpc/Resource/list.md) или метода REST API [list](../../cdn/api-ref/Resource/list.md).
     1. Отключите кеширование с помощью вызова gRPC API [ResourceService/Update](../../cdn/api-ref/grpc/Resource/update.md) или метода REST API [list](../../cdn/api-ref/Resource/update.md). 

   {% endlist %}

1. Удалите из кеша файл `index.html`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Контент**.
     1. Нажмите кнопку **Очистить кеш**.
     1. В поле **Тип очистки** выберите `Выборочная`.
     1. Укажите путь к загруженному файлу: `/index.html`.
     1. Нажмите кнопку **Очистить кеш**.

   - Yandex Cloud CLI {#cli}

     1. Получите идентификатор созданного CDN-ресурса:

        ```bash
        yc cdn resource list
        ```

        Результат:

        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkh******** | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
        |                      |                          | nanos:434085000                | nanos:434115000                |        | default_value:345600}                     |
        |                      |                          |                                |                                |        | cache_http_headers:{value:"accept-ranges" |
        |                      |                          |                                |                                |        | value:"cache-control" value:"connection"  |
        |                      |                          |                                |                                |        | value:"content-encoding"                  |
        |                      |                          |                                |                                |        | value:"content-length"                    |
        |                      |                          |                                |                                |        | value:"content-type"                      |
        |                      |                          |                                |                                |        | value:"date" value:"etag"                 |
        |                      |                          |                                |                                |        | value:"expires" value:"keep-alive"        |
        |                      |                          |                                |                                |        | value:"last-modified" value:"server"      |
        |                      |                          |                                |                                |        | value:"vary"} stale:{enabled:true         |
        |                      |                          |                                |                                |        | value:"error" value:"updating"}           |
        |                      |                          |                                |                                |        | allowed_http_methods:{value:"GET"         |
        |                      |                          |                                |                                |        | value:"POST" value:"HEAD"                 |
        |                      |                          |                                |                                |        | value:"OPTIONS"}                          |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        ```

     1. Удалите файл из кеша:

        ```bash
        yc cdn cache purge \
          --resource-id <идентификатор_CDN-ресурса> \
          --path "/index.html"
        ```

   - API {#api}

     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API [ResourceService/List](../../cdn/api-ref/grpc/Resource/list.md) или метода REST API [list](../../cdn/api-ref/Resource/list.md).
     1. Удалите файл `index.html` из кеша с помощью вызова gRPC API [CacheService/Purge](../../cdn/api-ref/grpc/Cache/purge.md) или метода [purge](../../cdn/api-ref/Cache/purge.md). 

   {% endlist %}

1. Перенаправьте весь трафик доменного имени `cdn.yandexcloud.example` обратно на бэкенд `canary-backend-blue` с версией 1:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Application Load Balancer**.
     1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов**.
     1. Выберите `canary-bg-production`.
     1. Для бэкенда `canary-backend-blue` установите вес 100 вместо 0:

        1. В блоке **Бэкенды** найдите бэкенд `canary-backend-blue`, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
        1. В поле **Вес** укажите `100`.
        1. Нажмите кнопку **Сохранить**.

     1. Аналогично для бэкенда `canary-backend-green` установите вес 0 вместо 100.
     1. Нажмите кнопку **Сохранить**.

   - Yandex Cloud CLI {#cli}

     1. Для бэкенда `canary-backend-blue` установите вес 100 вместо 0:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-blue \
          --weight 100
        ```

        Результат:

        ```
        done (1s)
        id: ds7l9puc18c9********
        name: canary-bg-production
        folder_id: b1g9hv2loamq********
        http:
          backends:
          - name: canary-backend-blue
            backend_weight: "100"
            storage_bucket:
              bucket: <имя_синего_бакета>
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

     1. Для бэкенда `canary-backend-green` установите вес 0 вместо 100:

        ```bash
        yc alb backend-group update-http-backend \
          --backend-group-name canary-bg-production \
          --name canary-backend-green \
          --weight 0
        ```

        Результат:

        ```
        done (1s)
        id: ds7l9puc18c9********
        name: canary-bg-production
        folder_id: b1g9hv2loamq********
        http:
          backends:
          - name: canary-backend-green
            backend_weight: "0"
            storage_bucket:
              bucket: <имя_зеленого_бакета>
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```

   - API {#api}

     Используйте вызов gRPC API [BackendGroupService/UpdateBackend](../../application-load-balancer/api-ref/grpc/BackendGroup/updateBackend.md) или метод REST API [updateBackend](../../application-load-balancer/api-ref/BackendGroup/updateBackend.md).   

   {% endlist %}

1. Несколько раз откройте в браузере адрес `https://cdn.yandexcloud.example/index.html`. Во всех случаях вы должны увидеть страницу с указанием на версию 1.
1. Аналогично шагам 1–2 переключите весь трафик доменного имени `cdn-staging.yandexcloud.example` на бэкенд `canary-backend-green` с версией 2 и проверьте переключение в браузере.
1. Снова включите кеширование:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
     1. Перейдите в сервис **Cloud CDN**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**.
     1. Нажмите кнопку **Редактировать**.
     1. Включите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.

   - API {#api}

     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API [ResourceService/List](../../cdn/api-ref/grpc/Resource/list.md) или метода REST API [list](../../cdn/api-ref/Resource/list.md).
     1. Включите кеширование с помощью вызова gRPC API [ResourceService/Update](../../cdn/api-ref/grpc/Resource/update.md) или метода REST API [list](../../cdn/api-ref/Resource/update.md).

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы настраивали CNAME-записи в Cloud DNS, [удалите](../../dns/operations/zone-delete.md) зону DNS `canary-dns-zone`.
1. [Удалите](../../cdn/operations/resources/delete-resource.md) CDN-ресурс с основным доменным именем `cdn.yandexcloud.example`.
1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `canary-balancer`.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из «синего» и «зеленого» бакетов.
1. [Удалите](../../storage/operations/buckets/delete.md) «синий» и «зеленый» бакеты.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсети `canary-subnet-ru-central1-a`, `canary-subnet-ru-central1-b` и `canary-subnet-ru-central1-d`.
1. [Удалите](../../vpc/operations/network-delete.md) сеть `canary-network`.