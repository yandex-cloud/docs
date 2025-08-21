Вы можете перенести базу данных из {{ GP }} в {{ CH }} с помощью сервиса {{ data-transfer-full-name }}.

Чтобы перенести базу данных из {{ GP }} в {{ CH }}:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ mgp-name }}: использование вычислительных ресурсов, выделенных хостам, и дискового пространства (см. [тарифы {{ mgp-name }}](../../managed-greenplum/pricing/index.md)).

* Плата за кластер {{ mch-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).

* Плата за использование публичных IP-адресов, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).

* Плата за трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в {{ yandex-cloud }}. Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник {{ mgp-full-name }}](../../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации.

    1. [Создайте кластер-приемник {{ mch-full-name }}](../../managed-clickhouse/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с базой данных `db1`.

    
    1. Если вы используете группы безопасности в кластерах, убедитесь, что они настроены правильно и допускают подключение к кластерам:

        * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).


    1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/clickhouse.md) типа `{{ CH }}`. В [параметрах](../../data-transfer/operations/endpoint/target/clickhouse#additional-settings) эндпоинта укажите политику очистки `Drop` или `Truncate`, чтобы данные на приемнике не дублировались при копировании.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [greenplum-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-greenplum-to-clickhouse/blob/main/greenplum-clickhouse.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;

        
        * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;


        * кластер-источник {{ mgp-name }};
        * кластер-приемник {{ mch-name }};
        * эндпоинт-приемник.

    1. Укажите в файле `greenplum-clickhouse.tf`:

        * `mgp_password` — пароль администратора {{ GP }}.
        * `mch_db` — имя базы данных {{ CH }}.
        * `mch_user` — имя пользователя базы данных {{ CH }}.
        * `mch_password` — пароль пользователя базы данных {{ CH }}.

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

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/greenplum.md) типа `{{ GP }}` и укажите в нем параметры подключения к кластеру.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа [{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}](../../data-transfer/concepts/index.md#transfer-type), использующий эндпоинты для источника и приемника.

    Для этой пары эндпоинтов репликация недоступна, но вы можете настроить регулярное копирование при создании трансфера. Для этого в блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}** в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** выберите **Регулярно**, затем укажите интервал копирования. Трансфер будет автоматически активироваться через указанный промежуток времени.

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

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
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

1. [Подключитесь к кластеру {{ mgp-name }}](../../managed-greenplum/operations/connect.md), удалите одну строку и измените другую в таблице `x_tab`:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Повторно [активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
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

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Убедитесь, что трансфер находится в статусе **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** и [удалите](../../data-transfer/operations/transfer.md#delete) его.
1. [Удалите](../../data-transfer/operations/endpoint/index.md#delete) эндпоинт-источник.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите](../../managed-clickhouse/operations/cluster-delete.md) кластер {{ mch-name }}.
        1. [Удалите](../../managed-greenplum/operations/cluster-delete.md) кластер {{ mgp-name }}.
        1. [Удалите](../../data-transfer/operations/endpoint/index.md#delete) эндпоинт-приемник.

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}


## Дополнительные материалы {#video}

Больше информации о сценариях поставок данных в вебинаре {{ yandex-cloud }}:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvkntkhjbfsn2c7ptv?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=bzWmmPp6KFg).



