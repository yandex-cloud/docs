# Создание кластера

Кластер {{ mkf-name }} — это один или несколько хостов-брокеров, на которых размещены топики и соответствующие топикам разделы. Производители и потребители могут работать с этими топиками, подключившись к хостам кластера.

{% note info %}

* Количество хостов-брокеров, которые можно создать вместе с кластером {{ KF }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

## Как создать кластер {{ mkf-name }} {#create-cluster}

Перед созданием кластера рассчитайте [минимальный размер хранилища](../concepts/storage.md#minimal-storage-size) для топиков.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. В блоке **Базовые параметры**:
     1. Введите имя кластера и, при необходимости, его описание. Имя кластера должно быть уникальным в рамках каталога.
     1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mkf-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
     1. Выберите версию {{ KF }}.
     1. Чтобы [управлять топиками через Admin API {{ KF }}](../concepts/topics.md#management):
         1. Включите настройку **Управление топиками через API**.
         1. После создания кластера [создайте пользователя-администратора](./cluster-accounts.md#create-user).

         {% include [mkf-admin-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}
     1. Чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md), включите настройку **Реестр схем данных**.

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

  1. В блоке **Класс хоста** выберите платформу, тип хостов и класс хостов.

     Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты [брокеры {{ KF }}](../concepts/brokers.md). Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

     При [изменении класса хостов](cluster-update.md#change-brokers) для кластера меняются характеристики всех уже созданных экземпляров.

  1. В блоке **Хранилище**:

     * Выберите [тип диска](../concepts/storage.md).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

        Тип диска для кластера {{ mkf-name }} нельзя изменить после создания.

     * Выберите объем хранилища, который будет использоваться для данных.

  
  1. В блоке **Сетевые настройки**:

     1. Выберите одну или несколько [зон доступности](../../overview/concepts/geo-scope.md), в которых нужно разместить брокеры {{ KF }}. Если создать кластер с одной зоной доступности, то в дальнейшем увеличить количество зон и брокеров будет невозможно.
     1. Выберите [сеть](../../vpc/concepts/network.md).
     1. Выберите подсети в каждой зоне доступности для этой сети. Чтобы [создать новую подсеть](../../vpc/operations/subnet-create.md), нажмите на кнопку **Создать новую** рядом с нужной зоной доступности.

        {% note info %}

        Для кластера из нескольких хостов-брокеров нужно указать подсети в каждой зоне доступности, даже если вы планируете разместить брокеры только в некоторых из них. Эти подсети понадобятся для размещения трех хостов {{ ZK }} — по одному в каждой зоне доступности. Подробнее см. в разделе [Взаимосвязь ресурсов в {{ mkf-name }}](../concepts/index.md).

        {% endnote %}

     1. Выберите группы безопасности для сетевого трафика кластера.

     1. Для доступа к хостам-брокерам из интернета выберите опцию **Публичный доступ**. В этом случае подключаться к ним можно только с использованием SSL-соединения. Запросить публичный доступ после создания кластера невозможно. Подробнее см. в разделе [{#T}](connect.md).


  1. В блоке **Хосты**:
  
     1. Укажите количество [хостов-брокеров](../concepts/brokers.md) {{ KF }} для размещения в каждой выбранной зоне доступности.

        При выборе количества хостов учитывайте, что:

         * Хосты кластера {{ KF }} будут равномерно расположены в выбранных зонах доступности. Количество зон и хостов в зоне следует выбирать исходя из требуемой модели отказоустойчивости и нагрузки на кластер.
         * Репликация возможна при наличии как минимум двух хостов в кластере.
         * Если в блоке **Хранилище** выбран тип `local-ssd` или `network-ssd-nonreplicated`, то необходимо добавить не менее трех хостов в кластер.
         * Добавление в кластер более одного хоста приведет к автоматическому добавлению трех хостов {{ ZK }}.

     
     1. (Опционально) Выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md), на которых будет размещен кластер.

         {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


  1. Если вы указали более одного хоста-брокера, то в блоке **Класс хоста {{ ZK }}** укажите характеристики [хостов {{ ZK }}](../concepts/index.md) для размещения в каждой выбранной зоне доступности.

  1. При необходимости задайте дополнительные настройки кластера:

      {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. При необходимости задайте [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

  1. Нажмите кнопку **Создать кластер**.

  1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mkf-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-kf }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

      
      ```bash
      {{ yc-mdb-kf }} cluster create \
        --name <имя кластера> \
        --environment <окружение: prestable или production> \
        --version <версия {{ KF }}: {{ versions.cli.str }}> \
        --network-name <имя сети> \
        --brokers-count <количество брокеров в зоне> \
        --resource-preset <класс хоста> \
        --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
        --disk-size <размер хранилища в гигабайтах> \
        --assign-public-ip <публичный доступ> \
        --security-group-ids <список идентификаторов групп безопасности> \
        --deletion-protection=<защита от удаления кластера: true или false>
      ```


      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

  1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), передайте нужное значение в параметре `--maintenance-window` при создании кластера:

      ```bash
      {{ yc-mdb-kf }} cluster create \
      ...
         --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                             `day=<день недели для типа weekly>,`
                             `hour=<час дня для типа weekly>
      ```

      Где:

      * `type` — тип технического обслуживания:
          * `anytime` — в любое время.
          * `weekly` — по расписанию.
      * `day` — день недели для типа `weekly` в формате `DDD`. Например, `MON`.
      * `hour` — час дня по UTC для типа `weekly` в формате `HH`. Например, `21`.

  1. Чтобы управлять топиками через Admin API {{ KF }}:

      1. Задайте значение `true` для параметра `--unmanaged-topics` при создании кластера:

          ```bash
          {{ yc-mdb-kf }} cluster create \
            ...
            --unmanaged-topics true
          ```

          Эту настройку невозможно изменить после создания кластера.

      1. После создания кластера [создайте пользователя-администратора](./cluster-accounts.md#create-user).

  
  1. {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-create.md) %}

  1. Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids` при создании кластера:

      ```bash
      {{ yc-mdb-kf }} cluster create \
        ...
        --host-group-ids <идентификаторы групп выделенных хостов>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

    
    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


    Чтобы создать кластер:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

        * Кластер {{ KF }} — описание кластера и его хостов. При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        Пример структуры конфигурационного файла:

        
        
        ```hcl
        terraform {
          required_providers {
            yandex = {
             source = "yandex-cloud/yandex"
            }
          }
        }

        provider "yandex" {
          token     = "<OAuth или статический ключ сервисного аккаунта>"
          cloud_id  = "<идентификатор облака>"
          folder_id = "<идентификатор каталога>"
          zone      = "<зона доступности>"
        }

        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
          environment         = "<окружение: PRESTABLE или PRODUCTION>"
          name                = "<имя кластера>"
          network_id          = "<идентификатор сети>"
          security_group_ids  = ["<список идентификаторов групп безопасности кластера>"]
          deletion_protection = <защита от удаления кластера: true или false>

          config {
            assign_public_ip = "<публичный доступ к кластеру: true или false>"
            brokers_count    = <количество брокеров>
            version          = "<версия {{ mkf-name }}: {{ versions.tf.str }}>"
            schema_registry  = "<управление схемами данных: true или false>"
            kafka {
              resources {
                disk_size          = <размер хранилища в гигабайтах>
                disk_type_id       = "<тип диска>"
                resource_preset_id = "<класс хоста>"
              }
            }

            zones = [
              "<зоны доступности>"
            ]
          }
        }

        resource "yandex_vpc_network" "<имя сети>" {
          name = "<имя сети>"
        }

        resource "yandex_vpc_subnet" "<имя подсети>" {
          name           = "<имя подсети>"
          zone           = "<зона доступности>"
          network_id     = "<идентификатор сети>"
          v4_cidr_blocks = ["<диапазон>"]
        }
        ```




        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

        {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

    Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
        * Идентификаторы групп безопасности в параметре `securityGroupIds`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

    Чтобы управлять топиками через Admin API {{ KF }}:

    1. Передайте значение `true` для параметра `unmanagedTopics`. Эту настройку невозможно изменить после создания кластера.
    1. После создания кластера [создайте пользователя-администратора](./cluster-accounts.md#create-user).

    Чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md), передайте значение `true` для параметра `configSpec.schemaRegistry`. Эту настройку невозможно изменить после создания кластера.

    {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

    
    Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), передайте список их идентификаторов в параметре `hostGroupIds`.

    {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

{% endnote %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  
  * С именем `mykf`.
  * В окружении `production`.
  * С {{ KF }} версии `{{ versions.cli.latest }}`.
  * В сети `{{ network-name }}`.
  * В группе безопасности `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}`, в зоне доступности `{{ region-id }}-a`.
  * С одним брокером.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 10 ГБ.
  * С публичным доступом.
  * С защитой от случайного удаления кластера.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-kf }} cluster create \
    --name mykf \
    --environment production \
    --version {{ versions.cli.latest }} \
    --network-name {{ network-name }} \
    --zone-ids {{ region-id }}-a \
    --brokers-count 1 \
    --resource-preset {{ host-class }} \
    --disk-size 10 \
    --disk-type {{ disk-type-example }} \
    --assign-public-ip \
    --security-group-ids {{ security-group }} \
    --deletion-protection=true
  ```


- {{ TF }}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * С именем `mykf`.
    * В окружении `PRODUCTION`.
    * С {{ KF }} версии `{{ versions.tf.latest }}`.
    * В новой сети `mynet` с подсетью `mysubnet`.
        * В новой группе безопасности `mykf-sg`, разрешающей подключение к кластеру из интернета по порту `9091`.
    * С одним хостом класса `{{ host-class }}`, в зоне доступности `{{ region-id }}-a`.
    * С одним брокером.
    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 10 ГБ.
    * С публичным доступом.
    * С защитой от случайного удаления кластера.

  Конфигурационный файл для такого кластера выглядит так:

    
    
    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    }

    provider "yandex" {
      token     = "<OAuth или статический ключ сервисного аккаунта>"
      cloud_id  = "{{ tf-cloud-id }}"
      folder_id = "{{ tf-folder-id }}"
      zone      = "{{ region-id }}-a"
    }

    resource "yandex_mdb_kafka_cluster" "mykf" {
      environment         = "PRODUCTION"
      name                = "mykf"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [ yandex_vpc_security_group.mykf-sg.id ]
      deletion_protection = true

      config {
        assign_public_ip = true
        brokers_count    = 1
        version          = "{{ versions.tf.latest }}"
        kafka {
          resources {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }

        zones = [
          "{{ region-id }}-a"
        ]
      }
    }

    resource "yandex_vpc_network" "mynet" {
      name = "mynet"
    }

    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.5.0.0/24"]
    }

    resource "yandex_vpc_security_group" "mykf-sg" {
      name       = "mykf-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "Kafka"
        port           = 9091
        protocol       = "TCP"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
      }
    }
    ```




{% endlist %}
