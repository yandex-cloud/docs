# Асинхронная репликация данных из PostgreSQL в ClickHouse®

Вы можете перенести базу данных из PostgreSQL в ClickHouse® с помощью сервиса Yandex Data Transfer. Для этого:

1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работу репликации](#example-check-replication).
1. [Выполните выборку данных в приемнике](#working-with-data-ch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for PostgreSQL](../pricing.md)).
* Кластер Managed Service for ClickHouse®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы Data Transfer](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в Yandex Cloud. Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

  {% note info %}
  
  Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
  
  {% endnote %}

  1. Создайте кластер-источник Managed Service for PostgreSQL любой подходящей [конфигурации](../concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
      * **Имя БД** — `db1`.
      * **Имя пользователя** — `pg-user`.
      * **Пароль** — `<пароль_источника>`.

  1. Создайте кластер-приемник Managed Service for ClickHouse® любой подходящей [конфигурации](../../managed-clickhouse/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
      * **Количество хостов ClickHouse®** — не меньше 2 (для включения репликации в кластере).
      * **Имя БД** — `db1`.
      * **Имя пользователя** — `ch-user`.
      * **Пароль** — `<пароль_приемника>`.

  
  1. Если вы используете группы безопасности в кластерах, убедитесь, что они настроены правильно и допускают подключение к кластерам:

     * [Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
     * [Managed Service for PostgreSQL](../operations/connect/index.md#configuring-security-groups).


  1. [Выдайте роль](../operations/grant.md#grant-privilege) `mdb_replication` пользователю `pg-user` в кластере Managed Service for PostgreSQL.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-clickhouse/blob/main/postgresql-to-clickhouse.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network);
        * [подсети](../../vpc/concepts/network.md#subnet);
        * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для подключения к кластерам;
        * кластер-источник Managed Service for PostgreSQL;
        * кластер-приемник Managed Service for ClickHouse®;
        * эндпоинт для источника;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `postgresql-to-clickhouse.tf` пароли пользователя-администратора PostgreSQL и ClickHouse®.
    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Подключитесь к кластеру Managed Service for PostgreSQL](../operations/connect/index.md).
1. Создайте в базе данных `db1` таблицу `x_tab` и заполните ее данными:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC PRIMARY KEY,
         name CHAR(5)
     );
     CREATE INDEX ON x_tab (id);
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/postgresql.md) типа `PostgreSQL` и укажите в нем параметры подключения к кластеру:

            * **Тип инсталляции** — `Кластер Managed Service for PostgreSQL`.
            * **Кластер Managed Service for PostgreSQL** — `<имя_кластера-источника_PostgreSQL>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `pg-user`.
            * **Пароль** — `<пароль_пользователя>`.

        1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/clickhouse.md) типа `ClickHouse` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Managed кластер`.
            * **Managed кластер** — `<имя_кластера-приемника_ClickHouse®>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `ch-user`.
            * **Пароль** — `<пароль_пользователя>`.
            * **Политика очистки** — `DROP`.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа [**Копирование и репликация**](../../data-transfer/concepts/index.md#transfer-type), использующий созданные эндпоинты, и [активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - Terraform {#tf}

        1. Укажите в файле `postgresql-to-clickhouse.tf` значение `1` для переменной `transfer_enabled`.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

        Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работу репликации {#example-check-replication}

1. Дождитесь перехода трансфера в статус **Реплицируется**.
1. Чтобы проверить, что трансфер перенес данные с учетом репликации в приемнике, подключитесь к кластеру-приемнику Yandex Managed Service for ClickHouse® и посмотрите, что таблица `x_tab` в базе `db1` содержит те же колонки, что таблица `x_tab` в базе-источнике, а также [колонки с временными метками](#working-with-data-ch) `__data_transfer_commit_time` и `__data_transfer_delete_time`:

   ```sql
   SELECT * FROM db1.x_tab WHERE id = 41;
   ```

   ```text
   ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
   │ 41 │  User2 │   1633417594957267000          │ 0                             │
   └────┴────────┴────────────────────────────────┴───────────────────────────────┘
   ```

1. Подключитесь к кластеру-источнику.
1. Удалите строку с идентификатором `41` и измените строку с идентификатором `42` в таблице `x_tab` базы-источника PostgreSQL:

    ```sql
    DELETE FROM db1.public.x_tab WHERE id = 41;
    UPDATE db1.public.x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Убедитесь, что в таблице `x_tab` на приемнике ClickHouse® отобразились изменения:

    ```sql
    SELECT * FROM db1.x_tab WHERE (id >= 41) AND (id <= 42);
    ```

    ```text
    ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
    │ 41 │  User2 │   1633417594957267000          │ 1675417594957267000           │
    │ 42 │  Key3  │   1675417594957267000          │ 0                             │
    │ 42 │  User3 │   1633417594957268000          │ 1675417594957267000           │
    └────┴────────┴────────────────────────────────┴───────────────────────────────┘
    ```

## Выполните выборку данных в ClickHouse® {#working-with-data-ch}

На приемнике ClickHouse® с включенной [репликацией](../../managed-clickhouse/concepts/replication.md) для воссоздания таблиц используются движки [ReplicatedReplacingMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication/) и [ReplacingMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replacingmergetree/). В каждую таблицу автоматически добавляются столбцы:

* `__data_transfer_commit_time` — время изменения строки на это значение, в формате `TIMESTAMP`;
* `__data_transfer_delete_time` — время удаления строки в формате `TIMESTAMP`, если строка удалена в источнике. Если строка не удалялась, то устанавливается значение `0`.

    Столбец `__data_transfer_commit_time` необходим для работы движка ReplicatedReplacedMergeTree. Если запись удаляется или изменяется, в таблицу вставляется новая строка со значением в этом столбце. Запрос по одному первичному ключу возвращает несколько записей с разными значениями в столбце `__data_transfer_commit_time`.

В статусе трансфера **Реплицируется** данные в источнике могут добавляться или удаляться. Чтобы обеспечить стандартное поведение команд SQL, когда первичный ключ указывает на единственную запись, дополните запросы к перенесенным таблицам в ClickHouse® конструкцией с фильтром по столбцу `__data_transfer_delete_time`. Например, для таблицы `x_tab`:

```sql
SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

Для упрощения запросов `SELECT` создайте представление с фильтром по столбцу `__data_transfer_delete_time` и обращайтесь к нему. Например, для таблицы `x_tab`:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

{% note info %}

Использование ключевого слова `FINAL` сильно снижает эффективность запросов. По возможности избегайте его применения при работе с большими таблицами.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. Убедитесь, что трансфер находится в статусе **Завершен** и [удалите](../../data-transfer/operations/transfer.md#delete) его.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите эндпоинт-источник и эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).
        1. [Удалите кластер Managed Service for PostgreSQL](../operations/cluster-delete.md).
        1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).

    - Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._