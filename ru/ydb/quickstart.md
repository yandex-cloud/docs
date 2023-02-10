# Как начать работать с {{ ydb-name }}


{% include [mdb-grant-note](../_includes/mdb/mdb-grant-note.md) %}


В этой инструкции вы создадите базу данных [{{ ydb-short-name }}](https://ydb.tech/ru) в {{ yandex-cloud }} и выполните простой запрос к ней с помощью [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} или инструментов командной строки.

Для работы с БД в {{ ydb-full-name }} также доступны:
* [{{ ydb-short-name }} SDK](https://ydb.tech/ru/docs/reference/ydb-sdk/).
* [{{ ydb-short-name }} CLI](https://ydb.tech/ru/docs/reference/ydb-cli/).
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

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите **Имя** БД. Требования к имени:

     {% include [name-format](../_includes/name-format.md) %}

  1. В блоке **Тип базы данных** выберите опцию **Serverless**.
  
      Вы можете оставить параметры по умолчанию для создаваемой БД и [изменить](operations/manage-databases.md#update-db-serverless) их позже. Подробнее о параметрах БД читайте в разделе [{#T}](operations/manage-databases.md#create-db-serverless).
  1. Нажмите кнопку **Создать базу данных**.

  Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`, а когда станет готова к использованию — статус сменится на `Running`.

- YC CLI

  1. {% include [cli-install](../_includes/cli-install.md) %}
  1. Создайте базу данных:

      ```bash
      yc ydb database create <name> --serverless
      ```

      Где `name` — имя вашей базы данных.

      Результат:

      ```text
      done (6s)
      id: etn95g8jk8g0qk84hk20
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2022-05-30T07:26:44Z"
      name: test
      status: PROVISIONING
      endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaomkfvsleds/etn95g8jk8g0qk84hk20
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
      document_api_endpoint: https://docapi.serverless.yandexcloud.net/{{ region-id }}/b1gia87mbaomkfvsleds/etn95g8jk8g0qk84hk20
      monitoring_config: {}
      ```

      Будет создана база с параметрами по умолчанию. Вы сможете [изменить](operations/manage-databases.md#update-db-serverless) параметры позже. Подробнее о параметрах БД читайте в разделе [{#T}](operations/manage-databases.md#create-db-serverless).
  1. Проверьте статус созданной БД:

     ```bash
     yc ydb database get <name>
     ```

     Где `name` — имя созданной БД.

     В процессе создания БД будет иметь статус `PROVISIONING`, а когда станет готова к использованию — статус сменится на `RUNNING`.

{% endlist %}

### Создайте БД на выделенных серверах {#dedicated}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите **Имя** БД. Требования к имени:

     {% include [name-format](../_includes/name-format.md) %}

  1. В блоке **Тип базы данных** выберите опцию **Dedicated**.
  1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](concepts/index.md#resource-presets).
  1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](concepts/index.md#storage-groups), определяющее суммарный объем хранилища.
  1. В блоке **Сеть** настройте параметры сети:
     1. (опционально) В поле **Публичные IP-адреса** выберите опцию **Присвоить**, если вы планируете отправлять запросы к БД не только из сети {{ yandex-cloud }}, но и через интернет.

        {% include [traffic_metering](_includes/traffic_metering.md) %}

     1. Выберите существующую сеть из списка **Облачная сеть** или создайте новую:
        1. Нажмите кнопку **Создать новую**.
        1. В открывшемся окне укажите **Имя** новой сети.
        1. (опционально) Выберите опцию **Создать подсети**. Подсети в каждой зоне доступности будут созданы автоматически.
        1. Нажмите кнопку **Создать**.
     1. В блоке **Подсети** для каждой [зоны доступности](../overview/concepts/geo-scope.md) выберите подсеть или создайте новую:
        1. Нажмите кнопку **Создать новую**.
        1. В открывшемся окне укажите **Имя** новой подсети.
        1. (опционально) Введите **Описание** подсети.
        1. Выберите из списка **Зона доступности** нужную зону.
        1. Задайте адрес подсети в формате [**CIDR**](https://ru.wikipedia.org/wiki/Бесклассовая_адресация).
        1. Нажмите кнопку **Создать**.

     Настойки блока **Сеть** нельзя изменить после создания БД.
  1. Нажмите кнопку **Создать базу данных**.

     Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`, а когда станет готова к использованию — статус сменится на `Running`.

- YC CLI

  1. {% include [cli-install](../_includes/cli-install.md) %}

  1. При необходимости создайте облачную [сеть](../vpc/operations/network-create.md) и [подсети](../vpc/operations/subnet-create.md) для каждой [зоны доступности](../overview/concepts/geo-scope.md).
  1. Создайте базу данных:

      ```bash
      yc ydb database create <name> \
        --dedicated \
        --resource-preset <preset> \
        --storage type=<type>,groups=<groups> \
        --public-ip \
        --network-name default\
        --async
      ```

      Где:

      * `--resource-preset STR` — конфигурация вычислительных ресурсов узла. Возможные значения перечислены в колонке "Имя конфигурации" в таблице пункта [Вычислительные ресурсы](concepts/index.md#resource-presets) на странице о базах данных.
      * `--storage STR` — тип носителя и количество групп хранения в формате `type=<type>,groups=<groups>`. Для типа `ssd` одна группа хранения вмещает 100GB данных.
      * `--public-ip` — флаг назначения публичных IP-адресов. Без этого флага вы не сможете подключиться к создаваемой базе данных из интернета.
      * `--network-name STR` — имя облачной сети, в которой будет создана база данных. Может быть указана сеть `default`.
      * `--async` — флаг асинхронного создания БД.

      Подробнее о параметрах БД читайте в разделе [{#T}](operations/manage-databases.md#create-db-serverless).

      Результат:

      ```text
      done (7m18s)
      id: etnk1u65e4shtgj207sc
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2022-05-31T10:10:12Z"
      name: test-ded
      status: PROVISIONING
      endpoint: grpcs://lb.etnk1u65e4shtgj207sc.ydb.mdb.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaomkfvsleds/etnk1u65e4shtgj207sc
      resource_preset_id: medium
      storage_config:
        storage_options:
        - storage_type_id: ssd
          group_count: "1"
        storage_size_limit: "107374182400"
      scale_policy:
        fixed_scale:
          size: "1"
      network_id: enpqkm0od2bueqbuo9qa
      subnet_ids:
      - b0cmespgm8o3pr0ssprq
      - e2lif378n1pg90pp96bl
      - e9b72lv142k40bul5qgv
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
        network_id: enpqkm0od2bueqbuo9qa
        subnet_ids:
        - b0cmespgm8o3pr0ssprq
        - e2lif378n1pg90pp96bl
        - e9b72lv142k40bul5qgv
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
     yc ydb database get <name>
     ```

     Где `name` — имя созданной БД.

     В процессе создания БД будет иметь статус `PROVISIONING`, а когда станет готова к использованию — статус сменится на `RUNNING`.

{% endlist %}

## Выполните запрос к базе данных {#query}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Выберите созданную ранее БД.
  1. Перейдите на вкладку **Навигация**.
  1. Нажмите кнопку **SQL-запрос** и введите текст запроса:

     ```yql
     SELECT 1;
     ```

  1. Нажмите кнопку **Выполнить**.

     Ниже будет отображен результат выполнения запроса:

     ```text
     # column0
     0 1
     ```

- {{ ydb-short-name }} CLI

  1. {% include [cli-install](../_includes/cli-install.md) %}

  1. Чтобы управлять вашими БД из командной строки, [установите]((https://ydb.tech/ru/docs/reference/ydb-cli/install)) {{ ydb-short-name }} CLI.
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
     endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaomkfvsleds/etnudu2n9ri35luqs9o2
     ...
     ```

     Здесь часть строки `grpcs://ydb.serverless.yandexcloud.net:2135` содержит эндпоинт, а `/{{ region-id }}/b1gia87mbaomkfvsleds/etnudu2n9ri35luqs9o2` — путь БД.

  1. Выполните запрос к созданной ранее БД, используя полученные значения эндпоинта и пути БД:
  
     ```bash
     ydb \
       --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 \
       --database /{{ region-id }}/b1gia87mbaomkfvsleds/etnudu2n9ri35luqs9o2 \
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
* Ознакомьтесь с языком запросов [YQL](https://ydb.tech/ru/docs/yql/reference/).
