[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Безопасность](index.md) > Запись логов балансировщика в PostgreSQL

# Запись логов балансировщика в PostgreSQL


Вы можете записывать [логи](../../application-load-balancer/concepts/monitoring.md#logging) балансировщика — сообщения с информацией о каждом входящем запросе к балансировщику Yandex Application Load Balancer — в базу данных PostgreSQL.

Для логирования работы балансировщика будет создана [лог-группа](../../logging/concepts/log-group.md) в Cloud Logging. Поставка логов из этой лог-группы в БД будет настроена с помощью ресурсов сервиса Yandex Cloud Functions — [триггера](../../functions/concepts/trigger/cloud-logging-trigger.md) и вызываемой им [функции](../../functions/concepts/function.md).

БД будет создана с помощью сервиса [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md).

Чтобы настроить запись логов:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте группы безопасности](#create-security-groups).
1. [Подготовьте базу данных в Yandex Managed Service for PostgreSQL](#set-up-db).
1. [Создайте группу ВМ](#create-vms).
1. [Создайте лог-группу Yandex Cloud Logging](#create-log-group).
1. [Создайте необходимые ресурсы в Yandex Application Load Balancer](#create-alb-resources).
1. [Создайте необходимые ресурсы в Yandex Cloud Functions](#set-up-sf).
1. [Проверьте запись логов](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Виртуальные машины: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../../compute/pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Функции Yandex Cloud Functions: количество вызовов функции, время простоя подготовленных экземпляров и выделенные для выполнения функции вычислительные ресурсы ([тарифы Yandex Cloud Functions](../../functions/pricing.md)).
* Логи Cloud Logging: объем записываемых данных и время их хранения ([тарифы Cloud Logging](../../logging/pricing.md)).
* Балансировщики Application Load Balancer: использование вычислительных ресурсов каждого активного балансировщика ([тарифы Application Load Balancer](../../application-load-balancer/pricing.md)).


## Создайте облачную сеть {#create-network}

Все созданные ресурсы будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте [консоль управления](https://console.yandex.cloud).
    1. Перейдите в сервис **Virtual Private Cloud**.
    1. Нажмите кнопку **Создать сеть**.
    1. Укажите **Имя** сети: `alb-logging-network`.
    1. В поле **Дополнительно** выберите опцию **Создать подсети**.
    1. Нажмите кнопку **Создать сеть**.
    
{% endlist %}

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. В поле **Имя** введите `alb-logging-service-account`.
  1. Добавьте роли: `functions.functionInvoker` и `editor`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые: 
* разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик; 
* разрешают балансировщику отправлять логи в лог-группу, а кластеру PostgreSQL — получать логи из нее.

Вы создадите три группы безопасности: для балансировщика, для всех ВМ и для кластера.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Откройте вкладку **Группы безопасности**.
  1. Создайте группу безопасности для балансировщика:
     
     1. Нажмите кнопку **Создать группу безопасности**.
     1. Укажите **Имя** группы: `alb-logging-sg-balancer`.
     1. Выберите **Сеть** `alb-logging-network`.
     1. В блоке **Правила** создайте следующие правила по инструкции под таблицей:

        | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>назначение | CIDR блоки |
        | --- | --- | --- | --- | --- | --- |
        | `Исходящий` | `any` | `Весь` | `Любой` | `CIDR` | `0.0.0.0/0` |
        | `Входящий` | `ext-http` | `80` | `TCP` | `CIDR` | `0.0.0.0/0` |
        | `Входящий` | `ext-https` | `443` | `TCP` | `CIDR` | `0.0.0.0/0` |
        | `Входящий` | `healthchecks` | `30080` | `TCP` | `Проверки состояния балансировщика` | — |
      
        1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.
        1. Нажмите кнопку **Добавить правило**.
        1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **Протокол** укажите нужный протокол или оставьте `Любой`, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **Назначение** или **Источник** выберите назначение правила:
      
           * `CIDR` — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
           * `Группа безопасности` — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
           * `Проверки состояния балансировщика` — правило, которое позволяет балансировщику проверять состояние ВМ.

        1. Нажмите кнопку **Сохранить**. Таким образом создайте все правила из таблицы.
   
     1. Нажмите кнопку **Сохранить**.

  1. Аналогично создайте группу безопасности для ВМ с именем `alb-logging-sg-vms`, той же сетью `alb-logging-network` и следующими правилами:
      
     | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>назначение | CIDR блоки |
     | --- | --- | --- | --- | --- | --- |
     | `Входящий` | `balancer` | `80` | `TCP` | `Группа безопасности` | `alb-logging-sg-balancer` |
     | `Входящий` | `ssh` | `22` | `TCP` | `CIDR` | `0.0.0.0/0` |
     
  1. Аналогично создайте группу безопасности для кластера PostgreSQL с именем `alb-logging-sg-cluster`, той же сетью `alb-logging-network` и следующим правилом:
        
       | Направление<br/>трафика | Описание | Диапазон портов | Протокол | Источник /<br/>назначение | CIDR блоки |
       | --- | --- | --- | --- | --- | --- |
       | `Входящий` | `db` | `6432` | `TCP` | `CIDR` | `0.0.0.0/0` |
     
{% endlist %}

## Подготовьте базу данных в Yandex Managed Service for PostgreSQL {#set-up-db}

### Создайте кластер {#set-up-db-create-cluster}

Логи, полученные от балансировщика, будут записываться в базу данных, которая входит в состав [кластера](../../managed-postgresql/concepts/index.md) Managed Service for PostgreSQL.

Чтобы создать кластер и базу данных:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите кнопку **Создать кластер**.
  1. В поле **Имя кластера** введите `alb-logging-cluster`.
  1. В поле **Окружение** выберите `PRODUCTION`.
  1. В поле **Версия** выберите `17`.
  1. В блоке **Класс хоста**:

     * Укажите платформу `Intel Cascade Lake`.
     * Выберите тип `burstable`.
     * Укажите класс `b2.medium`.

     {% note warning %}

     Класс `b2.medium` был выбран только в рамках тестирования. В реальных проектах использовать хосты с гарантированной долей vCPU ниже 100% не рекомендуется.

     {% endnote %}

  1. В блоке **Размер хранилища**:

     * Выберите `network-ssd`.
     * Укажите размер равным 10 ГБ.

     {% note info %}

     Тип и размер диска следует выбирать в соответствии с решаемыми задачами. Значения, указанные выше, используются для тестирования.

     {% endnote %}

  1. В блоке **База данных** укажите атрибуты БД:

     * Имя базы данных. Имя БД должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
     * Имя пользователя — владельца БД. Имя пользователя должно содержать только латинские буквы, цифры и подчеркивания.
     * Пароль пользователя. Длина — от 8 до 128 символов.

     Для базы данных, которая создается вместе с кластером, устанавливаются настройки набора символов (кодировки) `LC_CTYPE=C` и `LC_COLLATE=C`. После создания эти настройки изменить нельзя, но вы можете [создать новую базу](../../managed-postgresql/operations/databases.md#add-db) с нужными настройками.

  1. В блоке **Сетевые настройки**:

     * Выберите сеть `alb-logging-network`.
     * Выберите группу безопасности `alb-logging-sg-cluster`.
   
  1. В блоке **Хосты** добавьте хост, который будет доступен извне Yandex Cloud. Для этого включите опцию **Публичный доступ**.
  1. В блоке **Дополнительные настройки** включите опции **Доступ из консоли управления** и **Доступ из Serverless**.
  1. Остальные поля оставьте заполненными по умолчанию.
  1. Нажмите кнопку **Создать кластер**.

{% endlist %}

Подробнее о создании кластера — в разделе [Как создать кластер PostgreSQL](../../managed-postgresql/operations/cluster-create.md#create-cluster).

В дальнейшем настройки кластера можно будет [изменить](../../managed-postgresql/operations/update.md).

### Подключитесь к кластеру и создайте таблицу {#set-up-db-create-table}

В качестве примера в базу данных PostgreSQL будет записываться информация из следующих полей сообщений, которые балансировщик записывает в логи при входящих запросах:

* `type` — протокол запроса: HTTP или gRPC.
* `time` — дата и время запроса.
* `http_status` — HTTP-код ответа балансировщика на запрос.
* `backend_ip` — IP-адрес ВМ, обработавшей запрос.
* `request_processing_times.request_time` — длительность соединения между клиентом и балансировщиком.

Таблицу для записи нужно создать заранее:

{% list tabs group=instructions %}

- Консоль управления {#console}

  После [создания кластера](#set-up-db-create-cluster) вы автоматически будете перенаправлены на страницу **Кластеры**.

  1. Дождитесь, когда статус кластера `alb-logging-cluster` изменится на **Alive**, и выберите этот кластер.
  1. Перейдите на вкладку **SQL**.
  1. Выберите пользователя, [созданного вместе с кластером](#set-up-db-create-cluster), и введите его пароль.
  1. Выберите базу данных, созданную вместе с кластером, и нажмите кнопку **Подключиться**.
  1. В окне редактирования введите следующий запрос:
  
     ```sql
     CREATE TABLE load_balancer_requests (
         type            varchar(24) NOT NULL,
         "time"          timestamptz NOT NULL,
         http_status     varchar(4) NOT NULL,
         backend_ip      varchar(40) NULL,
         request_time    numeric NULL
     );
     ```

  1. Нажмите кнопку **Выполнить**.
  1. Дождитесь появления надписи о завершении выполнения запроса.
  
{% endlist %}
    
## Создайте группу ВМ {#create-vms}

В качестве веб-серверов для сайта будет выступать [группа виртуальных машин](../../compute/concepts/instance-groups/index.md) Compute Cloud. Серверы будут реализованы на LEMP-стеке (Linux, nginx, MySQL, PHP; подробнее смотрите [Сайт на LAMP- или LEMP-стеке](../web/lamp-lemp/index.md)).

Чтобы создать группу ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Compute Cloud**.
  1. Откройте вкладку **Группы виртуальных машин**. Нажмите кнопку **Создать группу виртуальных машин**.
  1. Укажите имя группы ВМ: `alb-logging-ig`.
  1. В поле **Сервисный аккаунт** выберите аккаунт, [созданный ранее](#create-sa).
  1. В блоке **Распределение** выберите несколько [зон доступности](../../overview/concepts/geo-scope.md), чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать**.
  1. В блоке **Образ загрузочного диска** откройте вкладку **Marketplace** и нажмите кнопку **Показать все продукты Marketplace**. Выберите продукт [LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp) и нажмите кнопку **Использовать**.
  1. В блоке **Вычислительные ресурсы**:
     
     - Выберите [платформу](../../compute/concepts/vm-platforms.md) виртуальной машины.
     - Укажите необходимое количество vCPU и объем RAM.
  
     Для функционального тестирования сайта хватит минимальной конфигурации:
     * **Платформа** — `Intel Cascade Lake`.
     * **Гарантированная доля vCPU** — `5%`.
     * **vCPU** — `2`.
     * **RAM** — `1 ГБ`.
  
  1. В блоке **Сетевые настройки** выберите **Сеть** `alb-logging-network`, [созданную ранее](#create-network), и ее подсети.
  1. В поле **Публичный адрес** выберите **Автоматически**. 
  1. Выберите группу безопасности `alb-logging-sg-vms`, [созданную ранее](#create-security-groups).
  1. Укажите данные для доступа на виртуальную машину:
     - В поле **Логин** введите имя пользователя.
     - В поле **SSH-ключ** вставьте содержимое файла открытого ключа.
        
       Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать самостоятельно](../../compute/operations/vm-connect/ssh.md).
        
     {% note alert %}
      
     IP-адрес и имя хоста ([FQDN](../../glossary/fqdn.md)) для подключения к машине назначатся ей при создании. Если вы выбрали вариант **Без адреса** в поле **Публичный адрес**, вы не сможете обращаться к ВМ из интернета.
      
     {% endnote %}
     
  1. Нажмите кнопку **Сохранить**.
  1. В блоке **Масштабирование** укажите **Размер** группы ВМ — 2.
  1. В блоке **Интеграция с Application Load Balancer** выберите опцию **Создать целевую группу** и укажите имя группы — `alb-logging-tg`. [Подробнее о целевых группах](../../application-load-balancer/concepts/target-group.md).
  1. Нажмите кнопку **Создать**.
  
{% endlist %}

Создание группы ВМ может занять несколько минут. После создания группа перейдет в [статус](../../compute/concepts/instance-groups/statuses.md#group-statuses) `RUNNING`, а все ВМ в ней — в [статус](../../compute/concepts/instance-groups/statuses.md#vm-statuses) `RUNNING_ACTUAL`.

![ig-running](../../_assets/application-load-balancer/tutorials/virtual-hosting/ig-running.png)

## Создайте лог-группу Yandex Cloud Logging {#create-log-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать [лог-группу](../../logging/concepts/log-group.md).
    1. Перейдите в сервис **Cloud Logging**.
    1. Нажмите кнопку **Создать группу**.
    1. Введите имя и описание лог-группы, например `alb-logging-group`.
    1. Укажите срок хранения записей в лог-группе.
    1. Нажмите кнопку **Создать группу**.

{% endlist %}

## Создайте необходимые ресурсы в Yandex Application Load Balancer {#create-alb-resources}

### Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, нужно привязать к [группе бэкендов](../../application-load-balancer/concepts/backend-group.md) с настройками распределения трафика.

Для бэкендов в группе будет создана [проверка состояния](../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **Группы бэкендов**. Нажмите кнопку **Создать группу бэкендов**.
  1. Укажите **Имя** группы бэкендов: `alb-logging-bg`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить**.
  1. Укажите **Имя** бэкенда: `alb-logging-backend`.
  1. В поле **Целевые группы** выберите группу `alb-logging-tg`.
  1. Укажите **Порт**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
  1. Нажмите кнопку **Добавить проверку состояния**.
  1. Укажите **Порт**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
  1. Укажите **Путь**, к которому будет обращаться балансировщик при проверке состояния: `/`.
  1. Нажмите кнопку **Создать**.
  
{% endlist %}

### Создайте и настройте HTTP-роутер {#create-http-router}

Группу бэкендов нужно привязать к [HTTP-роутеру](../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации HTTP-запросов.

Чтобы создать HTTP-роутер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **HTTP-роутеры**. Нажмите кнопку **Создать HTTP-роутер**.
  1. Укажите **Имя** HTTP-роутера: `alb-logging-router`.
  1. Нажмите кнопку **Добавить виртуальный хост**.
  1. Укажите **Имя** виртуального хоста: `alb-logging-host`.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Укажите **Имя** маршрута: `alb-logging-route`.
  1. В поле **Группа бэкендов** выберите группу `alb-logging-bg`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте L7-балансировщик {#create-l7-balancer}

Чтобы создать балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Application Load Balancer**.
  1. Нажмите кнопку **Создать L7-балансировщик** и выберите опцию **Вручную**.
  1. Укажите **Имя** балансировщика: `alb-logging-balancer`.
  1. В блоке **Сетевые настройки** выберите сеть `alb-logging-network` и группу безопасности `alb-logging-sg-balancer`, созданные ранее.
  1. В блоке **Настройки логов** укажите лог-группу `alb-logging-group`.
  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**.
  1. Укажите **Имя** обработчика: `alb-logging-listener`.
  1. В поле **Протокол** выберите пункт `HTTPS`.
  1. В поле **HTTP-роутер** выберите роутер `alb-logging-router`, [созданный ранее](#create-http-router).
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте необходимые ресурсы в Yandex Cloud Functions {#set-up-sf}

### Создайте функцию для обработки данных {#set-up-sf-create-function}

[Функция](../../functions/concepts/function.md) будет получать сообщения из лог-группы и записывать их в таблицу, [созданную ранее](#set-up-db-create-table).

Чтобы создать функцию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Cloud Functions**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя функции: `alb-logging-function`.
  1. Нажмите кнопку **Создать**. После создания функции вы автоматически будете перенаправлены на страницу **Редактор**.
  1. Выберите среду выполнения **Python** версии **3.8** и нажмите кнопку **Продолжить**.
  1. Очистите область редактирования файла и вставьте в нее следующий код:
  
     {% cut "Код функции" %}
     
     ```python
     import os
     import logging
     import psycopg2
     import json
     
     logger = logging.getLogger()
     logger.setLevel(logging.INFO)
     verboseLogging = eval(os.environ['VERBOSE_LOG'])
     if verboseLogging:
         logger.info('Loading handler function')
     
     def handler(event, context):
         statusCode = 500
         
         if verboseLogging:
             logger.info(event)
             logger.info(context)
         
         connection_string = (
             "host='{db_hostname}' port='{db_port}' dbname='{db_name}' "
             "user='{db_user}' password='{db_password}' sslmode='require'"
         ).format(
             db_hostname=os.environ['DB_HOSTNAME'],
             db_port=os.environ['DB_PORT'],
             db_name=os.environ['DB_NAME'],
             db_user=os.environ['DB_USER'],
             db_password=os.environ['DB_PASSWORD']
         )
             
         if verboseLogging:
             logger.info(f'Connecting: {connection_string}')
     
         conn = psycopg2.connect(connection_string)
         cursor = conn.cursor()
     
         messages = event['messages'][0]['details']['messages']
     
         for message in messages:
             alb_message = message['json_payload']
             alb_message['table_name'] = 'load_balancer_requests'
             insert_statement = (
                 'INSERT INTO {table_name} ' 
                 '(type, "time", http_status, backend_ip, request_time) ' 
                 'VALUES(\'{type}\', timestamptz \'{time}\', \'{http_status}\', ' 
                 '\'{backend_ip}\', {request_processing_times[request_time]});'
             ).format(**alb_message)
     
             if verboseLogging:
                 logger.info(f'Exec: {insert_statement}')
             try:
                 cursor.execute(insert_statement)
                 statusCode = 200
             except Exception as error:
                 logger.error(error)
             
             conn.commit()
             
         cursor.close()
         conn.close()
     
         return {
             'statusCode': statusCode,
             'headers': {
                 'Content-Type': 'text/plain'
             }
         }
     ```

     {% endcut %}
  
  1. Задайте следующие параметры версии:
  
     * **Таймаут** — `10`.
     * **Память** — `128 МБ`.
  
  1. Выберите созданный ранее сервисный аккаунт `alb-logging-service-account`. От имени этого аккаунта функция будет записывать данные в БД.
  
  1. Добавьте переменные окружения:
  
     * `VERBOSE_LOG` — параметр, отвечающий за вывод подробной информации о выполнении функции. Введите значение `True`.
     * `DB_HOSTNAME` — имя хоста БД PostgreSQL для подключения.
     * `DB_PORT` — порт для подключения.
     * `DB_NAME` — имя базы данных для подключения.
     * `DB_USER` — имя пользователя для подключения.
     * `DB_PASSWORD` — пароль, который был введен при [создании кластера](#cluster).
  
     Чтобы определить значения параметров для подключения:
  
     1. Откройте [консоль управления](https://console.yandex.cloud).
     1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
     1. Выберите кластер `alb-logging-cluster`.
     1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке с нужной БД.
     1. Выберите пункт **Подключиться**.
     1. На вкладке **Shell** найдите пример строки подключения.
     1. Перенесите значения переменных `host`, `port`, `dbname` и `user` в соответствующее поле **Значение** переменных окружения функции.
  
  1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

### Создайте триггер {#set-up-sf-create-trigger}

[Триггер](../../functions/concepts/trigger/index.md) будет принимать копии сообщений от балансировщика и передавать их в функцию для обработки.

Чтобы создать триггер:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать триггер.

    1. Перейдите в сервис **Cloud Functions**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя триггера, например `alb-logging-trigger`.
        * В поле **Тип** выберите `Cloud Logging`.
        * В поле **Запускаемый ресурс** выберите `Функция`.

    1. В блоке **Настройки Cloud Logging**:
        * В поле **Лог-группа** выберите `alb-logging-group`.
        * В поле **Типы ресурсов** укажите `alb.loadBalancer`.

    1. В блоке **Настройки группирования сообщений**:
        * В поле **Время ожидания, с** укажите `15`.
        * В поле **Размер группы** укажите `10`.

    1. В блоке **Настройки функции** выберите функцию, созданную ранее, и укажите:

        * тег версии функции — `$latest`;
        * сервисный аккаунт, созданный ранее.

    1. Нажмите кнопку **Создать триггер**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create logging alb-logging-trigger \
      --log-group-name <имя_лог-группы> \
      --resource-types alb.loadBalancer \
      --batch-size 10 \
      --batch-cutoff 15s \
      --invoke-function-name alb-logging-function \
      --invoke-function-service-account-name alb-logging-service-account \
    ```

  Где:

  * `--log-group-name` — имя лог-группы, [созданной ранее](#create-log-group).
  * `--resource-types` — типы ресурсов лог-группы.
  * `--invoke-function-name` — имя функции, [созданной ранее](#set-up-sf-create-function).
  * `--invoke-function-service-account-name` — имя сервисного аккаунта, созданного вместе с функцией.
  * `--batch-size` — максимальное количество сообщений, одновременно отправляемых в функцию.
  * `--batch-cutoff` — максимальное время между последовательными отправками сообщений в функцию.
  
  Подробнее о команде смотрите в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/trigger/create/logging.md).
  
- API {#api}

  Используйте вызов gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) или метод REST API [create](../../functions/triggers/api-ref/Trigger/create.md).
  
{% endlist %}
  
## Проверьте работу балансировщика и запись логов {#test}

1. Получите публичный IP-адрес балансировщика:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. Откройте [консоль управления](https://console.yandex.cloud).
     1. Перейдите в сервис **Application Load Balancer**.
     1. Найдите в списке балансировщик `alb-logging-balancer` и скопируйте его IP-адрес.
     
   {% endlist %}
   
1. Откройте в браузере сайт `http://<IP-адрес_балансировщика>`. Перезагрузите страницу несколько раз.
1. Проверьте, что в логах появилась информация о ваших запросах к балансировщику:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. Откройте [консоль управления](https://console.yandex.cloud).
     1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
     1. Выберите кластер `alb-logging-cluster`.
     1. Перейдите на вкладку **SQL**.
     1. Выберите пользователя, [созданного вместе с кластером](#set-up-db-create-cluster), и введите его пароль.
     1. Выберите базу данных, созданную вместе с кластером, и нажмите **Подключиться**.
     1. Нажмите на таблицу `load_balancer_requests`. Вы должны увидеть первые строки этой таблицы, соответствующие вашим запросам к балансировщику.
     
   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу балансировщика и перестать платить за созданные ресурсы: 

1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `alb-logging-balancer`.
1. [Удалите](../../application-load-balancer/operations/http-router-delete.md) HTTP-роутер `alb-logging-router`.
1. [Удалите](../../application-load-balancer/operations/backend-group-delete.md) группу бэкендов `alb-logging-bg`.
1. [Удалите](../../compute/operations/instance-groups/delete.md) группу виртуальных машин `alb-logging-ig`.
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер `alb-logging-trigger`.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию `alb-logging-function`.
1. [Удалите](../../managed-postgresql/operations/cluster-delete.md) кластер `alb-logging-cluster`.
1. [Удалите](../../logging/operations/delete-group.md) лог-группу `alb-logging-group`.