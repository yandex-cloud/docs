# Запись логов балансировщика в {{ PG }}


Вы можете записывать [логи](../../application-load-balancer/concepts/application-load-balancer.md#logging) балансировщика — сообщения с информацией о каждом входящем запросе к балансировщику {{ alb-full-name }} — в базу данных {{ PG }}.

Для логирования работы балансировщика будет создана [лог-группа](../../logging/concepts/log-group.md) в {{ cloud-logging-name }}. Поставка логов из этой лог-группы в БД будет настроена с помощью ресурсов сервиса {{ sf-full-name }} — [триггера](../../functions/concepts/trigger/cloud-logging-trigger.md) и вызываемой им [функции](../../functions/concepts/function.md).

БД будет создана с помощью сервиса [{{ mpg-full-name }}](../../managed-postgresql/index.yaml).

Чтобы настроить запись логов:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте группы безопасности](#create-security-groups).
1. [Подготовьте базу данных в {{ mpg-full-name }}](#set-up-db).
1. [Создайте группу ВМ](#create-vms).
1. [Создайте лог-группу {{ cloud-logging-full-name }}](#create-log-group).
1. [Создайте необходимые ресурсы в {{ alb-full-name }}](#create-alb-resources).
1. [Создайте необходимые ресурсы в {{ sf-full-name }}](#set-up-sf).
1. [Проверьте запись логов](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки балансировщика с записью логов входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за вычислительные ресурсы, объем хранилища и резервных копий для кластера {{ PG }} (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md));
* плата за вызовы функции для обработки логов и вычислительные ресурсы, выделенные на выполнение функции (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за запись и хранение логов (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md));
* плата за использование ресурсов {{ alb-name }} (см. [тарифы {{ alb-full-name }}](../../application-load-balancer/pricing.md)).


## Создайте облачную сеть {#create-network}

Все созданные ресурсы будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
    1. Укажите **{{ ui-key.yacloud.vpc.networks.create.field_name }}** сети: `alb-logging-network`.
    1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
    
{% endlist %}

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** введите `alb-logging-service-account`.
  1. Добавьте роли: `{{ roles-functions-invoker }}` и `editor`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые: 
* разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик; 
* разрешают балансировщику отправлять логи в лог-группу, а кластеру {{ PG }} — получать логи из нее.

Вы создадите три группы безопасности: для балансировщика, для всех ВМ и для кластера.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Создайте группу безопасности для балансировщика:
     
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Укажите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** группы: `alb-logging-sg-balancer`.
     1. Выберите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** `alb-logging-network`.
     1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:

        | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
        | --- | --- | --- | --- | --- | --- |
        | `Исходящий` | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Входящий` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Входящий` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | `Входящий` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — |
      
        1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите назначение правила:
      
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` — правило, которое позволяет балансировщику проверять состояние ВМ.

        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.
   
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  1. Аналогично создайте группу безопасности для ВМ с именем `alb-logging-sg-vms`, той же сетью `alb-logging-network` и следующими правилами:
      
     | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
     | --- | --- | --- | --- | --- | --- |
     | `Входящий` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `alb-logging-sg-balancer` |
     | `Входящий` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
     
  1. Аналогично создайте группу безопасности для кластера {{ PG }} с именем `alb-logging-sg-cluster`, той же сетью `alb-logging-network` и следующим правилом:
        
       | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br/>назначение | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
       | --- | --- | --- | --- | --- | --- |
       | `Входящий` | `db` | `6432` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
     
{% endlist %}

## Подготовьте базу данных в {{ mpg-full-name }} {#set-up-db}

### Создайте кластер {#set-up-db-create-cluster}

Логи, полученные от балансировщика, будут записываться в базу данных, которая входит в состав [кластера](../../managed-postgresql/concepts/index.md) {{ mpg-name }}.

Чтобы создать кластер и базу данных:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите `alb-logging-cluster`.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** выберите `PRODUCTION`.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите `12`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}**:

     * Укажите платформу `Intel Cascade Lake`.
     * Выберите тип `burstable`.
     * Укажите класс `b2.medium`.

     {% note warning %}

     Класс `b2.medium` был выбран только в рамках тестирования. В реальных проектах использовать хосты с гарантированной долей vCPU ниже 100% не рекомендуется.

     {% endnote %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * Выберите `network-ssd`.
     * Укажите размер равным 10 ГБ.

     {% note info %}

     Тип и размер диска следует выбирать в соответствии с решаемыми задачами. Значения, указанные выше, используются для тестирования.

     {% endnote %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите атрибуты БД:

     * Имя базы данных. Имя БД должно быть уникальным в рамках каталога и содержать только латинские буквы, цифры и подчеркивания.
     * Имя пользователя — владельца БД. Имя пользователя должно содержать только латинские буквы, цифры и подчеркивания.
     * Пароль пользователя. Длина — от 8 до 128 символов.

     Для базы данных, которая создается вместе с кластером, устанавливаются настройки набора символов (кодировки) `LC_CTYPE=C` и `LC_COLLATE=C`. После создания эти настройки изменить нельзя, но вы можете [создать новую базу](../../managed-postgresql/operations/databases.md#add-db) с нужными настройками.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:

     * Выберите сеть `alb-logging-network`.
     * Выберите группу безопасности `alb-logging-sg-cluster`.
   
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** добавьте хост, который будет доступен извне {{ yandex-cloud }}. Для этого включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** включите опции **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** и **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**.
  1. Остальные поля оставьте заполненными по умолчанию.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

Подробнее о создании кластера — в разделе [Как создать кластер PostgreSQL](../../managed-postgresql/operations/cluster-create.md#create-cluster).

В дальнейшем настройки кластера можно будет [изменить](../../managed-postgresql/operations/update.md).

### Подключитесь к кластеру и создайте таблицу {#set-up-db-create-table}

В качестве примера в базу данных {{ PG }} будет записываться информация из следующих полей сообщений, которые балансировщик записывает в логи при входящих запросах:

* `type` — протокол запроса: HTTP или gRPC.
* `time` — дата и время запроса.
* `http_status` — HTTP-код ответа балансировщика на запрос.
* `backend_ip` — IP-адрес ВМ, обработавшей запрос.
* `request_processing_times.request_time` — длительность соединения между клиентом и балансировщиком.

Таблицу для записи нужно создать заранее:

{% list tabs group=instructions %}

- Консоль управления {#console}

  После [создания кластера](#set-up-db-create-cluster) вы автоматически будете перенаправлены на страницу **{{ ui-key.yacloud.mdb.clusters.label_title }}**.

  1. Дождитесь, когда статус кластера `alb-logging-cluster` изменится на **Alive**, и выберите этот кластер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
  1. Выберите пользователя, [созданного вместе с кластером](#set-up-db-create-cluster), и введите его пароль.
  1. Выберите базу данных, созданную вместе с кластером, и нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
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

  1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.
  1. Дождитесь появления надписи о завершении выполнения запроса.
  
{% endlist %}
    
## Создайте группу ВМ {#create-vms}

В качестве веб-серверов для сайта будет выступать [группа виртуальных машин](../../compute/concepts/instance-groups/index.md) {{ compute-name }}. Серверы будут реализованы на LEMP-стеке (Linux, nginx, MySQL, PHP; подробнее см. [Веб-сайт на LAMP- или LEMP-стеке](../../tutorials/web/lamp-lemp/index.md)).

Чтобы создать группу ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.compute.switch_groups }}**. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Укажите имя группы ВМ: `alb-logging-ig`.
  1. В поле **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** выберите аккаунт, [созданный ранее](#create-sa).
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите несколько зон доступности, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** откройте вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Выберите продукт [LEMP](/marketplace/products/yc/lemp) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     
     - Выберите [платформу](../../compute/concepts/vm-platforms.md) виртуальной машины.
     - Укажите необходимое количество vCPU и объем RAM.
  
     Для функционального тестирования сайта хватит минимальной конфигурации:
     * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Cascade Lake`.
     * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `5%`.
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** `alb-logging-network`, [созданную ранее](#create-network), и ее подсети.
  1. В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите **{{ ui-key.yacloud.compute.instances.create.value_address-auto }}**. 
  1. Выберите группу безопасности `alb-logging-sg-vms`, [созданную ранее](#create-security-groups).
  1. Укажите данные для доступа на виртуальную машину:
     - В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     - В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.
        
       Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. [раздел о подключении к виртуальным машинам по SSH](../../compute/operations/vm-connect/ssh.md).
        
     {% note alert %}
      
     IP-адрес и имя хоста ([FQDN](../../glossary/fqdn.md)) для подключения к машине назначатся ей при создании. Если вы выбрали вариант **{{ ui-key.yacloud.compute.instances.create.value_address-none }}** в поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}**, вы не сможете обращаться к ВМ из интернета.
      
     {% endnote %}
     
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** укажите **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** группы ВМ — 2.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** выберите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** и укажите имя группы — `alb-logging-tg`. [Подробнее о целевых группах](../../application-load-balancer/concepts/target-group.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
{% endlist %}

Создание группы ВМ может занять несколько минут. После создания группа перейдет в [статус](../../compute/concepts/instance-groups/statuses.md#group-statuses) `RUNNING`, а все ВМ в ней — в [статус](../../compute/concepts/instance-groups/statuses.md#vm-statuses) `RUNNING_ACTUAL`.

![ig-running](../../_assets/application-load-balancer/tutorials/virtual-hosting/ig-running.png)

## Создайте лог-группу {{ cloud-logging-full-name }} {#create-log-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [лог-группу](../../logging/concepts/log-group.md).
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. Введите имя и описание лог-группы, например `alb-logging-group`.
    1. Укажите срок хранения записей в лог-группе.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.

{% endlist %}

## Создайте необходимые ресурсы в {{ alb-full-name }} {#create-alb-resources}

### Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, нужно привязать к [группе бэкендов](../../application-load-balancer/concepts/backend-group.md) с настройками распределения трафика.

Для бэкендов в группе будет создана [проверка состояния](../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** группы бэкендов: `alb-logging-bg`.
  1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** бэкенда: `alb-logging-backend`.
  1. В поле **{{ ui-key.yacloud.alb.label_target-groups }}** выберите группу `alb-logging-tg`.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
  1. Укажите **{{ ui-key.yacloud.alb.label_path }}**, к которому будет обращаться балансировщик при проверке состояния: `/`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  
{% endlist %}

### Создайте и настройте HTTP-роутер {#create-http-router}

Группу бэкендов нужно привязать к [HTTP-роутеру](../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации HTTP-запросов.

Чтобы создать HTTP-роутер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** HTTP-роутера: `alb-logging-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** виртуального хоста: `alb-logging-host`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** маршрута: `alb-logging-route`.
  1. В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите группу `alb-logging-bg`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте L7-балансировщик {#create-l7-balancer}

Чтобы создать балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}** и выберите опцию **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** балансировщика: `alb-logging-balancer`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть `alb-logging-network` и группу безопасности `alb-logging-sg-balancer`, созданные ранее.
  1. В блоке **{{ ui-key.yacloud.alb.section_logs-settings }}** укажите лог-группу `alb-logging-group`.
  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** обработчика: `alb-logging-listener`.
  1. В поле **{{ ui-key.yacloud.alb.label_protocol-type }}** выберите пункт `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
  1. В поле **{{ ui-key.yacloud.alb.label_http-router }}** выберите роутер `alb-logging-router`, [созданный ранее](#create-http-router).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте необходимые ресурсы в {{ sf-full-name }} {#set-up-sf}

### Создайте функцию для обработки данных {#set-up-sf-create-function}

[Функция](../../functions/concepts/function.md) будет получать сообщения из лог-группы и записывать их в таблицу, [созданную ранее](#set-up-db-create-table).

Чтобы создать функцию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя функции: `alb-logging-function`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**. После создания функции вы автоматически будете перенаправлены на страницу **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**.
  1. Выберите среду выполнения **Python** версии **3.8** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
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
  
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `10`.
     * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
  
  1. Выберите созданный ранее сервисный аккаунт `alb-logging-service-account`. От имени этого аккаунта функция будет записывать данные в БД.
  
  1. Добавьте переменные окружения:
  
     * `VERBOSE_LOG` — параметр, отвечающий за вывод подробной информации о выполнении функции. Введите значение `True`.
     * `DB_HOSTNAME` — имя хоста БД {{ PG }} для подключения.
     * `DB_PORT` — порт для подключения.
     * `DB_NAME` — имя базы данных для подключения.
     * `DB_USER` — имя пользователя для подключения.
     * `DB_PASSWORD` — пароль, который был введен при [создании кластера](#cluster).
  
     Чтобы определить значения параметров для подключения:
  
     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
     1. Выберите кластер `alb-logging-cluster`.
     1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке с нужной БД.
     1. Выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
     1. На вкладке **Shell** найдите пример строки подключения.
     1. Перенесите значения переменных `host`, `port`, `dbname` и `user` в соответствующее поле **{{ ui-key.yacloud.common.value }}** переменных окружения функции.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Создайте триггер {#set-up-sf-create-trigger}

[Триггер](../../functions/concepts/trigger/index.md) будет принимать копии сообщений от балансировщика и передавать их в функцию для обработки.

Чтобы создать триггер:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя триггера, например `alb-logging-trigger`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}**:
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_log-group }}** выберите `alb-logging-group`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_resource-type }}** укажите `alb.loadBalancer`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**:
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}** укажите `15`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}** укажите `10`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию, созданную ранее, и укажите:

        * тег версии функции — `$latest`;
        * сервисный аккаунт, созданный ранее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
  
  Подробнее о команде см. в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/trigger/create/logging.md).
  
- API {#api}

  Используйте вызов gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) или метод REST API [create](../../functions/triggers/api-ref/Trigger/create.md).
  
{% endlist %}
  
## Проверьте работу балансировщика и запись логов {#test}

1. Получите публичный IP-адрес балансировщика:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
     1. Найдите в списке балансировщик `alb-logging-balancer` и скопируйте его IP-адрес.
     
   {% endlist %}
   
1. Откройте в браузере сайт `http://<IP-адрес_балансировщика>`. Перезагрузите страницу несколько раз.
1. Проверьте, что в логах появилась информация о ваших запросах к балансировщику:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
     1. Выберите кластер `alb-logging-cluster`.
     1. Перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
     1. Выберите пользователя, [созданного вместе с кластером](#set-up-db-create-cluster), и введите его пароль.
     1. Выберите базу данных, созданную вместе с кластером, и нажмите **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
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
