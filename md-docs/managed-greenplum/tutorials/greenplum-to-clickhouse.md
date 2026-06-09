# Миграция базы данных из Greenplum® в ClickHouse®

Вы можете перенести базу данных из Greenplum® в ClickHouse® с помощью сервиса Yandex Data Transfer.

Чтобы перенести базу данных из Greenplum® в ClickHouse®:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу копирования при повторной активации](#example-check-copy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex MPP Analytics for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Yandex MPP Analytics for PostgreSQL](../pricing/index.md)).
* Кластер Yandex Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы Data Transfer](../../data-transfer/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в Yandex Cloud. Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL](../operations/cluster-create.md#create-cluster) любой подходящей конфигурации.

    1. [Создайте кластер-приемник Yandex Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md#create-cluster) любой подходящей конфигурации с базой данных `db1`.

    
    1. Если вы используете группы безопасности в кластерах, убедитесь, что они настроены правильно и допускают подключение к кластерам:

        * [Managed Service for ClickHouse®](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
        * [Yandex MPP Analytics for PostgreSQL](../operations/connect/index.md#configuring-security-groups).


    1. [Создайте эндпоинт-приемник](../../data-transfer/operations/endpoint/target/clickhouse.md) типа `ClickHouse®`. В [параметрах](../../data-transfer/operations/endpoint/target/clickhouse.md#additional-settings) эндпоинта укажите политику очистки `Drop` или `Truncate`, чтобы данные на приемнике не дублировались при копировании.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [greenplum-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-greenplum-to-clickhouse/blob/main/greenplum-clickhouse.tf).

        В этом файле описаны:

        * [сети](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet) для размещения кластеров;

        
        * [группы безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;


        * кластер-источник Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL;
        * кластер-приемник Managed Service for ClickHouse®;
        * эндпоинт-приемник.

    1. Укажите в файле `greenplum-clickhouse.tf`:

        * `mgp_password` — пароль администратора Greenplum®.
        * `mch_db` — имя базы данных ClickHouse®.
        * `mch_user` — имя пользователя базы данных ClickHouse®.
        * `mch_password` — пароль пользователя базы данных ClickHouse®.

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

## Подготовьте трансфер {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../data-transfer/operations/endpoint/source/greenplum.md) типа `Greenplum®` и укажите в нем параметры подключения к кластеру.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа [Копирование](../../data-transfer/concepts/index.md#transfer-type), использующий эндпоинты для источника и приемника.

    Для этой пары эндпоинтов репликация недоступна, но вы можете настроить регулярное копирование при создании трансфера. Для этого в блоке **Параметры трансфера** в поле **Копирование** выберите **Регулярно**, затем укажите интервал копирования. Трансфер будет автоматически активироваться через указанный промежуток времени.

## Активируйте трансфер {#activate-transfer}

1. [Подключитесь к кластеру Greenplum®](../operations/connect/index.md), создайте в нем таблицу `x_tab` и заполните ее данными:

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

1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Завершен**.
1. Чтобы проверить корректность переноса данных, подключитесь к кластеру-приемнику Managed Service for ClickHouse® и убедитесь, что колонки в таблице `x_tab` в базе `db1` совпадают с колонками таблицы `x_tab` в базе источника:

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

1. [Подключитесь к кластеру Greenplum®](../operations/connect/index.md), удалите одну строку и измените другую в таблице `x_tab`:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Повторно [активируйте трансфер](../../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус **Завершен**.
1. Убедитесь, что в таблице `x_tab` на приемнике ClickHouse® отобразились изменения:

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

1. Убедитесь, что трансфер находится в статусе **Завершен** и [удалите](../../data-transfer/operations/transfer.md#delete) его.
1. [Удалите](../../data-transfer/operations/endpoint/index.md#delete) эндпоинт-источник.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
        1. [Удалите кластер Greenplum®](../operations/cluster-delete.md).
        1. [Удалите эндпоинт-приемник](../../data-transfer/operations/endpoint/index.md#delete).

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


## Дополнительные материалы {#video}

Больше информации о сценариях поставок данных в вебинаре Yandex Cloud:


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvkntkhjbfsn2c7ptv?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=bzWmmPp6KFg).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._