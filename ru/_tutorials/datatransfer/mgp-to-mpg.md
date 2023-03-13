Вы можете перенести базу данных из {{ GP }} в кластер {{ PG }} с помощью сервиса {{ data-transfer-full-name }}.

Чтобы перенести базу данных из {{ GP }} в {{ PG }}:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в {{ yandex-cloud }}. Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. [Создайте кластер-источник {{ mgp-full-name }}](../../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с именем пользователя-администратора `gp-user` и хостами в публичном доступе.

    1. [Создайте кластер-приемник {{ mpg-full-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе. При создании кластера укажите:

        * **Имя пользователя** — `pg-user`.
        * **Имя базы данных** — `db1`.

    {% if audience != "internal" %}

    1. Если вы используете группы безопасности в кластерах, убедитесь, что они настроены правильно и допускают подключение к кластерам:

        * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).

        {% include [preview-pp.md](../../_includes/preview-pp.md) %}

    {% endif %}

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [greenplum-postgresql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/greenplum-postgresql.tf).

        В этом файле описаны:

        * {% if audience != "internal" %}[сети](../../vpc/concepts/network.md#network){% else %}сети{% endif %} и {% if audience != "internal" %}[подсети](../../vpc/concepts/network.md#subnet){% else %}подсети{% endif %} для размещения кластеров;
        * {% if audience != "internal" %}[группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;{% else %}группы безопасности для подключения к кластерам;{% endif %}
        * кластер-источник {{ mgp-name }};
        * кластер-приемник {{ mpg-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `greenplum-postgresql.tf` пароли пользователя-администратора {{ GP }} и {{ PG }}.
    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/greenplum.md) типа `{{ GP }}` и укажите в нем параметры подключения к кластеру:

    * **Тип подключения** — `Кластер Managed Service for Greenplum`.
    * **Кластер** — `<имя кластера-источника {{ GP }}>` из выпадающего списка.
    * **База данных** — `postgres`.
    * **Пользователь** — `gp-user`.
    * **Пароль** — `<пароль пользователя>`.
    * **Схема служебных объектов** — `public`.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Кластер Managed Service for PostgreSQL`.
            * **Кластер** — `<имя кластера-приемника {{ PG }}>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `pg-user`.
            * **Пароль** — `<пароль пользователя>`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy }}_, использующий созданные эндпоинты.

            Для этой пары эндпоинтов репликация недоступна, но вы можете настроить регулярное копирование при создании трансфера. Для этого в блоке **Параметры трансфера** в поле **Копирование** выберите **Регулярно**, затем укажите интервал копирования. Трансфер будет автоматически активироваться через указанный промежуток времени.

            {% note warning %}

            Перед настройкой регулярного копирования убедитесь, что в [параметрах эндпоинта-приемника](../../data-transfer/operations/endpoint/target/postgresql#additional-settings) указана политика очистки `DROP` или `TRUNCATE`. Иначе данные на приемнике будут дублироваться при копировании.

            {% endnote %}

    * С помощью {{ TF }}

        1. Укажите в файле `greenplum-postgresql.tf` переменные:

            * `gp_source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Подключитесь к кластеру {{ mgp-name }}](../../managed-greenplum/operations/connect.md), создайте в нем таблицу `x_tab` и заполните ее данными:

    ```sql
    CREATE TABLE x_tab
    (
        id NUMERIC,
        name CHARACTER(5)
    );
    CREATE INDEX ON x_tab (id);
    INSERT INTO x_tab (id, name) VALUES
    (40, 'User1'),
    (41, 'User2'),
    (42, 'User3'),
    (43, 'User4'),
    (44, 'User5');
    ```

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-finished }}.
1. Чтобы проверить корректность переноса данных, подключитесь к кластеру-приемнику {{ mpg-name }} и убедитесь, что колонки в таблице `x_tab` в базе `db1` совпадают с колонками таблицы `x_tab` в базе источника:

   ```sql
   SELECT id, name FROM db1.public.x_tab;
   ```

   ```text
   ┌─id─┬─name──┐
   │ 40 │ User1 │
   │ 41 │ User2 │
   │ 42 │ User3 │
   │ 43 │ User4 │
   │ 44 │ User5 │
   └────┴───────┘
   ```

## Проверьте работу копирования при повторной активации {#example-check-copy}

1. В [параметрах эндпоинта-приемника](../../data-transfer/operations/endpoint/target/postgresql#additional-settings) установите политику очистки `DROP` или `TRUNCATE`.
1. [Подключитесь к кластеру {{ mgp-name }}](../../managed-greenplum/operations/connect.md).
1. Удалите строку с идентификатором `41` и измените строку с идентификатором `42` в таблице `x_tab`:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Повторно [активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-finished }}.
1. Убедитесь, что в таблице `x_tab` на приемнике {{ PG }} отобразились изменения:

    ```sql
    SELECT id, name FROM db1.public.x_tab;
    ```

    ```text
    ┌─id─┬─name──┐
    │ 42 │ Key3  │
    │ 40 │ User1 │
    │ 43 │ User4 │
    │ 44 │ User5 │
    └────┴───────┘
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

* Убедитесь, что трансфер находится в статусе {{ dt-status-finished }} и [удалите](../../data-transfer/operations/transfer.md#delete) его.
* [Удалите эндпоинт-источник и эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
* Удалите кластеры:

    {% list tabs %}

    * Вручную

        * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        * [{{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).

    * С помощью {{ TF }}

        Если вы создали ресурсы с помощью {{ TF }}:

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `greenplum-postgresql.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `greenplum-postgresql.tf`, будут удалены.

    {% endlist %}
