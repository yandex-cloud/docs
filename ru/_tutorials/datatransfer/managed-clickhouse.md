# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-ch).
1. Подготовьте инфраструктуру:

    {% list tabs %}

    * Вручную

        1. [Подготовьте кластер-приемник](../../data-transfer/operations/prepare.md#target-ch).

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `ClickHouse`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Пользовательская инсталляция`.

                Укажите параметры подключения к кластеру-источнику.

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `ClickHouse`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Кластер MDB`.

                Выберите кластер-приемник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy }}_, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    * С помощью {{ TF }}

        1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
        1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ch-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-ch-mch.tf).

            В этом файле описаны:

            * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
            * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
            * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %} и правило, необходимое для подключения к кластеру;
            * источник {{ CH }};
            * кластер-приемник {{ mch-name }};
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-ch-mch.tf`:

            * [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/clickhouse.md#on-premise):
                * `source_user` и `source_pwd` — имя и пароль пользователя для доступа к источнику;
                * `source_db_name` — имя базы данных;
                * `source_host` — FQDN или IP-адрес сервера {{ CH }};
                * `source_http_port` и `source_native_port` — порты для подключения по HTTP-интерфейсу и нативному интерфейсу {{ CH }}.

            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

                * `target_clickhouse_version` — версия {{ CH }};
                * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

        1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

1. Дождитесь перехода трансфера в статус {{ dt-status-finished }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Удалите созданные ресурсы:

    {% list tabs %}

    * Ресурсы созданы вручную

        * [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
        * [Удалите завершившийся трансфер](../../data-transfer/operations/transfer.md#delete).
        * [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

    * Ресурсы созданы с помощью {{ TF }}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `data-transfer-ch-mch.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-ch-mch.tf`, будут удалены.

    {% endlist %}
