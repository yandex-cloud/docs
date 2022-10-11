# Организация сине-зеленого и канареечного развертывания версий веб-сервиса

Настройте архитектуру веб-сервиса, которая позволит переключаться между версиями по распространенным схемам развертывания: с помощью [сине-зеленого развертывания](https://martinfowler.com/bliki/BlueGreenDeployment.html) (blue-green deployment) и [канареечного развертывания](https://martinfowler.com/bliki/CanaryRelease.html) (canary deployment). 

Обе схемы используют пару бэкендов: «синий» и «зеленый». Сначала на одном из бэкендов (например, на «синем») размещается стабильная версия, доступная пользователям, а другой («зеленый») используется для тестирования следующей версии. Когда тестирование окончено, бэкенды меняются ролями: 

* При сине-зеленом развертывании весь пользовательский трафик одномоментно перераспределяется с одного бэкенда на другой.
* При канареечном развертывании переключение происходит постепенно, начиная с части пользователей.

После этого основным становится «зеленый» бэкенд, а на «синем» бэкенде можно тестировать следующую версию сервиса. Также, пока на «синем» бэкенде остается предыдущая версия, на нее можно откатить сервис, снова поменяв бэкенды ролями.

В данном руководстве в качестве бэкендов используются бакеты {{ objstorage-full-name }}, а за переключение между ними отвечает L7-балансировщик {{ alb-full-name }}. Запросы пользователей передаются балансировщику через сеть распространения контента {{ cdn-full-name }}, чтобы сократить время доставки контента.

В качестве примеров будут использованы доменные имена `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example`.

Для выполнения шагов можно использовать различные [поддерживаемые инструменты](#supported-tools).

Чтобы построить архитектуру для сине-зеленого и канареечного развертывания:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте бакеты в {{ objstorage-name }}](#create-buckets).
1. [Загрузите файлы сервиса в бакеты](#upload-files).
1. [Создайте группы бэкендов в {{ alb-name }}](#create-l7backend).
1. [Создайте HTTP-роутер и виртуальные хосты](#create-route-hosts).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Настройте DNS для сервиса](#configure-dns).
1. [Проверьте работу сервиса и переключение между версиями](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Поддерживаемые инструменты {#supported-tools}

Бо́льшую часть шагов можно выполнить с помощью любого из стандартных инструментов: [консоли управления]({{ link-console-main }}), интерфейсов командной строки (CLI) [{{ yandex-cloud }}](../../cli/) и [AWS](../../storage/tools/aws-cli.md), {{ TF }} и [API {{ yandex-cloud }}](../../api-design-guide). В каждом шаге перечислены поддерживаемые для него инструменты.

Некоторые инструменты поддерживаются не для всех шагов:

* Через CLI и {{ TF }} сейчас нельзя:
  * [создать группу бэкендов в {{ alb-name }} с бакетами в качестве бэкендов](#create-l7backend);
  * получить доменное имя CDN-балансировщика при [настройке DNS для сервиса](#configure-dns);
  * отключать и включать кеширование CDN-ресурса при [проверке работы сервиса и переключения между версиями](#check).
* Через API сейчас нельзя получить доменное имя CDN-балансировщика при [настройке DNS для сервиса](#configure-dns).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

В качестве примера будет использоваться каталог с именем `example-folder`.

{% if product == "yandex-cloud" and audience != "internal" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение данных в {{ objstorage-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика (см. {% if audience != "internal" %}[тарифы {{ alb-name }}](../../application-load-balancer/pricing.md){% else %}тарифы {{ alb-name }}{% endif %});
* плата за исходящий трафик с CDN-серверов (см. {% if audience != "internal" %}[тарифы {{ cdn-name }}](../../cdn/pricing.md){% else %}тарифы {{ cdn-name }}{% endif %});
* плата за публичные DNS-запросы и DNS-зоны, если вы используете {{ dns-full-name }} (см. {% if audience != "internal" %}[тарифы {{ dns-name }}](../../dns/pricing.md){% else %}тарифы {{ dns-name }}{% endif %}).

{% endif %}

## Создайте облачную сеть и подсети {#create-network}

Все ресурсы будут относиться к одной {% if audience != "internal" %}[облачной сети](../../vpc/concepts/network.md){% else %}облачной сети{% endif %}.

Чтобы создать сеть и подсети:

{% list tabs %}

- Консоль управления 

    1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
    1. В списке сервисов выберите **{{ vpc-name }}**.
    1. Нажмите кнопку **Создать сеть**.
    1. Укажите **Имя** сети: `canary-network`.
    1. В поле **Дополнительно** выберите опцию **Создать подсети**.
    1. Нажмите кнопку **Создать сеть**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сеть `canary-network`:
  
     ```bash
     yc vpc network create canary-network
     ```
     
     Результат:
       
     ```
     id: enptrcle5q3d3ktd33hj
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2021-11-03T09:25:03Z"
     name: canary-network
     default_security_group_id: enpbsnnop4akg7ng70ll
     ```
     
     Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).
     
  1. Создайте подсети во всех зонах доступности:
  
     * В `{{ region-id }}-a`:
     
       ```
       yc vpc subnet create canary-subnet-{{ region-id }}-a \
         --zone {{ region-id }}-a \
         --network-name canary-network \
         --range 10.1.0.0/16
       ```
     
       Результат:
      
       ``` 
       id: e9bnnssj8sc8mjhat9qk
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2021-11-03T09:27:00Z"
       name: canary-subnet-{{ region-id }}-a
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-a
       v4_cidr_blocks:
       - 10.1.0.0/16
       ```
     
     * В `{{ region-id }}-b`:
     
       ```
       yc vpc subnet create canary-subnet-{{ region-id }}-b \
         --zone {{ region-id }}-b \
         --network-name canary-network \
         --range 10.2.0.0/16
       ```
     
       Результат:
      
       ``` 
       id: e2lghukd9iqo4haidjbt
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2021-11-03T09:27:39Z"
       name: canary-subnet-{{ region-id }}-b
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-b
       v4_cidr_blocks:
       - 10.2.0.0/16
       ```
     
     * В `{{ region-id }}-c`:
     
       ```
       yc vpc subnet create canary-subnet-{{ region-id }}-c \
         --zone {{ region-id }}-c \
         --network-name canary-network \
         --range 10.3.0.0/16
       ```
     
       Результат:
      
       ``` 
       id: b0c3pte4o2kn4v12o05p
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2021-11-03T09:28:08Z"
       name: canary-subnet-{{ region-id }}-c
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-c
       v4_cidr_blocks:
       - 10.3.0.0/16
       ```
       
     Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

- {{ TF }}

  Если у вас ещё нет {{ TF }}, {% if audience != "internal" %}[установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его и настройте провайдер {{ yandex-cloud }}{% endif %}.
  
  1. Опишите в конфигурационном файле параметры сети `canary-network` и ее подсетей `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b` и `canary-subnet-{{ region-id }}-c`:
  
     ```
     resource "yandex_vpc_network" "canary-network" {
       name = "canary-network"
     }

     resource "yandex_vpc_subnet" "canary-subnet-a" {
       name           = "canary-subnet-{{ region-id }}-a"
       zone           = "{{ region-id }}-a"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }
     
     resource "yandex_vpc_subnet" "canary-subnet-b" {
       name           = "canary-subnet-{{ region-id }}-b"
       zone           = "{{ region-id }}-b"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.2.0.0/16"]
     }
     
     resource "yandex_vpc_subnet" "canary-subnet-c" {
       name           = "canary-subnet-{{ region-id }}-c"
       zone           = "{{ region-id }}-c"
       network_id     = "${yandex_vpc_network.canary-network.id}"
       v4_cidr_blocks = ["10.3.0.0/16"]
     }
     ```
     
     Подробнее см. в описаниях ресурсов [yandex_vpc_network]({{ tf-provider-link }}/vpc_network) и [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet) в документации провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API

  1. Создайте сеть `canary-network` с помощью вызова gRPC API {% if audience != "internal" %}[NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create){% else %}NetworkService/Create{% endif %} или метода REST API {% if audience != "internal" %}[create](../../vpc/api-ref/Network/create.md){% else %}create{% endif %}.
  1. Создайте подсети `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b` и `canary-subnet-{{ region-id }}-c` в трех зонах доступности с помощью вызова gRPC API {% if audience != "internal" %}[SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create){% else %}SubnetService/Create{% endif %} или метода REST API {% if audience != "internal" %}[create](../../vpc/api-ref/Subnet/create.md){% else %}create{% endif %}.

{% endlist %}

## Создайте бакеты в {{ objstorage-name }} {#create-buckets}

Создайте два бакета `canary-bucket-blue` и `canary-bucket-green`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ objstorage-name }}**.
  1. Создайте бакет `canary-bucket-blue`:
  
     1. Нажмите кнопку **Создать бакет**.
     1. Укажите **Имя** бакета: `canary-bucket-blue`.
     1. В полях **Доступ на чтение объектов** и **Доступ к списку объектов** выберите **Публичный**.
     1. Нажмите кнопку **Создать бакет**.
     
  1. Таким же образом создайте бакет `canary-bucket-green`.
  
- AWS CLI

  1. Создайте бакет `canary-bucket-blue`:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://canary-bucket-blue
     ```
     
     Результат:
     
     ```
     make_bucket: s3://canary-bucket-blue
     ```
     
  1. Включите публичный доступ к чтению объектов и их списка:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3api put-bucket-acl \
       --bucket canary-bucket-blue \
       --acl public-read
     ```
     
  1. Аналогично создайте бакет `canary-bucket-green` и включите публичный доступ к нему.

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры бакетов `canary-bucket-blue` и `canary-bucket-green`:
  
     ```
     ...
     
     resource "yandex_storage_bucket" "canary-bucket-blue" {
       bucket = "canary-bucket-blue"
       acl    = "public-read"
     }
     
     resource "yandex_storage_bucket" "canary-bucket-green" {
       bucket = "canary-bucket-green"
       acl    = "public-read"
     }
     ```
     
     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации]({{ tf-provider-link }}/storage_bucket) провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API

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

   {% list tabs %}
   
   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ objstorage-name }}**.
     1. В списке бакетов выберите `canary-bucket-blue`.
     1. Нажмите кнопку **Загрузить** и выберите для загрузки файл `index.html` версии 1.
     1. Таким же образом загрузите в бакет `canary-bucket-green` файл `index.html` версии 2.
     
   - AWS CLI
   
     1. Загрузите в бакет `canary-bucket-blue` файл `index.html` версии 1:
     
        ```bash
        aws --endpoint-url https://{{ s3-storage-host }} \
          s3 cp v1/index.html s3://canary-bucket-blue/index.html
        ```
        
        Результат:
        
        ```
        upload: v1/index.html to s3://canary-bucket-blue/index.html
        ```
        
     1. Загрузите в бакет `canary-bucket-green` файл `index.html` версии 2:
     
        ```bash
        aws --endpoint-url https://{{ s3-storage-host }} \
          s3 cp v2/index.html s3://canary-bucket-green/index.html
        ```
        
        Результат:
        
        ```
        upload: v2/index.html to s3://canary-bucket-green/index.html
        ```

   - {{ TF }}
   
     1. Добавьте в конфигурационный файл параметры файлов `v1/index.html` и `v2/index.html`, загружаемых в бакеты `canary-bucket-blue` и `canary-bucket-green` соответственно:
     
        ```
        ...
        
        resource "yandex_storage_object" "canary-bucket-blue-index" {
          bucket = "canary-bucket-blue"
          key    = "index.html"
          source = "v1/index.html"
        }
        
        resource "yandex_storage_bucket" "canary-bucket-green-index" {
          bucket = "canary-bucket-green"
          key    = "index.html"
          source = "v2/index.html"
        }
        ```
        
        Подробнее о ресурсе `yandex_storage_object` см. в [документации]({{ tf-provider-link }}/storage_object) провайдера {{ TF }}.
        
     1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:
   
           ```bash
           terraform plan
           ```
   
        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
   
     1. Разверните облачные ресурсы.
     
        1. Если в конфигурации нет ошибок, выполните команду:
   
           ```bash
           terraform apply
           ```
   
        1. Подтвердите создание ресурсов.

   - API
   
     Используйте метод REST API [upload](../../storage/s3/api-ref/object/upload.md).

   {% endlist %}

## Создайте группу безопасности {#create-security-group}

{% include [security-groups-note](../../application-load-balancer/_includes_service/security-groups-note.md) %}

{% if audience != "internal" %}[Группы безопасности](../../vpc/concepts/security-groups.md){% else %}Группы безопасности{% endif %} содержат правила, которые разрешают L7-балансировщику получать входящий трафик и отправлять его на бакеты-бэкенды.

Чтобы создать группы безопасности:

{% list tabs %}

- Консоль управления 

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Перейдите на вкладку **Группы безопасности**.
  1. Нажмите кнопку **Создать группу**.
  1. Укажите **Имя** группы: `canary-sg`.
  1. Выберите **Сеть** `canary-network`.
  1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:
   
     | Направление<br/>трафика | Описание | Диапазон<br/>портов | Протокол | Тип источника /<br/>назначения | Источник /<br/>назначение |
     | --- | --- | --- | --- | --- | --- |
     | Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0 |
     | Входящий | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
     | Входящий | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
     | Входящий | healthchecks | 30080 | TCP | CIDR | 198.18.235.0/24<br/>198.18.248.0/24 |
      
     1. Перейдите на вкладку **Исходящий трафик** или **Входящий трафик**.
     1. Нажмите кнопку **Добавить правило**.
     1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
     1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
     1. В поле **Назначение** или **Источник** выберите назначение правила:
      
        * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
        * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
         
     1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
   
  1. Нажмите кнопку **Сохранить**.

- CLI

  Выполните следующую команду:

  ```bash
  yc vpc security-group create canary-sg \
    --network-name canary-network \
    --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=30080,protocol=tcp,v4-cidrs=[198.18.235.0/24,198.18.248.0/24]
  ```
  
  Результат:
  
  ```
  id: enpd133ngcnrgc8475cc
  folder_id: b1g9hv2loamqfnbul7d9
  created_at: "2021-11-03T10:26:16Z"
  name: canary-sg
  network_id: enptrcle5q3d3ktd33hj
  status: ACTIVE
  rules:
  - id: enpkgrpi2gsibdm6aotd
    direction: EGRESS
    protocol_name: ANY
    protocol_number: "-1"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpgssij0i168jknb85r
    direction: INGRESS
    ports:
      from_port: "80"
      to_port: "80"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enp0bft67j9lrlnhdur5
    direction: INGRESS
    ports:
      from_port: "443"
      to_port: "443"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 0.0.0.0/0
  - id: enpmorcimu65fk4oaanm
    direction: INGRESS
    ports:
      from_port: "30080"
      to_port: "30080"
    protocol_name: TCP
    protocol_number: "6"
    cidr_blocks:
      v4_cidr_blocks:
      - 198.18.235.0/24
      - 198.18.248.0/24
  ```

  Подробнее о команде `yc vpc security-group create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры группы безопасности `canary-sg`:
  
     ```
     resource "yandex_vpc_security_group" "canary-sg" {
       name       = "canary-sg"
       network_id = "${yandex_vpc_network.canary-network.id}"
     
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
         protocol       = "TCP"
         port           = 30080
         v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
       }
     }
     ```
     
     Подробнее о ресурсе `yandex_vpc_security_group` см. в [документации]({{ tf-provider-link }}/vpc_security_group) провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API

  Используйте вызов gRPC API {% if audience != "internal" %}[SecurityGroupService/Create](../../vpc/api-ref/grpc/security_group_service.md#Create){% else %}SecurityGroupService/Create{% endif %} или метод REST API {% if audience != "internal" %}[create](../../vpc/api-ref/SecurityGroup/create.md){% else %}create{% endif %}.
     
{% endlist %}

## Создайте группы бэкендов в {{ alb-name }} {#create-l7backend}

{% list tabs %}
   
- Консоль управления
   
  1. Создайте группу бэкендов `canary-bg-production` с бэкендами `canary-backend-blue` и `canary-backend-green`:
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **Группы бэкендов**.
     1. Нажмите кнопку **Создать группу бэкендов**.
     1. Введите имя группы бэкендов: `canary-bg-production`.
     1. В блоке **Бэкенды** нажмите кнопку **Добавить**. Задайте настройки бэкенда:
         1. Введите имя бэкенда: `canary-backend-blue`.
         1. Задайте вес бэкенда: `100`.
         1. Выберите тип бэкенда **Бакет**.
         1. В поле **Бакет** укажите название бакета: `canary-bucket-blue`.
     1. Нажмите кнопку **Добавить** и аналогично задайте настройки бэкенда `canary-backend-green` с весом `0` и бакетом `canary-bucket-green`.
     1. Нажмите кнопку **Создать**.

  1. Аналогично создайте группу бэкендов `canary-bg-staging`. Для бэкенда `canary-backend-blue` установите вес `0`, для `canary-backend-green` — `100`.
  1. Если вы будете выполнять следующие шаги с помощью {{ TF }}, скопируйте идентификаторы групп бэкендов `canary-bg-production` и `canary-bg-staging` со вкладки **Группы бэкендов**.

- API

  Используйте вызов gRPC API {% if audience != "internal" %}[BackendGroupService/Create](../../application-load-balancer/api-ref/grpc/backend_group_service.md#Create){% else %}BackendGroupService/Create{% endif %} или метод REST API {% if audience != "internal" %}[create](../../application-load-balancer/api-ref/BackendGroup/create.md){% else %}create{% endif %}.
     
{% endlist %} 

## Создайте HTTP-роутер и виртуальные хосты {#create-route-hosts}

Создайте HTTP-роутер с двумя виртуальными хостами: `cdn.mywebsite.com` и `cdn-staging.mywebsite.com`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **HTTP-роутеры**.
  1. Нажмите кнопку **Создать HTTP-роутер**.
  1. Введите имя роутера: `canary-router`.
  1. Создайте виртуальный хост `canary-vh-production`:
  
     1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
     1. Введите имя хоста: `canary-vh-production`.
     1. Укажите значение **Authority**: `cdn.yandexcloud.example`
     1. Нажмите кнопку **Добавить маршрут**.
     1. Введите **Имя**: `canary-route-production`.
     1. В поле **Путь** выберите **Начинается с** и укажите путь `/`.
     1. В списке **Методы HTTP** выберите **GET**.
     1. В поле **Действие** оставьте **Маршрутизация**.
     1. В списке **Группа бэкендов** выберите `canary-bg-production`.
  
  1. Аналогично создайте виртуальный хост `canary-vh-staging` со следующими параметрами:
     
     * **Authority** — `cdn-staging.yandexcloud.example`.
     * **Имя** маршрута — `canary-route-staging`.
     * **Группа бэкендов** — `canary-bg-staging`.
     * Остальные параметры — как у `canary-vh-production`.
     
  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.
  
- CLI

  1. Создайте HTTP-роутер `canary-router`:
  
     ```bash
     yc alb http-router create canary-router
     ```
     
     Результат:
     
     ```
     id: ds7qd0vj01djuu3c6f8q
     name: canary-router
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2021-11-03T10:31:41.027649223Z"
     ```
     
     Подробнее о команде `yc alb http-router create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/http-router/create.md).

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
     
     Подробнее о команде `yc alb virtual-host create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/create.md).
     
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
           backend_group_id: ds7pbm5fj2v09ptnn29p
     ```
     
     Подробнее о команде `yc alb virtual-host append-http-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).
     
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
           backend_group_id: ds765atleotaiui5pqeu
     ```

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры HTTP-роутера `canary-router`, его виртуальных хостов и маршрутов:
  
     ```
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
             backend_group_id = "<идентификатор группы бэкендов canary-bg-production>"
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
             backend_group_id = "<идентификатор группы бэкендов canary-bg-staging>"
           }
         }
       }  
     }
     ```
     
     Подробнее см. в описаниях ресурсов [yandex_alb_http_router]({{ tf-provider-link }}/alb_http_router) и [yandex_alb_virtual_host]({{ tf-provider-link }}/alb_virtual_host) в документации провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API

  1. Создайте HTTP-роутер `canary-router` с помощью вызова gRPC API {% if audience != "internal" %}[HttpRouterService/Create](../../application-load-balancer/api-ref/grpc/http_router_service.md#Create){% else %}HttpRouterService/Create{% endif %} или метода REST API {% if audience != "internal" %}[create](../../application-load-balancer/api-ref/HttpRouter/create.md){% else %}create{% endif %}.
  1. Создайте виртуальные хосты `canary-vh-production` и `canary-vh-staging`, привязанные к роутеру, и их маршруты с помощью вызова gRPC API {% if audience != "internal" %}[VirtualHostService/Create](../../application-load-balancer/api-ref/grpc/virtual_host_service.md#Create){% else %}VirtualHostService/Create{% endif %} или метода REST API {% if audience != "internal" %}[create](../../application-load-balancer/api-ref/VirtualHost/create.md){% else %}create{% endif %}.
           
{% endlist %}

## Создайте L7-балансировщик {#create-balancer}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **Балансировщики**.
  1. Нажмите кнопку **Создать L7-балансировщик**.
  1. Введите имя балансировщика: `canary-balancer`.
  1. В блоке **Сетевые настройки**:
  
     1. Выберите **Сеть** `canary-network`.
     1. Выберите **Группу безопасности** `canary-sg`. Если этого поля нет, для балансировщика будет разрешен любой входящий и исходящий трафик.
      
  1. В блоке **Размещение** выберите три подсети для узлов балансировщика — `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b` и `canary-subnet-{{ region-id }}-c` — и включите передачу трафика в эти подсети.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:
  
     1. Введите имя обработчика: `canary-listener`.
     1. В блоке **Настройки публичного IP-адреса** включите передачу трафика.
     1. Укажите порт `80`.
     1. В поле **Назначить IP-адрес** выберите **Автоматически**.
      
  1. В поле **HTTP-роутер** выберите `canary-router`.
  1. Нажмите кнопку **Создать**.
  
- CLI

  1. Получите идентификаторы подсетей сети `canary-network`:
  
     ```bash
     yc vpc network list-subnets canary-network
     ```
     
     Результат:
     
     ```
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     |          ID          |            NAME             |      FOLDER ID       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |     RANGE     |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     | e9bnnssj8sc8mjhat9qk | canary-subnet-{{ region-id }}-c | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-c | [10.1.0.0/16] |
     | e2lghukd9iqo4haidjbt | canary-subnet-{{ region-id }}-b | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-b | [10.2.0.0/16] |
     | b0c3pte4o2kn4v12o05p | canary-subnet-{{ region-id }}-a | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-a | [10.3.0.0/16] |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     ```
     
     Подробнее о команде `yc vpc network list-subnets` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/list-subnets.md).

  1. Получите идентификатор группы безопасности `canary-sg`:
  
     ```bash
     yc vpc security-group get canary-sg | grep "^id"
     ```
     
     Результат:
     
     ```
     id: enpd133ngcnrgc8475cc
     ```
     
     Подробнее о команде `yc vpc security-group get` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/get.md).
  
  1. Создайте балансировщик `canary-balancer`:
  
     ```bash
     yc alb load-balancer create canary-balancer \
       --network-name canary-network \
       --security-group-id <идентификатор группы безопасности canary-sg> \
       --location zone={{ region-id }}-a,subnet-id=<идентификатор подсети canary-subnet-{{ region-id }}-a> \
       --location zone={{ region-id }}-b,subnet-id=<идентификатор подсети canary-subnet-{{ region-id }}-b> \
       --location zone={{ region-id }}-c,subnet-id=<идентификатор подсети canary-subnet-{{ region-id }}-c>
     ```
     
     Результат:
     
     ```
     done (3m0s)
     id: ds77q7v39b4ubg8ta2n4
     name: canary-balancer
     folder_id: b1g9hv2loamqfnbul7d9
     status: ACTIVE
     region_id: {{ region-id }}
     network_id: enptrcle5q3d3ktd33hj
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-c
         subnet_id: b0c3pte4o2kn4v12o05p
       - zone_id: {{ region-id }}-b
         subnet_id: e2lghukd9iqo4haidjbt
       - zone_id: {{ region-id }}-a
         subnet_id: e9bnnssj8sc8mjhat9qk
     log_group_id: ckg23vr4dlkse3hvq0kc
     security_group_ids:
     - enpd133ngcnrgc8475cc
     created_at: "2021-11-03T10:55:49.134935148Z"
     ```
     
     Подробнее о команде `yc alb load-balancer create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/create.md).
     
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
     id: ds77q7v39b4ubg8ta2n4
     name: canary-balancer
     folder_id: b1g9hv2loamqfnbul7d9
     status: ACTIVE
     region_id: {{ region-id }}
     network_id: enptrcle5q3d3ktd33hj
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
           http_router_id: ds7qd0vj01djuu3c6f8q
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-c
         subnet_id: b0c3pte4o2kn4v12o05p
       - zone_id: {{ region-id }}-b
         subnet_id: e2lghukd9iqo4haidjbt
       - zone_id: {{ region-id }}-a
         subnet_id: e9bnnssj8sc8mjhat9qk
     log_group_id: ckg23vr4dlkse3hvq0kc
     security_group_ids:
     - enpd133ngcnrgc8475cc
     created_at: "2021-11-03T10:55:49.134935148Z"
     ```
     
     Подробнее о команде `yc alb load-balancer add-listener` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md).

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры L7-балансировщика `canary-balancer`:
  
     ```
     ...
     
     resource "yandex_alb_load_balancer" "canary-balancer" {
       name               = "canary-balancer"
       network_id         = ${yandex_vpc_network.canary-network.id}
       security_group_ids = [ ${yandex_vpc_security_group.canary-sg.id} ]
     
       allocation_policy {
         location {
           zone_id   = "{{ region-id }}-a"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-{{ region-id }}-a.id}
         }
     
         location {
           zone_id   = "{{ region-id }}-b"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-{{ region-id }}-b.id}
         }
     
         location {
           zone_id   = "{{ region-id }}-c"
           subnet_id = ${yandex_vpc_subnet.canary-subnet-{{ region-id }}-c.id}
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
     
     Подробнее о ресурсе `yandex_alb_load_balancer` см. в [документации]({{ tf-provider-link }}/alb_load_balancer) провайдера {{ TF }}.
     
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

- API

  Используйте вызов gRPC API {% if audience != "internal" %}[LoadBalancerService/Create](../../application-load-balancer/api-ref/grpc/load_balancer_service.md#Create){% else %}LoadBalancerService/Create{% endif %} или метод REST API {% if audience != "internal" %}[create](../../application-load-balancer/api-ref/LoadBalancer/create.md){% else %}create{% endif %}.
          
{% endlist %}

## Создайте CDN-ресурс {#create-cdn-resource}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ cdn-name }}**.
  1. Если CDN-провайдер ещё не активирован, нажмите кнопку **Подключиться к провайдеру**.
  1. Создайте CDN-ресурс:
  
     1. На вкладке **CDN-ресурсы** нажмите кнопку **Создать ресурс**.
     1. Задайте основные параметры CDN-ресурса следующим образом:

        * **Запрос контента** — **Из одного источника**.
        * **Тип источника** — **L7-балансировщик**.
        * **L7-балансировщик** — `canary-balancer`.
        * **IP-адрес** — IP-адрес, назначенный балансировщику (будет единственным в списке).
        * **Доменные имена для раздачи контента** — `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example`.

          {% note alert %}

          Первое доменное имя, `cdn.yandexcloud.example`, станет основным, и его будет невозможно изменить после создания CDN-ресурса.

          {% endnote %}

        * В блоке **Дополнительно**:

          * В поле **Протокол для источников** выберите **HTTP**. 
          * В поле **Переадресация клиентов** выберите **С HTTP на HTTPS**.
          * Выберите опцию **Доступ конечных пользователей к контенту**.
          * В поле **Тип сертификата** выберите **Let's Encrypt®**, чтобы автоматически выпустить сертификат для доменных имен `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example` после создания CDN-ресурса.
          * В поле **Заголовок Host** выберите **Как у клиента**.

     1. Нажмите кнопку **Создать**.
     1. Включите кеширование в CDN:

        1. В списке CDN-ресурсов выберите ресурс с основным доменным именем `cdn.yandexcloud.example`.
        1. Перейдите на вкладку **Кеширование**.
        1. Нажмите кнопку **Редактировать**.
        1. Включите опцию **Кеширование в CDN**.
        1. Нажмите кнопку **Сохранить**.

- CLI

  1. Если CDN-провайдер ещё не активирован, выполните команду:
      ```
      yc cdn provider activate --folder-id <идентификатор каталога> --type gcore
      ```

  1. Создайте группу источников `canary-origin-group`, указав IP-адрес балансировщика:
      ```bash
      yc cdn origin-group create --name "canary-origin-group" \
        --origin source=<IP-адрес балансировщика>:80,enabled=true
      ```

      Результат:
      ```
      id: "90748"
      folder_id: b1geoelk7fldts6chmjq
      name: canary-origin-group
      use_next: true
      origins:
      - id: "562449"
        origin_group_id: "90748"
        source: 51.250.10.216:80
        enabled: true
      ```

      Подробнее о команде `yc cdn origin-group create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/origin-group/create.md).


  1. Скопируйте идентификатор группы источников `origin_group_id` из предыдушего шага и создайте CDN-ресурс, выполнив команду:
  
      ```bash
      yc cdn resource create \
        --cname cdn.yandexcloud.example \
        --origin-group-id <идентификатор группы источников> \
        --secondary-hostnames cdn-staging.yandexcloud.example \
        --origin-protocol http \
        --redirect-http-to-https \
        --forward-host-header
      ```

      Результат:
      ```
      id: bc843k2yinvq5fhgvuvc
      folder_id: b1ge1elk72ldts6chmjq
      cname: cdn.yandexcloud.example
      ...
      active: true
      ...
      ...
      secondary_hostnames:
      - cdn-staging.yandexcloud.example
      ...
      ```

      Подробнее о команде `yc cdn resource create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/resource/create.md).

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры CDN-ресурсов:
      ```hcl
      ...

      resource "yandex_cdn_origin_group" "my_group" {
        name     = "canary-origin-group"
        use_next = true
        origin {
         source = "<IP-адрес балансировщика>:80"
         backup = false
        }
      }
      
      resource "yandex_cdn_resource" "my_resource" {
      
          cname               = "cdn.yandexcloud.example"
          active              = true
          origin_protocol     = "http"
          secondary_hostnames = ["cdn-staging.yandexcloud.example"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
          options {
              edge_cache_settings    = "345600"
              browser_cache_settings = "1800"
              ignore_cookie          = true
              ignore_query_params    = false
          }
      
      }
      ```

      Подробнее см. в описаниях ресурсов [yandex_cdn_origin_group]({{ tf-provider-link }}/cdn_origin_group) и [yandex_cdn_resource]({{ tf-provider-link }}/cdn_resource) в документации провайдера {{ TF }}.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

  Используйте вызов gRPC API {% if audience != "internal" %}[ResourceService/Create](../../cdn/api-ref/grpc/resource_service.md#Create){% else %}ResourceService/Create{% endif %} или метод REST API {% if audience != "internal" %}[create](../../cdn/api-ref/Resource/create.md){% else %}create{% endif %}.
  
{% endlist %}

## Настройте DNS для сервиса {#configure-dns}

Доменные имена `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example` должны быть связаны с CDN-ресурсом с помощью записей DNS.

Чтобы настроить DNS:

1. Получите доменное имя CDN-балансировщика:

   {% list tabs %}
   
   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. В списке CDN-ресурсов выберите ресурс с основным доменным именем `cdn.yandexcloud.example`.
     1. Из блока **Настройки DNS** внизу страницы скопируйте доменное имя вида `cl-....edgecdn.ru`.

   {% endlist %}

1. На сайте компании, которая предоставляет вам услуги DNS-хостинга, перейдите в настройки DNS.
1. Создайте или измените CNAME-записи для `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example` таким образом, чтобы они указывали на скопированное доменное имя:

   ```
   cdn CNAME cl-....edgecdn.ru
   cdn-staging CNAME cl-....edgecdn.ru 
   ```
   
   Если вы пользуетесь {{ dns-name }}, настройте запись по следующей инструкции:
   
   {% cut "Инструкция по настройке DNS-записей для {{ dns-name }}" %}
   
   {% list tabs %}
   
   - Консоль управления 
   
     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ dns-name }}**.
     1. Если у вас нет публичной зоны DNS, создайте ее:

        1. Нажмите кнопку **Создать зону**.
        1. В поле **Зона** укажите доменное имя сайта с точкой в конце: `yandexcloud.example.`
        1. Выберите **Тип** зоны — **Публичная**.
        1. Укажите **Имя** зоны: `canary-dns-zone`.
        1. Нажмите кнопку **Создать**.
      
     1. Создайте в зоне CNAME-запись для `cdn.yandexcloud.example`:

        1. В списке зон нажмите на зону `canary-dns-zone`.
        1. Нажмите кнопку **Создать запись**.
        1. В поле **Имя** укажите `cdn`.
        1. Выберите **Тип** записи — **CNAME**.
        1. В поле **Значение** вставьте скопированное значение вида `cl-....edgecdn.ru`.
        1. Нажмите кнопку **Создать**.
        
     1. Аналогично создайте в той же зоне CNAME-запись для `cdn-staging.yandexcloud.example`. В поле **Имя** укажите `cdn-staging`.
     
   - CLI
   
     1. Если у вас нет публичной зоны DNS, создайте ее:
     
        ```bash
        yc dns zone create \
          --name canary-dns-zone \
          --zone yandexcloud.example. \
          --public-visibility
        ```
        
        Результат:
        
        ```
        id: dns4rq4tadddth4h20qm
        folder_id: b1g9hv2loamqfnbul7d9
        created_at: "2021-11-03T11:03:28.847Z"
        name: canary-dns-zone
        zone: yandexcloud.example.
        public_visibility: {}
        ```
        
        Подробнее о команде `yc dns zone create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/dns/zone/create.md).
        
     1. Создайте в зоне CNAME-записи для `cdn.yandexcloud.example` и `cdn-staging.yandexcloud.example` со скопированным значением вида `cl-....edgecdn.ru`:
     
        ```bash
        yc dns zone add-records \
          --name canary-dns-zone \
          --record "cdn CNAME cl-....edgecdn.ru" \
          --record "cdn-staging CNAME cl-....edgecdn.ru"
        ```
        
        Подробнее о команде `yc dns zone add-records` см. в [справочнике CLI](../../cli/cli-ref/managed-services/dns/zone/add-records.md).
   
   - {{ TF }}
   
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
          data    = ["<скопированное значение вида cl-....edgecdn.ru>"]
        }
        
        resource "yandex_dns_recordset" "canary-recordset-staging" {
          zone_id = ${yandex_dns_zone.canary-dns-zone.id}
          name    = "cdn-staging"
          type    = "CNAME"
          data    = ["<скопированное значение вида cl-....edgecdn.ru>"]
        }
        ```
        
        Подробнее см. в описаниях ресурсов [yandex_dns_zone]({{ tf-provider-link }}/dns_zone) и [yandex_dns_recordset]({{ tf-provider-link }}/dns_recordset) в документации провайдера {{ TF }}.
        
     1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:
   
           ```bash
           terraform plan
           ```
   
        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
   
     1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:
   
           ```bash
           terraform apply
           ```

        1. Подтвердите создание ресурсов.

   - API
    
     1. Создайте DNS-зону `canary-dns-zone` с помощью вызова gRPC API {% if audience != "internal" %}[DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create){% else %}DnsZoneService/Create{% endif %} или метода REST API {% if audience != "internal" %}[create](../../dns/api-ref/DnsZone/create.md){% else %}create{% endif %}.
     1. Добавьте в зону CNAME-записи `cdn` и `cdn-staging` со скопированным значением вида `cl-....edgecdn.ru` с помощью вызова gRPC API {% if audience != "internal" %}[DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets){% else %}DnsZoneService/UpdateRecordSets{% endif %} или метода REST API {% if audience != "internal" %}[updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md){% else %}updateRecordSets{% endif %}.
        
   {% endlist %}
   
   {% endcut %}

Через 15–20 минут после настройки DNS вы сможете проверить работу сервиса.

## Проверьте работу сервиса и переключение между версиями {#check}

### Первая проверка {#check-one}

Проверьте, что доменному имени `cdn.yandexcloud.example` соответствует версия 1, а `cdn-staging.yandexcloud.example` — версия 2:

1. Откройте в браузере адрес `https://cdn.yandexcloud.example/index.html`. Вы должны увидеть страницу с указанием на версию 1.
1. Удалите из кеша CDN-ресурса файл `index.html`:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Контент**.
     1. Нажмите кнопку **Очистить кеш**.
     1. Выберите тип очистки — **Выборочная**.
     1. Укажите путь к загруженному файлу: `/index.html`.
     1. Нажмите кнопку **Очистить кеш**.
     
   - CLI
   
     1. Получите идентификатор созданного CDN-ресурса:
     
        ```bash
        yc cdn resource list
        ```
     
        Результат:
     
        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkhbc7xwioa | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
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

        Подробнее о команде `yc cdn resource list` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/resource/list.md).
        
     1. Удалите файл из кеша:
     
        ```bash
        yc cdn cache purge \
          --resource-id <идентификатор CDN-ресурса> \
          --path "/index.html"
        ```
        
        Подробнее о команде `yc cdn cache purge` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/cache/purge.md).

   - API
   
     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/List](../../cdn/api-ref/grpc/resource_service.md#List){% else %}ResourceService/List{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/list.md){% else %}list{% endif %}.
     1. Удалите файл `index.html` из кеша с помощью вызова gRPC API {% if audience != "internal" %}[CacheService/Purge](../../cdn/api-ref/grpc/cache_service#Purge){% else %}CacheService/Purge{% endif %} или метода {% if audience != "internal" %}[purge](../../cdn/api-ref/Cache/purge.md){% else %}purge{% endif %}. 
     
   {% endlist %}

1. Откройте в браузере адрес `https://cdn-staging.yandexcloud.example/index.html`. Вы должны увидеть страницу с указанием на версию 2.

### Канареечное развертывание версии 2 {#canary-v2}
   
1. Отключите кеширование CDN-ресурса и удалите из кеша файл `index.html`:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**.
     1. Нажмите кнопку **Редактировать**.
     1. Отключите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.
     
   - API
   
     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/List](../../cdn/api-ref/grpc/resource_service.md#List){% else %}ResourceService/List{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/list.md){% else %}list{% endif %}.
     1. Отключите кеширование с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/Update](../../cdn/api-ref/grpc/resource_service.md#Update){% else %}ResourceService/Update{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/update.md){% else %}list{% endif %}. 
     
   {% endlist %}

1. Удалите из кеша файл `index.html`:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Контент**.
     1. Нажмите кнопку **Очистить кеш**.
     1. Выберите тип очистки — **Выборочная**.
     1. Укажите путь к загруженному файлу: `/index.html`.
     1. Нажмите кнопку **Очистить кеш**.
     
   - CLI
   
     1. Получите идентификатор созданного CDN-ресурса:
     
        ```bash
        yc cdn resource list
        ```
     
        Результат:
     
        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkhbc7xwioa | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
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
          --resource-id <идентификатор CDN-ресурса> \
          --path "/index.html"
        ```
     
   - API
   
     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/List](../../cdn/api-ref/grpc/resource_service.md#List){% else %}ResourceService/List{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/list.md){% else %}list{% endif %}.
     1. Удалите файл `index.html` из кеша с помощью вызова gRPC API {% if audience != "internal" %}[CacheService/Purge](../../cdn/api-ref/grpc/cache_service#Purge){% else %}CacheService/Purge{% endif %} или метода {% if audience != "internal" %}[purge](../../cdn/api-ref/Cache/purge.md){% else %}purge{% endif %}. 
     
   {% endlist %}

1. Настройте группу бэкендов `canary-bg-production` так, чтобы 20% трафика доменного имени `cdn.yandexcloud.example` приходилось на бэкенд `canary-backend-green` с версией 2:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **Группы бэкендов**.
     1. В списке групп бэкендов выберите `canary-bg-production`.
     1. Для бэкенда `canary-backend-blue` установите вес 80 вместо 100:

        1. В блоке **Бэкенды** найдите бэкенд `canary-backend-blue` и нажмите кнопку ![Три точки](../../_assets/horizontal-ellipsis.svg) → **Редактировать**.
        1. В поле **Вес** укажите `80`.
        1. Нажмите кнопку **Сохранить**.

     1. Аналогично для бэкенда `canary-backend-green` установите вес 20 вместо 0.
     1. Нажмите кнопку **Сохранить**.
     
   - CLI
   
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
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-blue
            backend_weight: "80"
            storage_bucket:
              bucket: canary-bucket-blue
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```
        
        Подробнее о команде `yc alb backend-group update-http-backend` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/backend-group/update-http-backend.md).
        
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
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-green
            backend_weight: "20"
            storage_bucket:
              bucket: canary-bucket-green
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```
   
   - API
   
     Используйте вызов gRPC API {% if audience != "internal" %}[BackendGroupService/UpdateBackend](../../application-load-balancer/api-ref/grpc/backend_group_service.md#UpdateBackend){% else %}BackendGroupService/UpdateBackend{% endif %} или метод REST API {% if audience != "internal" %}[updateBackend](../../application-load-balancer/api-ref/BackendGroup/updateBackend.md){% else %}updateBackend{% endif %}.
           
   {% endlist %}
   
1. Несколько раз откройте в браузере адрес `https://cdn.yandexcloud.example/index.html`. Примерно в 20% случаев вы должны увидеть страницу с указанием на версию 2, в остальных случаях — на версию 1.
1. Аналогично шагам 1–2 настройте и проверьте следующие распределения трафика между бэкендами:

   1. В группе бэкендов `canary-bg-production` — по 50% трафика на оба бэкенда.
   1. В группе бэкендов `canary-bg-production` — весь трафик на бэкенд `canary-backend-green`.
   1. В группе бэкендов `canary-bg-staging` (доменное имя `cdn-staging.yandexcloud.example`) — весь трафик на бэкенд `canary-backend-blue`.

1. Снова включите кеширование:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**
     1. Нажмите кнопку **Редактировать**.
     1. Включите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.
     
   - API
   
     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/List](../../cdn/api-ref/grpc/resource_service.md#List){% else %}ResourceService/List{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/list.md){% else %}list{% endif %}.
     1. Включите кеширование с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/Update](../../cdn/api-ref/grpc/resource_service.md#Update){% else %}ResourceService/Update{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/update.md){% else %}list{% endif %}.
     
   {% endlist %}
   
### Сине-зеленое развертывание для отката к версии 1 {#blue-green-v1-rollback}

1. Отключите кеширование CDN-ресурса и удалите из кеша файл `index.html`:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**
     1. Нажмите кнопку **Редактировать**.
     1. Отключите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.
     
   - API
   
     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/List](../../cdn/api-ref/grpc/resource_service.md#List){% else %}ResourceService/List{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/list.md){% else %}list{% endif %}.
     1. Отключите кеширование с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/Update](../../cdn/api-ref/grpc/resource_service.md#Update){% else %}ResourceService/Update{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/update.md){% else %}list{% endif %}. 
     
   {% endlist %}

1. Удалите из кеша файл `index.html`:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Контент**.
     1. Нажмите кнопку **Очистить кеш**.
     1. Выберите тип очистки — **Выборочная**.
     1. Укажите путь к загруженному файлу: `/index.html`.
     1. Нажмите кнопку **Очистить кеш**.
     
   - CLI
   
     1. Получите идентификатор созданного CDN-ресурса:
     
        ```bash
        yc cdn resource list
        ```
     
        Результат:
     
        ```
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        |          ID          |          CNAME           |           CREATED AT           |           UPDATED AT           | ACTIVE |                  OPTIONS                  |
        +----------------------+--------------------------+--------------------------------+--------------------------------+--------+-------------------------------------------+
        | bc837xptmpkhbc7xwioa | cdn.yandexcloud.example  | seconds:1637235693             | seconds:1637235693             | true   | edge_cache_settings:{enabled:true         |
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
          --resource-id <идентификатор CDN-ресурса> \
          --path "/index.html"
        ```
     
   - API
   
     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/List](../../cdn/api-ref/grpc/resource_service.md#List){% else %}ResourceService/List{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/list.md){% else %}list{% endif %}.
     1. Удалите файл `index.html` из кеша с помощью вызова gRPC API {% if audience != "internal" %}[CacheService/Purge](../../cdn/api-ref/grpc/cache_service#Purge){% else %}CacheService/Purge{% endif %} или метода {% if audience != "internal" %}[purge](../../cdn/api-ref/Cache/purge.md){% else %}purge{% endif %}. 
     
   {% endlist %}

1. Перенаправьте весь трафик доменного имени `cdn.yandexcloud.example` обратно на бэкенд `canary-backend-blue` с версией 1:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **Группы бэкендов**.
     1. В списке групп бэкендов выберите `canary-bg-production`.
     1. Для бэкенда `canary-backend-blue` установите вес 100 вместо 0:

        1. В блоке **Бэкенды** найдите бэкенд `canary-backend-blue` и нажмите кнопку ![Три точки](../../_assets/horizontal-ellipsis.svg) → **Редактировать**.
        1. В поле **Вес** укажите `100`.
        1. Нажмите кнопку **Сохранить**.
        
     1. Аналогично для бэкенда `canary-bucket-green` установите вес 0 вместо 100.
     1. Нажмите кнопку **Сохранить**.

   - CLI
   
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
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-blue
            backend_weight: "100"
            storage_bucket:
              bucket: canary-bucket-blue
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
        id: ds7l9puc18c9b40cd359
        name: canary-bg-production
        folder_id: b1g9hv2loamqfnbul7d9
        http:
          backends:
          - name: canary-backend-green
            backend_weight: "0"
            storage_bucket:
              bucket: canary-bucket-green
        created_at: "2021-11-03T10:28:47.680825561Z"
        ```
        
   - API
   
     Используйте вызов gRPC API {% if audience != "internal" %}[BackendGroupService/UpdateBackend](../../application-load-balancer/api-ref/grpc/backend_group_service.md#UpdateBackend){% else %}BackendGroupService/UpdateBackend{% endif %} или метод REST API {% if audience != "internal" %}[updateBackend](../../application-load-balancer/api-ref/BackendGroup/updateBackend.md){% else %}updateBackend{% endif %}.   
   
   {% endlist %}
   
1. Несколько раз откройте в браузере адрес `https://cdn.yandexcloud.example/index.html`. Во всех случаях вы должны увидеть страницу с указанием на версию 1.
1. Аналогично шагам 1–2 переключите весь трафик доменного имени `cdn-staging.yandexcloud.example` на бэкенд `canary-backend-green` с версией 2 и проверьте переключение в браузере.
1. Снова включите кеширование:

   {% list tabs %}
   
   - Консоль управления
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ cdn-name }}**.
     1. Выберите созданный CDN-ресурс (в списке ресурсов будет указано его основное доменное имя — `cdn.yandexcloud.example`).
     1. Перейдите на вкладку **Кеширование**
     1. Нажмите кнопку **Редактировать**.
     1. Включите опцию **Кеширование в CDN**.
     1. Нажмите кнопку **Сохранить**.
     
   - API
   
     1. Получите идентификатор созданного CDN-ресурса с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/List](../../cdn/api-ref/grpc/resource_service.md#List){% else %}ResourceService/List{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/list.md){% else %}list{% endif %}.
     1. Включите кеширование с помощью вызова gRPC API {% if audience != "internal" %}[ResourceService/Update](../../cdn/api-ref/grpc/resource_service.md#Update){% else %}ResourceService/Update{% endif %} или метода REST API {% if audience != "internal" %}[list](../../cdn/api-ref/Resource/update.md){% else %}list{% endif %}.
     
   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы настраивали CNAME-записи в {{ dns-name }}, {% if audience != "internal" %}[удалите](../../dns/operations/zone-delete.md){% else %}удалите{% endif %} зону DNS `canary-dns-zone`.
1. {% if audience != "internal" %}[Удалите](../../cdn/operations/resources/delete-resource.md){% else %}Удалите{% endif %} CDN-ресурс с основным доменным именем `cdn.yandexcloud.example`.
1. {% if audience != "internal" %}[Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md){% else %}Удалите{% endif %} L7-балансировщик `canary-balancer`.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакетов `canary-bucket-blue` и `canary-bucket-green`.
1. [Удалите](../../storage/operations/buckets/delete.md) бакеты `canary-bucket-blue` и `canary-bucket-green`.
1. {% if audience != "internal" %}[Удалите](../../vpc/operations/subnet-delete.md){% else %}Удалите{% endif %} подсети `canary-subnet-{{ region-id }}-a`, `canary-subnet-{{ region-id }}-b` и `canary-subnet-{{ region-id }}-c`.
1. {% if audience != "internal" %}[Удалите](../../vpc/operations/network-delete.md){% else %}Удалите{% endif %} сеть `canary-network`.
