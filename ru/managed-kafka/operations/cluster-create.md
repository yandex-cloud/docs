# Создание кластера {{ KF }}

[Кластер {{ mkf-name }}](../concepts/index.md) — один или несколько [хостов-брокеров](../concepts/brokers.md), на которых размещены [топики и соответствующие топикам разделы](../concepts/topics.md). [Производители и потребители](../concepts/producers-consumers.md) могут работать с этими топиками, подключившись к хостам кластера.

{% note info %}


* Количество хостов-брокеров, которые можно создать вместе с кластером {{ KF }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).


{% endnote %}

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

## Как создать кластер {{ mkf-name }} {#create-cluster}

Перед созданием кластера {{ mkf-name }} рассчитайте [минимальный размер хранилища](../concepts/storage.md#minimal-storage-size) для топиков.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:
     1. Введите имя кластера {{ mkf-name }} и его описание. Имя кластера должно быть уникальным в рамках каталога.
     1. Выберите окружение, в котором нужно создать кластер {{ mkf-name }} (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mkf-name }}. В prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
     1. Выберите версию {{ KF }}.
     1. Чтобы [управлять топиками через Admin API {{ KF }}](../concepts/topics.md#management):
         1. Включите настройку **{{ ui-key.yacloud.kafka.field_unmanaged-topics }}**.
         1. После создания кластера {{ mkf-name }} [создайте пользователя-администратора](cluster-accounts.md#create-user).

        {% include [mkf-admin-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

     1. Чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md), включите настройку **{{ ui-key.yacloud.kafka.field_schema-registry }}**.

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите [платформу](../../compute/concepts/vm-platforms.md), тип хостов и класс хостов.

     Класс хостов определяет технические характеристики [виртуальных машин](../../compute/concepts/vm.md), на которых будут развернуты брокеры {{ KF }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

     При [изменении класса хостов](cluster-update.md#change-brokers) для кластера {{ mkf-name }} меняются характеристики всех уже созданных экземпляров.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
     * Выберите тип диска.

              
       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


       Тип диска для кластера {{ mkf-name }} нельзя изменить после создания.
     * Выберите объем хранилища, который будет использоваться для данных.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:
     1. Выберите одну или несколько [зон доступности](../../overview/concepts/geo-scope.md), в которых нужно разместить брокеры {{ KF }}. Если создать кластер {{ mkf-name }} с одной зоной доступности, в дальнейшем увеличить количество зон и брокеров будет невозможно.
     1. Выберите [сеть](../../vpc/concepts/network.md#network).
     1. Выберите [подсети](../../vpc/concepts/network.md#subnet) в каждой зоне доступности для этой сети. Чтобы [создать новую подсеть](../../vpc/operations/subnet-create.md), нажмите на кнопку **{{ ui-key.yacloud.common.label_create-new_female }}** рядом с нужной зоной доступности.

        {% note info %}

        Для кластера {{ mkf-name }} из нескольких хостов-брокеров нужно указать подсети в каждой зоне доступности, даже если вы планируете разместить брокеры только в некоторых из них. Эти подсети понадобятся для размещения трех [хостов {{ ZK }}](../concepts/index.md) — по одному в каждой зоне доступности. Подробнее см. в разделе [Взаимосвязь ресурсов в {{ mkf-name }}](../concepts/index.md).

        {% endnote %}

     1. Выберите [группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера {{ mkf-name }}.

        {% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

     1. Для доступа к хостам-брокерам из интернета выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. В этом случае подключаться к ним можно только с использованием SSL-соединения. Подробнее см. в разделе [{#T}](connect.md).


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:
     1. Укажите количество хостов-брокеров {{ KF }} для размещения в каждой выбранной зоне доступности.

        При выборе количества хостов учтите следующие особенности:

         * Репликация возможна при наличии как минимум двух хостов в кластере {{ mkf-name }}.
                  * Если в блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** выбран тип `local-ssd` или `network-ssd-nonreplicated`, необходимо добавить не менее трех хостов в кластер {{ mkf-name }}.
         * Для отказоустойчивости кластера {{ mkf-name }} должны выполняться [определенные условия](../concepts/index.md#fault-tolerance).
         * Добавление в кластер {{ mkf-name }} более одного хоста приведет к автоматическому добавлению трех хостов {{ ZK }}.

     
     1. (Опционально) Выберите группы [выделенных хостов](../../compute/concepts/dedicated-host.md), на которых будет размещен кластер {{ mkf-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


  1. Если вы указали более одного хоста-брокера, то в блоке **{{ ui-key.yacloud.kafka.section_zookeeper-resources }}** укажите характеристики [хостов {{ ZK }}](../concepts/index.md) для размещения в каждой выбранной зоне доступности.

  1. При необходимости задайте дополнительные настройки кластера:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. При необходимости задайте [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Дождитесь, когда кластер {{ mkf-name }} будет готов к работе: его статус на панели {{ mkf-name }} сменится на `Running`, а состояние — на `Alive`. Это может занять некоторое время.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания кластера {{ mkf-name }}:

     ```bash
     {{ yc-mdb-kf }} cluster create --help
     ```

  1. Укажите параметры кластера {{ mkf-name }} в команде создания (в примере приведены не все параметры):

     
     ```bash
     {{ yc-mdb-kf }} cluster create \
       --name <имя кластера> \
       --environment <окружение: prestable или production> \
       --version <версия {{ KF }}: {{ versions.cli.str }}> \
       --network-name <имя сети> \
       --subnet-ids <идентификаторы подсетей> \
       --brokers-count <количество брокеров в зоне> \
       --resource-preset <класс хоста> \
       --disk-type <тип диска> \
       --disk-size <размер хранилища в гигабайтах> \
       --assign-public-ip <публичный доступ> \
       --security-group-ids <список идентификаторов групп безопасности> \
       --deletion-protection=<защита от удаления кластера: true или false>
     ```


     {% note tip %}

     При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

     {% endnote %}

     {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

  1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров {{ mkf-name }}), передайте нужное значение в параметре `--maintenance-window` при создании кластера:

     ```bash
     {{ yc-mdb-kf }} cluster create \
       ...
       --maintenance-window type=<тип>[,day=<день недели>,hour=<час дня>]
     ```

     Где:

     {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

  1. Чтобы [управлять топиками через Admin API {{ KF }}](../concepts/topics.md#management):
     1. Задайте значение `true` для параметра `--unmanaged-topics` при создании кластера {{ mkf-name }}:

        ```bash
        {{ yc-mdb-kf }} cluster create \
          ...
          --unmanaged-topics true
        ```

        Эту настройку невозможно изменить после создания кластера {{ mkf-name }}.
     1. После создания кластера [создайте пользователя-администратора](./cluster-accounts.md#create-user).

  
  1. {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-create.md) %}

  1. Чтобы создать кластер {{ mkf-name }}, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids` при создании кластера:

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
     * Кластер {{ mkf-name }} — описание кластера и его хостов. При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     
     ```hcl
     resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
       environment         = "<окружение: PRESTABLE или PRODUCTION>"
       name                = "<имя кластера>"
       network_id          = "<идентификатор сети>"
       subnet_ids          = ["<список идентификаторов подсетей>"]
       security_group_ids  = ["<список идентификаторов групп безопасности кластера>"]
       deletion_protection = <защита от удаления кластера: true или false>

       config {
         assign_public_ip = "<публичный доступ к кластеру: true или false>"
         brokers_count    = <количество брокеров>
         version          = "<версия {{ KF }}: {{ versions.tf.str }}>"
         schema_registry  = "<управление схемами данных: true или false>"
         kafka {
           resources {
             disk_size          = <размер хранилища в гигабайтах>
             disk_type_id       = "<тип диска>"
             resource_preset_id = "<класс хоста>"
           }
           kafka_config {}
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

  1. Создайте кластер {{ mkf-name }}.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся [IP-адреса](../../vpc/concepts/address.md) [ВМ](../../compute/concepts/vm.md). Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

  Чтобы создать кластер, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:
  * Идентификатор [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором должен быть размещен кластер {{ mkf-name }}, в параметре `folderId`.
  * Имя кластера {{ mkf-name }} в параметре `name`.

  
  * Идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в параметре `securityGroupIds`.


  * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров {{ mkf-name }}) в параметре `maintenanceWindow`.
  * Настройки защиты от удаления кластера в параметре `deletionProtection`.

    {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

  Чтобы [управлять топиками через Admin API {{ KF }}](../concepts/topics.md#management):
  1. Передайте значение `true` для параметра `unmanagedTopics`. Эту настройку невозможно изменить после создания кластера {{ mkf-name }}.
  1. После создания кластера {{ mkf-name }} [создайте пользователя-администратора](./cluster-accounts.md#create-user).

  Чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md), передайте значение `true` для параметра `configSpec.schemaRegistry`. Эту настройку невозможно изменить после создания кластера {{ mkf-name }}.

  {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

  
  Чтобы создать кластер {{ mkf-name }}, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), передайте список их идентификаторов в параметре `hostGroupIds`.

  {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера {{ mkf-name }}, для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups).

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
  * В подсети с идентификатором `{{ subnet-id }}`.
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
    --subnet-ids {{ subnet-id }} \
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

  Конфигурационный файл для такого кластера {{ mkf-name }} выглядит так:

  
  
  ```hcl
  resource "yandex_mdb_kafka_cluster" "mykf" {
    environment         = "PRODUCTION"
    name                = "mykf"
    network_id          = yandex_vpc_network.mynet.id
    subnet_ids          = yandex_vpc_subnet.mysubnet.id
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
        kafka_config {}
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