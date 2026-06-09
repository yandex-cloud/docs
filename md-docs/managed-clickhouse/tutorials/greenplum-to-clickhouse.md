# Миграция базы данных из {{ GP }} в {{ CH }}

Вы можете перенести базу данных из {{ GP }} в {{ CH }} с помощью сервиса {{ data-transfer-full-name }}.

Чтобы перенести базу данных из {{ GP }} в {{ CH }}:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mgp-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mgp-name }}](../../managed-greenplum/pricing/index.md)).
* Кластер {{ mch-full-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mch-name }}](../pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в {{ yandex-cloud }}. Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник {{ GP }} в сервисе {{ mgp-name }}](../../managed-greenplum/operations/cluster-create.md#create-cluster) любой подходящей конфигурации.

    1. [Создайте кластер-приемник {{ mch-full-name }}](../operations/cluster-create.md#create-cluster) любой подходящей конфигурации с базой данных `db1`.

    
    1. Если вы используете группы безопасности в кластерах, убедитесь, что они настроены правильно и допускают подключение к кластерам:

        * [{{ mch-name }}](../operations/connect/index.md#configuring-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect/index.md#configuring-security-groups).


    1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/clickhouse.md) типа `{{ CH }}`. В [параметрах](../../data-transfer/operations/endpoint/target/clickhouse.md#additional-settings) эндпоинта укажите политику очистки `Drop` или `Truncate`, чтобы данные на приемнике не дублировались при копировании.


- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [greenplum-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-greenplum-to-clickhouse/blob/main/greenplum-clickhouse.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;

        
        * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;


        * кластер-источник {{ GP }} в сервисе {{ mgp-name }};
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

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/greenplum.md) типа `{{ GP }}` и укажите в нем параметры подключения к кластеру.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа [{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}](../../data-transfer/concepts/index.md#transfer-type), использующий эндпоинты для источника и приемника.

    Для этой пары эндпоинтов репликация недоступна, но вы можете настроить регулярное копирование при создании трансфера. Для этого в блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}** в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** выберите **Регулярно**, затем укажите интервал копирования. Трансфер будет автоматически активироваться через указанный промежуток времени.

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

1. [Подключитесь к кластеру {{ GP }}](../../managed-greenplum/operations/connect/index.md), удалите одну строку и измените другую в таблице `x_tab`:

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

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. Убедитесь, что трансфер находится в статусе **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** и [удалите](../../data-transfer/operations/transfer.md#delete) его.
1. [Удалите](../../data-transfer/operations/endpoint/index.md#delete) эндпоинт-источник.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите кластер {{ mch-name }}](../operations/cluster-delete.md).
        1. [Удалите кластер {{ GP }}](../../managed-greenplum/operations/cluster-delete.md).
        1. [Удалите эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).

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


## Дополнительные материалы {#video}

Больше информации о сценариях поставок данных в вебинаре {{ yandex-cloud }}:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvkntkhjbfsn2c7ptv?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=bzWmmPp6KFg).

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._