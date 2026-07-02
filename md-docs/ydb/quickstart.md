[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for YDB](index.md) > Начало работы

# Как начать работать с Managed Service for YDB

В этой инструкции вы создадите базу данных [YDB](https://ydb.tech/ru) в Yandex Cloud и выполните простой запрос к ней с помощью [консоли управления](https://console.yandex.cloud) Yandex Cloud или инструментов командной строки.

Для работы с БД в Yandex Managed Service for YDB также доступны:
* [YDB SDK](https://ydb.tech/docs/ru//reference/ydb-sdk/).
* [YDB CLI](https://ydb.tech/docs/ru//reference/ydb-cli/).
* [AWS SDK](docapi/tools/aws-sdk/index.md).
* [AWS CLI](docapi/tools/aws-cli/index.md).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

## Создайте базу данных {#create-db}

Вы можете создать БД в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [Serverless и Dedicated режимы работы](concepts/serverless-and-dedicated.md). Тип БД нельзя изменить после создания.

{% note info %}

Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

{% endnote %}

### Создайте бессерверную БД {#serverless}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите **Имя** БД. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. В блоке **Тип базы данных** выберите опцию `Serverless`.
  
      Вы можете оставить параметры по умолчанию для создаваемой БД и [изменить](operations/manage-databases.md#update-db-serverless) их позже. Подробнее о параметрах БД читайте в разделе [Создать Serverless базу данных](operations/manage-databases.md#create-db-serverless).
  1. Нажмите кнопку **Создать базу данных**.

  Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`, а когда станет готова к использованию — статус сменится на `Running`.

- Yandex Cloud CLI {#cli}

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).
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
      endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gia87mbaom********/etn95g8jk8g0********
      serverless_database:
        storage_size_limit: "53687091200"
      location_id: ru-central1
      backup_config:
        backup_settings:
        - name: daily
          backup_schedule:
            daily_backup_schedule:
              execute_time:
                hours: 17
          backup_time_to_live: 172800s
          type: SYSTEM
      document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaom********/etn95g8jk8g0********
      monitoring_config: {}
      ```

      Будет создана база с параметрами по умолчанию. Вы сможете [изменить](operations/manage-databases.md#update-db-serverless) параметры позже. Подробнее о параметрах БД читайте в разделе [Создать Serverless базу данных](operations/manage-databases.md#create-db-serverless).
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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите **Имя** БД. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. В блоке **Тип базы данных** выберите опцию `Dedicated`.
  1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](concepts/resources.md#resource-presets).
  1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](concepts/resources.md#storage-groups), определяющее суммарный объем хранилища.
  1. В блоке **Сеть** настройте параметры сети:
     1. (Опционально) В поле **Публичные IP-адреса** выберите опцию **Присвоить**, если вы планируете отправлять запросы к БД не только из сети Yandex Cloud, но и через интернет.

        {% note warning %}
        
        Потребление исходящего интернет-трафика для баз Managed Service for YDB с внешними IP-адресами учитывается по [действующим тарифам](../vpc/pricing.md).
        
        Начисления за исходящий интернет-трафик, возникшие в результате использования Managed Service for YDB, будут компенсированы грантами.
        
        {% endnote %}

     1. Выберите существующую сеть из списка **Облачная сеть** или создайте новую:
        1. Нажмите кнопку **Создать**.
        1. В открывшемся окне укажите **Имя** новой сети.
        1. (Опционально) Выберите опцию **Создать подсети**. Подсети в каждой зоне доступности будут созданы автоматически.
        1. Нажмите кнопку **Создать сеть**.
     1. В блоке **Подсети** для каждой [зоны доступности](../overview/concepts/geo-scope.md) выберите подсеть или создайте новую:
        1. Нажмите кнопку **Создать**.
        1. В открывшемся окне укажите **Имя** новой подсети.
        1. (Опционально) Введите **Описание** подсети.
        1. Выберите из списка **Зона доступности** нужную зону.
        1. Задайте адрес подсети в формате [**CIDR**](https://ru.wikipedia.org/wiki/Бесклассовая_адресация).
        1. Нажмите кнопку **Создать подсеть**.

     Настойки блока **Сеть** нельзя изменить после создания БД.
  1. Нажмите кнопку **Создать базу данных**.

     Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`, а когда станет готова к использованию — статус сменится на `Running`.

- Yandex Cloud CLI {#cli}

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

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

      * `--resource-preset STR` — конфигурация вычислительных ресурсов узла. Возможные значения перечислены в колонке **Имя конфигурации** в таблице раздела [База данных на выделенных ресурсах (Dedicated)](concepts/resources.md#resource-presets).
      * `--storage STR` — тип носителя и количество [групп хранения](concepts/resources.md#storage-groups) в формате `type=<тип_носителя>,groups=<количество_групп_хранения>`. Для типа `ssd` одна группа хранения вмещает 100 ГБ данных.
      * `--public-ip` — флаг назначения публичных IP-адресов. Без этого флага вы не сможете подключиться к создаваемой базе данных из интернета.
      * `--network-name STR` — имя облачной сети, в которой будет создана база данных. Может быть указана сеть `default`.
      * `--async` — флаг асинхронного создания БД.

      Подробнее о параметрах БД читайте в разделе [Создать Serverless базу данных](operations/manage-databases.md#create-db-serverless).

      Результат:

      ```text
      done (7m18s)
      id: etnk1u65e4sh********
      folder_id: b1g7gvsi89m3********
      created_at: "2022-05-31T10:10:12Z"
      name: test-ded
      status: PROVISIONING
      endpoint: grpcs://lb.etnk1u65e4sh********.ydb.mdb.yandexcloud.net:2135/?database=/ru-central1/b1gia87mbaom********/etnk1u65e4sh********
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
      location_id: ru-central1
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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится нужная БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Выберите созданную ранее БД.
  1. Перейдите на вкладку **Навигация**.
  1. Нажмите кнопку **Новый SQL-запрос** и введите текст запроса:

     ```yql
     SELECT 1;
     ```

  1. Нажмите кнопку **Выполнить**.

     Ниже будет отображен результат выполнения запроса:

     ```text
     # column0
     0 1
     ```

- YDB CLI {#cli}

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

  1. Чтобы управлять вашими БД из командной строки, [установите](https://ydb.tech/docs/ru//reference/ydb-cli/install) YDB CLI.
  1. Для аутентификации YDB CLI в Yandex Cloud получите [IAM-токен](../iam/concepts/authorization/iam-token.md) и экспортируйте его в переменную окружения:

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
     endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gia87mbaom********/etnudu2n9ri3********
     ...
     ```

     Здесь часть строки `grpcs://ydb.serverless.yandexcloud.net:2135` содержит эндпоинт, а `/ru-central1/b1gia87mbaom********/etnudu2n9ri3********` — путь БД.

  1. Выполните запрос к созданной ранее БД, используя полученные значения эндпоинта и пути БД:
  
     ```bash
     ydb \
       --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 \
       --database /ru-central1/b1gia87mbaom********/etnudu2n9ri3******** \
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
* Ознакомьтесь с языком запросов [YQL](https://ydb.tech/docs/ru//yql/reference/).