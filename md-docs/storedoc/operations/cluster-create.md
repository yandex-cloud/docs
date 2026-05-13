# Создание кластера Yandex StoreDoc


[Кластер](../../glossary/cluster.md) Yandex StoreDoc — это один или несколько хостов базы данных, между которыми можно настроить [репликацию](../concepts/replication.md). Репликация работает по умолчанию в любом кластере из более чем 1 хоста (первичный хост принимает запросы на запись и асинхронно дублирует изменения на вторичных хостах).


{% note info %}

* Количество хостов, которые можно создать вместе с кластером Yandex StoreDoc, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}


Подключениями к БД кластера управляет сервис Connection Manager. Вместе с кластером автоматически создаются:

* [Подключение Connection Manager](../../metadata-hub/concepts/connection-manager.md) с информацией о соединении с БД.

* [Секрет Yandex Lockbox](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя — владельца БД. Хранение паролей в сервисе Yandex Lockbox обеспечивает их безопасность.

Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **Подключения**.

Для просмотра информации о подключении требуется роль `connection-manager.viewer`. Вы можете [настраивать доступ к подключениям в Connection Manager](../../metadata-hub/operations/connection-access.md).

Использование сервиса Connection Manager и секретов, созданных с его помощью, не тарифицируется.





## Создать кластер {#create-cluster}


Для создания кластера Yandex StoreDoc нужна роль [vpc.user](../../vpc/security/index.md#vpc-user) и роль [managed-mongodb.editor или выше](../security/index.md#roles-list). О том, как назначить роль, см. в [документации Identity and Access Management](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер Yandex StoreDoc:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер БД.

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.

  1. Нажмите кнопку **Создать кластер**.

  1. В блоке **Базовые параметры**:

      * Введите название в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках облака.
      * (Опционально) Введите **Описание** кластера.
      * Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      * Укажите версию СУБД.
      * Выберите тип шардирования:
          * **Выключено** — кластер будет состоять только из хостов `MONGOD`.
          * **Стандартное** — кластер будет состоять из хостов `MONGOD` и `MONGOINFRA`.
          * **Расширенное** — кластер будет состоять из хостов `MONGOD`, `MONGOS` и `MONGOCFG`.

  
  1. В блоке **Сетевые настройки** выберите:

      * [Облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера.
      * Группы безопасности для сетевого трафика кластера. Для подключения к кластеру может потребоваться [настройка групп безопасности](connect/index.md#configuring-security-groups).


  1. Задайте конфигурацию вычислительных ресурсов:

      * для нешардированного кластера — в блоке **Ресурсы**;
      * для кластера со стандартным шардированием — в блоках **Ресурсы Mongod** и **Ресурсы Mongoinfra**;
      * для кластера с расширенным шардированием — в блоках **Ресурсы Mongod**, **Ресурсы Mongos** и **Ресурсы Mongocfg**.

     Чтобы задать конфигурацию вычислительных ресурсов:

     1. Выберите платформу, тип виртуальной машины и класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных экземпляров.

        {% note info %}

        Тип конфигурации **memory-optimized** недоступен для хостов `MONGOS`.

        {% endnote %}

     
     1. В блоке **Хранилище**:

         * Выберите [тип диска](../concepts/storage.md).

             От выбранного типа зависит, с каким шагом можно будет изменить размер диска:
             
             * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
             * Локальные SSD-диски:
                 * для платформ **Intel Broadwell** и **Intel Cascade Lake** — с шагом 100 ГБ;
                 * для платформ **Intel Ice Lake** и **AMD Zen 4** — с шагом 368 ГБ.
             * Нереплицируемые SSD-диски и cверхбыстрые сетевые SSD-диски с тремя репликами — с шагом 93 ГБ.

         * Выберите размер хранилища, который будет использоваться для данных и резервных копий. Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

         * (Опционально) Выберите опцию **Зашифрованный диск**, чтобы зашифровать диск [пользовательским ключом KMS](../../kms/concepts/key.md).

             * Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **Создать**.

             * Чтобы использовать созданный ранее ключ, выберите его в поле **Ключ KMS**.

             Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).


     1. В блоке **Хосты** добавьте хосты БД, создаваемые вместе с кластером:

         
         * Нажмите кнопку **Добавить хост**.
         * Выберите [зону доступности](../../overview/concepts/geo-scope.md).
         * Выберите [подсеть](../../vpc/concepts/network.md#subnet) в указанной зоне доступности. Если подсети нет, создайте ее.
         * Если хост должен быть доступен снаружи Yandex Cloud, включите опцию **Публичный доступ**.

         
         Чтобы обеспечить отказоустойчивость, для типов диска `local-ssd` и `network-ssd-nonreplicated` необходимо как минимум 3 хоста. Подробнее см. в разделе [Хранилище](../concepts/storage.md).

         
         По умолчанию хосты создаются в разных зонах доступности. См. подробнее об [управлении хостами](hosts.md).


  1. В блоке **База данных** укажите атрибуты БД:

      * Имя БД.

        Имя базы может содержать латинские буквы, цифры, нижнее подчеркивание и дефис. Максимальная длина имени — 63 символа. Имена `config`, `local`, `admin` и `mdb_internal` зарезервированы для собственных нужд Yandex StoreDoc. Создавать БД с этими именами нельзя.

      * Имя пользователя.
      * Пароль пользователя. Минимум 8 символов. 

  1. При необходимости задайте дополнительные настройки кластера:

      - **Начало резервного копирования (UTC)** — промежуток времени, в течение которого начинается резервное копирование кластера. Время указывается по UTC в 24-часовом формате. По умолчанию — `22:00 - 23:00` UTC.
      
      - **Срок хранения автоматических резервных копий, дней**{#setting-backup-saving}
        
        Время, в течение которого нужно хранить созданные автоматически резервные копии. Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — 7 дней. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Подробнее см. в разделе [Резервные копии](../concepts/backup.md).
      
      
        Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, если изначальный срок хранения был 7 дней и оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день, то при увеличении срока хранения до 9 дней, оставшееся время жизни этой резервной копии будет уже 3 дня.
      
        Для существующего кластера автоматически созданные копии хранятся заданное количество дней, а созданные вручную — бессрочно. После удаления кластера все копии хранятся 7 дней.
      
      - **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):
      
          * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **произвольное** (по умолчанию).
          * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **по расписанию** и укажите нужные день недели и час дня по UTC. Например, можно выбрать время, когда кластер наименее загружен.
          
          Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.
      
      
      
      - **Доступ из WebSQL** — опция разрешает [выполнять SQL-запросы](websql.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL.
      
      
      - **Сбор статистики** — включите эту опцию, чтобы пользоваться встроенным инструментом для [диагностики производительности](performance-diagnostics.md) в кластере. Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).
      
      - **Защита от удаления** — защита кластера от непреднамеренного удаления.
      
        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

      {% note info %}
      
      Некоторые настройки Yandex StoreDoc [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).
      
      {% endnote %}

  1. Нажмите кнопку **Создать кластер**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать кластер Yandex StoreDoc:

  
  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе VPC.


  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      yc managed-mongodb cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

      {% cut "Для нешардированного кластера" %}

      
      ```bash
      yc managed-mongodb cluster create \
        --name <имя_кластера> \
        --environment=<окружение> \
        --network-name <имя_сети> \\
        --security-group-ids <идентификаторы_групп_безопасности> \ 
        --host zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<разрешить_публичный_доступ_к_хосту>,`
              `hidden=<скрыть_хост>,`
              `secondary-delay-secs=<отставание_реплики_в_секундах>,`
              `priority=<приоритет_хоста> \
        --mongod-resource-preset <класс_хоста> \
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_БД> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <размер_хранилища_ГБ> \
        --disk-encryption-key-id <идентификатор_ключа_KMS> \
        --performance-diagnostics=<включить_диагностику> \
        --deletion-protection
      ```


      {% endcut %}

      {% cut "Для кластера со стандартным шардированием" %}

      
      ```bash
      yc managed-mongodb cluster create \
        --name <имя_кластера> \
        --environment=<окружение> \
        --mongodb-version <версия_Yandex_StoreDoc> \          
        --network-name <имя_сети> \
        --security-group-ids <идентификаторы_групп_безопасности> \      
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_БД> \
        --mongod-resource-preset <класс_хоста> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <размер_хранилища_ГБ> \
        --host type=mongod,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `hidden=<скрыть_хост>,`
              `secondary-delay-secs=<отставание_реплики_в_секундах>,`
              `priority=<приоритет_хоста> \
        --mongoinfra-resource-preset <класс_хоста> \
        --mongoinfra-disk-type <network-hdd|network-ssd> \
        --mongoinfra-disk-size <размер_хранилища_ГБ> \
        --host type=mongoinfra,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<разрешить_публичный_доступ_к_хосту> \
        --disk-encryption-key-id <идентификатор_ключа_KMS> \
        --performance-diagnostics=<включить_диагностику> \
        --deletion-protection
      ```


      {% endcut %}

      {% cut "Для кластера с расширенным шардированием" %}

      
      ```bash
      yc managed-mongodb cluster create \
        --name <имя_кластера> \
        --environment=<окружение> \
        --mongodb-version <версия_Yandex_StoreDoc> \          
        --network-name <имя_сети> \
        --security-group-ids <идентификаторы_групп_безопасности> \      
        --user name=<имя_пользователя>,password=<пароль_пользователя> \
        --database name=<имя_БД> \
        --mongod-resource-preset <класс_хоста> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <размер_хранилища_ГБ> \
        --host type=mongod,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `hidden=<скрыть_хост>,`
              `secondary-delay-secs=<отставание_реплики_в_секундах>,`
              `priority=<приоритет_хоста> \
        --mongos-resource-preset <класс_хоста> \
        --mongos-disk-type <network-hdd|network-ssd> \
        --mongos-disk-size <размер_хранилища_ГБ> \
        --host type=mongos,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<разрешить_публичный_доступ_к_хосту> \
        --mongocfg-resource-preset <класс_хоста> \
        --mongocfg-disk-type <network-hdd|network-ssd> \
        --mongocfg-disk-size <размер_хранилища_ГБ> \
        --host type=mongocfg,`
              `zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети> \
        --disk-encryption-key-id <идентификатор_ключа_KMS> \
        --performance-diagnostics=<включить_диагностику> \
        --deletion-protection
      ```


      {% endcut %}

      Где:

      * `--environment` — окружение: `prestable` или `production`.

      
      * `--security-group-ids` — список идентификаторов групп безопасности.
      * `--database name` — имя базы данных.
        
        {% note info %}

        Имя базы может содержать латинские буквы, цифры, нижнее подчеркивание и дефис. Максимальная длина имени — 63 символа. Имена `config`, `local`, `admin` и `mdb_internal` зарезервированы для собственных нужд Yandex StoreDoc. Создавать БД с этими именами нельзя.

        {% endnote %}

      * `--host` — параметры хоста:
        * `type` — тип хоста: `mongod`, `mongoinfra`, `mongos` или `mongocfg`. По умолчанию хост имеет тип `mongod`.
        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Указывается, если в выбранной зоне доступности создано больше одной подсети.
        * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. В шардированном кластере используется только для хостов `MONGOS` и `MONGOINFRA`.
        * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузку на кластер).
        * `secondary-delay-secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
        * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).
          
          {% note info %}

          Параметры `hidden`, `secondary-delay-secs` и `priority` используются только для хостов `MONGOD`.

          {% endnote %}

      * `--mongod-resource-preset` — класс хостов `MONGOD`.
      * `--mongoinfra-resource-preset`, `--mongos-resource-preset`, `--mongocfg-resource-preset` — классы хостов `MONGOINFRA`, `MONGOS`, `MONGOCFG` соответственно (только для шардированных кластеров).
      * `--mongod-disk-type` — тип диска хостов `MONGOD`.
      * `--mongoinfra-disk-type`, `--mongos-disk-type`, `--mongocfg-disk-type` — типы дисков хостов `MONGOINFRA`, `MONGOS`, `MONGOCFG` соответственно (только для шардированных кластеров).
      * `--disk-encryption-key-id` — шифрование диска [пользовательским ключом KMS](../../kms/concepts/key.md).

         Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).


      * `--performance-diagnostics` — включить диагностику производительности кластера: `true` или `false`.
      
      * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

      {% note info %}

      По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

      {% endnote %}


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать кластер Yandex StoreDoc:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * Кластер базы данных — описание кластера и его хостов.

     * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

     * Подсети — описание [подсетей](../../vpc/concepts/network.md#subnet), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

     Пример структуры конфигурационного файла:

     {% cut "Для нешардированного кластера" %}

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       name                = "<имя_кластера>"
       environment         = "<окружение>"
       network_id          = yandex_vpc_network.<имя_сети>.id
       security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
       deletion_protection = <защитить_кластер_от_удаления>

       cluster_config {
         version = "<версия_Yandex_StoreDoc>"
       }

       resources_mongod {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         type             = "mongod"
         zone_id          = "<зона_доступности>"
         subnet_id        = yandex_vpc_subnet.<имя_подсети>.id
         assign_public_ip = <разрешить_публичный_доступ_к_хосту>
         host_parameters {
           hidden               = <скрыть_хост>
           secondary_delay_secs = <отставание_реплики_в_секундах>
           priority             = <приоритет_хоста>
         }
       }

       resources_mongoinfra {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         type             = "mongoinfra"
         zone_id          = "<зона_доступности>"
         subnet_id        = yandex_vpc_subnet.<имя_подсети>.id
         assign_public_ip = <разрешить_публичный_доступ_к_хосту>
       }
     }

     resource "yandex_mdb_mongodb_database" "<имя_БД>" {
       cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
       name       = "<имя_БД>"
     }

     resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
       cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
       name       = "<имя_пользователя>"
       password   = "<пароль>"
       permission {
         database_name = "<имя_БД>"
         roles         = [ "<список_ролей_пользователя>" ]
       }
       depends_on = [
         yandex_mdb_mongodb_database.<имя_БД>
       ]
     }

     resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

     resource "yandex_vpc_subnet" "<имя_подсети>" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```

     {% endcut %}

     {% cut "Для кластера со стандартным шардированием" %}

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       name                = "<имя_кластера>"
       environment         = "<окружение>"
       network_id          = yandex_vpc_network.<имя_сети>.id
       security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
       deletion_protection = <защитить_кластер_от_удаления>

       cluster_config {
         version = "<версия_Yandex_StoreDoc>"
       }

       resources_mongod {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         type             = "mongod"
         zone_id          = "<зона_доступности>"
         subnet_id        = yandex_vpc_subnet.<имя_подсети>.id
         host_parameters {
           hidden               = <скрыть_хост>
           secondary_delay_secs = <отставание_реплики_в_секундах>
           priority             = <приоритет_хоста>
         }
       }

       resources_mongoinfra {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         type             = "mongoinfra"
         zone_id          = "<зона_доступности>"
         subnet_id        = yandex_vpc_subnet.<имя_подсети>.id
         assign_public_ip = <разрешить_публичный_доступ_к_хосту>
       }
     }

     resource "yandex_mdb_mongodb_database" "<имя_БД>" {
       cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
       name       = "<имя_БД>"
     }

     resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
       cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
       name       = "<имя_пользователя>"
       password   = "<пароль>"
       permission {
         database_name = "<имя_БД>"
         roles         = [ "<список_ролей_пользователя>" ]
       }
       depends_on = [
         yandex_mdb_mongodb_database.<имя_БД>
       ]
     }

     resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

     resource "yandex_vpc_subnet" "<имя_подсети>" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```

     {% endcut %}

     {% cut "Для кластера с расширенным шардированием" %}

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       name                = "<имя_кластера>"
       environment         = "<окружение>"
       network_id          = yandex_vpc_network.<имя_сети>.id
       security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
       deletion_protection = <защитить_кластер_от_удаления>

       cluster_config {
         version = "<версия_Yandex_StoreDoc>"
       }

       resources_mongod {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         type             = "mongod"
         zone_id          = "<зона_доступности>"
         subnet_id        = yandex_vpc_subnet.<имя_подсети>.id
         host_parameters {
           hidden               = <скрыть_хост>
           secondary_delay_secs = <отставание_реплики_в_секундах>
           priority             = <приоритет_хоста>
         }
       }

       resources_mongos {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         type             = "mongos"
         zone_id          = "<зона_доступности>"
         subnet_id        = yandex_vpc_subnet.<имя_подсети>.id
         assign_public_ip = <разрешить_публичный_доступ_к_хосту>
       }

       resources_mongocfg {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         type             = "mongocfg"
         zone_id          = "<зона_доступности>"
         subnet_id        = yandex_vpc_subnet.<имя_подсети>.id
       }
     }

     resource "yandex_mdb_mongodb_database" "<имя_БД>" {
       cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
       name       = "<имя_БД>"
     }

     resource "yandex_mdb_mongodb_user" "<имя_пользователя>" {
       cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
       name       = "<имя_пользователя>"
       password   = "<пароль>"
       permission {
         database_name = "<имя_БД>"
         roles         = [ "<список_ролей_пользователя>" ]
       }
       depends_on = [
         yandex_mdb_mongodb_database.<имя_БД>
       ]
     }

     resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

     resource "yandex_vpc_subnet" "<имя_подсети>" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```

     {% endcut %}

     Где:

     * `environment` — окружение: `PRESTABLE` или `PRODUCTION`.
     * `host` — параметры хоста:
       * `zone_id` — зона доступности.
       * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
       * `assign_public_ip` — публичный доступ к хосту: `true` или `false`. В шардированном кластере используется только для хостов `MONGOS` и `MONGOINFRA`.
       * `host_parameters` — дополнительные параметры хоста:
         * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузку на кластер).
         * `secondary_delay_secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
         * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

        {% note info %}

        Параметры `hidden`, `secondary_delay_secs` и `priority` используются только для хостов `MONGOD`.

        {% endnote %}
     
     * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

     * `version` — версия Yandex StoreDoc: 6.0, 7.0 или 8.0.

     Имя базы может содержать латинские буквы, цифры, нижнее подчеркивание и дефис. Максимальная длина имени — 63 символа. Имена `config`, `local`, `admin` и `mdb_internal` зарезервированы для собственных нужд Yandex StoreDoc. Создавать БД с этими именами нельзя.

     Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
     
     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       ...
       maintenance_window {
         type = "<тип_технического_обслуживания>"
         day  = "<день_недели>"
         hour = <час_дня>
       }
       ...
     }
     ```
     
     Где:
     
     * `type` — тип технического обслуживания. Принимает значения:
         * `ANYTIME` — в любое время.
         * `WEEKLY` — по расписанию.
     * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
     * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.

     Чтобы зашифровать диск [пользовательским ключом KMS](../../kms/concepts/key.md), добавьте параметр `disk_encryption_key_id`:

       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
         ...
         disk_encryption_key_id = <идентификатор_ключа_KMS>
         ...
       }
       ```

       Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](../../terraform/resources/mdb_mongodb_cluster.md).

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте кластер.

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

      После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся [FQDN хостов](../concepts/network.md#hostname). Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
      
      * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
      * изменение — 60 минут.
      
      Операции, длящиеся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию кластера блок `timeouts`, например:
      
      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
        ...
        timeouts {
          create = "1h30m" # Полтора часа
          update = "2h"    # 2 часа
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        {% cut "Для нешардированного кластера" %}

        
        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "securityGroupIds": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletionProtection": <защитить_кластер_от_удаления>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "configSpec": {
            "version": "<версия_Yandex_StoreDoc>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resourcePresetId": "<класс_хоста>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              }
            },
            "backupWindowStart":  {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },  
            "backupRetainPeriodDays": "<время_хранения_резервных_копий_в_днях>",
            "performanceDiagnostics": {
              "profilingEnabled": <включить_профилировщик>
            }
          },
          "databaseSpecs": [
            {
              "name": "<имя_БД>"
            },
            { <аналогичный_набор_настроек_для_БД_2> },
            { ... },
            { <аналогичный_набор_настроек_для_БД_N> }
          ],
          "userSpecs": [
            {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                {
                  "databaseName": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
              ]
            },
            { <аналогичный_набор_настроек_для_пользователя_2> },
            { ... },
            { <аналогичный_набор_настроек_для_пользователя_N> }
          ],
          "hostSpecs": [
            {
              "zoneId": "<зона_доступности>",
              "subnetId": "<идентификатор_подсети>",
              "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
              "type": "MONGOD",
              "hidden": <скрыть_хост>,
              "secondaryDelaySecs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_2> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "Для кластера со стандартным шардированием" %}

        
        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "securityGroupIds": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletionProtection": <защитить_кластер_от_удаления>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "configSpec": {
            "version": "<версия_Yandex_StoreDoc>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resourcePresetId": "<класс_хоста>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              },
              "mongoinfra": {
                "resources": {
                  "resourcePresetId": "<класс_хоста>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              }
            },
            "backupWindowStart":  {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },  
            "backupRetainPeriodDays": "<время_хранения_резервных_копий_в_днях>",
            "performanceDiagnostics": {
              "profilingEnabled": <включить_профилировщик>
            }
          },
          "databaseSpecs": [
            {
              "name": "<имя_БД>"
            },
            { <аналогичный_набор_настроек_для_БД_2> },
            { ... },
            { <аналогичный_набор_настроек_для_БД_N> }
          ],
          "userSpecs": [
            {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                {
                  "databaseName": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
              ]
            },
            { <аналогичный_набор_настроек_для_пользователя_2> },
            { ... },
            { <аналогичный_набор_настроек_для_пользователя_N> }
          ],
          "hostSpecs": [
            {
              "zoneId": "<зона_доступности>",
              "subnetId": "<идентификатор_подсети>",
              "type": "MONGOD",
              "shardName": "<имя_шарда>",
              "hidden": <скрыть_хост>,
              "secondaryDelaySecs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            {
              "zoneId": "<зона_доступности>",
              "subnetId": "<идентификатор_подсети>",
              "type": "MONGOINFRA",
              "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_3> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "Для кластера с расширенным шардированием" %}

        
        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "securityGroupIds": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletionProtection": <защитить_кластер_от_удаления>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "configSpec": {
            "version": "<версия_Yandex_StoreDoc>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resourcePresetId": "<класс_хоста>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              },
              "mongos": {
                "resources": {
                  "resourcePresetId": "<класс_хоста>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              },
              "mongocfg": {
                "resources": {
                  "resourcePresetId": "<класс_хоста>",
                  "diskSize": "<размер_хранилища_в_байтах>",
                  "diskTypeId": "<тип_диска>"
                }
              }
            },
            "backupWindowStart":  {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },  
            "backupRetainPeriodDays": "<время_хранения_резервных_копий_в_днях>",
            "performanceDiagnostics": {
              "profilingEnabled": <включить_профилировщик>
            }
          },
          "databaseSpecs": [
            {
              "name": "<имя_БД>"
            },
            { <аналогичный_набор_настроек_для_БД_2> },
            { ... },
            { <аналогичный_набор_настроек_для_БД_N> }
          ],
          "userSpecs": [
            {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                {
                  "databaseName": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
              ]
            },
            { <аналогичный_набор_настроек_для_пользователя_2> },
            { ... },
            { <аналогичный_набор_настроек_для_пользователя_N> }
          ],
          "hostSpecs": [
            {
              "zoneId": "<зона_доступности>",
              "subnetId": "<идентификатор_подсети>",
              "type": "MONGOD",
              "shardName": "<имя_шарда>",
              "hidden": <скрыть_хост>,
              "secondaryDelaySecs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            {
              "zoneId": "<зона_доступности>",
              "subnetId": "<идентификатор_подсети>",
              "type": "MONGOS",
              "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
              "tags": "<метки_хоста>"
            },
            {
              "zoneId": "<зона_доступности>",
              "subnetId": "<идентификатор_подсети>",
              "type": "MONGOCFG",
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_4> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ]
        }
        ```


        {% endcut %}

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        
        * `securityGroupIds` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


        * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`.

          Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

          * `anytime` — техническое обслуживание происходит в любое время.
          * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

            * `day` — день недели в формате `DDD`.
            * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

        * `configSpec` — настройки кластера:

            * `version` — версия Yandex StoreDoc: 5.0, 6.0 или 7.0.
            * `mongod`, `mongoinfra`, `mongos`, `mongocfg` — типы хостов.

              * `resources` — ресурсы кластера:

                * `resourcePresetId` — [класс хостов](../concepts/instance-types.md).
                * `diskSize` — размер диска в байтах.
                * `diskTypeId` — [тип диска](../concepts/storage.md).

            * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов.
              * `minutes` — от `0` до `59` минут.
              * `seconds` — от `0` до `59` секунд.
              * `nanos` — от `0` до `999999999` наносекунд.

            * `backupRetainPeriodDays` — время хранения резервных копий в днях.

            * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):
              * `profilingEnabled` — включение [профилировщика](tools.md#explore-profiler): `true` или `false`.

        * `databaseSpecs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и содержит параметр `name` — имя БД.

            Имя базы может содержать латинские буквы, цифры, нижнее подчеркивание и дефис. Максимальная длина имени — 63 символа. Имена `config`, `local`, `admin` и `mdb_internal` зарезервированы для собственных нужд Yandex StoreDoc. Создавать БД с этими именами нельзя.

        * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

          * `name` — имя пользователя.
          * `password` — пароль пользователя.
          * `permissions` — настройки разрешений пользователя:

            * `databaseName` — имя базы данных, к которой пользователь получает доступ.
            * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).

            Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

        * `hostSpecs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          
          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. В шардированном кластере используется только для хостов `MONGOS` и `MONGOINFRA`.
          * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`.
          * `tags`— метки хоста.
          * `shardName` — имя шарда в шардированном кластере (только для хостов `MONGOD`).
          * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузку на кластер).
          * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
          * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

          {% note info %}

          Параметры `shardName`, `hidden`, `secondaryDelaySecs` и `priority` используются только для хостов `MONGOD`.

          {% endnote %}


  1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters' \
          --data "@body.json"
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        {% cut "Для нешардированного кластера" %}

        
        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "security_group_ids": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletion_protection": <защитить_кластер_от_удаления>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "config_spec": {
            "version": "<версия_Yandex_StoreDoc>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resource_preset_id": "<класс_хоста>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              }
            },
            "backup_window_start": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "backup_retain_period_days": "<время_хранения_резервных_копий_в_днях>",
            "performance_diagnostics": {
              "profiling_enabled": <включить_профилировщик>
            }
          },
          "database_specs": [
            {
              "name": "<имя_БД>"
            },
            { <аналогичный_набор_настроек_для_БД_2> },
            { ... },
            { <аналогичный_набор_настроек_для_БД_N> }
          ],
          "user_specs": [
            {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                {
                  "database_name": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
              ]
            },
            { <аналогичный_набор_настроек_для_пользователя_2> },
            { ... },
            { <аналогичный_набор_настроек_для_пользователя_N> }
          ],
          "host_specs": [
            {
              "zone_id": "<зона_доступности>",
              "subnet_id": "<идентификатор_подсети>",
              "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
              "type": "MONGOD",
              "hidden": <скрыть_хост>,
              "secondary_delay_secs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_2> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "Для кластера со стандартным шардированием" %}

        
        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "security_group_ids": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletion_protection": <защитить_кластер_от_удаления>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "config_spec": {
            "version": "<версия_Yandex_StoreDoc>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resource_preset_id": "<класс_хоста>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              },
              "mongoinfra": {
                "resources": {
                  "resource_preset_id": "<класс_хоста>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              }
            },
            "backup_window_start": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "backup_retain_period_days": "<время_хранения_резервных_копий_в_днях>",
            "performance_diagnostics": {
              "profiling_enabled": <включить_профилировщик>
            }
          },
          "database_specs": [
            {
              "name": "<имя_БД>"
            },
            { <аналогичный_набор_настроек_для_БД_2> },
            { ... },
            { <аналогичный_набор_настроек_для_БД_N> }
          ],
          "user_specs": [
            {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                {
                  "database_name": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
              ]
            },
            { <аналогичный_набор_настроек_для_пользователя_2> },
            { ... },
            { <аналогичный_набор_настроек_для_пользователя_N> }
          ],
          "host_specs": [
            {
              "zone_id": "<зона_доступности>",
              "subnet_id": "<идентификатор_подсети>",
              "type": "MONGOD",
              "shard_name": "<имя_шарда>",
              "hidden": <скрыть_хост>,
              "secondary_delay_secs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            {
              "zone_id": "<зона_доступности>",
              "subnet_id": "<идентификатор_подсети>",
              "type": "MONGOINFRA",
              "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_3> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "Для кластера с расширенным шардированием" %}

        
        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "security_group_ids": [
            "<идентификатор_группы_безопасности_1>",
            "<идентификатор_группы_безопасности_2>",
            ...
            "<идентификатор_группы_безопасности_N>"
          ],
          "deletion_protection": <защитить_кластер_от_удаления>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "config_spec": {
            "version": "<версия_Yandex_StoreDoc>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resource_preset_id": "<класс_хоста>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              },
              "mongos": {
                "resources": {
                  "resource_preset_id": "<класс_хоста>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              },
              "mongocfg": {
                "resources": {
                  "resource_preset_id": "<класс_хоста>",
                  "disk_size": "<размер_хранилища_в_байтах>",
                  "disk_type_id": "<тип_диска>"
                }
              }
            },
            "backup_window_start": {
              "hours": "<часы>",
              "minutes": "<минуты>",
              "seconds": "<секунды>",
              "nanos": "<наносекунды>"
            },
            "backup_retain_period_days": "<время_хранения_резервных_копий_в_днях>",
            "performance_diagnostics": {
              "profiling_enabled": <включить_профилировщик>
            }
          },
          "database_specs": [
            {
              "name": "<имя_БД>"
            },
            { <аналогичный_набор_настроек_для_БД_2> },
            { ... },
            { <аналогичный_набор_настроек_для_БД_N> }
          ],
          "user_specs": [
            {
              "name": "<имя_пользователя>",
              "password": "<пароль_пользователя>",
              "permissions": [
                {
                  "database_name": "<имя_БД>",
                  "roles": [
                    "<роль_1>", "<роль_2>", ..., "<роль_N>"
                  ]
                }
              ]
            },
            { <аналогичный_набор_настроек_для_пользователя_2> },
            { ... },
            { <аналогичный_набор_настроек_для_пользователя_N> }
          ],
          "host_specs": [
            {
              "zone_id": "<зона_доступности>",
              "subnet_id": "<идентификатор_подсети>",
              "type": "MONGOD",
              "shard_name": "<имя_шарда>",
              "hidden": <скрыть_хост>,
              "secondary_delay_secs": "<отставание_реплики_в_секундах>",
              "priority": "<приоритет_хоста>",
              "tags": "<метки_хоста>"
            },
            {
              "zone_id": "<зона_доступности>",
              "subnet_id": "<идентификатор_подсети>",
              "type": "MONGOS",
              "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
              "tags": "<метки_хоста>"
            },
            {
              "zone_id": "<зона_доступности>",
              "subnet_id": "<идентификатор_подсети>",
              "type": "MONGOCFG",
              "tags": "<метки_хоста>"
            },
            { <аналогичный_набор_настроек_для_хоста_4> },
            { ... },
            { <аналогичный_набор_настроек_для_хоста_N> }
          ]
        }
        ```


        {% endcut %}

        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.

        
        * `security_group_ids` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).


        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

          Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

          * `anytime` — техническое обслуживание происходит в любое время.
          * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

            * `day` — день недели в формате `DDD`.
            * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

        * `config_spec` — настройки кластера:

          * `version` — версия Yandex StoreDoc: 5.0, 6.0 или 7.0.
            * `mongod`, `mongoinfra`, `mongos`, `mongocfg` — типы хостов.

              * `resources` — ресурсы кластера:

                * `resource_preset_id` — [класс хостов](../concepts/instance-types.md).
                * `disk_size` — размер диска в байтах.
                * `disk_type_id` — [тип диска](../concepts/storage.md).

            * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов.
              * `minutes` — от `0` до `59` минут.
              * `seconds` — от `0` до `59` секунд.
              * `nanos` — от `0` до `999999999` наносекунд.

            * `backup_retain_period_days` — время хранения резервных копий в днях.

            * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):
              * `profiling_enabled` — включение [профилировщика](tools.md#explore-profiler): `true` или `false`.

        * `database_specs` — настройки баз данных в виде массива элементов. Каждый элемент соответствует отдельной БД и содержит параметр `name` — имя БД.

            Имя базы может содержать латинские буквы, цифры, нижнее подчеркивание и дефис. Максимальная длина имени — 63 символа. Имена `config`, `local`, `admin` и `mdb_internal` зарезервированы для собственных нужд Yandex StoreDoc. Создавать БД с этими именами нельзя.

        * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

          * `name` — имя пользователя.
          * `password` — пароль пользователя.
          * `permissions` — настройки разрешений пользователя:

            * `database_name` — имя базы данных, к которой пользователь получает доступ.
            * `roles` — массив ролей пользователя. Каждая роль представлена в виде отдельной строки в массиве. Список доступных значений см. в разделе [Пользователи и роли](../concepts/users-and-roles.md).

            Для каждой базы данных добавьте отдельный элемент с настройками разрешений в массив `permissions`.

        * `host_specs` — настройки хостов кластера в виде массива элементов. Каждый элемент соответствует отдельному хосту и имеет следующую структуру:

          
          * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. В шардированном кластере используется только для хостов `MONGOS` и `MONGOINFRA`.
          * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`.
          * `tags`— метки хоста.
          * `shard_name` — имя шарда в шардированном кластере.
          * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузку на кластер).
          * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
          * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

          {% note info %}

          Параметры `shard_name`, `hidden`, `secondaryDelaySecs` и `priority` используются только для хостов `MONGOD`.

          {% endnote %}


  1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Create \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).

{% endnote %}



## Создать копию кластера {#duplicate}

Вы можете создать кластер Yandex StoreDoc, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера Yandex StoreDoc импортируется в Terraform. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер Yandex StoreDoc обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера Yandex StoreDoc:

{% list tabs group=instructions %}

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера Yandex StoreDoc в переменную окружения:

        ```bash
        export STOREDOC_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера Yandex StoreDoc в конфигурацию Terraform:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${STOREDOC_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id`, `sharded` и `status`.
        * В блоках `host` удалите параметры `health` и `name`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * Если есть блоки `user`, удалите их. Пользователи БД добавляются с помощью отдельного ресурса `yandex_mdb_mongodb_user`.
        * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия.

    1. В директории `imported-cluster` [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. В этой же директории [настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Проверьте корректность файлов конфигурации Terraform:

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

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
    * изменение — 60 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
      ...
      timeouts {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}

{% endlist %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер Yandex StoreDoc с тестовыми характеристиками:

  
  * С именем `mymg`.
  * В окружении `production`.
  * В сети `default`.
  * В группе безопасности с идентификатором `enp6saqnq4ie********`.
  * С одним хостом класса `s2.micro` в подсети `b0rcctk2rvtr********`, в зоне доступности `ru-central1-a`.
  * С хранилищем на сетевых SSD-дисках (`network-ssd`) размером 20 ГБ.
  * С одним пользователем, `user1`, с паролем `user1user1`.
  * С одной базой данных, `db1`.
  * С защитой от непреднамеренного удаления.


  Выполните следующую команду:

  
  ```bash
  yc managed-mongodb cluster create \
    --name mymg \
    --environment production \
    --network-name default \
    --security-group-ids enp6saqnq4ie******** \
    --mongod-resource-preset s2.micro \
    --host zone-id=ru-central1-a,subnet-id=b0rcctk2rvtr******** \
    --mongod-disk-size 20 \
    --mongod-disk-type network-ssd \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --deletion-protection
  ```



- Terraform {#tf}

  Создайте кластер Yandex StoreDoc и сеть для него с тестовыми характеристиками:

  * Название — `mymg`.
  * Версия — `8.0`.
  * Окружение — `PRODUCTION`.
  * Идентификатор облака — `b1gq90dgh25********`.
  * Идентификатор каталога — `b1gia87mbaom********`.
  * Сеть — `mynet`.
  * Класс хоста — `s2.micro`.
  * Количество блоков `host` — один.
  * Подсеть — `mysubnet`. Сетевые настройки: 

    * Зона доступности — `ru-central1-a`.
    * Диапазон — `10.5.0.0/24`.

  * Группа безопасности — `mymg-sg`. Правила группы разрешают TCP-подключения к кластеру из интернета через порт `27018`.
  * Хранилище на сетевых SSD-дисках — `network-ssd`.
  * Размер хранилища — 20 ГБ.
  * Пользователь — `user1`.
  * Пароль — `user1user1`.
  * База данных — `db1`.
  * Защита от непреднамеренного удаления — включена.

  Конфигурационный файл для кластера с одним хостом:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "8.0"
    }

    resources_mongod {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 20
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Yandex StoreDoc"
      port           = 27018
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```


{% endlist %}

### Создание шардированного кластера {#creating-a-sharded-cluster}

Кластер Yandex StoreDoc можно создать со [стандартным](#std-sharding) или [расширенным](#adv-sharding) шардированием. Подробнее о видах шардирования см. в разделе [Особенности управления шардированием](../concepts/sharding.md#shard-management).

##### **Стандартное шардирование** {#std-sharding}

Создайте кластер Yandex StoreDoc и сеть для него с несколькими хостами:

* один хост `MONGOD`;
* три хоста `MONGOINFRA`.

Тестовые характеристики кластера:

* Название — `mymg`.
* Окружение — `PRODUCTION`.
* Защита от непреднамеренного удаления — включена.
* Версия — `8.0`.
* База данных — `db1`.
* Пользователь — `user1`.
* Пароль — `user1user1`.
* Класс хоста `MONGOD` — `s2.micro`.
* Класс хостов `MONGOINFRA` — `c3-c2-m4`.
* Хранилище на сетевых SSD-дисках — `network-ssd`.
* Размер хранилища — 10 ГБ.

Сетевые характеристики:


* Зона доступности — `ru-central1-a`.
* Сеть — `mynet`.
* Группа безопасности — `mymg-sg` с идентификатором `enp6saqnq4ie********`. В Terraform группа создается с правилом, которое разрешает TCP-подключения к кластеру из интернета через порт `27018`.
* Подсеть — `mysubnet`. 
* Диапазон — `10.5.0.0/24` (только для Terraform).


{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы создать кластер Yandex StoreDoc со стандартным шардированием:


  ```bash
  yc managed-mongodb cluster create \
     --name mymg \
     --environment production \
     --deletion-protection \
     --mongodb-version 8.0 \
     --database name=db1 \
     --user name=user1,password=user1user1 \
     --mongod-resource-preset s2.micro \
     --mongod-disk-type network-ssd \
     --mongod-disk-size 10 \
     --host type=mongod,`
       `zone-id=ru-central1-a,`
       `subnet-name=mysubnet \
     --mongoinfra-resource-preset c3-c2-m4 \
     --mongoinfra-disk-type network-ssd \
     --mongoinfra-disk-size 10 \
     --host type=mongoinfra,`
       `zone-id=ru-central1-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id=ru-central1-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id=ru-central1-a,`
       `subnet-name=mysubnet \
     --network-name mynet \
     --security-group-ids enp6saqnq4ie********
  ```



- Terraform {#tf}

  Конфигурационный файл для кластера со стандартным шардированием:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "8.0"
    }

    resources_mongod {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }

    resources_mongoinfra {
      resource_preset_id = "c3-c2-m4"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Yandex StoreDoc"
      port           = 27018
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```


{% endlist %}

##### **Расширенное шардирование** {#adv-sharding}

Создайте кластер Yandex StoreDoc и сеть для него с несколькими хостами:

* один хост `MONGOD`;
* два хоста `MONGOS`;
* три хоста `MONGOCFG`.

Тестовые характеристики кластера:

* Название — `mymg`.
* Окружение — `PRODUCTION`.
* Защита от непреднамеренного удаления — включена.
* Версия — `8.0`.
* База данных — `db1`.
* Пользователь — `user1`.
* Пароль — `user1user1`.
* Класс хостов — `s2.micro`.
* Хранилище на сетевых SSD-дисках — `network-ssd`.
* Размер хранилища — 10 ГБ.

Сетевые характеристики:


* Зона доступности — `ru-central1-a`.
* Сеть — `mynet`.
* Группа безопасности — `mymg-sg` с идентификатором `enp6saqnq4ie********`. В Terraform группа создается с правилом, которое разрешает TCP-подключения к кластеру из интернета через порт `27018`.
* Подсеть — `mysubnet`. 
* Диапазон — `10.5.0.0/24` (только для Terraform).


{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы создать кластер Yandex StoreDoc с расширенным шардированием:


  ```bash
  yc managed-mongodb cluster create \
    --name mymg \
    --environment production \
    --deletion-protection \
    --mongodb-version 8.0 \
    --database name=db1 \
    --user name=user1,password=user1user1 \
    --mongod-resource-preset s2.micro \
    --mongod-disk-type network-ssd \
    --mongod-disk-size 10 \
    --host type=mongod,`
      `zone-id=ru-central1-a,`
      `subnet-name=mysubnet \
    --mongos-resource-preset s2.micro \
    --mongos-disk-type network-ssd \
    --mongos-disk-size 10 \
    --host type=mongos,`
      `zone-id=ru-central1-a,`
      `subnet-name=mysubnet \
    --host type=mongos,`
      `zone-id=ru-central1-a,`
      `subnet-name=mysubnet \
    --mongocfg-resource-preset s2.micro \
    --mongocfg-disk-type network-ssd \
    --mongocfg-disk-size 10 \
    --host type=mongocfg,`
      `zone-id=ru-central1-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id=ru-central1-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id=ru-central1-a,`
      `subnet-name=mysubnet \
    --network-name mynet \
    --security-group-ids enp6saqnq4ie********
  ```



- Terraform {#tf}

  Конфигурационный файл для кластера с расширенным шардированием:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "8.0"
    }

    resources_mongod {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }

    resources_mongos {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }

    resources_mongocfg {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Yandex StoreDoc"
      port           = 27018
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```


{% endlist %}