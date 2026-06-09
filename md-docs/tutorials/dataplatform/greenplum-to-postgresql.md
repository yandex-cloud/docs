# Миграция базы данных из {{ GP }} в {{ PG }}

Вы можете перенести базу данных из {{ GP }} в кластер {{ PG }} с помощью сервиса {{ data-transfer-full-name }}.

Чтобы перенести базу данных из {{ GP }} в {{ PG }}:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mgp-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mgp-name }}](../../managed-greenplum/pricing/index.md)).
* Кластер {{ mpg-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mpg-full-name }}](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в {{ yandex-cloud }}. Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник {{ GP }}](../../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с именем пользователя-администратора `gp-user` и хостами в публичном доступе.

    1. [Создайте кластер-приемник {{ mpg-full-name }}](../../managed-postgresql/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с хостами в публичном доступе. При создании кластера укажите:

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.

    
    1. Если вы используете группы безопасности в кластерах, убедитесь, что они настроены правильно и допускают подключение к кластерам:

        * [{{ mpg-name }}](../../managed-postgresql/operations/connect/index.md#configuring-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [greenplum-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-greenplum-to-postgresql/blob/main/greenplum-postgresql.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;
        * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;
        * кластер-источник {{ GP }} в сервисе {{ mgp-name }};
        * кластер-приемник {{ mpg-name }};
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `greenplum-postgresql.tf` пароли пользователя-администратора и версии {{ GP }} и {{ PG }}.
    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/greenplum.md) типа `{{ GP }}` и укажите в нем параметры подключения к кластеру:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-источника_{{ GP }}>` из выпадающего списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — `postgres`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — `gp-user`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — `<пароль_пользователя>`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}** — `public`.

1. Создайте эндпоинт-приемник и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}** — `Кластер Managed Service for PostgreSQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-приемника_{{ PG }}>` из выпадающего списка.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — `<пароль_пользователя>`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.

            Для этой пары эндпоинтов репликация недоступна, но вы можете настроить регулярное копирование при создании трансфера. Для этого в блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}** в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** выберите **Регулярно**, затем укажите интервал копирования. Трансфер будет автоматически активироваться через указанный промежуток времени.

            {% note warning %}

            Перед настройкой регулярного копирования убедитесь, что в [параметрах эндпоинта-приемника](../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) указана политика очистки `DROP` или `TRUNCATE`. Иначе данные на приемнике будут дублироваться при копировании.

            {% endnote %}

    - {{ TF }} {#tf}

        1. Укажите в файле `greenplum-postgresql.tf` переменные:

            * `gp_source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Подключитесь к кластеру {{ GP }}](../../managed-greenplum/operations/connect/index.md), создайте в нем таблицу `x_tab` и заполните ее данными:

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

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
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

1. В [параметрах эндпоинта-приемника](../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) установите политику очистки `DROP` или `TRUNCATE`.
1. [Подключитесь к кластеру {{ GP }}](../../managed-greenplum/operations/connect/index.md).
1. Удалите строку с идентификатором `41` и измените строку с идентификатором `42` в таблице `x_tab`:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Повторно [активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
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

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. Убедитесь, что трансфер находится в статусе **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** и [удалите](../../data-transfer/operations/transfer.md#delete) его.
1. [Удалите эндпоинт-источник и эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        1. [Удалите кластер {{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

    {% endlist %}