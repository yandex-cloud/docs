# Управление базами данных YDB

В сервисе Managed Service for YDB вы можете создавать базы данных в двух режимах: [бессерверном](../concepts/serverless-and-dedicated.md#serverless) (Serverless) и с [выделенными серверами](../concepts/serverless-and-dedicated.md#dedicated) (Dedicated).

С помощью консоли управления или Yandex Cloud CLI можно:

* [Создать и изменить параметры бессерверной (Serverless) базы данных](#serverless).
* [Создать и изменить параметры базы данных с выделенными серверами (Dedicated)](#dedicated).
* [Посмотреть список баз данных](#list-db).
* [Удалить базу данных](#delete-db).

## Создать и изменить параметры бессерверной (Serverless) базы данных {#serverless}

### Создать Serverless базу данных {#create-db-serverless}

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
  1. В блоке **Тип нагрузки** выберите одну из следующих опций:

      - `OLTP`;
      - `OLAP (Analytics β)`.

  1. Вам будут предложены значения по умолчанию. Они подобраны таким образом, чтобы вы могли эффективно начать работу. Вы можете изменить их сейчас или в будущем, если потребуется. Подробнее о настройках БД [см. раздел Режимы работы Serverless и Dedicated](../concepts/serverless-and-dedicated.md).
  1. Нажмите кнопку **Создать базу данных**.

   Дождитесь, когда статус БД изменится на `Running`.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды Yandex Cloud CLI для создания БД:

      ```bash
      yc ydb database create --help
      ```

  1. Выполните команду:

      ```bash
      yc ydb database create <имя_БД> --serverless
      ```

      Результат:

      ```text
      id: etne027gi9aa********
      folder_id: b1gmit33ngp3********
      created_at: "2022-12-13T09:17:06Z"
      name: svlbd
      status: PROVISIONING
      endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gia87mbaom********/etne027gi9aa********
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
          backup_time_to_live: 604800s
          type: SYSTEM
      document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaom********/etne027gi9aa********
      monitoring_config: {}
      ```

  Все параметры можно будет [изменить](#update-db-serverles) в дальнейшем командой `update` Yandex Cloud CLI или в консоли управления. Подробнее см. в разделе [Параметры Serverless базы данных](../concepts/serverless-and-dedicated.md#serverless-options).

  Любая создаваемая Serverless БД является георезервированной в трех [зонах доступности](../../overview/concepts/geo-scope.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле Terraform параметры Serverless БД, которую необходимо создать:

      ```hcl
      resource "yandex_ydb_database_serverless" "database1" {
        name                = "<имя_БД>"
        deletion_protection = "<защита_от_удаления>"

        serverless_database {
          enable_throttling_rcu_limit = <ограничение_пропускной_способности>
          provisioned_rcu_limit       = <пропускная_способность>
          storage_size_limit          = <объем_данных>
          throttling_rcu_limit        = <выделенная_пропускная_способность>
        }
      }
      ```

     Где:

     * `name` — имя БД. Обязательный параметр.
     * `deletion_protection` — защита БД от удаления: `true` или `false`. Пока опция включена, удалить БД  невозможно. Включенная защита от удаления не защищает содержимое БД. Значение по умолчанию `false`.
     * `enable_throttling_rcu_limit` — включить ограничение пропускной способности: `true` или `false`. Необязательный параметр. Значение по умолчанию `false`.
     * `provisioned_rcu_limit` — ограничение потребления Request Units в секунду. Необязательный параметр. Значение по умолчанию `0`.
     * `storage_size_limit` — ограничение на объем данных, байт. Необязательный параметр. Значение по умолчанию `50` ГБ.
     * `throttling_rcu_limit` — устанавленное значение показывает, какое потребление Request Units в секунду оплачивается по часам по тарифу. Ноль выключает почасовую оплату. Необязательный параметр. Значение по умолчанию `0`.

  1. Примените изменения:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Terraform создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [Yandex Cloud CLI](../../cli/quickstart.md):

    ```bash
    yc ydb database get <имя_БД>
    ```

  **Пример**

  Создание Serverless БД с защитой от удаления, ограничением пропускной способности 10 RU/c и объемом данных 50 ГБ:

    > ```hcl
    > resource "yandex_ydb_database_serverless" "database1" {
    >   name                = "test-ydb-serverless"
    >   deletion_protection = "true"
    >
    >   serverless_database {
    >     enable_throttling_rcu_limit = false
    >     provisioned_rcu_limit       = 10
    >     storage_size_limit          = 50
    >     throttling_rcu_limit        = 0
    >   }
    > }
    > ```

- API {#api}

  Чтобы создать Serverless базу данных, воспользуйтесь методом REST API [create](../api-ref/Database/create.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Create](../api-ref/grpc/Database/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором должна быть размещена БД, в параметре `folderId`.
  * Имя БД в параметре `name`.
  * Пропускную способность БД в параметре `serverlessDatabase.throttlingRcuLimit`.
  * Объем БД в параметре (в байтах) `serverlessDatabase.storageSizeLimit`.

{% endlist %}

### Изменить параметры Serverless базы данных {#update-db-serverless}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно изменить настройки БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Изменить**.
  1. Настройте параметры БД:
      1. При необходимости измените имя БД.
      1. В блоке **Ограничения** задайте [пропускную способность](../pricing/serverless.md#prices-ru) и [объем данных](../pricing/serverless.md#rules-storage).
      1. В блоке **Тарификация** задайте [выделенную пропускную способность](../pricing/serverless.md#prices-ru).
  1. Нажмите кнопку **Изменить базу данных**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Посмотрите описание команды Yandex Cloud CLI для изменения БД:

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл Terraform и измените фрагмент с описанием Serverless базы данных:

      ```hcl
      resource "yandex_ydb_database_serverless" "database1" {
        name                = "<имя_БД>"
        deletion_protection = "<защита_от_удаления>"

        serverless_database {
          enable_throttling_rcu_limit = <ограничение_пропускной_способности>
          provisioned_rcu_limit       = <пропускная_способность>
          storage_size_limit          = <объем_данных>
          throttling_rcu_limit        = <выделенная_пропускная_способность>
        }
      }
      ```

     Где:

     * `name` — имя БД. Обязательный параметр.
     * `deletion_protection` — защита БД от удаления: `true` или `false`. Пока опция включена, удалить БД невозможно. Включенная защита от удаления не защищает содержимое БД. Значение по умолчанию `false`.
     * `enable_throttling_rcu_limit` — включить ограничение пропускной способности: `true` или `false`. Необязательный параметр. Значение по умолчанию `false`.
     * `provisioned_rcu_limit` — ограничение потребления Request Units в секунду. Необязательный параметр. Значение по умолчанию `0`.
     * `storage_size_limit` — объем данных, ГБ. Необязательный параметр. Значение по умолчанию `50`.
     * `throttling_rcu_limit` — устанавленное значение показывает, какое потребление Request Units в секунду оплачивается по часам по тарифу. Ноль выключает почасовую оплату. Необязательный параметр. Значение по умолчанию `0`.

  1. Примените изменения:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Terraform применит требуемые изменения к ресурсам. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [Yandex Cloud CLI](../../cli/quickstart.md):

    ```bash
    yc ydb database get <имя_БД>
    ```

  **Пример**

  Изменение выделенной пропускной способности и объема данных для БД `test-ydb-serverless`:

    > ```hcl
    > resource "yandex_ydb_database_serverless" "database1" {
    >   name                = "test-ydb-serverless"
    >   deletion_protection = "true"
    >
    >   serverless_database {
    >     enable_throttling_rcu_limit = false
    >     provisioned_rcu_limit       = 10
    >     storage_size_limit          = 80
    >     throttling_rcu_limit        = 100
    >   }
    > }
    > ```

- API {#api}

  Чтобы изменить параметры Serverless базы данных, воспользуйтесь методом REST API [update](../api-ref/Database/update.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Update](../api-ref/grpc/Database/update.md) и укажите в запросе идентификатор требуемой БД в параметре `databaseId`.

  Идентификатор БД можно получить со [списком БД](manage-databases.md#list-db).

   Передайте в запросе:

  * Идентификатор каталога, в котором должна быть размещена БД, в параметре `folderId`.
  * Имя БД в параметре `name`.
  * Пропускную способность БД в параметре `serverlessDatabase.throttlingRcuLimit`.
  * Объем БД в параметре (в байтах) `serverlessDatabase.storageSizeLimit`.
  * Идентификатор вычислительного ресурса в параметре `resourcePresetId`.
  * Идентификатор сети в параметре `networkId`.
  * Тип носителя в параметре `storageConfig.storageOptions.storageTypeId`.
  * Количество групп хранения в параметре `storageConfig.storageOptions.groupCount`.
  * Количество экземпляров БД в параметре `scalePolicy.fixedScale.size`.

{% endlist %}

## Создать и изменить параметры базы данных с выделенными серверами (Dedicated) {#dedicated}

### Создать Dedicated базу данных {#create-db-dedicated}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите **Имя** базы. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. В блоке **Тип базы данных** выберите опцию `Dedicated`.
  1. В блоке **Тип нагрузки** выберите одну из следующих опций:

      - `OLTP`;
      - `OLAP`.

  1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](../concepts/resources.md#resource-presets).

      {% note warning %}

      Для надежной и стабильной работы базе данных необходимо более одного слота. База в production-окружении должна запускаться минимум на трех слотах.

      {% endnote %}

  1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](../concepts/resources.md#storage-groups), определяющее суммарный объем хранилища.
  1. В блоке **Сеть** настройте параметры сети:
      1. (Опционально) В поле **Публичные IP-адреса** выберите опцию **Присвоить**, если вы планируете отправлять запросы к базе не только из сети Yandex Cloud, но и через интернет.

          {% note warning %}
          
          Потребление исходящего интернет-трафика для баз Managed Service for YDB с внешними IP-адресами учитывается по [действующим тарифам](../../vpc/pricing.md).
          
          Начисления за исходящий интернет-трафик, возникшие в результате использования Managed Service for YDB, будут компенсированы грантами.
          
          {% endnote %}

      1. Выберите существующую сеть из списка **Облачная сеть** или создайте новую:
          * Нажмите кнопку **Создать**.
          * В открывшемся окне укажите **Имя** новой сети.
          * (Опционально) Выберите опцию **Создать подсети**. Подсети в каждой зоне доступности будут созданы автоматически.
          * Нажмите кнопку **Создать сеть**.
      1. В блоке **Подсети** для каждой зоны доступности выберите подсеть или создайте новую:
          * Нажмите кнопку **Создать**.
          * В открывшемся окне укажите **Имя** новой подсети.
          * (Опционально) Введите **Описание** подсети.
          * Выберите из списка **Зона доступности** нужную зону.
          * Задайте адрес подсети в формате [**CIDR**](https://ru.wikipedia.org/wiki/Бесклассовая_адресация).
          * Нажмите кнопку **Создать подсеть**.
  1. Нажмите кнопку **Создать базу данных**.

    Дождитесь, когда статус БД изменится на `Running`.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды Yandex Cloud CLI для создания БД:

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
        * `--storage` — тип носителя и количество [групп хранения](../concepts/resources.md#storage-groups) в формате `type=<тип_носителя>,groups=<количество_групп_хранения>`. Для типа `ssd` одна группа хранения вмещает 100 ГБ данных.
        * `--resource-preset` — конфигурация вычислительных ресурсов узла. Возможные значения перечислены в колонке **Имя конфигурации** в таблице раздела [База данных на выделенных ресурсах (Dedicated)](../concepts/resources.md#resource-presets).

  Важные дополнительные параметры:

  * `--public-ip` — флаг назначения публичных IP-адресов. Без этого флага вы не сможете подключиться к создаваемой БД из интернета.
  * `--fixed-size INT` — количество узлов в кластере, по умолчанию `1`. Узлы выделяются в разных зонах доступности, таким образом конфигурация из трех узлов будет географически распределена в трех зонах доступности.
  * `--async` — флаг асинхронного создания. Создание Dedicated БД может занимать значительное время, измеряемое минутами. Вы можете указать данный флаг для того, чтобы управление было возвращено сразу как только команда на создание БД будет принята облаком.

  **Примеры**

  1. Создание минимальной одноузловой Dedicated БД YDB с именем dedb, доступной из интернета:

      > ```bash
      > yc ydb database create dedb \
      >   --dedicated \
      >   --network-name default \
      >   --storage type=ssd,groups=1 \
      >   --resource-preset medium \
      >   --public-ip
      > ```

  1. Асинхронное создание трехузловой георезервированной Dedicated БД YDB с хранилищем в 300 ГБ и вычислительным узлами по 64 ГБ RAM, с именем dedb3, доступной из интернета:

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле Terraform опишите параметры Dedicated БД, которую необходимо создать:

     ```hcl
      resource "yandex_ydb_database_dedicated" "database1" {
        name                = "<имя_БД>"

        network_id          = "<идентификатор_сети>"
        subnet_ids          = ["<идентификатор_подсети_1>", "<идентификатор_подсети_2>", "<идентификатор_подсети_3>"]

        resource_preset_id  = "<конфигурация_вычислительных_ресурсов>"
        deletion_protection = "<защита_от_удаления>"

        scale_policy {
          fixed_scale {
            size = <количество_экземпляров_БД>
          }
        }

        storage_config {
          group_count     = <количество_групп_хранения>
          storage_type_id = "<тип_носителя>"
        }
      }
     ```

     Где:

     * `name` — имя БД.
     * `network_id` — идентификатор сети, к которой подключается БД.
     * `subnet_ids` — список идентификаторов подсетей. Перечисляются через запятую.
     * `resource_preset_id` — конфигурация вычислительных ресурсов узла. Возможные значения перечислены в колонке **Имя конфигурации** в таблице раздела [База данных на выделенных ресурсах (Dedicated)](../concepts/resources.md#resource-presets).
     * `deletion_protection` — защита БД от удаления: `true` или `false`. Пока опция включена, БД удалить невозможно. Включенная защита не защищает содержимое БД. Значение по умолчанию — `false`.
     * `scale_policy` — политика масштабирования, где `size` — количество экземпляров БД.
     * `storage_config` — конфигурация хранилища, где:
        * `group_count` — количество [групп хранения](../concepts/resources.md#storage-groups).
        * `storage_type_id` — тип носителя. Для типа `ssd` одна группа хранения вмещает 100 ГБ данных.

  1. Создайте БД:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Terraform создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [Yandex Cloud CLI](../../cli/quickstart.md):

    ```bash
    yc ydb database list
    ```

  **Пример**

  Создание минимальной одноузловой Dedicated БД Managed Service for YDB с именем `test-bd`, доступной из интернета:

    > ```hcl
    > resource "yandex_ydb_database_dedicated" "database2" {
    >    name                = "test-ydb-dedicated"
    >    network_id          = yandex_vpc_network.my-net.id
    >    subnet_ids          = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-d.id]
    >    resource_preset_id  = "medium"
    >    deletion_protection = "true"
    >    scale_policy {
    >      fixed_scale {
    >        size = 1
    >      }
    >    }
    >   storage_config {
    >     group_count     = 1
    >     storage_type_id = "ssd"
    >   }
    > }
    > ```

- API {#api}

  Чтобы создать Dedicated базу данных, воспользуйтесь методом REST API [create](../api-ref/Database/create.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Create](../api-ref/grpc/Database/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором должна быть размещена БД, в параметре `folderId`.
  * Имя БД в параметре `name`.
  * Разрешение на присвоение публичных IP-адресов узлам БД в параметре `dedicatedDatabase.assignPublicIps`.
  * Идентификатор вычислительного ресурса в параметре `resourcePresetId`.
  * Идентификатор сети в параметре `networkId`.
  * Тип носителя в параметре `storageConfig.storageOptions.storageTypeId`.
  * Количество групп хранения в параметре `storageConfig.storageOptions.groupCount`.
  * Количество экземпляров БД в параметре `scalePolicy.fixedScale.size`.

{% endlist %}

### Изменить параметры Dedicated базы данных {#update-db-dedicated}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно изменить настройки БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Изменить**.
  1. Настройте параметры БД:
      1. При необходимости измените имя БД.
      1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](../concepts/resources.md#resource-presets).
      1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](../concepts/resources.md#storage-groups), определяющее суммарный объем хранилища.
  1. Нажмите кнопку **Изменить базу данных**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Посмотрите описание команды Yandex Cloud CLI для изменения БД:

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл Terraform и измените фрагмент с описанием БД:

      > ```hcl
      > resource "yandex_ydb_database_dedicated" "database2" {
      >   name                = "my-first-ydb-dedicated"
      >   network_id          = yandex_vpc_network.my-net.id
      >   subnet_ids          = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-d.id]
      >   resource_preset_id  = "medium"
      >   deletion_protection = "true"
      >   scale_policy {
      >     fixed_scale {
      >       size = 2
      >     }
      >   }
      >   storage_config {
      >     group_count     = 1
      >     storage_type_id = "ssd"
      >   }
      > }
      > ```

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [Yandex Cloud CLI](../../cli/quickstart.md):

  ```bash
  yc ydb database get <имя_БД>
  ```

- API {#api}

  Чтобы изменить параметры Dedicated базы данных, воспользуйтесь методом REST API [update](../api-ref/Database/update.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Update](../api-ref/grpc/Database/update.md) и укажите в запросе идентификатор требуемой БД в параметре `databaseId`.

  Идентификатор БД можно получить со [списком БД](manage-databases.md#list-db).

  Передайте в запросе набор параметров, который используется для [создания Dedicated БД](#create-db-dedicated), с измененными значениями.

{% endlist %}

Если вы хотите перенести БД в другую зону доступности, обратитесь к [инструкции](migration-to-an-availability-zone.md).

## Посмотреть список баз данных {#list-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, для которого нужно получить список БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc ydb database list
  ```

- API {#api}

  Чтобы получить список баз данных в каталоге, воспользуйтесь методом REST API [list](../api-ref/Database/list.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/List](../api-ref/grpc/Database/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Назначить роль на базу данных {#add-access-binding}

Вы можете предоставить пользователю, сервисному аккаунту или группе пользователей доступ к БД Managed Service for YDB. Для этого назначьте [роль](../../iam/concepts/access-control/roles.md) на БД. Чтобы выбрать нужную, [узнайте](../security/index.md#roles-list), какие роли действуют в сервисе.

{% list tabs group=instructions %}

* Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите на имя нужной БД.
  1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
  1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к БД.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые роли.
  1. Нажмите кнопку **Сохранить**.

* CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы назначить роль на БД:

  1. Посмотрите описание команды CLI для назначения роли:

     ```bash
     yc ydb database add-access-binding --help
     ```

  1. Получите список БД вместе с их идентификаторами:

     ```bash
     yc ydb database list
     ```

  1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роль.
  1. С помощью одной из команд ниже назначьте роль:

     * Пользователю:

        ```bash
        yc ydb database add-access-binding \
           --id <идентификатор_БД> \
           --role <роль> \
           --user-account-id <идентификатор_пользователя>
        ```

     * Федеративному пользователю:

        ```bash
        yc ydb database add-access-binding \
           --id <идентификатор_БД> \
           --role <роль> \
           --user-account-id <идентификатор_пользователя>
        ```

     * Сервисному аккаунту:

        ```bash
        yc ydb database add-access-binding \
           --id <идентификатор_БД> \
           --role <роль> \
           --service-account-id <идентификатор_сервисного_аккаунта>
        ```

     * Группе пользователей:

        ```bash
        yc ydb database add-access-binding \
           --id <идентификатор_БД> \
           --role <роль> \
           --subject group:<идентификатор_группы>
        ```

* API {#api}

  Воспользуйтесь вызовом gRPC API [DatabaseService/UpdateAccessBindings](../api-ref/grpc/Database/updateAccessBindings.md) и передайте в запросе:

  * Значение `ADD` в параметре `access_binding_deltas[].action`, чтобы добавить роль.
  * Роль в параметре `access_binding_deltas[].access_binding.role_id`.
  * Идентификатор субъекта, на кого назначается роль, в параметре `access_binding_deltas[].access_binding.subject.id`.
  * Тип субъекта, на кого назначается роль, в параметре `access_binding_deltas[].access_binding.subject.type`.

{% endlist %}

## Назначить несколько ролей на базу данных {#set-access-bindings}

{% list tabs group=instructions %}

* Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите на имя нужной БД.
  1. Перейдите в раздел ![image](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
  1. Выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к БД.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые роли.
  1. Нажмите кнопку **Сохранить**.

* CLI {#cli}

  {% note alert %}
  
  Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы назначить несколько ролей на базу данных:

  1. Убедитесь, что на БД не назначены роли, которые вы не хотите потерять:

     ```bash
     yc ydb database list-access-bindings \
        --id <идентификатор_БД>
     ```

  1. Посмотрите описание команды CLI для назначения ролей:

     ```bash
     yc ydb database set-access-bindings --help
     ```

  1. Получите список БД вместе с их идентификаторами:

     ```bash
     yc ydb database list
     ```

  1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.
  1. С помощью одной из команд ниже назначьте роли:

     * Пользователю с аккаунтом на Яндексе или локальному пользователю:

        ```bash
        yc ydb database set-access-bindings \
           --id <идентификатор_БД> \
           --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
        ```

     * Федеративному пользователю:

        ```bash
        yc ydb database set-access-bindings \
           --id <идентификатор_БД> \
           --access-binding role=<роль>,subject=federatedUser:<идентификатор_пользователя>
        ```

     * Сервисному аккаунту:

        ```bash
        yc ydb database set-access-bindings \
           --id <идентификатор_БД> \
           --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
        ```

     * Группе пользователей:

        ```bash
        yc ydb database set-access-bindings \
           --id <идентификатор_БД> \
           --access-binding role=<роль>,subject=group:<идентификатор_группы>
        ```

     Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

     ```bash
     yc ydb database set-access-bindings \
        --id <идентификатор_БД> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
     ```

* API {#api}

  {% note alert %}
  
  Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Воспользуйтесь вызовом gRPC API [DatabaseService/SetAccessBindings](../api-ref/grpc/Database/setAccessBindings.md). Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

  * Роль в параметре `access_bindings[].role_id`.
  * Идентификатор субъекта, на кого назначаются роли, в параметре `access_bindings[].subject.id`.
  * Тип субъекта, на кого назначаются роли, в параметре `access_bindings[].subject.type`.

{% endlist %}

## Удалить базу данных {#delete-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно удалить БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.
  1. Подтвердите удаление.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

    ```bash
    yc ydb database delete <имя_БД>
    ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием БД.

     Пример описания БД в конфигурации Terraform:

     ```hcl
     resource "yandex_ydb_database_dedicated" "database2" {
       name               = "test-ydb-dedicated"

       network_id         = yandex_vpc_network.my-net.id
       subnet_ids         = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-d.id]

       resource_preset_id = "medium"
       scale_policy {
         fixed_scale {
           size = 1
         }
       }

       storage_config {
         group_count     = 1
         storage_type_id = "ssd"
       }
     }
     ```

  1. Примените изменения:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    Terraform удалит все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [Yandex Cloud CLI](../../cli/quickstart.md):

    ```bash
    yc ydb database list
    ```

- API {#api}

  Чтобы удалить базу данных, воспользуйтесь методом REST API [delete](../api-ref/Database/delete.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Delete](../api-ref/grpc/Database/delete.md) и укажите в запросе идентификатор удаляемой БД в параметре `databaseId`.

  Идентификатор БД можно получить со [списком БД](manage-databases.md#list-db).

{% endlist %}