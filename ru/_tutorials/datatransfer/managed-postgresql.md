# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-pg).
1. Подготовьте инфраструктуру:

    {% list tabs %}

    * Вручную

        1. [Создайте кластер-приемник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

             * Версия {{ PG }} должна быть не ниже, чем в кластере-источнике. Миграция с понижением версии {{ PG }} невозможна.
             * При создании кластера укажите то же имя базы данных, что и в кластере-источнике.
             * Включите те же [расширения {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md), что и в кластере-источнике.
        1. [Подготовьте кластер-приемник](../../data-transfer/operations/prepare.md#target-pg).
        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

             * **Тип базы данных** — `{{ PG }}`.
             * **Параметры эндпоинта** → **Настройки подключения** — `Пользовательская инсталляция`.

           Укажите параметры подключения к кластеру-источнику.

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

             * **Тип базы данных** — `{{ PG }}`.
             * **Параметры эндпоинта** → **Настройки подключения** — `Кластер MDB`.

           Укажите идентификатор кластера-приемника.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).

            {% note warning %}

            Избегайте любых изменений в схеме данных в кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [{#T}](../../data-transfer/operations/db-actions.md).

            {% endnote %}

    * С помощью {{ TF }}

        1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
        1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-pgsql-mpg.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-pgsql-mpg/data-transfer-pgsql-mpg.tf).

            В этом файле описаны:

            * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
            * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
            * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %} и правило, необходимое для подключения к кластеру;
            * кластер-приемник {{ mpg-name }};
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-pgsql-mpg.tf`:

            * [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/postgresql.md#on-premise);
            * `pg-extensions` – список [расширений {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md) в кластере-источнике;
            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/postgresql.md#managed-service):

                * `target_pgsql_version` — версия {{ PG }}, она должна быть не ниже, чем в кластере-источнике;
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

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q>.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum lag on delivery**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Переключите нагрузку на кластер-приемник.
1. Удалите созданные ресурсы:

    {% list tabs %}

    * Ресурсы созданы вручную

        * [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        * [Удалите остановленный трансфер](../../data-transfer/operations/transfer.md#delete).
        * [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

    * Ресурсы созданы с помощью {{ TF }}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `data-transfer-pgsql-mpg.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-pgsql-mpg.tf`, будут удалены.

    {% endlist %}
