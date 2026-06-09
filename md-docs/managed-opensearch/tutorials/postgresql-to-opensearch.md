# Миграция данных из {{ mpg-full-name }} в {{ mos-full-name }} с помощью {{ data-transfer-full-name }}

## Поставка данных из {{ mpg-full-name }} в {{ mos-full-name }} с помощью {{ data-transfer-full-name }}

Вы можете перенести базу данных из {{ mpg-full-name }} в {{ mos-full-name }} с помощью сервиса {{ data-transfer-full-name }}. Для этого:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Подготовьте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Кластер {{ mos-name }}: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mos-name }}](../pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. Создайте кластер-источник {{ mpg-name }} любой подходящей [конфигурации](../../managed-postgresql/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** — `<пароль_источника>`.

    1. [Создайте кластер-приемник {{ mos-name }}](../operations/cluster-create.md) любой подходящей конфигурации с хостами в публичном доступе.

    1. [Получите SSL-сертификат](../operations/connect/index.md#ssl-certificate) для подключения к кластеру-приемнику {{ mos-name }}.

    1. Настройте группы безопасности для подключения к [кластеру-источнику {{ mpg-name }}](../../managed-postgresql/operations/connect/index.md#configuring-security-groups) и [кластеру-приемнику {{ mos-name }}](../operations/connect/index.md#configuring-security-groups).

- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-to-opensearch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-opensearch/blob/main/postgresql-to-opensearch.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) для подключения к кластерам;
        * кластер-источник {{ mpg-name }};
        * кластер-приемник {{ mos-name }};
        * эндпоинт для источника;
        * трансфер.

    1. Укажите в файле `postgresql-to-opensearch.tf` значения переменных:

        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md);
        * `pg_password` — пароль пользователя {{ PG }};
        * `mos_version` — версия {{ OS }};
        * `mos_password` — пароль пользователя {{ OS }};
        * `profile_name` — имя вашего профиля в CLI.

           Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

1. [Подключитесь к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect/index.md), создайте в базе данных `db1` таблицу `x_tab` и заполните ее данными:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC PRIMARY KEY,
         name CHAR(5)
     );
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/target/opensearch.md) со следующими настройками:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}** — выберите кластер {{ mos-name }} из списка.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}** — `admin`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}** — `<пароль_пользователя>`.

1. Создайте эндпоинт для источника и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

      1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/source/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-источника_{{ PG }}>` из выпадающего списка.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — `db1`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — `pg-user`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — `<пароль_пользователя>`.

      1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**, использующий созданные эндпоинты.

      1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).

    - {{ TF }} {#tf}

      1. Укажите в файле `postgresql-to-opensearch.tf` значения переменных:

          * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
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

          Трансфер активируется автоматически после создания.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Подключитесь к кластеру-приемнику с помощью [{{ OS }} Dashboards](../operations/connect/clients.md#dashboards).
1. Выберите общий тенант `Global`.
1. Создайте новый шаблон индекса с именем `public.x_tab`:

    1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
    1. В разделе **Management** выберите **Stack Management**.
    1. Перейдите в раздел **Index Patterns** и нажмите кнопку **Create index pattern**.
    1. В поле **Index pattern name** укажите `public.x_tab` и нажмите кнопку **Next step**.
    1. Нажмите кнопку **Create index pattern**.

1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
1. В разделе **OpenSearch Dashboards** выберите **Discover**.
1. В открывшемся дашборде должны появиться данные из базы данных {{ mpg-name }}.

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

1. [Удалите эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#delete).
1. Остальные ресурсы удалите в зависимости от способа их создания:

   {% list tabs group=instructions %}

   - Вручную {#manual}

       1. [Удалите кластер {{ mos-name }}](../operations/cluster-delete.md).
       1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
       1. [Удалите эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#delete).
       1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).

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