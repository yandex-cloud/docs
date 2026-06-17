# Настройка Yandex Managed Service for ClickHouse® для Graphite

# Настройка Managed Service for ClickHouse® для Graphite

Yandex Managed Service for ClickHouse® можно использовать как хранилище данных для [Graphite](https://graphite.readthedocs.io/en/latest/index.html).

Движок таблиц [GraphiteMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree) позволяет прореживать и агрегировать или усреднять содержимое БД специально для Graphite. Движок уменьшает объем хранения данных и повышает эффективность запросов от Graphite.

{% note info %}

Если прореживание и агрегирование или усреднение не требуется, то для хранения данных Graphite можно использовать любой [движок таблиц](https://clickhouse.com/docs/ru/engines/table-engines) ClickHouse®.

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

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки БД ClickHouse® для Graphite входит:
* плата за вычислительные ресурсы кластера, объем хранилища и резервных копий ([тарифы Yandex Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md));
* плата за запущенную ВМ для управления БД ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).


## Создайте кластер {#cluster-create}

1. [Создайте кластер **Managed Service for&nbsp;ClickHouse**](../../managed-clickhouse/operations/cluster-create.md) любой подходящей вам конфигурации с БД `db1` и публичным доступом ко всем его хостам. Сохраните имя БД, имя пользователя БД и пароль.
1. Откройте [консоль управления](https://console.yandex.cloud).
1. Перейдите в сервис Managed Service for&nbsp;ClickHouse.
1. Выберите созданный кластер и на вкладке **Обзор** сохраните идентификатор кластера.
1. В правом верхнем углу нажмите **Подключиться**, на вкладке **Shell** из поля **Пример строки подключения** сохраните параметр `--host`, например `rc1a-2sqal8f0********.mdb.yandexcloud.net`, это FQDN хоста кластера, он потребуется в дальнейшем.

## Зарегистрируйте конфигурацию rollup в кластере {#rollup-config}

Зарегистрируйте в кластере конфигурацию `rollup` для прореживания и агрегирования или усреднения содержимого БД для Graphite:

{% list tabs group=instructions %}

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Подготовьте yaml-файл `graphite-rollup.yaml` с описанием параметров `rollup`, например:
  
      ```yaml
      name: test_rollup
      patterns:
        - regexp: click_cost
          function: max
          retention:
            - age: 86400
              precision: 60
      ```

  1. Выполните команду:

      ```bash
      yc managed-clickhouse cluster add-graphite-rollup <идентификатор_кластера> --rollup-file-name <путь_к_yaml-файлу>
      ```

      Где:

      * `<идентификатор_кластера>` — идентификатор кластера.
      * `--rollup-file-name` — путь к `graphite-rollup.yaml`.

      Подробнее о команде `managed-clickhouse cluster add-graphite-rollup` см. в [справочнике CLI](../../cli/cli-ref/managed-clickhouse/cli-ref/cluster/add-graphite-rollup.md).

- API {#api}
  
  Используйте метод REST API [update](../../managed-clickhouse/api-ref/Cluster/update.md), передав в теле запроса требуемые параметры `rollup`:

    ```json
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

1. В той же [облачной сети](../../vpc/concepts/network.md), где расположен кластер, [создайте](../../compute/operations/vm-create/create-linux-vm.md) ВМ на основе Linux. 
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../../glossary/ssh-keygen.md). 
1. Подключите [DEB-репозиторий](https://clickhouse.com/docs/ru/install#install-from-deb-packages) ClickHouse®:

    ```bash
    sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
    echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list
    ```

1. Установите зависимости и клиентское приложение `clickhouse-client`:

    ```bash
    sudo apt update && sudo apt install -y clickhouse-client
    ```

1. Загрузите файл конфигурации для `clickhouse-client`:

    ```bash
    mkdir -p ~/.clickhouse-client && \
    wget "https://storage.yandexcloud.net/doc-files/clickhouse-client.conf.example" \
      --output-document ~/.clickhouse-client/config.xml
    ```

1. Получите [SSL-сертификат](../../glossary/ssl-certificate.md):

    ```bash
    sudo mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
    sudo wget "https://storage.yandexcloud.net/cloud-certs/RootCA.pem" \
         --output-document /usr/local/share/ca-certificates/Yandex/RootCA.crt && \
    sudo chmod 655 /usr/local/share/ca-certificates/Yandex/RootCA.crt && \
    sudo update-ca-certificates
    ```

## Подключите виртуальную машину к базе данных {#cluster-connect}

1. Если вы используете группы безопасности для облачной сети, [настройте их](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и ВМ.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md). 
1. Запустите ClickHouse® CLI со следующими параметрами: вместо `<FQDN_хоста>`, `<имя_БД>`, `<имя_пользователя_БД>` и `<пароль_пользователя_БД>` укажите ранее сохраненные параметры.

    ```bash
    clickhouse-client --host <FQDN_хоста> \
                      --secure \
                      --user <имя_пользователя_БД> \
                      --database <имя_БД> \
                      --password <пароль_пользователя_БД> \
                      --port 9440
    ```

## Создайте таблицу на основе GraphiteMergeTree {#table-create}

{% list tabs group=instructions %}

- ClickHouse® CLI {#cli}

  В интерфейсе ClickHouse® CLI выполните запрос на создание таблицы на основе [GraphiteMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/graphitemergetree). В качестве параметра передайте имя секции `rollup`, описанной ранее:

    ```sql
    CREATE TABLE GraphiteTable
    (        
        Path String, 
        Time DateTime, 
        Value Int64, 
        Version UInt64
    )
    ENGINE = GraphiteMergeTree('test_rollup')
    PARTITION BY Time
    ORDER BY cityHash64(Version, Path)
    ```

{% endlist %}

## Настройте Graphite {#graphite-setup}

Настройте Graphite для сохранения значений метрик в кластере ClickHouse®. При этом прореживание данных будет проводиться автоматически средствами сервера ClickHouse® в соответствии с параметрами, которые вы указали.

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

Чтобы удалить из кластера конфигурацию `rollup`:

1. Удалите все таблицы, которые используют эту конфигурацию.
1. Используйте команду `yc managed-clickhouse cluster remove-graphite-rollup`.

Подробнее о команде см. в [справочнике CLI](../../cli/cli-ref/managed-clickhouse/cli-ref/cluster/remove-graphite-rollup.md).

{% note alert %}

Удаление конфигурации `rollup` без предварительного удаления таблиц, которые ее используют, может привести к отказу кластера.

{% endnote %}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [Удалите кластер ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
* [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._