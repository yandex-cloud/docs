# Сервисы {{ yandex-cloud }}

_Сервис_ в составе {{ yandex-cloud }} позволяет управлять определенными облачными ресурсами и доступом к ним.

## Список сервисов {{ yandex-cloud }} {#list}

На данный момент в рамках платформы {{ yandex-cloud }} доступны следующие сервисы:

{% if product == "yandex-cloud" %}* [{{ api-gw-full-name }}](../../api-gateway/) (Сервис для создания API-шлюзов).{% endif %}
* [{{ alb-full-name }}](../../application-load-balancer/) (Сервис для распределения входящего трафика между компонентами веб-приложений).
* [{{ at-full-name }}](../../audit-trails/) (Сервис сбора и выгрузки аудитных логов). {% if product == "yandex-cloud" %}_Сервис находится на стадии [Preview](./launch-stages.md)._{% endif %}
* [{{ certificate-manager-full-name }}](../../certificate-manager/) (Сервис для управления TLS-сертификатами).
{% if product == "yandex-cloud" %}* [{{ backup-full-name }}](../../backup/) (Сервис для резервного копирования ресурсов {{ yandex-cloud }}). _Сервис находится на стадии [Preview](./launch-stages.md)._{% endif %}
{% if product == "yandex-cloud" %}* [{{ cdn-full-name }}](../../cdn/) (Сервис для организации сети распространения контента).{% endif %}
{% if product == "yandex-cloud" %}* [{{ cloud-desktop-full-name }}](../../cloud-desktop/) (Сервис для создания удаленных рабочих мест в облаке). _Сервис находится на стадии [Preview](./launch-stages.md)._{% endif %}
* [{{ dns-full-name }}](../../dns/) (Сервис администрирования ресурсных записей {% if lang == "ru" and audience != "internal" %}[DNS](../../glossary/dns.md){% else %}DNS{% endif %} и обслуживания DNS-запросов).
{% if product == "yandex-cloud" %}* [{{ sf-full-name }}](../../functions/) (Сервис бессерверных вычислений).{% endif %}
{% if product == "yandex-cloud" %}* [{{ interconnect-full-name }}](../../interconnect/) (Сервис управления выделенными сетевыми соединениями).{% endif %}
{% if product == "yandex-cloud" %}* [{{ cloud-logging-full-name }}](../../logging/) (Сервис для агрегации и чтения логов пользовательских приложений и ресурсов {{ yandex-cloud }}). _Сервис находится на стадии [Preview](./launch-stages.md)._{% endif %}
* [{{ org-full-name }}](../../organization) (Сервис для управления составом организации, настройки интеграции с каталогом сотрудников и разграничения доступа пользователей к облачным ресурсам организации).
* [{{ compute-full-name }}](../../compute/) (Сервис для создания и управления {% if lang == "ru" and audience != "internal" %}[виртуальными машинами](../../glossary/vm.md){% else %}виртуальными машинами{% endif %}).
* [{{ container-registry-full-name }}](../../container-registry/) (Сервис для управления образами и контейнерами).
{% if product == "yandex-cloud" %}* [{{ dataproc-full-name }}](../../data-proc/) (Сервис для управления кластерами Apache Hadoop®).{% endif %}
{% if product == "yandex-cloud" %}* [{{ yds-full-name }}](../../data-streams/) (Сервис для управления потоками данных в режиме реального времени).{% endif %}
* [{{ data-transfer-full-name }}](../../data-transfer/) (Сервис для миграции баз данных).
{% if product == "yandex-cloud" %}* [{{ ydb-full-name }}](../../ydb/) (Сервис управления для базы данных {{ ydb-full-name }}).{% endif %}
{% if product == "yandex-cloud" %}* [{{ datalens-full-name }}](../../datalens/) (Сервис визуализации и анализа данных).{% endif %}
{% if product == "yandex-cloud" %}* [{{ ml-platform-full-name }}](../../datasphere/) (Сервис для ML-разработки).{% endif %}
{% if product == "yandex-cloud" %}* [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/) (Сервис защиты от DDoS-атак).{% endif %}
{% if product == "yandex-cloud" %}* [{{ forms-full-name }}](../../forms/) (Сервис для создания и интеграции форм).{% endif %}
* [{{ iam-full-name }}](../../iam/) (Сервис для управления доступом к облачным ресурсам).
* [{{ ig-full-name }}](../../compute/concepts/instance-groups/) (Сервис для создания и управления группами виртуальных машин).
{% if product == "yandex-cloud" %}* [{{ iot-full-name }}](../../iot-core/) (Сервис интернета вещей для двустороннего обмена сообщениями между реестрами и устройствами по {% if lang == "ru" and audience != "internal" %}[протоколу MQTT](../../glossary/mqtt-server.md#mqtt-protocol){% else %}протоколу MQTT{% endif %}).{% endif %}
* [{{ kms-full-name }}](../../kms/) (Сервис для управления ключами шифрования).
{% if product == "yandex-cloud" %}* [{{ load-testing-full-name }}](../../load-testing/) (Сервис для проведения нагрузочного тестирования и анализа производительности). _Сервис находится на стадии [Preview](./launch-stages.md)._{% endif %}
* [{{ lockbox-name }}](../../lockbox) (Сервис для создания и хранения секретов в инфраструктуре {{ yandex-cloud }}). {% if product == "yandex-cloud" %}_Сервис находится на стадии [Preview](./launch-stages.md)._{% endif %}
* [{{ mkf-full-name }}](../../managed-kafka/) (Сервис для создания и управления кластерами {{ KF }}).
* [{{ mch-full-name }}](../../managed-clickhouse/) (Сервис для создания и управления кластерами {{ CH }}).
{% if product == "yandex-cloud" %}* [{{ mes-full-name }}](../../managed-elasticsearch/) (Сервис для создания и управления кластерами {{ ES }}).{% endif %}
{% if product == "yandex-cloud" %}* [{{ mgl-full-name }}](../../managed-gitlab/) (Сервис для управления DevOps-платформой {{ GL }}).{% endif %}
{% if product == "yandex-cloud" %}* [{{ mgp-full-name }}](../../managed-greenplum/) (Сервис для создания и управления кластерами {{ GP }}).{% endif %}
* [{{ managed-k8s-full-name }}®](../../managed-kubernetes/) (Сервис для создания и управления кластерами Kubernetes).
{% if product == "yandex-cloud" %}* [{{ mmg-full-name }}](../../managed-mongodb/) (Сервис для создания и управления кластерами {{ MG }}).{% endif %}
* [{{ mmy-full-name }}](../../managed-mysql/) (Сервис для создания и управления кластерами {{ MY }}).
{% if product == "yandex-cloud" %}* [{{ mos-full-name }}](../../managed-opensearch/) (Сервис для создания и управления кластерами {{ OS }}).{% endif %}
* [{{ mpg-full-name }}](../../managed-postgresql/) (Сервис для создания и управления кластерами {{ PG }}).
{% if product == "yandex-cloud" %}* [{{ mrd-full-name }}](../../managed-redis/) (Сервис для создания и управления кластерами {{ RD }}).{% endif %}
{% if product == "yandex-cloud" %}* [{{ mms-full-name }}](../../managed-sqlserver/) (Сервис для создания и управления кластерами {{ MS }}).{% endif %}
{% if product == "yandex-cloud" %}* [{{ message-queue-full-name }}](../../message-queue/) (Сервис очередей для обмена сообщениями между компонентами распределенных приложений и микросервисов).{% endif %}
* [{{ monitoring-full-name }}](../../monitoring/) (Сервис для сбора и визуализации метрик).
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/) (Сервис для распределения сетевой нагрузки по облачным ресурсам).
* [{{ objstorage-full-name }}](../../storage/) (Универсальное масштабируемое облачное объектное хранилище).
* [{{ resmgr-full-name }}](../../resource-manager/) (Сервис для управления облачными ресурсами).
{% if product == "yandex-cloud" %}* [{{ serverless-containers-full-name }}](../../serverless-containers/) (Сервис бессерверного запуска контейнеризированных приложений).{% endif %}
{% if product == "yandex-cloud" %}* [{{ speechkit-full-name }}](../../speechkit/) (Сервис технологий распознавания и синтеза речи).{% endif %}
{% if product == "yandex-cloud" %}* [{{ tracker-full-name }}](../../tracker/) (Сервис для совместной работы и организации процессов в компании).{% endif %}
{% if product == "yandex-cloud" %}* [{{ translate-full-name }}](../../translate/) (Сервис машинного перевода).{% endif %}
* [{{ vpc-full-name }}](../../vpc/) (Сервис для управления облачными сетями).
{% if product == "yandex-cloud" %}* [{{ vision-full-name }}](../../vision/) (Сервис компьютерного зрения для анализа изображений).{% endif %}
{% if product == "yandex-cloud" %}* [{{ wiki-full-name }}](../../wiki/) (Сервис для создания корпоративной базы данных).{% endif %}

### Как подключиться к сервисам {#enable}

Для подключения к сервисам и управления ресурсами вы можете использовать [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}. С ее помощью вы можете запускать виртуальные машины в {{ yandex-cloud }} и подключаться к ним, обращаться к объектному хранилищу, создавать базы данных и т. п.

{% if product == "yandex-cloud" %}

Сервисы, находящиеся на стадии Preview, доступны не всем пользователям. Если вы хотите воспользоваться одним из таких сервисов, отправьте нам заявку на доступ. Сделать это можно на странице соответствующего сервиса.

{% endif %}

## Метки ресурсов сервисов {#labels}

[Большая часть сервисов](#services) поддерживает использование меток для маркировки ресурсов. 

_Метка_ — это пара ключ-значение в формате `<имя метки>=<значение метки>`. Вы можете использовать метки для логического разделения ресурсов. 

На метку накладываются следующие ограничения: 
* Максимальное количество меток на один ресурс: 64. 
* Для ключа: 
    * Длина — от 1 до 63 символов.
    * Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.
    * Первый символ — буква. 
* Для значения: 
    * Длина — до 63 символов.
    * Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.

### Управление метками {#managed-labels}

Вы можете добавить, удалить или изменить метку ресурса.

#### Добавить метку {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    Добавьте метку ресурсу сервиса:
    
    ```
    yc <имя сервиса> <тип ресурса> add-labels <имя или идентификатор ресурса> \
      --labels <имя метки>=<значение метки>
    ```

{% endlist %}

#### Изменить метку {#update-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% note warning %}
    
    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}
    
    Измените метку ресурса сервиса:
    
    ```
    yc <имя сервиса> <тип ресурса> update <имя или идентификатор ресурса> \
      --labels <имя метки>=<значение метки>
    ```

{% endlist %}

#### Удалить метку {#remove-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    Удалите метку ресурса сервиса:

    ```
    yc <имя сервиса> <тип ресурса> remove-labels <имя или идентификатор ресурса> \
      --labels <имя метки>
    ```
  
{% endlist %}


#### Примеры управления метками {#examples}

{% cut "Добавить метку виртуальной машине" %}

{% list tabs %}

- CLI
    
    Для добавления метки выполните команду:
    
    ```
    yc compute instance add-labels cl123g4dridnn5cna6df-yduv --labels project=test
    ```

    Результат:
    
    ```
    done (5s)
    id: fhm1pr2bu3p45s6ildh7
    folder_id: b1g23ga45mev6cljderg
    created_at: "2020-08-07T11:29:18Z"
    name: cl123g4dridnn5cna6df-yduv
    labels:
      project: test
    zone_id: {{ region-id }}-a
    ...
    ```

{% endlist %}

{% endcut %}

{% cut " Изменить метку кластера {{ k8s }}" %}

{% list tabs %}

- CLI

    Для изменения метки выполните команду:
    
    ```
    yc managed-kubernetes cluster update k8s-gpu --labels new_lable=test_label
    ```
    
    Результат:
    
    ```
    done (1m36s)
    id: cat1hknor2345e6d7rr8
    folder_id: b1g23ga45mev6cljderg
    created_at: "2020-08-07T11:15:59Z"
    name: cluster
    labels:
      new_lable: test_label
    status: RUNNING
    ...
    ```
  
{% endlist %}

{% endcut %}

{% cut "Удалить метку кластера {{ mmy-short-name }}" %}

{% list tabs %}

- CLI

    Для удаления метки выполните команду:
    
    ```
    yc managed-mysql cluster remove-labels mysql123 --labels my_lable
    ```
    
    Результат:
    
    ```
    id: c1qmjaatlurm2bcoi34i
    folder_id: b1g23ga45mev6cljderg
    created_at: "2020-08-20T11:53:20.015543Z"
    name: mysql123
    environment: PRODUCTION
    ...
    ```

{% endlist %}

{% endcut %}



### Сервисы, в которых поддержаны метки {#services}

Список сервисов, ресурсы которых поддерживают использование меток:
* [{{ certificate-manager-full-name }}](../../certificate-manager/)
* [{{ compute-full-name }}](../../compute/)
* [{{ vpc-full-name }}](../../vpc/)
* [{{ resmgr-full-name }}](../../resource-manager/)
* [{{ kms-full-name }}](../../kms/)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/)
* [{{ container-registry-full-name }}](../../container-registry/)
* [{{ mch-full-name }}](../../managed-clickhouse/)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/)
{% if product == "yandex-cloud" %}* [{{ mmg-full-name }}](../../managed-mongodb/){% endif %}
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
{% if product == "yandex-cloud" %}* [{{ mrd-full-name }}](../../managed-redis/){% endif %}
{% if product == "yandex-cloud" %}* [{{ dataproc-full-name }}](../../data-proc/){% endif %}
{% if product == "yandex-cloud" %}* [{{ sf-full-name }}](../../functions/){% endif %}
{% if product == "yandex-cloud" %}* [{{ iot-full-name }}](../../iot-core/){% endif %}
{% if product == "yandex-cloud" %}* [{{ ydb-full-name }}](../../ydb/){% endif %}

{% if product == "yandex-cloud" %}

{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

{% endif %}
