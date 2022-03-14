# Управление хостами кластера

Вы можете добавлять и удалять хосты кластера, а также управлять настройками {{ CH }} для отдельных кластеров.

{% note warning %}

Если вы создали кластер без поддержки [{{ CK }}](../concepts/replication.md#ck), то прежде чем добавлять новые хосты в любой из [шардов](../concepts/sharding.md), [включите отказоустойчивость](./zk-hosts.md#add-zk) с использованием хостов {{ ZK }}.

{% endnote %}


## Получить список хостов в кластере {#list-hosts}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.

  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список хостов в кластере, выполните команду:
  
  ```bash
  {{ yc-mdb-ch }} host list \
     --cluster-name=<имя кластера>
       
  +----------------------------+--------------+---------+--------+---------------+
  |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+--------------+---------+--------+---------------+
  | rc1b...mdb.yandexcloud.net | c9qp71dk1... | MASTER  | ALIVE  | ru-central1-b |
  | rc1c...mdb.yandexcloud.net | c9qp71dk1... | REPLICA | ALIVE  | ru-central1-c |
  +----------------------------+--------------+---------+--------+---------------+
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API
  
  Получить список хостов кластера можно с помощью метода [listHosts](../api-ref/Cluster/listHosts.md).
  
{% endlist %}


## Добавить хост {#add-host}

Количество хостов в кластерах {{ mch-short-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ mch-full-name }}**.

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и нажмите плитку **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**. 
  1. Нажмите кнопку **Добавить хост**.
  
  {% if audience != "internal" %}

  1. Укажите параметры хоста:

      * зону доступности;
      * подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md));
      * выберите опцию **Публичный доступ**, если хост должен быть доступен извне {{ yandex-cloud }};
      * выберите опцию **Копировать схему данных**, чтобы скопировать схему со случайной реплики на новый хост.

  {% endif %}

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы добавить хост в кластере:
  
  {% if audience != "internal" %}

  1. Запросите список подсетей кластера, чтобы выбрать подсеть для нового хоста:
  
      ```bash
      yc vpc subnet list
      
      +-----------+-----------+------------+---------------+------------------+
      |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
      +-----------+-----------+------------+---------------+------------------+
      | b0cl69... | default-c | enp6rq7... | ru-central1-c | [172.16.0.0/20]  |
      | e2lkj9... | default-b | enp6rq7... | ru-central1-b | [10.10.0.0/16]   |
      | e9b0ph... | a-2       | enp6rq7... | ru-central1-a | [172.16.32.0/20] |
      | e9b9v2... | default-a | enp6rq7... | ru-central1-a | [172.16.16.0/20] |
      +-----------+-----------+------------+---------------+------------------+
      ```
  
      Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md). 
  
  {% endif %} 
  
  1. Посмотрите описание команды CLI для добавления хостов:
  
     ```bash
     {{ yc-mdb-ch }} host add --help
     ``` 
  
  1. Выполните команду добавления хоста:
  
     {% if audience != "internal" %}

     ```bash
     {{ yc-mdb-ch }} host add \
        --cluster-name <имя кластера> \
        --host zone-id=<зона доступности>,subnet-id=<ID подсети>,assign-public-ip=<публичный IP>,shard-name=<имя шарда>
     ```

     {% else %}

     ```bash
     {{ yc-mdb-ch }} host add \
        --cluster-name <имя кластера> \
        --host zone-id=<зона доступности>,subnet-id=<ID подсети>,shard-name=<имя шарда> \
     ```

     {% endif %}

     Чтобы скопировать схему данных со случайной реплики на новый хост, укажите необязательный параметр `--copy-schema`.

     {{ mch-short-name }} запустит операцию добавления хоста.

     {% if audience != "internal" %}

     Идентификатор подсети необходимо указать, если в зоне доступности больше одной подсети, в противном случае {{ mch-short-name }} автоматически выберет единственную подсеть. Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     {% else %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     {% endif %}

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `host`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          host {
            type = "CLICKHOUSE"
            zone = "<зона доступности>"
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Добавить хост в кластер можно с помощью метода [addHosts](../api-ref/Cluster/addHosts.md).

  Чтобы скопировать схему данных со случайной реплики на новый хост, передайте в запросе параметр `copySchema` со значением `true`.

{% endlist %}

{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

Используйте опцию копирования схемы данных только в том случае, когда схема одинакова на всех хостах-репликах кластера.

{% endnote %}

## Удалить хост {#remove-host}

Вы можете удалить хост из {{ CH }}-кластера, если в кластере 3 и более хостов.

{% note info %}

Кластер, созданный с поддержкой механизма репликации [{{ CK }}](../concepts/replication.md#ck), должен состоять из трех или более хостов.

{% endnote %}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и нажмите плитку **{{ mch-name }}**.
  
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке нужного хоста и выберите пункт **Удалить**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить хост из кластера, выполните команду:
  
  ```
  {{ yc-mdb-ch }} host delete <имя хоста>
       --cluster-name=<имя кластера>
  ```
  
  Имя хоста можно запросить со [списком хостов в кластере](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок `host` с типом `CLICKHOUSE`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите удаление ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API
  
  Удалить хост можно с помощью метода [deleteHosts](../api-ref/Cluster/deleteHosts.md).
  
{% endlist %}
