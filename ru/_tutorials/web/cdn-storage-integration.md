# Интеграция L7-балансировщика с {{ cdn-short-name }} и {{ objstorage-short-name }}

В этом руководстве в качестве бэкенда L7-балансировщика {{ alb-full-name }} используется бакет {{ objstorage-full-name }}. Запросы пользователей передаются балансировщику через сеть распространения контента {{ cdn-full-name }}, чтобы сократить время доставки контента.

В качестве примера будет использовано доменное имя `cdn.yandexcloud.example`.

Для выполнения шагов можно использовать различные [поддерживаемые инструменты](#supported-tools).

Чтобы построить архитектуру для интеграции L7-балансировщика с CDN и Object Storage:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте бакет в {{ objstorage-name }}](#create-buckets).
1. [Загрузите файл сервиса в бакет](#upload-files).
1. [Создайте группу безопасности](#create-security-group).
1. [Создайте группу бэкендов в {{ alb-name }}](#create-l7backend).
1. [Создайте HTTP-роутер и виртуальный хост](#create-route-hosts).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Создайте CDN-ресурс](#create-cdn-resource).
1. [Настройте DNS для сервиса](#configure-dns).
1. [Проверьте работу сервиса](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Поддерживаемые инструменты {#supported-tools}

Бо́льшую часть шагов можно выполнить с помощью любого из стандартных инструментов: [консоли управления]({{ link-console-main }}), интерфейсов командной строки (CLI) [{{ yandex-cloud }}](../../cli/) и [AWS](../../storage/tools/aws-cli.md), {{ TF }} и [API {{ yandex-cloud }}](../../api-design-guide). В каждом шаге перечислены поддерживаемые для него инструменты.

Некоторые инструменты поддерживаются не для всех шагов:

* Через CLI и {{ TF }} сейчас нельзя:
  * [создать группу бэкендов в {{ alb-name }} с бакетами в качестве бэкендов](#create-l7backend);
  * получить доменное имя CDN-балансировщика при [настройке DNS для сервиса](#configure-dns);
* Через API сейчас нельзя получить доменное имя CDN-балансировщика при [настройке DNS для сервиса](#configure-dns).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

В качестве примера будет использоваться каталог с именем `example-folder`.


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение данных в {{ objstorage-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md));
* плата за использование вычислительных ресурсов L7-балансировщика (см. [тарифы {{ alb-name }}](../../application-load-balancer/pricing.md));
* плата за исходящий трафик с CDN-серверов (см. [тарифы {{ cdn-name }}](../../cdn/pricing.md));
* плата за публичные DNS-запросы и DNS-зоны, если вы используете {{ dns-full-name }} (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


## Создайте облачную сеть и подсети {#create-network}

Все ресурсы будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть и подсети:

{% list tabs %}

- Консоль управления 

    1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
    1. В списке сервисов выберите **{{ vpc-name }}**.
    1. Нажмите кнопку **Создать сеть**.
    1. Укажите **Имя** сети: `example-network`.
    1. В поле **Дополнительно** выберите опцию **Создать подсети**.
    1. Нажмите кнопку **Создать сеть**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сеть `example-network`:
  
     ```bash
     yc vpc network create example-network
     ```
     
     Результат:
       
     ```
     id: enptrcle5q3d3ktd33hj
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2022-04-04T05:25:03Z"
     name: example-network
     default_security_group_id: enpbsnnop4akg7ng70ll
     ```
     
     Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).
     
  1. Создайте подсети во всех зонах доступности:
  
     * В `{{ region-id }}-a`:
     
       ```bash
       yc vpc subnet create example-subnet-{{ region-id }}-a \
         --zone {{ region-id }}-a \
         --network-name example-network \
         --range 10.1.0.0/16
       ```
     
       Результат:
      
       ``` 
       id: e9bnnssj8sc8mjhat9qk
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2022-04-04T09:27:00Z"
       name: example-subnet-{{ region-id }}-a
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-a
       v4_cidr_blocks:
       - 10.1.0.0/16
       ```
     
     * В `{{ region-id }}-b`:
     
       ```bash
       yc vpc subnet create example-subnet-{{ region-id }}-b \
         --zone {{ region-id }}-b \
         --network-name example-network \
         --range 10.2.0.0/16
       ```
     
       Результат:
      
       ``` 
       id: e2lghukd9iqo4haidjbt
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2022-04-04T09:27:39Z"
       name: example-subnet-{{ region-id }}-b
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-b
       v4_cidr_blocks:
       - 10.2.0.0/16
       ```
     
     * В `{{ region-id }}-c`:
     
       ```bash
       yc vpc subnet create example-subnet-{{ region-id }}-c \
         --zone {{ region-id }}-c \
         --network-name example-network \
         --range 10.3.0.0/16
       ```
     
       Результат:
      
       ``` 
       id: b0c3pte4o2kn4v12o05p
       folder_id: b1g9hv2loamqfnbul7d9
       created_at: "2022-04-04T09:28:08Z"
       name: example-subnet-{{ region-id }}-c
       network_id: enptrcle5q3d3ktd33hj
       zone_id: {{ region-id }}-c
       v4_cidr_blocks:
       - 10.3.0.0/16
       ```
       
     Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Опишите в конфигурационном файле параметры сети `example-network` и ее подсетей `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` и `example-subnet-{{ region-id }}-c`:
  
     ```hcl
     resource "yandex_vpc_network" "example-network" {
       name = "example-network"
     }

     resource "yandex_vpc_subnet" "example-subnet-a" {
       name           = "example-subnet-{{ region-id }}-a"
       zone           = "{{ region-id }}-a"
       network_id     = "${yandex_vpc_network.example-network.id}"
       v4_cidr_blocks = ["10.1.0.0/16"]
     }
     
     resource "yandex_vpc_subnet" "example-subnet-b" {
       name           = "example-subnet-{{ region-id }}-b"
       zone           = "{{ region-id }}-b"
       network_id     = "${yandex_vpc_network.example-network.id}"
       v4_cidr_blocks = ["10.2.0.0/16"]
     }
     
     resource "yandex_vpc_subnet" "example-subnet-c" {
       name           = "example-subnet-{{ region-id }}-c"
       zone           = "{{ region-id }}-c"
       network_id     = "${yandex_vpc_network.example-network.id}"
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

  1. Создайте сеть `example-network` с помощью вызова gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/network_service.md#Create) или метода REST API [create](../../vpc/api-ref/Network/create.md).
  1. Создайте подсети `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` и `example-subnet-{{ region-id }}-c` в трех зонах доступности с помощью вызова gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/subnet_service.md#Create) или метода REST API [create](../../vpc/api-ref/Subnet/create.md).

{% endlist %}

## Создайте бакет в {{ objstorage-name }} {#create-buckets}

Создайте бакет `example-bucket`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ objstorage-name }}**.
  1. Создайте бакет `example-bucket`:
  
     1. Нажмите кнопку **Создать бакет**.
     1. Укажите **Имя** бакета: `example-bucket`.
     1. В полях **Доступ на чтение объектов** и **Доступ к списку объектов** выберите **Публичный**.
     1. Нажмите кнопку **Создать бакет**.

  
- AWS CLI

  1. Создайте бакет `example-bucket`:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://example-bucket
     ```
     
     Результат:
     
     ```
     make_bucket: s3://example-bucket
     ```
     
  1. Включите публичный доступ к чтению объектов и их списка:
  
     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3api put-bucket-acl \
       --bucket example-bucket \
       --acl public-read
     ```

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры бакета `example-bucket`:
  
     ```hcl
     ...
     
     resource "yandex_storage_bucket" "example-bucket" {
       bucket = "example-bucket"
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

## Загрузите файл сервиса в бакет {#upload-files}

1. Создайте файл `index.html`.

   {% cut "Пример файла index.html" %}

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>My service</title>
     </head>
     <body>
       <p>The service is working</p>
     </body>
   </html>
   ```

   {% endcut %}

1. Загрузите файл в бакет:

   {% list tabs %}
   
   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ objstorage-name }}**.
     1. В списке бакетов выберите `example-bucket`.
     1. Нажмите кнопку **Загрузить** и выберите для загрузки файл `index.html`.

   - AWS CLI
   
     1. Загрузите в бакет `example-bucket` файл `index.html`:
     
        ```bash
        aws --endpoint-url https://{{ s3-storage-host }} \
          s3 cp v1/index.html s3://example-bucket/index.html
        ```
        
        Результат:
        
        ```
        upload: v1/index.html to s3://example-bucket/index.html
        ```

   - {{ TF }}
   
     1. Добавьте в конфигурационный файл параметры файла `v1/index.html`, загружаемого в бакет `example-bucket`:
     
        ```hcl
        ...
        
        resource "yandex_storage_object" "example-bucket-index" {
          bucket = "example-bucket"
          key    = "index.html"
          source = "v1/index.html"
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

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

[Группы безопасности](../../vpc/concepts/security-groups.md) содержат правила, которые разрешают L7-балансировщику получать входящий трафик и отправлять его на бакеты-бэкенды.

Чтобы создать группы безопасности:

{% list tabs %}

- Консоль управления 

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ vpc-name }}**.
  1. Перейдите на вкладку **Группы безопасности**.
  1. Нажмите кнопку **Создать группу**.
  1. Укажите **Имя** группы: `example-sg`.
  1. Выберите **Сеть** `example-network`.
  1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:
   
     | Направление<br/>трафика | Описание | Диапазон<br/>портов | Протокол | Тип источника /<br/>назначения | Источник /<br/>назначение |
     | --- | --- | --- | --- | --- | --- |
     | Исходящий | any | Весь | Любой | CIDR | 0.0.0.0/0 |
     | Входящий | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
     | Входящий | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
     | Входящий | healthchecks | 30080 | TCP | Проверки состояния балансировщика | — |
      
     1. Перейдите на вкладку **Исходящий трафик** или **Входящий трафик**.
     1. Нажмите кнопку **Добавить правило**.
     1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
     1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.
     1. В поле **Назначение** или **Источник** выберите назначение правила:
      
        * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
        * **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
        * **Проверки состояния балансировщика** — правило, которое позволяет балансировщику проверять состояние ВМ.

     1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
   
  1. Нажмите кнопку **Сохранить**.

- CLI

  Выполните следующую команду:

  ```bash
  yc vpc security-group create example-sg \
    --network-name example-network \
    --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0] \
    --rule direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks
  ```
  
  Результат:
  
  ```
  id: enpd133ngcnrgc8475cc
  folder_id: b1g9hv2loamqfnbul7d9
  created_at: "2022-04-04T10:26:16Z"
  name: example-sg
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
    predefined_target: loadbalancer_healthchecks
  ```

  Подробнее о команде `yc vpc security-group create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры группы безопасности `example-sg`:
  
     ```hcl
     resource "yandex_vpc_security_group" "example-sg" {
       name       = "example-sg"
       network_id = "yandex_vpc_network.example-network.id"
     
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
     
     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/vpc_security_group).
     
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

  Используйте вызов gRPC API [SecurityGroupService/Create](../../vpc/api-ref/grpc/security_group_service.md#Create) или метод REST API [create](../../vpc/api-ref/SecurityGroup/create.md).

  Чтобы добавить правило для проверок состояния балансировщика, используйте параметр `loadbalancer_healthchecks` в поле [SecurityGroupRuleSpec.target.predefined_target](../../vpc/api-ref/grpc/security_group_service.md#SecurityGroupRuleSpec) для gRPC API или в поле [predefinedTarget](../../vpc/api-ref/SecurityGroup/create.md#body_params) для REST API.

{% endlist %}

## Создайте группу бэкендов в {{ alb-name }} {#create-l7backend}

{% list tabs %}
   
- Консоль управления
   
  1. Создайте группу бэкендов `example-bg` с бэкендом `example-backend`:
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
     1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **Группы бэкендов**.
     1. Нажмите кнопку **Создать группу бэкендов**.
     1. Введите имя группы бэкендов: `example-bg`.
     1. Выберите [тип группы бэкендов](../../application-load-balancer/concepts/backend-group.md#group-types) **HTTP**.
     1. В блоке **Бэкенды** нажмите кнопку **Добавить**. Задайте настройки бэкенда:
         1. Введите имя бэкенда: `example-backend`.
         1. Задайте вес бэкенда: `100`.
         1. Выберите [тип бэкенда](../../application-load-balancer/concepts/backend-group.md#types) **Бакет**.
         1. В поле **Бакет** укажите название бакета: `example-bucket`.
     1. Нажмите кнопку **Создать**.

  1. Если вы будете выполнять следующие шаги с помощью {{ TF }}, скопируйте идентификатор группы бэкендов `example-bg` со вкладки **Группы бэкендов**.

- API

  Используйте вызов gRPC API [BackendGroupService/Create](../../application-load-balancer/api-ref/grpc/backend_group_service.md#Create) или метод REST API [create](../../application-load-balancer/api-ref/BackendGroup/create.md).
     
{% endlist %} 

## Создайте HTTP-роутер и виртуальные хосты {#create-route-hosts}

Создайте HTTP-роутер с виртуальным хостом: `cdn.mywebsite.com`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **HTTP-роутеры**.
  1. Нажмите кнопку **Создать HTTP-роутер**.
  1. Введите имя роутера: `example-router`.
  1. Создайте виртуальный хост `example-vh`:
  
     1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
     1. Введите имя хоста: `example-vh`.
     1. Укажите значение **Authority**: `cdn.yandexcloud.example`
     1. Нажмите кнопку **Добавить маршрут**.
     1. Введите **Имя**: `example-route`.
     1. В поле **Путь** выберите **Начинается с** и укажите путь `/`.
     1. В списке **Методы HTTP** выберите **GET**.
     1. В поле **Действие** оставьте **Маршрутизация**.
     1. В списке **Группа бэкендов** выберите `example-bg`.

  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.
  
- CLI

  1. Создайте HTTP-роутер `example-router`:
  
     ```bash
     yc alb http-router create example-router
     ```
     
     Результат:
     
     ```
     id: ds7qd0vj01djuu3c6f8q
     name: example-router
     folder_id: b1g9hv2loamqfnbul7d9
     created_at: "2022-04-04T10:31:41.027649223Z"
     ```
     
     Подробнее о команде `yc alb http-router create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/http-router/create.md).

  1. Создайте виртуальный хост `example-vh`:
  
     ```bash
     yc alb virtual-host create example-vh \
       --http-router-name example-router \
       --authority cdn.yandexcloud.example
     ```
     
     Результат:
     
     ```
     done (1s)
     name: example-vh
     authority:
     - cdn.yandexcloud.example
     ```
     
     Подробнее о команде `yc alb virtual-host create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/create.md).
     
  1. Создайте маршрут `example-route` в виртуальном хосте `example-vh`:
  
     ```bash
     yc alb virtual-host append-http-route example-route \
       --http-router-name example-router \
       --virtual-host-name example-vh \
       --prefix-path-match "/" \
       --backend-group-name example-bg
     ```
     
     Результат:
     
     ```
     done (1s)
     name: example-vh
     authority:
     - cdn.yandexcloud.example
     routes:
     - name: example-route
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: ds7pbm5fj2v09ptnn29p
     ```
     
     Подробнее о команде `yc alb virtual-host append-http-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры HTTP-роутера `example-router`, его виртуальных хостов и маршрутов:
  
     ```hcl
     ...
     
     resource "yandex_alb_http_router" "example-router" {
       name = "example-router"
     }
     
     resource "yandex_alb_virtual_host" "example-vh" {
       name           = "example-vh"
       http_router_id = ${yandex_alb_http_router.example-router.id}
       authority      = "cdn.yandexcloud.example"
       
       route {
         name = "example-route"
         http_route {
           http_route_action {
             backend_group_id = "<идентификатор_группы_бэкендов_example-bg>"
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

  1. Создайте HTTP-роутер `example-router` с помощью вызова gRPC API [HttpRouterService/Create](../../application-load-balancer/api-ref/grpc/http_router_service.md#Create) или метода REST API [create](../../application-load-balancer/api-ref/HttpRouter/create.md).
  1. Создайте виртуальный хост `example-vh`, привязанный к роутеру, и его маршрут с помощью вызова gRPC API [VirtualHostService/Create](../../application-load-balancer/api-ref/grpc/virtual_host_service.md#Create) или метода REST API [create](../../application-load-balancer/api-ref/VirtualHost/create.md).

{% endlist %}

## Создайте L7-балансировщик {#create-balancer}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ alb-name }}** и перейдите на вкладку **Балансировщики**.
  1. Нажмите кнопку **Создать L7-балансировщик**.
  1. Введите имя балансировщика: `example-balancer`.
  1. В блоке **Сетевые настройки**:
  
     1. Выберите **Сеть** `example-network`.
     1. Выберите **Группу безопасности** `example-sg`. Если этого поля нет, для балансировщика будет разрешен любой входящий и исходящий трафик.
      
  1. В блоке **Размещение** выберите три подсети для узлов балансировщика — `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` и `example-subnet-{{ region-id }}-c` — и включите передачу трафика в эти подсети.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:
  
     1. Введите имя обработчика: `example-listener`.
     1. В блоке **Настройки публичного IP-адреса** включите передачу трафика.
     1. Укажите порт `80`.
     1. В поле **Назначить IP-адрес** выберите **Автоматически**.
      
  1. В поле **HTTP-роутер** выберите `example-router`.
  1. Нажмите кнопку **Создать**.
  
- CLI

  1. Получите идентификаторы подсетей сети `example-network`:
  
     ```bash
     yc vpc network list-subnets example-network
     ```
     
     Результат:
     
     ```
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     |          ID          |            NAME             |      FOLDER ID       |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |     RANGE     |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     | e9bnnssj8sc8mjhat9qk | example-subnet-{{ region-id }}-c | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-c | [10.1.0.0/16] |
     | e2lghukd9iqo4haidjbt | example-subnet-{{ region-id }}-b | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-b | [10.2.0.0/16] |
     | b0c3pte4o2kn4v12o05p | example-subnet-{{ region-id }}-a | b1g9hv2loamqfnbul7d9 | enptrcle5q3d3ktd33hj |                | {{ region-id }}-a | [10.3.0.0/16] |
     +----------------------+-----------------------------+----------------------+----------------------+----------------+---------------+---------------+
     ```
     
     Подробнее о команде `yc vpc network list-subnets` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/list-subnets.md).

  1. Получите идентификатор группы безопасности `example-sg`:
  
     ```bash
     yc vpc security-group get example-sg | grep "^id"
     ```
     
     Результат:
     
     ```
     id: enpd133ngcnrgc8475cc
     ```
     
     Подробнее о команде `yc vpc security-group get` см. в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/get.md).
  
  1. Создайте балансировщик `example-balancer`:
  
     ```bash
     yc alb load-balancer create example-balancer \
       --network-name example-network \
       --security-group-id <идентификатор_группы_безопасности_example-sg> \
       --location zone={{ region-id }}-a,subnet-id=<идентификатор_подсети_example-subnet-{{ region-id }}-a> \
       --location zone={{ region-id }}-b,subnet-id=<идентификатор_подсети_example-subnet-{{ region-id }}-b> \
       --location zone={{ region-id }}-c,subnet-id=<идентификатор_подсети_example-subnet-{{ region-id }}-c>
     ```
     
     Результат:
     
     ```hcl
     done (3m0s)
     id: ds77q7v39b4ubg8ta2n4
     name: example-balancer
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
     created_at: "2022-04-04T10:55:49.134935148Z"
     ```
     
     Подробнее о команде `yc alb load-balancer create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/create.md).
     
  1. Добавьте к балансировщику обработчик:
  
     ```bash
     yc alb load-balancer add-listener \
       --name example-balancer \
       --listener-name example-listener \
       --external-ipv4-endpoint port=80 \
       --http-router-name example-router
     ```
     
     Результат:
     
     ```
     done (43s)
     id: ds77q7v39b4ubg8ta2n4
     name: example-balancer
     folder_id: b1g9hv2loamqfnbul7d9
     status: ACTIVE
     region_id: {{ region-id }}
     network_id: enptrcle5q3d3ktd33hj
     listeners:
     - name: example-listener
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
     created_at: "2022-04-04T10:55:49.134935148Z"
     ```
     
     Подробнее о команде `yc alb load-balancer add-listener` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md).

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры L7-балансировщика `example-balancer`:
  
     ```hcl
     ...
     
     resource "yandex_alb_load_balancer" "example-balancer" {
       name               = "example-balancer"
       network_id         = ${yandex_vpc_network.example-network.id}
       security_group_ids = [ ${yandex_vpc_security_group.example-sg.id} ]
     
       allocation_policy {
         location {
           zone_id   = "{{ region-id }}-a"
           subnet_id = ${yandex_vpc_subnet.example-subnet-{{ region-id }}-a.id}
         }
     
         location {
           zone_id   = "{{ region-id }}-b"
           subnet_id = ${yandex_vpc_subnet.example-subnet-{{ region-id }}-b.id}
         }
     
         location {
           zone_id   = "{{ region-id }}-c"
           subnet_id = ${yandex_vpc_subnet.example-subnet-{{ region-id }}-c.id}
         }
       }
     
       listener {
         name = "example-listener"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [80]
         }
         http {
           handler {
             http_router_id = ${yandex_alb_http_router.example-router.id}
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

  Используйте вызов gRPC API [LoadBalancerService/Create](../../application-load-balancer/api-ref/grpc/load_balancer_service.md#Create) или метод REST API [create](../../application-load-balancer/api-ref/LoadBalancer/create.md).
          
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
        * **L7-балансировщик** — `example-balancer`.
        * **IP-адрес** — IP-адрес, назначенный балансировщику (будет единственным в списке).
        * **Доменные имена для раздачи контента** — `cdn.yandexcloud.example`.

          {% note alert %}

          Доменное имя `cdn.yandexcloud.example` станет основным и его будет невозможно изменить после создания CDN-ресурса.

          {% endnote %}

        * В блоке **Дополнительно**:

          * В поле **Протокол для источников** выберите **HTTP**. 
          * В поле **Переадресация клиентов** выберите **Не использовать**.
          * Выберите опцию **Доступ конечных пользователей к контенту**.
          * В поле **Тип сертификата** выберите **Let's Encrypt®**, чтобы автоматически выпустить сертификат для доменного имени `cdn.yandexcloud.example` после создания CDN-ресурса.
          * В поле **Заголовок Host** выберите **Как у клиента**.

     1. Нажмите кнопку **Создать**.

     Дождитесь выпуска сертификата Let's Encrypt® для доменного имени. Этот процесс может занять до 30 минут.
    
  1. Включите переадресацию клиентов с HTTP на HTTPS:

     1. На вкладке ![image](../../_assets/cdn/cdn-res.svg) **CDN-ресурсы** выберите ресурс, созданный ранее.
     1. Убедитесь, что в блоке **Дополнительно** статус сертификата изменился на `Выпущен`.
     1. Справа сверху нажмите кнопку ![image](../../_assets/pencil.svg) **Редактировать**.
     1. В блоке **Дополнительно** в поле **Переадресация клиентов** выберите **С HTTP на HTTPS**.
     1. Нажмите кнопку **Сохранить**.

- CLI

  1. Если CDN-провайдер ещё не активирован, выполните команду:

      ```bash
      yc cdn provider activate --folder-id <идентификатор_каталога> --type gcore
      ```

  1. Создайте группу источников `example-origin-group`, указав IP-адрес балансировщика:

      ```bash
      yc cdn origin-group create --name "example-origin-group" \
        --origin source=<IP-адрес_балансировщика>:80,enabled=true
      ```

      Результат:

      ```
      id: "90748"
      folder_id: b1geoelk7fldts6chmjq
      name: example-origin-group
      use_next: true
      origins:
      - id: "562449"
        origin_group_id: "90748"
        source: 51.250.10.216:80
        enabled: true
      ```

      Подробнее о команде `yc cdn origin-group create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/origin-group/create.md).


  1. Скопируйте идентификатор группы источников `origin_group_id` из предыдущего шага и создайте CDN-ресурс, выполнив команду:
  
      ```bash
      yc cdn resource create \
        --cname cdn.yandexcloud.example \
        --origin-group-id <идентификатор_группы_источников> \
        --origin-protocol http \
        --lets-encrypt-gcore-ssl-cert \
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
      ...
      ```

      Подробнее о команде `yc cdn resource create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/cdn/resource/create.md).

  1. Включите переадресацию клиентов для ресурса:

     ```bash
     yc cdn resource update <ID_ресурса> --redirect-http-to-https
     ```

- {{ TF }}

  1. Добавьте в конфигурационный файл параметры CDN-ресурсов:
      ```hcl
      ...

      resource "yandex_cdn_origin_group" "my_group" {
        name     = "example-origin-group"
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
          origin_group_id     = yandex_cdn_origin_group.my_group.id
          ssl_certificate {
            type = "lets_encrypt_gcore"
          }
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

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

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

     Если конфигурация описана верно, в терминале отобразится список обновляемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  
  1. Если ошибок нет, выполните команду:

      ```bash
      terraform apply
      ```

  1. Подтвердите обновление ресурса: введите в терминал слово `yes` и нажмите **Enter**.
      
  После этого для у ресурса будет включена переадресация.

- API

  Используйте вызов gRPC API [ResourceService/Create](../../cdn/api-ref/grpc/resource_service.md#Create) или метод REST API [create](../../cdn/api-ref/Resource/create.md).
  
{% endlist %}

## Настройте DNS для сервиса {#configure-dns}

Доменное имя `cdn.yandexcloud.example` должно быть связано с CDN-ресурсом с помощью записей [DNS](../../glossary/dns.md).

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
1. Создайте или измените CNAME-запись для `cdn.yandexcloud.example` так, чтобы она указывала на скопированное доменное имя:

   ```
   cdn CNAME cl-....edgecdn.ru
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
        1. Укажите **Имя** зоны: `example-dns-zone`.
        1. Нажмите кнопку **Создать**.
      
     1. Создайте в зоне CNAME-запись для `cdn.yandexcloud.example`:

        1. В списке зон нажмите на зону `example-dns-zone`.
        1. Нажмите кнопку **Создать запись**.
        1. В поле **Имя** укажите `cdn`.
        1. Выберите **Тип** записи — **CNAME**.
        1. В поле **Значение** вставьте скопированное значение вида `cl-....edgecdn.ru`.
        1. Нажмите кнопку **Создать**.

   - CLI
   
     1. Если у вас нет публичной зоны DNS, создайте ее:
     
        ```bash
        yc dns zone create \
          --name example-dns-zone \
          --zone yandexcloud.example. \
          --public-visibility
        ```
        
        Результат:
        
        ```
        id: dns4rq4tadddth4h20qm
        folder_id: b1g9hv2loamqfnbul7d9
        created_at: "2022-04-04T11:03:28.847Z"
        name: example-dns-zone
        zone: yandexcloud.example.
        public_visibility: {}
        ```
        
        Подробнее о команде `yc dns zone create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/dns/zone/create.md).
        
     1. Создайте в зоне CNAME-запись для `cdn.yandexcloud.example` со скопированным значением вида `cl-....edgecdn.ru`:
     
        ```bash
        yc dns zone add-records \
          --name example-dns-zone \
          --record "cdn CNAME cl-....edgecdn.ru" \
        ```

        Подробнее о команде `yc dns zone add-records` см. в [справочнике CLI](../../cli/cli-ref/managed-services/dns/zone/add-records.md).
   
   - {{ TF }}
   
     1. Добавьте в конфигурационный файл параметры DNS-зоны `example-dns-zone` и CNAME-записей в ней:
     
        ```
        ...
        
        resource "yandex_dns_zone" "example-dns-zone" {
          zone   = "yandexcloud.example."
          name   = "example-dns-zone"
          public = true
        }
        
        resource "yandex_dns_recordset" "example-recordset" {
          zone_id = ${yandex_dns_zone.example-dns-zone.id}
          name    = "cdn"
          type    = "CNAME"
          data    = ["<скопированное_значение_вида_cl-....edgecdn.ru>"]
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
    
     1. Создайте DNS-зону `example-dns-zone` с помощью вызова gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/dns_zone_service.md#Create) или метода REST API [create](../../dns/api-ref/DnsZone/create.md).
     1. Добавьте в зону CNAME-запись `cdn` со скопированным значением вида `cl-....edgecdn.ru` с помощью вызова gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/dns_zone_service.md#UpdateRecordSets) или метода REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md).
        
   {% endlist %}
   
   {% endcut %}

{% include [after-creation-tip-tutorials](../../_includes/cdn/after-creation-tip-tutorials.md) %}

## Проверьте работу сервиса {#check}

Чтобы проверить работу сервиса, откройте в браузере адрес `https://cdn.yandexcloud.example/index.html`. Вы должны увидеть страницу с таким содержанием:

   ```html
   <!DOCTYPE html>
   <html>
     <head>
       <title>My service</title>
     </head>
     <body>
       <p>The service is working</p>
     </body>
   </html>
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. Если вы настраивали CNAME-записи в {{ dns-name }}, [удалите](../../dns/operations/zone-delete.md) зону DNS `example-dns-zone`.
1. [Удалите](../../cdn/operations/resources/delete-resource.md) CDN-ресурс с основным доменным именем `cdn.yandexcloud.example`.
1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `example-balancer`.
1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета `example-bucket`.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет `example-bucket`.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсети `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b` и `example-subnet-{{ region-id }}-c`.
1. [Удалите](../../vpc/operations/network-delete.md) сеть `example-network`.
