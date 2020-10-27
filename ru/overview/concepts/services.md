# Сервисы {{ yandex-cloud }}

_Сервис_ в составе {{ yandex-cloud }} позволяет управлять определенными категориями облачных ресурсов и доступом к ним.

## Категории сервисов {#service-type}

{% include  [service-type](../../_includes/overview/service-type.md) %}

## Список сервисов {{ yandex-cloud }} {#list}

На данный момент в рамках платформы {{ yandex-cloud }} доступны следующие сервисы:
* Infrastructure:
    * [{{ compute-full-name }}](../../compute/) (Сервис Облачных вычислений).
    * [{{ objstorage-full-name }}](../../storage/) (Сервис Объектного хранилища).
    * [{{ vpc-full-name }}](../../vpc/) (Сервис Виртуальное частное облако).
    * [{{ interconnect-full-name }}](../../vpc/interconnect/) (Сервис управления выделенными сетевыми соединениями).
    * [{{ iam-full-name }}](../../iam/) (Сервис по управлению доступом к облачным ресурсам).
    * [{{ resmgr-full-name }}](../../resource-manager/) (Сервис по управлению облачными ресурсами).
    * [{{ kms-full-name }}](../../kms/) (Сервис для управления ключами шифрования).
    * [{{ load-balancer-full-name }}](../../load-balancer/) (Сервис для управления сетевыми балансировщиками нагрузки).
    * [Yandex Instance Groups](../../compute/concepts/instance-groups/) (Сервис для создания и управления группами виртуальных машин).
    * [{{ container-registry-full-name }}](../../container-registry/) (Сервис для управления образами контейнеров).
    * [{{managed-k8s-full-name}}<sup>®</sup>](../../managed-kubernetes/) (Сервис Управления для Kubernetes).
    * [{{ monitoring-full-name }}](../../monitoring/) (Сервис мониторинга).
    * [Yandex DDoS Protection](../../vpc/ddos-protection/) (Сервис защиты от DDoS-атак).
* Data storage & Analytics:
    * [{{ mpg-full-name }}](../../managed-postgresql/) (Сервис Управления для PostgreSQL).
    * [{{ mch-full-name }}](../../managed-clickhouse/) (Сервис Управления для ClickHouse).
    * [{{ mmg-full-name }}](../../managed-mongodb/) (Сервис Управления для MongoDB).
    * [{{ mmy-full-name }}<sup>®</sup>](../../managed-mysql/) (Сервис Управления для MySQL).
    * [{{ mrd-full-name }}™](../../managed-redis/) (Сервис Управления для Redis).
    * [{{ dataproc-full-name }}](../../data-proc/) (Сервис Управления данными Data Proc).
    * [{{ datalens-full-name }}](../../datalens/) (Сервис визуализации и анализа данных).
* Cloud-native:
    * [{{ ydb-full-name }}](../../ydb/) (Сервис управления для {{ ydb-full-name }}). 
    * [{{ message-queue-full-name }}](../../message-queue/) (Сервис очередей).
    * [{{ sf-full-name }}](../../functions/) (Сервис бессерверных вычислений).
    * [{{ iot-full-name }}](../../iot-core/) (Сервис Интернета Вещей).
* Machine Learning & Artificial Intelligence (ML & AI):
    * [{{ speechkit-full-name }}](../../speechkit/) (Сервис речевых технологий).
    * [{{ translate-full-name }}](../../translate/) (Сервис машинного перевода).
    * [{{ vision-full-name }}](../../vision/) (Сервис компьютерного зрения).

### Как подключиться к сервисам {#enable}

Для подключения к сервисам и управления ресурсами вы можете использовать [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}. С ее помощью вы можете запускать виртуальные машины в {{ yandex-cloud }} и подключаться к ним, обращаться к объектному хранилищу, создавать базы данных и т. п.

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
    Результат выполнения команды:
    
    ```
    done (5s)
    id: fhm1pr2bu3p45s6ildh7
    folder_id: b1g23ga45mev6cljderg
    created_at: "2020-08-07T11:29:18Z"
    name: cl123g4dridnn5cna6df-yduv
    labels:
      project: test
    zone_id: ru-central1-a
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
    
    Результат выполнения команды:
    
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
    
    Результат выполнения команды:
    
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
* [{{ load-balancer-full-name }}](../../load-balancer/)
* [{{ container-registry-full-name }}](../../container-registry/)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
* [{{ mch-full-name }}](../../managed-clickhouse/)
* [{{ mmg-full-name }}](../../managed-mongodb/)
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mrd-full-name }}](../../managed-redis/)
* [{{ dataproc-full-name }}](../../data-proc/)
* [{{ sf-full-name }}](../../functions/)
* [{{ iot-full-name }}](../../iot-core/)
* [{{ ydb-full-name }}](../../ydb/)