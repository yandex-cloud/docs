# Создание {{ CH }}-кластера

{{ CH }}-кластер — это один или несколько хостов базы данных, между которыми можно настроить репликацию.

{% note warning %}

{% if audience != "internal" %}

При создании кластера {{ CH }} из 2 и более хостов {{ mch-short-name }} автоматически создает кластер из 3 хостов ZooKeeper для управления репликацией и отказоустойчивостью. Эти хосты учитываются в расчете использованной [квоты ресурсов]({{ link-console-quotas }}) в облаке и в расчете стоимости кластера. Подробнее — в разделе о репликации для [{{ CH }}](../concepts/replication.md#clickhouse).

{% else %}

При создании кластера {{ CH }} из 2 и более хостов {{ mch-short-name }} автоматически создает кластер из 3 хостов ZooKeeper для управления репликацией и отказоустойчивостью. Эти хосты учитываются в расчете использованной [квоты ресурсов]({{ link-console-quotas }}) в облаке. Подробнее — в разделе о репликации для [{{ CH }}](../concepts/replication.md#clickhouse).

{% endif %}

{% endnote %}

{% if audience != "internal" %}

Количество хостов, которые можно создать вместе с {{ CH }}-кластером, зависит от выбранного [типа хранилища](../concepts/storage.md):

* При использовании **локального хранилища** вы можете создать кластер из двух или более хостов (минимум два хоста необходимо, чтобы обеспечить отказоустойчивость).
* При использовании сетевого хранилища:
    * Если выбрано **стандартное** или **быстрое сетевое хранилище**, вы можете добавить любое количество хостов в пределах [текущей квоты](../concepts/limits.md).
    * Если выбрано **нереплицируемое сетевое хранилище**, вы можете создать кластер из трех или более хостов (минимум три хоста необходимо, чтобы обеспечить отказоустойчивость).
* При использовании **гибридного хранилища** вы можете создать кластер только из одного хоста. После создания такого кластера в него можно [добавлять шарды](shards.md#add-shard), состоящие только из одного хоста. Такой кластер не будет устойчив к отказам хостов, однако в случае сбоя данные шарда или кластера будут сохранены. Гибридное хранилище находится на стадии [Preview](https://cloud.yandex.ru/docs/overview/concepts/launch-stages).

После создания кластера в него можно добавить дополнительные хосты, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

{% endif %}

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
  {% if audience != "internal" %}
  1. Выберите сервис **{{ mch-name }}**.
  {% endif %}
  1. Нажмите кнопку **Создать кластер**.
  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.
  1. Выберите версию {{ CH }}, которую будет использовать кластер {{ mch-name }}, из выпадающего списка **Версия**:
     1. Для большинства кластеров рекомендуется выбрать самую новую LTS-версию.
     1. Для кластеров, в которых планируется использовать гибридное хранилище, рекомендуется выбрать самую новую версию. Этот тип хранилища поддерживается, начиная с версии {{ CH }} {{ mch-hs-version }}. 
  1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
      - `PRODUCTION` — для стабильных версий ваших приложений.
      - `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mch-short-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
  1. Выберите класс хостов — он определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных экземпляров.
  1. В блоке **Размер хранилища**:

      {% if audience != "internal" %}

      - Выберите [тип хранилища](../concepts/storage.md) — более гибкое сетевое (`network-hdd`, `network-ssd` или `network-ssd-nonreplicated`) или более быстрое локальное хранилище (`local-ssd`).

        При выборе типа хранилища обратите внимание, что:
        - Размер локального хранилища можно менять только с шагом 100 ГБ.
        - Размер нереплицируемого сетевого хранилища можно менять только с шагом 93 ГБ.
        - Чтобы использовать использовать гибридное хранилище на стадии [Preview](../../overview/concepts/launch-stages.md), выберите `network-ssd` или `network-hdd`.

      {% endif %}

      - Выберите объем, который будет использоваться для данных и резервных копий. Подробнее о том, как занимают пространство резервные копии, см. раздел [{#T}](../concepts/backup.md).

  1. В блоке **База данных** укажите атрибуты БД:

      - Имя БД.
      - Имя пользователя.
      - Пароль пользователя. Минимум 8 символов.

  1. Для [управления пользователями через SQL](cluster-users.md#sql-user-management) включите настройку **Управление пользователями через SQL** и укажите пароль пользователя `admin`.

  1. Для [управления базами данных через SQL](databases.md#sql-database-management), включите настройки **Управление пользователями через SQL** и **Управление базами данных через SQL**, укажите пароль пользователя `admin`.

    {% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.

  1. В блоке **Хосты** укажите параметры хостов БД, создаваемых вместе с кластером. Чтобы изменить добавленный хост, наведите курсор на строку хоста и нажмите значок ![image](../../_assets/pencil.svg).
  
     При настройке параметров хостов обратите внимание, что:
     - Если в блоке **Хранилище** выбран `local-ssd`, необходимо добавить не менее двух хостов в кластер.
     - Если в блоке **Хранилище** выбран `network-ssd-nonreplicated`, необходимо добавить не менее трех хостов в кластер.
     - Если вы планируете использовать гибридное хранилище на стадии [Preview](../../overview/concepts/launch-stages.md), в кластере должен быть только один хост.

  1. При необходимости задайте дополнительные настройки кластера:
     
     {% include [mch-extra-settings](../../_includes/mdb/mch-extra-settings-web-console-new-cluster-wizard.md) %}
     
  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md#dbms-cluster-settings).

  1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  {% if audience != "internal" %}

  1. Проверьте, есть ли в каталоге подсети для хостов кластера:

     ```
     $ yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.

  {% endif %}

  1. Посмотрите описание команды CLI для создания кластера:

      ```
      $ {{ yc-mdb-ch }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены только обязательные флаги):

     {% if audience != "internal" %}

     ```bash
     {{ yc-mdb-ch }} cluster create \
        --name <имя кластера> \
        --environment <окружение: prestable или production> \
        --network-name <имя сети> \
        --host type=<clickhouse или zookeeper>,zone-id=<зона доступности>,subnet-id=<идентификатор подсети> \
        --clickhouse-resource-preset <класс хоста> \
        --clickhouse-disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
        --clickhouse-disk-size <размер хранилища в гигабайтах> \
        --user name=<имя пользователя>,password=<пароль пользователя> \
        --database name=<имя базы данных> \
        --security-group-ids <список идентификаторов групп безопасности>
     ```

     Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

     {% else %}

      ```
      $ {{ yc-mdb-ch }} cluster create \
         --name <имя кластера> \
         --environment <окружение, prestable или production> \
         --network-id ' ' \
         --host type=<clickhouse или zookeeper>,zone-id=<зона доступности> \
         --clickhouse-resource-preset <класс хоста> \
         --clickhouse-disk-type local-ssd \
         --clickhouse-disk-size <размер хранилища в гигабайтах> \
         --user name=<имя пользователя>,password=<пароль пользователя> \
         --database name=<имя базы данных> \
         --security-group-ids <список идентификаторов групп безопасности>
      ```

    {% endif %}

      1. Чтобы включить [режим управления пользователями через SQL](cluster-users.md#sql-user-management):

          {% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

          * Задайте значение `true` для параметра `--enable-sql-user-management`.
          * Задайте пароль для пользователя `admin` в параметре `--admin-password`.

          ```bash
          {{ yc-mdb-ch }} cluster create \
             ...
             --enable-sql-user-management=true \
             --admin-password <пароль пользователя admin>
          ```

      1. Чтобы включить [режим управления базами данных через SQL](databases.md#sql-database-management):

          * Задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`.
          * Задайте пароль для пользователя `admin` в параметре `--admin-password`.

          ```bash
          {{ yc-mdb-ch }} cluster create \
             ...
             --enable-sql-user-management=true \
             --enable-sql-database-management=true \
             --admin-password <пароль пользователя admin>
          ```

- Terraform

  {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать кластер:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * Кластер базы данных — описание кластера и его хостов. При необходимости здесь же можно задать [настройки СУБД](../concepts/settings-list.md).
       * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
       * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       Пример структуры конфигурационного файла:

       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
         name               = "<имя кластера>"
         environment        = "<окружение>"
         network_id         = "<идентификатор сети>"
         security_group_ids = ["<список групп безопасности>"]

         clickhouse {
           resources {
             resource_preset_id = "<класс хоста>"
             disk_type_id       = "<тип хранилища>"
             disk_size          = <объем хранилища, ГБ>
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
           type      = "CLICKHOUSE"
           zone      = "<зона доступности>"
           subnet_id = "<идентификатор подсети>"
         }
       }

       resource "yandex_vpc_network" "<имя сети>" { name = "<имя сети>" }

       resource "yandex_vpc_subnet" "<имя подсети>" {
         name           = "<имя подсети>"
         zone           = "<зона доступности>"
         network_id     = "<идентификатор сети>"
         v4_cidr_blocks = ["<диапазон>"]
       }
       ```

       Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/r/mdb_clickhouse_cluster.html).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

  Чтобы создать кластер, воспользуйтесь методом API [create](../api-ref/Cluster/create) и передайте в запросе:
  - Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  - Имя кластера в параметре `name`.
  - Окружение кластера в параметре `environment`.
  - Конфигурацию кластера в параметре `configSpec`.
  - Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
  - Идентификатор сети в параметре `networkId`.
  - Идентификаторы групп безопасности в параметре `securityGroupIds`.

  При необходимости включите управление пользователями и базами данных через SQL:
  - `configSpec.sqlUserManagement` — задайте значение `true` для включения режима [управления пользователями через SQL](cluster-users.md#sql-user-management).
  - `configSpec.sqlDatabaseManagement` — задайте значение `true` для включения режима [управления базами данных через SQL](databases.md#sql-database-management). Необходимо, чтобы был включен режим управления пользователями через SQL.
  - `configSpec.adminPassword` — задайте пароль пользователя `admin`, с помощью которого осуществляется управление.

  При создании кластера из нескольких хостов:
    - Если в [виртуальной сети](../../vpc/concepts/network.md) для кластера есть подсети в каждой из [зон доступности](../../overview/concepts/geo-scope.md), то в каждую подсеть автоматически будет добавлено по одному хосту {{ ZK }}, если не указать настройки этих хостов явно. При необходимости можно явно указать три хоста {{ ZK }} и их настройки при создании кластера. 
    - Если в виртуальной сети для кластера есть подсети только в некоторых зонах доступности, то нужно явно указать три хоста {{ ZK }} и их настройки при создании кластера.

{% endlist %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

{% endnote %}  

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер с одним хостом, следует передать один параметр `--host`.

  Допустим, нужно создать {{ CH }}-кластер со следующими характеристиками:

  {% if audience != "internal" %}

  - С именем `mych`.
  - В окружении `production`.
  - В сети `default`.
  - В группе безопасности `{{ security-group }}`.
  - С одним хостом ClickHouse класса `{{ host-class }}` в подсети `b0rcctk2rvtr8efcch64`, в зоне доступности `ru-central1-c`.
  - С быстрым сетевым хранилищем (`{{ disk-type-example }}`) объемом 20 ГБ.
  - С одним пользователем, `user1`, с паролем `user1user1`.
  - С одной базой данных, `db1`.

  {% else %}

  - С именем `mych`.
  - В окружении `production`.
  - В сети `default`.
  - В группе безопасности `{{ security-group }}`.
  - С одним хостом ClickHouse класса `{{host-class}}` в зоне доступности `{{zone-id}}`.
  - С быстрым локальным хранилищем (`local-ssd`) объемом 20 ГБ.
  - С одним пользователем, `user1`, с паролем `user1user1`.
  - С одной базой данных, `db1`.

  {% endif %}

  Запустите следующую команду:

  {% if audience != "internal" %}

  ```
  $ {{ yc-mdb-ch }} cluster create \
       --name mych \
       --environment=production \
       --network-name default \
       --clickhouse-resource-preset {{ host-class }} \
       --host type=clickhouse,zone-id=ru-central1-c,subnet-id=b0cl69g98qumiqmtg12a \
       --clickhouse-disk-size 20 \
       --clickhouse-disk-type {{ disk-type-example }} \
       --user name=user1,password=user1user1 \
       --database name=db1 \
       --security-group-ids {{ security-group }}
  ```

  {% else %}

  ```
  $ {{ yc-mdb-ch }} cluster create \
       --name mych \
       --environment=production \
       --clickhouse-resource-preset s2.nano \
       --host type=clickhouse,zone-id=man \
       --clickhouse-disk-size 20 \
       --clickhouse-disk-type local-ssd \
       --user name=user1,password=user1user1 \
       --database name=db1 \
       --security-group-ids {{ security-group }}
  ```

{% endif %}

- Terraform

  Допустим, нужно создать {{ CH }}-кластер и сеть для него со следующими характеристиками:
    - С именем `mych`.
    - В окружении `PRESTABLE`.
    - В облаке с идентификатором `{{ tf-cloud-id }}`.
    - В каталоге с идентификатором `{{ tf-folder-id }}`.
    - В новой сети `mynet`.
    - В новой группе безопасности `mych-sg`, разрешающей подключение к кластеру из интернета по портам `8443`, `9440`. 
    - С одним хостом класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `ru-central1-c`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    - С быстрым сетевым хранилищем объемом 32 ГБ.
    - С именем базы данных `my_db`.
    - C именем пользователя `user1` и паролем `user1user1`.

  Конфигурационный файл для такого кластера выглядит так:

  ```hcl
  provider "yandex" {
    token     = "<OAuth или статический ключ сервисного аккаунта>"
    cloud_id  = "{{ tf-cloud-id }}"
    folder_id = "{{ tf-folder-id }}"
    zone      = "ru-central1-c"
  }

  resource "yandex_mdb_clickhouse_cluster" "mych" {
    name               = "mych"
    environment        = "PRESTABLE"
    network_id         = yandex_vpc_network.mynet.id
    security_group_ids = [ yandex_vpc_security_group.mych-sg.id ]

    clickhouse {
      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "network-ssd"
        disk_size          = 32
      }
    }

    database {
      name = "my_db"
    }

    user {
      name     = "user1"
      password = "user1user1"
      permission {
        database_name = "my_db"
      }
    }

    host {
      type      = "CLICKHOUSE"
      zone      = "ru-central1-c"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_vpc_network" "mynet" { name = "mynet" }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "ru-central1-c"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }

  resource "yandex_vpc_security_group" "mych-sg" {
    name       = "mych-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MCHSSSH"
      port           = 8443
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
      description    = "MCHSSH2"
      port           = 9440
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  ```

{% endlist %}
