---
title: Как начать работать с {{ ydb-full-name }}
description: Следуя данной инструкции, вы сможете создать и настроить БД {{ ydb-name }}.
---

# Как начать работать с {{ ydb-name }}


В этой инструкции вы создадите базу данных [{{ ydb-short-name }}](https://ydb.tech/{{ lang }}) в {{ yandex-cloud }} и выполните простой запрос к ней с помощью [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} или инструментов командной строки.

Для работы с БД в {{ ydb-full-name }} также доступны:
* [{{ ydb-short-name }} SDK]({{ ydb.docs }}/reference/ydb-sdk/).
* [{{ ydb-short-name }} CLI]({{ ydb.docs }}/reference/ydb-cli/).
* [AWS SDK](docapi/tools/aws-sdk/index.md).
* [AWS CLI](docapi/tools/aws-cli/index.md).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

## Создайте базу данных {#create-db}

Вы можете создать БД в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [Serverless и Dedicated режимы работы](concepts/serverless-and-dedicated.md). Тип БД нельзя изменить после создания.

{% note info %}

Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

{% endnote %}

### Создайте бессерверную БД {#serverless}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана БД.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Введите **{{ ui-key.yacloud.ydb.forms.label_field_name }}** БД. Требования к имени:

     {% include [name-format](../_includes/name-format.md) %}

  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите опцию `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  
      Вы можете оставить параметры по умолчанию для создаваемой БД и [изменить](operations/manage-databases.md#update-db-serverless) их позже. Подробнее о параметрах БД читайте в разделе [{#T}](operations/manage-databases.md#create-db-serverless).
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`, а когда станет готова к использованию — статус сменится на `Running`.

- {{ yandex-cloud }} CLI {#cli}

  1. {% include [cli-install](../_includes/cli-install.md) %}
  1. Создайте базу данных:

      ```bash
      yc ydb database create <имя_БД> --serverless
      ```

      Где `<имя_БД>` — имя вашей базы данных.

      Результат:

      ```text
      done (6s)
      id: etn95g8jk8g0********
      folder_id: b1g7gvsi89m3********
      created_at: "2022-05-30T07:26:44Z"
      name: test
      status: PROVISIONING
      endpoint: {{ ydb.ep-serverless }}/?database=/{{ region-id }}/b1gia87mbaom********/etn95g8jk8g0********
      serverless_database:
        storage_size_limit: "53687091200"
      location_id: {{ region-id }}
      backup_config:
        backup_settings:
        - name: daily
          backup_schedule:
            daily_backup_schedule:
              execute_time:
                hours: 17
          backup_time_to_live: 172800s
          type: SYSTEM
      document_api_endpoint: {{ ydb.document-api-endpoint }}/{{ region-id }}/b1gia87mbaom********/etn95g8jk8g0********
      monitoring_config: {}
      ```

      Будет создана база с параметрами по умолчанию. Вы сможете [изменить](operations/manage-databases.md#update-db-serverless) параметры позже. Подробнее о параметрах БД читайте в разделе [{#T}](operations/manage-databases.md#create-db-serverless).
  1. Проверьте статус созданной БД:

     ```bash
     yc ydb database get <имя_БД>
     ```

     Где `<имя_БД>` — имя созданной БД.

     В процессе создания БД будет иметь статус `PROVISIONING`, а когда станет готова к использованию — статус сменится на `RUNNING`.

{% endlist %}

### Создайте БД на выделенных серверах {#dedicated}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана БД.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Введите **{{ ui-key.yacloud.ydb.forms.label_field_name }}** БД. Требования к имени:

     {% include [name-format](../_includes/name-format.md) %}

  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите опцию `{{ ui-key.yacloud.ydb.forms.label_dedicated-type }}`.
  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_section-compute }}** выберите тип и количество [вычислительных ресурсов](concepts/resources.md#resource-presets).
  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_section-storage }}** выберите тип диска и количество [групп хранения](concepts/resources.md#storage-groups), определяющее суммарный объем хранилища.
  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_section-network }}** настройте параметры сети:
     1. (Опционально) В поле **{{ ui-key.yacloud.ydb.forms.field_public-ips }}** выберите опцию **{{ ui-key.yacloud.ydb.forms.label_text-public-ips }}**, если вы планируете отправлять запросы к БД не только из сети {{ yandex-cloud }}, но и через интернет.

        {% include [traffic_metering](_includes/traffic_metering.md) %}

     1. Выберите существующую сеть из списка **{{ ui-key.yacloud.ydb.forms.field_network }}** или создайте новую:
        1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-network-new }}**.
        1. В открывшемся окне укажите **{{ ui-key.yacloud.vpc.networks.create.field_name }}** новой сети.
        1. (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**. Подсети в каждой зоне доступности будут созданы автоматически.
        1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
     1. В блоке **{{ ui-key.yacloud.ydb.forms.field_subnetworks }}** для каждой [зоны доступности](../overview/concepts/geo-scope.md) выберите подсеть или создайте новую:
        1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-subnetwork-new }}**.
        1. В открывшемся окне укажите **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** новой подсети.
        1. (Опционально) Введите **{{ ui-key.yacloud.vpc.subnetworks.create.field_description }}** подсети.
        1. Выберите из списка **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** нужную зону.
        1. Задайте адрес подсети в формате [**{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**](https://ru.wikipedia.org/wiki/Бесклассовая_адресация).
        1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

     Настойки блока **{{ ui-key.yacloud.ydb.forms.label_section-network }}** нельзя изменить после создания БД.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

     Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`, а когда станет готова к использованию — статус сменится на `Running`.

- {{ yandex-cloud }} CLI {#cli}

  1. {% include [cli-install](../_includes/cli-install.md) %}

  1. При необходимости создайте облачную [сеть](../vpc/operations/network-create.md) и [подсети](../vpc/operations/subnet-create.md) для каждой [зоны доступности](../overview/concepts/geo-scope.md).
  1. Создайте базу данных:

      ```bash
      yc ydb database create <имя_БД> \
        --dedicated \
        --resource-preset <конфигурация> \
        --storage type=<тип_носителя>,groups=<количество_групп_хранения> \
        --public-ip \
        --network-name default\
        --async
      ```

      Где:

      * `--resource-preset STR` — конфигурация вычислительных ресурсов узла. Возможные значения перечислены в колонке **Имя конфигурации** в таблице раздела [{#T}](concepts/resources.md#resource-presets).
      * `--storage STR` — тип носителя и количество [групп хранения](concepts/resources.md#storage-groups) в формате `type=<тип_носителя>,groups=<количество_групп_хранения>`. Для типа `ssd` одна группа хранения вмещает 100 ГБ данных.
      * `--public-ip` — флаг назначения публичных IP-адресов. Без этого флага вы не сможете подключиться к создаваемой базе данных из интернета.
      * `--network-name STR` — имя облачной сети, в которой будет создана база данных. Может быть указана сеть `default`.
      * `--async` — флаг асинхронного создания БД.

      Подробнее о параметрах БД читайте в разделе [{#T}](operations/manage-databases.md#create-db-serverless).

      Результат:

      ```text
      done (7m18s)
      id: etnk1u65e4sh********
      folder_id: b1g7gvsi89m3********
      created_at: "2022-05-31T10:10:12Z"
      name: test-ded
      status: PROVISIONING
      endpoint: {{ ydb.ep-dedicated }}/?database=/{{ region-id }}/b1gia87mbaom********/etnk1u65e4sh********
      resource_preset_id: medium
      storage_config:
        storage_options:
        - storage_type_id: ssd
          group_count: "1"
        storage_size_limit: "107374182400"
      scale_policy:
        fixed_scale:
          size: "1"
      network_id: enpqkm0od2bu********
      subnet_ids:
      - b0cmespgm8o3********
      - e2lif378n1pg********
      - e9b72lv142k4********
      dedicated_database:
        resource_preset_id: medium
        storage_config:
          storage_options:
          - storage_type_id: ssd
            group_count: "1"
          storage_size_limit: "107374182400"
        scale_policy:
          fixed_scale:
            size: "1"
        network_id: enpqkm0od2bu********
        subnet_ids:
        - b0cmespgm8o3********
        - e2lif378n1pg********
        - e9b72lv142k4********
        assign_public_ips: true
      assign_public_ips: true
      location_id: {{ region-id }}
      backup_config:
        backup_settings:
        - name: daily
          backup_schedule:
            daily_backup_schedule:
              execute_time:
                hours: 17
          backup_time_to_live: 172800s
          type: SYSTEM
      monitoring_config: {}
      ```

  1. Проверьте статус созданной БД:

     ```bash
     yc ydb database get <имя_БД>
     ```

     Где `<имя_БД>` — имя созданной БД.

     В процессе создания БД будет иметь статус `PROVISIONING`, а когда станет готова к использованию — статус сменится на `RUNNING`.

{% endlist %}

## Выполните запрос к базе данных {#query}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная БД.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Выберите созданную ранее БД.
  1. Перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.browse.button_sql-query }}** и введите текст запроса:

     ```yql
     SELECT 1;
     ```

  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.sql.button_run }}**.

     Ниже будет отображен результат выполнения запроса:

     ```text
     # column0
     0 1
     ```

- {{ ydb-short-name }} CLI {#cli}

  1. {% include [cli-install](../_includes/cli-install.md) %}

  1. Чтобы управлять вашими БД из командной строки, [установите](https://{{ ydb.docs }}/reference/ydb-cli/install) {{ ydb-short-name }} CLI.
  1. Для аутентификации {{ ydb-short-name }} CLI в {{ yandex-cloud }} получите [IAM-токен](../iam/concepts/authorization/iam-token.md) и экспортируйте его в переменную окружения:

     ```bash
     export IAM_TOKEN=`yc iam create-token`
     ```

  1. Получите эндпоинт и путь БД:

     ```bash
     yc ydb database get ydb-prod
     ```

     Результат:

     ```text
     ...
     endpoint: {{ ydb.ep-serverless }}/?database=/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********
     ...
     ```

     Здесь часть строки `{{ ydb.ep-serverless }}` содержит эндпоинт, а `/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********` — путь БД.

  1. Выполните запрос к созданной ранее БД, используя полученные значения эндпоинта и пути БД:
  
     ```bash
     ydb \
       --endpoint {{ ydb.ep-serverless }} \
       --database /{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3******** \
       yql -s "SELECT 1;"
     ```

     Результат:

     ```text
     ┌─────────┐
     | column0 |
     ├─────────┤
     | 1       |
     └─────────┘
     ```

{% endlist %}

## Что дальше {#whats-next}

* Узнайте подробнее о [работе с БД](operations/index.md).
* Изучите [концепции сервиса](concepts/index.md).
* Ознакомьтесь с языком запросов [YQL]({{ ydb.docs }}/yql/reference/).
