# Создание кластера {{ CH }}

Кластер {{ CH }} — это один или несколько хостов базы данных, между которыми можно настроить репликацию.

{% note info %}

* Количество хостов, которые можно создать вместе с кластером {{ CH }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

Выбранный [механизм обеспечения работы репликации](../concepts/replication.md) также влияет на количество хостов в кластере из нескольких хостов:

* Кластер, использующий для управления репликацией и отказоустойчивостью {{ CK }}, должен состоять из трех или более хостов — отдельные хосты для запуска {{ CK }} не требуются. Создать такой кластер можно только с помощью CLI и [API](../../glossary/rest-api.md).

    
    Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Доступ к {{ CK }} предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.


* При использовании {{ ZK }} кластер может состоять из двух и более хостов. Еще 3 хоста {{ ZK }} будут добавлены в кластер автоматически.

    Минимальное количество ядер для одного хоста {{ ZK }} зависит от суммарного количества ядер хостов {{ CH }}. Подробнее см. в разделе [Репликация](../concepts/replication.md#zk).

    {% note alert %}

    
    Эти хосты учитываются в расчете использованной [квоты ресурсов]({{ link-console-quotas }}) в облаке и в [расчете стоимости](../pricing.md#prices-zookeeper) кластера.


    {% endnote %}

## Как создать кластер {{ CH }} {#create-cluster}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
    1. Выберите сервис **{{ mch-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      * `PRODUCTION` — для стабильных версий ваших приложений.
      * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mch-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите версию {{ CH }}, которую будет использовать кластер {{ mch-name }}, из выпадающего списка **Версия**:
     * Для большинства кластеров рекомендуется выбрать самую новую LTS-версию.
     * Для кластеров, в которых планируется использовать гибридное хранилище, рекомендуется выбрать версию не ниже {{ mch-ck-version }}.

  
  1. Если вы планируете использовать данные из бакета {{ objstorage-name }} с [ограниченным доступом](../../storage/concepts/bucket#bucket-access), то выберите сервисный аккаунт из выпадающего списка или создайте новый. Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к {{ objstorage-name }}](s3-access.md).


  1. В блоке **Ресурсы**:

      * Выберите платформу, тип виртуальной машины и класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных экземпляров.

      
      * Выберите [тип диска](../concepts/storage.md).

                
        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}



      * Выберите размер диска, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).

  1. В блоке **Хосты**:

      * Если вы хотите создать дополнительные хосты базы данных, нажмите **Добавить хост**. После добавления второго хоста появится кнопка **Настроить {{ ZK }}**. Измените настройки {{ ZK }} в блоках **Ресурсы {{ ZK }}** и **Хосты {{ ZK }}** при необходимости.
      * Укажите параметры хостов базы, создаваемых вместе с кластером. Чтобы изменить добавленный хост, наведите курсор на строку хоста и нажмите на значок ![image](../../_assets/pencil.svg).

  1. В блоке **Настройки СУБД**:

      * Если вы хотите управлять пользователями кластера через SQL, в поле **Управление пользователями через SQL** выберите из выпадающего списка **Включено** и укажите пароль пользователя `admin`. Управление пользователями через другие интерфейсы при этом станет недоступно.

        В противном случае выберите **Выключено**.

      * Если вы хотите управлять базами данных через SQL, в поле **Управление базами данных через SQL** выберите из выпадающего списка **Включено**. Управление базами данных через другие интерфейсы при этом станет недоступно. Поле неактивно, если управление пользователями через SQL выключено.

        В противном случае выберите **Выключено**.

        {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      * Имя пользователя и пароль.

        {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

      * Имя БД. Имя базы может содержать латинские буквы, цифры и нижнее подчеркивание. Максимальная длина имени 63 символа. Запрещено создание базы данных с именем `default`.

      * При необходимости включите для кластера [гибридное хранилище](../concepts/storage.md#hybrid-storage-features).

        {% note alert %}

        Эту опцию невозможно выключить.

        {% endnote %}

      * При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

  
  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

      {% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}
  

  1. В блоке **Хосты** укажите параметры хостов БД, создаваемых вместе с кластером. Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/pencil.svg) в строке с его номером:

      * **Зона доступности** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
      * **Подсеть** — укажите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.
      * **Публичный доступ** — разрешите [доступ](connect.md) к хосту из интернета.

      Чтобы добавить хосты в кластер, нажмите кнопку **Добавить хост**.

  1. При необходимости задайте сервисные настройки кластера:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  
  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.


  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-ch }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

     
     ```bash
     {{ yc-mdb-ch }} cluster create \
       --name <имя кластера> \
       --environment <окружение: prestable или production> \
       --network-name <имя сети> \
       --host type=<clickhouse или zookeeper>,`
            `zone-id=<зона доступности>,`
            `subnet-id=<идентификатор подсети>,`
            `assign-public-ip=<публичный доступ к хосту: true или false> \
       --clickhouse-resource-preset <класс хоста> \
       --clickhouse-disk-type <тип диска> \
       --clickhouse-disk-size <размер хранилища в гигабайтах> \
       --user name=<имя пользователя>,password=<пароль пользователя> \
       --database name=<имя базы данных> \
       --security-group-ids <список идентификаторов групп безопасности> \
       --yandexquery-access=<доступ через {{ yq-full-name }}: true или false> \
       --deletion-protection=<защита от удаления кластера: true или false>
     ```

     Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.


     {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

     Пользователями и базами данных в кластере можно управлять через SQL.

     {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

     1. Чтобы включить [режим управления пользователями через SQL](./cluster-users.md#sql-user-management):

         * задайте значение `true` для параметра `--enable-sql-user-management`;
         * задайте пароль для пользователя `admin` в параметре `--admin-password`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --admin-password "<пароль пользователя admin>"
         ```

     1. Чтобы включить [режим управления базами данных через SQL](./databases.md#sql-database-management):

         * задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`;
         * задайте пароль для пользователя `admin` в параметре `--admin-password`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<пароль пользователя admin>"
         ```

     
     1. Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте параметр `--serverless-access`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


     1. {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-create.md) %}

     1. Чтобы включить [{{ CK }}](../concepts/replication.md#ck) в кластере:

        * Задайте версию {{ CH }} (не ниже {{ mch-ck-version }}) в параметре `--version`.
        * Задайте значение `true` для параметра `--embedded-keeper`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --version "<версия {{ CH }}: не ниже {{ mch-ck-version }}>" \
           --embedded-keeper true
         ```

         {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

         Чтобы получить список доступных версий {{ CH }}, выполните команду:

         ```bash
         {{ yc-mdb-ch }} version list
         ```

     1. Чтобы задать [настройки гибридного хранилища](../concepts/storage.md#hybrid-storage-settings):

         * Включите гибридное хранилище, задав значение `true` для параметра `--cloud-storage`.

            {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

         * Передайте настройки гибридного хранилища в соответствующих параметрах:

            {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

         ```bash
         {{ yc-mdb-ch }} cluster create \
            ...
            --cloud-storage=true \
            --cloud-storage-data-cache=<true или false> \
            --cloud-storage-data-cache-max-size=<объем памяти (в байтах)> \
            --cloud-storage-move-factor=<доля свободного места>
           ...
         ```

- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Чтобы создать кластер:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

        1. Если у вас еще нет {{ TF }}, [установите его и создайте конфигурационный файл с настройками провайдера](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    1. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).
        * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
        * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью:

       ```hcl
       resource "yandex_vpc_network" "<имя сети в {{ TF }}>" { name = "<имя сети>" }

       resource "yandex_vpc_subnet" "<имя подсети в {{ TF }}>" {
         name           = "<имя подсети>"
         zone           = "<зона доступности>"
         network_id     = yandex_vpc_network.<имя сети в {{ TF }}>.id
         v4_cidr_blocks = ["<подсеть>"]
       }
       ```

    1. Создайте конфигурационный файл с описанием кластера и его хостов.

        * Кластер базы данных — описание кластера и его хостов. Здесь же при необходимости:
            * Задайте [настройки СУБД](../concepts/settings-list.md).
            * Включите защиту от удаления.

                {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

       Пример структуры конфигурационного файла, в котором описывается кластер из одного хоста:

       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
         name                = "<имя кластера>"
         environment         = "<окружение>"
         network_id          = yandex_vpc_network.<имя сети в {{ TF }}>.id
         security_group_ids  = ["<список идентификаторов групп безопасности>"]
         deletion_protection = <защита от удаления кластера: true или false>

         clickhouse {
           resources {
             resource_preset_id = "<класс хоста>"
             disk_type_id       = "<тип диска>"
             disk_size          = <размер хранилища, ГБ>
           }
         }

         database {
           name = "<имя базы данных>"
         }

         user {
           name     = "<имя пользователя БД>"
           password = "<пароль>"
           permission {
             database_name = "<имя БД, в которой создается пользователь>"
           }
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<зона доступности>"
           subnet_id        = yandex_vpc_subnet.<имя подсети в {{ TF }}>.id
           assign_public_ip = <публичный доступ к хосту: true или false>
         }
       }
       ```


       {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

       1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

       
       1. Чтобы разрешить доступ из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md), добавьте блок `access` с нужными вам настройками:

          ```hcl
          resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
            ...
            access {
              data_lens  = <доступ из DataLens: true или false>
              metrika    = <доступ из Метрики и AppMetrika: true или false>
              serverless = <доступ из Cloud Functions: true или false>
              web_sql    = <выполнение SQL-запросов из консоли управления: true или false>
            }
            ...
          }
          ```



       Пользователями и базами данных в кластере можно управлять через SQL.

       {% include notitle [SQL Management can't be switched off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

       * {% include notitle [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

       * {% include notitle [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mch }}).

    1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

  Чтобы создать кластер, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:
  * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  * Окружение кластера в параметре `environment`.
  * Конфигурацию кластера в параметре `configSpec`.
  * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
  * Идентификатор сети в параметре `networkId`.

  
  * Идентификаторы групп безопасности в параметре `securityGroupIds`.


  Чтобы разрешить [подключение](connect.md) к хостам кластера из интернета, передайте значение `true` в параметре `hostSpecs.assignPublicIp`.

  При необходимости включите управление пользователями и базами данных через SQL:
  * `configSpec.sqlUserManagement` — задайте значение `true` для включения режима [управления пользователями через SQL](cluster-users.md#sql-user-management).
  * `configSpec.sqlDatabaseManagement` — задайте значение `true` для включения режима [управления базами данных через SQL](databases.md#sql-database-management). Необходимо, чтобы был включен режим управления пользователями через SQL.
  * `configSpec.adminPassword` — задайте пароль пользователя `admin`, с помощью которого осуществляется управление.

  {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

    Чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md), передайте значение `true` для параметра `configSpec.access.serverless`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).

  {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

  Чтобы разрешить доступ к кластеру из сервиса {{ yq-full-name }}, передайте значение `true` для параметра `configSpec.access.yandexQuery`.

  Чтобы задать [настройки гибридного хранилища](../concepts/storage.md##hybrid-storage-settings):

    * Включите гибридное хранилище, передав значение `true` в параметре `configSpec.cloudStorage.enabled`.
    * Передайте настройки гибридного хранилища в параметрах `configSpec.cloudStorage`:

        {% include [Hybrid Storage settings API](../../_includes/mdb/mch/hybrid-storage-settings-api.md) %}

  При создании кластера из нескольких хостов:

  * Если для параметра `embeddedKeeper` указано значение `true`, для управления репликацией будет использоваться [{{ CK }}](../concepts/replication.md#ck).

      {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

      Для использования {{ CK }} необходима версия {{ CH }} не ниже {{ mch-ck-version }}. Список доступных версий {{ CH }} можно получить с помощью метода REST API [list](../api-ref/Versions/list.md) для ресурса [Versions](../api-ref/Versions/index.md) или вызова gRPC API [VersionsService/List](../api-ref/grpc/versions_service.md#List).

  * Если значение параметра `embeddedKeeper` не задано или равно `false`, для управления репликацией и распределением запросов будет использоваться {{ ZK }}.

    
    Если в [облачной сети](../../vpc/concepts/network.md) кластера есть подсети в каждой из [зон доступности](../../overview/concepts/geo-scope.md), а настройки хостов {{ ZK }} не заданы, в каждую подсеть будет автоматически добавлено по одному такому хосту.

    Если подсети в сети кластера есть только в некоторых зонах доступности, укажите настройки хостов {{ ZK }} явно.


{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

{% endnote %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mch-name }} с тестовыми характеристиками:

  
  * Имя `mych`.
  * Окружение `production`.
  * Сеть `default`.
  * Группа безопасности `{{ security-group }}`.
  * Один хост {{ CH }} класса `{{ host-class }}` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `{{ region-id }}-a`.
  * {{ CK }}.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 20 ГБ.
  * Один пользователь `user1` с паролем `user1user1`.
  * Одна база данных `db1`.
  * Защита от случайного удаления кластера.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-ch }} cluster create \
    --name mych \
    --environment=production \
    --network-name default \
    --clickhouse-resource-preset {{ host-class }} \
    --host type=clickhouse,zone-id={{ region-id }}-a,subnet-id=b0cl69g98qumiqmtg12a \
    --version {{ versions.keeper }} \
    --embedded-keeper true \
    --clickhouse-disk-size 20 \
    --clickhouse-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --security-group-ids {{ security-group }} \
    --deletion-protection=true
  ```


- {{ TF }}

  Создайте кластер {{ mch-name }} и сеть для него с тестовыми характеристиками:

  * Имя `mych`.
  * Окружение `PRESTABLE`.
  * Облако с идентификатором `{{ tf-cloud-id }}`.
  * Каталог с идентификатором `{{ tf-folder-id }}`.
  * Новая облачная сеть `cluster-net`.
    * Новая [группа безопасности по умолчанию](connect.md#configuring-security-groups) `cluster-sg` (в сети `cluster-net`), разрешающая подключение к любому хосту кластера из любой сети (в том числе из интернета) по портам `8443`, `9440`.
  * Один хост класса `{{ host-class }}` в новой подсети `cluster-subnet-{{ region-id }}-a`.

    Параметры подсети:
    * диапазон адресов — `172.16.1.0/24`;
    * сеть — `cluster-net`;
    * зона доступности — `{{ region-id }}-a`.

  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 32 ГБ.
  * Имя базы данных `db1`.
  * Пользователь `user1` с паролем `user1user1`.

  Конфигурационные файлы для такого кластера выглядят так:

  1. Конфигурационный файл с описанием настроек провайдера:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

  1. Конфигурационный файл с описанием облачной сети и подсети:

      {% include [terraform-mdb-single-network](../../_includes/mdb/terraform-single-network.md) %}

  
  1. Конфигурационный файл с описанием группы безопасности:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}


  1. Конфигурационный файл с описанием кластера и его хоста:

      {% include [terraform-mch-single-host-single-shard](../../_includes/mdb/mch/terraform/single-host-single-shard.md) %}

{% endlist %}

### Создание кластера из нескольких хостов {#creating-a-multi-host-cluster}

{% list tabs %}

- {{ TF }}

  Создайте кластер {{ mch-name }} с тестовыми характеристиками:

  * Имя `mych`.
  * Окружение `PRESTABLE`.
  * Облако с идентификатором `{{ tf-cloud-id }}`.
  * Каталог с идентификатором `{{ tf-folder-id }}`.
  * Новая облачная сеть `cluster-net`.

  * Три хоста {{ CH }} класса `{{ host-class }}` и три хоста {{ ZK }} класса `{{ zk-host-class }}` (для обеспечения работы [репликации](../concepts/replication.md)).

    По одному хосту каждого класса будет размещено в новых подсетях:
    * `cluster-subnet-{{ region-id }}-a`: `172.16.1.0/24`, зона доступности `{{ region-id }}-a`.
    * `cluster-subnet-{{ region-id }}-b`: `172.16.2.0/24`, зона доступности `{{ region-id }}-b`.
    * `cluster-subnet-{{ region-id }}-c`: `172.16.3.0/24`, зона доступности `{{ region-id }}-c`.

    Эти подсети будут принадлежать сети `cluster-net`.

    * Новая [группа безопасности по умолчанию](connect.md#configuring-security-groups) `cluster-sg` (в сети `cluster-net`), разрешающая подключение к любому хосту кластера из любой сети (в том числе из интернета) по портам `8443`, `9440`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 32 ГБ для каждого {{ CH }}-хоста кластера.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 10 ГБ для каждого {{ ZK }}-хоста кластера.
  * Имя базы данных `db1`.
  * Пользователь `user1` с паролем `user1user1`.

  Конфигурационные файлы для такого кластера выглядят так:

  1. Конфигурационный файл с описанием настроек провайдера:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

  1. Конфигурационный файл с описанием облачной сети и подсетей:

      {% include [terraform-mdb-multiple-networks](../../_includes/mdb/terraform-multiple-networks.md) %}

  
  1. Конфигурационный файл с описанием группы безопасности:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}


  1. Конфигурационный файл с описанием кластера и его хостов:

      {% include [terraform-mch-multiple-hosts-single-shard](../../_includes/mdb/mch/terraform/multiple-hosts-single-shard.md) %}

{% endlist %}
