# Управление базами данных {{ ydb-short-name }}

В сервисе {{ ydb-name }} вы можете создавать базы данных в двух режимах: [бессерверном](../concepts/serverless-and-dedicated.md#serverless) (Serverless) и с [выделенными серверами](../concepts/serverless-and-dedicated.md#dedicated) (Dedicated).

С помощью консоли управления или YC CLI можно:

* [Создать и изменить параметры бессерверной (Serverless) базы данных](#serverless).
* [Создать и изменить параметры базы данных с выделенными серверами (Dedicated)](#dedicated).
* [Посмотреть список баз данных](#list-db).
* [Удалить базу данных](#delete-db).

## Создать и изменить параметры бессерверной (Serverless) базы данных {#serverless}

### Создать Serverless базу данных {#create-db-serverless}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите **Имя** БД. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. В блоке **Тип базы данных** выберите опцию **Serverless**.
  1. Вам будут предложены значения по умолчанию. Они подобраны таким образом, чтобы вы могли эффективно начать работу. Вы можете изменить их сейчас или в будущем, если потребуется. Подробнее о настройках БД [см. раздел Режимы работы Serverless и Dedicated](../concepts/serverless-and-dedicated.md).
  1. Нажмите кнопку **Создать базу данных**.

   Дождитесь, когда статус БД изменится на `Running`.

- YC CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды YC CLI для создания БД:

      ```bash
      yc ydb database create --help
      ```

  1. Выполните команду:

      ```bash
      yc ydb database create <имя_БД> --serverless
      ```

      Результат:

      ```text
      id: etne027gi9aap7ldau3f
      folder_id: b1gmit33ngp3kr4mhjmo
      created_at: "2022-12-13T09:17:06Z"
      name: svlbd
      status: PROVISIONING
      endpoint: {{ ydb.ep-serverless }}/?database=/{{ region-id }}/b1gia87mbaomkfvsleds/etne027gi9aap7ldau3f
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
          backup_time_to_live: 604800s
          type: SYSTEM
      document_api_endpoint: https://docapi.serverless.yandexcloud.net/{{ region-id }}/b1gia87mbaomkfvsleds/etne027gi9aap7ldau3f
      monitoring_config: {}
      ```

  Все параметры можно будет [изменить](#update-db-serverles) в дальнейшем командой `update` YC CLI или в консоли управления. Подробнее см. в разделе [{#T}](../concepts/serverless-and-dedicated.md#serverless-options).

  Любая создаваемая Serverless БД является георезервированной в трех [зонах доступности](../../overview/concepts/geo-scope.md).

{% endlist %}

### Изменить параметры Serverless базы данных {#update-db-serverless}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить настройки БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Изменить**.
  1. Настройте параметры БД:
      1. При необходимости измените имя БД.
      1. В блоке **Ограничения** задайте [пропускную способность](../pricing/serverless.md#prices-ru) и [объем данных](../pricing/serverless.md#rules-storage).
      1. В блоке **Тарификация** задайте [выделенную пропускную способность](../pricing/serverless.md#prices-ru).
  1. Нажмите кнопку **Изменить базу данных**.

- YC CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды YC CLI для изменения БД:

  ```bash
  yc ydb database update --help
  ```

  Имена параметров Serverless БД начинаются с `sls-`. Другие параметры применимы только к Dedicated БД.

  **Примеры**

  1. Переименование БД dbtest в mydb:

      > ```bash
      > yc ydb database update dbtest \
      >   --new-name mydb
      > ```

  1. Установка ограничения на потребление 100 Request Units в секунду для Serverless БД с именем db5:

      > ```bash
      > yc ydb database update db5 \
      >   --sls-throttling-rcu 100
      > ```

{% endlist %}

## Создать и изменить параметры базы данных с выделенными серверами (Dedicated) {#dedicated}

### Создать Dedicated базу данных {#create-db-dedicated}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите **Имя** базы. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. В блоке **Тип базы данных** выберите опцию **Dedicated**.
  1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](../concepts/resources.md#resource-presets).
  1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](../concepts/resources.md#storage-groups), определяющее суммарный объем хранилища.
  1. В блоке **Сеть** настройте параметры сети:
      1. (опционально) В поле **Публичные IP-адреса** выберите опцию **Присвоить**, если вы планируете отправлять запросы к базе не только из сети {{ yandex-cloud }}, но и через интернет.

          {% include  [traffic_metering](../_includes/traffic_metering.md) %}

      1. Выберите существующую сеть из списка **Облачная сеть** или создайте новую:
          * Нажмите кнопку **Создать новую**.
          * В открывшемся окне укажите **Имя** новой сети.
          * (опционально) Выберите опцию **Создать подсети**. Подсети в каждой зоне доступности будут созданы автоматически.
          * Нажмите кнопку **Создать**.
      1. В блоке **Подсети** для каждой зоны доступности выберите подсеть или создайте новую:
          * Нажмите кнопку **Создать новую**.
          * В открывшемся окне укажите **Имя** новой подсети.
          * (опционально) Введите **Описание** подсети.
          * Выберите из списка **Зона доступности** нужную зону.
          * Задайте адрес подсети в формате [**CIDR**](https://ru.wikipedia.org/wiki/Бесклассовая_адресация).
          * Нажмите кнопку **Создать**.
  1. Нажмите кнопку **Создать базу данных**.

    Дождитесь, когда статус БД изменится на `Running`.

- YC CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды YC CLI для создания БД:

      ```bash
      yc ydb database create --help
      ```

  1. Выполните команду:

      ```bash
      yc ydb database create <имя_БД> \
        --dedicated \
        --network-name <название_сети> \
        --storage <тип_носителя>,<количество_групп_хранения> \
        --resource-preset <конфигурация_вычислительных_ресурсов> \
      ```

      Где:

        * `--dedicated` — конфигурация БД с выделенными серверами.
        * `--network-name` — имя облачной сети, в которой будет создана БД. Может быть указана сеть `default`.
        * `--storage` — тип носителя и количество групп хранения в формате `type=<type>,groups=<groups>`. Для типа `ssd` одна группа хранения вмещает 100 ГБ данных.
        * `--resource-preset` — конфигурация вычислительных ресурсов узла. Возможные значения можно [посмотреть](../concepts/resources.md#resource-presets) в таблице, в столбце **Имя конфигурации**.

  Важные дополнительные параметры:

  * `--public-ip` — флаг назначения публичных IP-адресов. Без этого флага вы не сможете подключиться к создаваемой БД из интернета.
  * `--fixed-size INT` — количество узлов в кластере, по умолчанию 1. Узлы выделяются в разных зонах доступности, таким образом конфигурация из трех узлов будет географически распределена в трех зонах доступности.
  * `--async` — флаг асинхронного создания. Создание Dedicated БД может занимать значительное время, измеряемое минутами. Вы можете указать данный флаг для того, чтобы управление было возвращено сразу как только команда на создание БД будет принята облаком.

  **Примеры**
  
  1. Создание минимальной одноузловой Dedicated БД YDB с именем dedb, доступной из Интернет:

      > ```bash
      > yc ydb database create dedb \
      >   --dedicated \
      >   --network-name default \
      >   --storage type=ssd,groups=1 \
      >   --resource-preset medium \
      >   --public-ip
      > ```  

  1. Асинхронное создание трехузловой георезервированной Dedicated БД YDB с хранилищем в 300 ГБ и вычислительным узлами по 64 ГБ RAM, с именем dedb3, доступной из Интернет:

      > ```bash
      > yc ydb database create dedb3 \
      >   --dedicated 
      >   --network-name default \
      >   --storage type=ssd,groups=3 \
      >   --resource-preset medium-m64 \
      >   --public-ip \
      >   --fixed-size 3 \
      >   --async
      > ```

{% endlist %}

### Изменить параметры Dedicated базы данных {#update-db-dedicated}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить настройки БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Изменить**.
  1. Настройте параметры БД:
      1. При необходимости измените имя БД.
      1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](../concepts/index.md#resource-presets).
      1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](../concepts/index.md#storage-groups), определяющее суммарный объем хранилища.
  1. Нажмите кнопку **Изменить базу данных**.

- YC CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды YC CLI для изменения БД:

  ```bash
  yc ydb database update --help
  ```

  К Dedicated БД применимы параметры без префикса `sls-`.

  **Пример**

  Изменение количества групп хранения для БД с типом дисков ssd и одной группой хранения:

  > ```bash
  > yc ydb database update test-db \
  >   --storage type=ssd,group=2
  > ```

  Количество групп хранения нельзя уменьшить.

{% endlist %}

## Посмотреть список баз данных {#list-db}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, для которого нужно получить список БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.

- YC CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc ydb database list
  ```

{% endlist %}

## Удалить базу данных {#delete-db}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно удалить БД.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.
  1. Подтвердите удаление.

- YC CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc ydb database delete <имя_БД>
  ```

{% endlist %}
