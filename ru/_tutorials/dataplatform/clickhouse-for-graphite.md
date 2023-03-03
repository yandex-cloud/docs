# Настройка {{ mch-name }} для Graphite

{{ mch-full-name }} можно использовать как хранилище данных для [Graphite](https://graphite.readthedocs.io/en/latest/index.html).

Движок таблиц [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/) позволяет прореживать и агрегировать или усреднять содержимое БД специально для Graphite. Движок уменьшает объем хранения данных и повышает эффективность запросов от Graphite.

{% note info %}

Если прореживание и агрегирование или усреднение не требуется, то для хранения данных Graphite можно использовать любой [движок таблиц]({{ ch.docs }}/engines/table-engines/) {{ CH }}.

{% endnote %}

Чтобы настроить БД для работы с Graphite:
1. [Подготовьте окружение](#start).
1. [Создайте кластер](#cluster-create).
1. [Зарегистрируйте конфигурацию rollup в кластере](#rollup-config).
1. [Создайте и настройте виртуальную машину](#VM-setup).
1. [Подключите виртуальную машину к базе данных](#cluster-connect).
1. [Создайте таблицу на основе GraphiteMergeTree](#table-create).
1. [Настройте Graphite](#graphite-setup).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте окружение {#start}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if audience != "internal" %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки БД {{ CH }} для Graphite входит:
* плата за вычислительные ресурсы кластера, объем хранилища и резервных копий (см. [тарифы {{ mch-full-name }}](../../managed-clickhouse/pricing.md));
* плата за запущенную ВМ для управления БД (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

{% endif %}

{% endif %}

## Создайте кластер {#cluster-create}

1. [Создайте кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей вам конфигурации с БД `db1` и публичным доступом ко всем его хостам. Сохраните имя БД, имя пользователя БД и пароль.
1. В [консоли управления]({{ link-console-main }}) выберите сервис {{ mch-name }}, перейдите в созданный кластер. На вкладке **Обзор** сохраните идентификатор кластера. 
1. В правом верхнем углу нажмите **Подключиться**, на вкладке **Shell** из поля **Пример строки подключения** сохраните параметр `--host`, например `rc1a-2sqal8f01znegjkj.{{ dns-zone }}`, это FQDN хоста кластера, он потребуется в дальнейшем.

## Зарегистрируйте конфигурацию rollup в кластере {#rollup-config}

Зарегистрируйте в кластере конфигурацию `rollup` для прореживания и агрегирования или усреднения содержимого БД для Graphite:

{% list tabs %}

- CLI
  
  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Подготовьте yaml-файл `graphite-rollup.yaml` с описанием параметров `rollup`, например:
  
      ```bash
                name: test_rollup
      patterns:    
          - regexp: click_cost
          function: max
          retention:
            - age: 86400
              precision: 60
      ```

  1. Вместо `<CLUSTER_ID>` укажите идентификатор кластера, вместо `<путь к yaml-файлу>` — путь к `graphite-rollup.yaml` и выполните команду: 
   
      ```bash
      yc managed-clickhouse cluster add-graphite-rollup <CLUSTER_ID> --rollup-file-name <путь к yaml-файлу>
      ```

      Где:

      * `<CLUSTER_ID>` – идентификатор кластера.
      * `<путь к yaml-файлу>` — путь к `graphite-rollup.yaml`.

      Подробнее о команде `managed-clickhouse cluster add-graphite-rollup` см. в [справочнике CLI](../../cli/cli-ref/managed-services/managed-clickhouse/cluster/add-graphite-rollup.md). 

      {% note info %}

      Для удаления конфигурации `rollup` используйте команду `managed-clickhouse cluster remove-graphite-rollup`. Подробнее о команде см. в [справочнике CLI](../../cli/cli-ref/managed-services/managed-clickhouse/cluster/remove-graphite-rollup.md).

      {% endnote %}

- API
  
  Используйте метод REST API [update](../../managed-clickhouse/api-ref/Cluster/update.md), передав в теле запроса требуемые параметры `rollup`:

    ```
    "graphiteRollup": [
              {
                "name": "test_rollup",
                "patterns": [
                  {
                    "regexp": "click_cost",
                    "function": "max",
                    "retention": [
                      {
                        "age": "86400",
                        "precision": "60"
                      }
                    ]
                  }
                ]
              }
            ]
    ```

{% endlist %}

## Создайте и настройте виртуальную машину {#VM-setup}

1. {% if audience != "internal" %}В той же [облачной сети](../../vpc/concepts/network.md), где расположен кластер, [создайте](../../compute/operations/vm-create/create-linux-vm.md) ВМ на основе Linux. {% else %}В той же облачной сети, где расположен кластер, создайте ВМ на основе Linux. {% endif %}
1. {% if audience != "internal" %}[Подключитесь](../../compute/operations/vm-connect/ssh.md){% else %}Подключитесь{% endif %} к ВМ по {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}. 
1. Подключите [DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

    ```bash
    sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
    echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list
    ```

1. Установите зависимости и клиентское приложение `clickhouse-client`:

    ```bash
    sudo apt update && sudo apt install -y clickhouse-client
    ```

1. Загрузите файл конфигурации для `clickhouse-client`:

    {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

1. Получите SSL-сертификат:

    ```bash
    sudo mkdir --parents {{ crt-local-dir }} && \
    sudo wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
    sudo chmod 655 {{ crt-local-dir }}{{ crt-local-file }}
    ```

## Подключите виртуальную машину к базе данных {#cluster-connect}

{% if audience != "internal" %}
1. Если вы используете группы безопасности для облачной сети, [настройте их](../../managed-clickhouse/operations/connect.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и ВМ.

    {% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endif %}
1. {% if audience != "internal" %}[Подключитесь](../../compute/operations/vm-connect/ssh.md){% else %}Подключитесь{% endif %}. 
1. Запустите ClickHouse CLI со следующими параметрами: вместо `<FQDN хоста>`, `<имя БД>`, `<имя пользователя БД>` и `<пароль пользователя БД>` укажите ранее сохраненные параметры.

    ```bash
    clickhouse-client --host <FQDN хоста> \
                      --secure \
                      --user <имя пользователя БД> \
                      --database <имя БД> \
                      --password <пароль пользователя БД> \
                      --port 9440
    ```

## Создайте таблицу на основе GraphiteMergeTree {#table-create}

{% list tabs %}

- ClickHouse CLI

  В интерфейсе ClickHouse CLI выполните запрос на создание таблицы на основе [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/). В качестве параметра передайте имя секции `rollup`, описанной ранее:

    ```bash
    CREATE TABLE GraphiteTable
    (        
        metric String, 
        time DateTime, 
        value Int64, 
        version UInt64
    )
    ENGINE = GraphiteMergeTree('test_rollup')
    PARTITION BY time
    ORDER BY cityHash64(version, metric)
    ```

{% endlist %}

## Настройте Graphite {#graphite-setup}

Настройте Graphite для сохранения значений метрик в кластере {{ CH }}. При этом прореживание данных будет проводиться автоматически средствами сервера {{ CH }} в соответствии с параметрами, которые вы указали.

1. В системе с Graphite установите утилиту `carbon-clickhouse`:

    ```bash
    wget https://github.com/go-graphite/carbon-clickhouse/releases/download/v0.11.2/carbon-clickhouse_0.11.2_amd64.deb && \
    sudo apt-get install $(pwd)/carbon-clickhouse_0.11.2_amd64.deb
    ```

1. [Настройте](https://github.com/go-graphite/carbon-clickhouse) `carbon-clickhouse`.
1. Запустите `carbon-clickhouse`:

    ```bash
    sudo systemctl enable carbon-clickhouse && \
    sudo systemctl start carbon-clickhouse
    ```

1. Установите утилиту `graphite-clickhouse`:

    ```bash
    wget https://github.com/go-graphite/graphite-clickhouse/releases/download/v0.13.2/graphite-clickhouse_0.13.2_amd64.deb && \
    sudo apt-get install $(pwd)/graphite-clickhouse_0.13.2_amd64.deb
    ```

1. [Настройте](https://github.com/go-graphite/graphite-clickhouse) `graphite-clickhouse`.
1. Запустите `graphite-clickhouse`:

    ```bash
    sudo systemctl enable graphite-clickhouse && \
    sudo systemctl start graphite-clickhouse
    ```

    Подробнее о настройке Graphite см. в [документации](https://graphite.readthedocs.io/en/latest/index.html). 

## Как удалить созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

* [Удалите кластер {{ CH }}](../../managed-clickhouse/operations/cluster-delete.md).
* {% if audience != "internal" %}[Удалите ВМ](../../compute/operations/vm-control/vm-delete.md){% else %}Удалите ВМ{% endif %}.
