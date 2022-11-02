Вы можете перенести базу данных из {{ GP }} в {{ CH }} с помощью сервиса {{ data-transfer-full-name }}.

Чтобы перенести базу данных из {{ GP }} в {{ CH }}:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в {{ yandex-cloud }}. Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

    1. [Создайте кластер-источник {{ mgp-full-name }}](../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации.

    1. [Создайте кластер-приемник {{ mch-full-name }}](../managed-clickhouse/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с базой данных `db1`.

    
    1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:
        * [{{ mch-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).
        * [{{ mgp-name }}](../managed-greenplum/operations/connect.md#configuring-security-groups).


* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите и настройте его](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [greenplum-clickhouse.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/greenplum-clickhouse/greenplum-clickhouse.tf).

        В этом файле описаны:

        * [сети](../vpc/concepts/network.md#network) и [подсети](../vpc/concepts/network.md#subnet) для размещения кластеров;
                * [группы безопасности](../vpc/concepts/security-groups.md) для подключения к кластерам;
        * кластер-источник {{ mgp-name }};
        * кластер-приемник {{ mch-name }}.

    1. Укажите в файле `greenplum-clickhouse.tf` пароли пользователя-администратора {{ GP }} и {{ CH }}.
    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../data-transfer/operations/endpoint/source/greenplum.md) типа `{{ GP }}` и укажите в нем параметры подключения к кластеру.

1. [Создайте эндпоинт-приемник](../data-transfer/operations/endpoint/target/clickhouse.md) типа `{{ CH }}`.

1. [Создайте трансфер](../data-transfer/operations/transfer.md#create) типа [{{ dt-type-copy }}](../data-transfer/concepts/index.md#transfer-type), использующий созданные эндпоинты.

    Для этой пары эндпоинтов репликация недоступна, но вы можете настроить регулярное копирование при создании трансфера. Для этого в блоке **Параметры трансфера** в поле **Копирование** выберите **Регулярно**, затем укажите интервал копирования. Трансфер будет автоматически активироваться через указанный промежуток времени.

    {% note warning %}

    Перед настройкой регулярного копирования убедитесь, что в [параметрах эндпойнта-приемника](../data-transfer/operations/endpoint/target/clickhouse#additional-settings) указана политика очистки `Drop` или `Truncate`. Иначе данные на приемнике будут дублироваться при копировании.

    {% endnote %}

## Активируйте трансфер {#activate-transfer}

1. [Подключитесь к кластеру {{ mgp-name }}](../managed-greenplum/operations/connect.md), создайте в нем таблицу `x_tab` и заполните ее данными:

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

1. [Активируйте трансфер](../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-finished }}.
1. Чтобы проверить корректность переноса данных, подключитесь к кластеру-приемнику {{ mch-name }} и убедитесь, что колонки в таблице `x_tab` в базе `db1` совпадают с колонками таблицы `x_tab` в базе источника:

   ```sql
   SELECT id, name FROM db1.x_tab;
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

1. [Подключитесь к кластеру {{ mgp-name }}](../managed-greenplum/operations/connect.md), удалите одну строку и измените другую в таблице `x_tab`:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Повторно [активируйте трансфер](../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-finished }}.
1. Убедитесь, что в таблице `x_tab` на приемнике {{ CH }} отобразились изменения:

    ```sql
    SELECT id, name FROM db1.x_tab;
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

Если созданные ресурсы вам больше не нужны, удалите их:

* Убедитесь, что трансфер находится в статусе {{ dt-status-finished }} и [удалите](../data-transfer/operations/transfer.md#delete) его.
* [Удалите эндпоинт-источник и эндпоинт-приемник](../data-transfer/operations/endpoint/index.md#delete).
* Удалите кластеры:

    {% list tabs %}

    * Вручную

        * [{{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).
        * [{{ mgp-name }}](../managed-greenplum/operations/cluster-delete.md).

    * С помощью {{ TF }}

        Если вы создали ресурсы с помощью {{ TF }}:

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `greenplum-clickhouse.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `greenplum-clickhouse.tf`, будут удалены.

    {% endlist %}
