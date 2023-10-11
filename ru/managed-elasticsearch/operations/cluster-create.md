---
title: "Создание кластера {{ ES }}"
description: "Кластер управляемого сервиса {{ ES }} — это группа из нескольких связанных друг с другом хостов
{{ ES }}. При создании кластера {{ ES }} отдельно указываются параметры для хостов, выполняющих роль Master node, и отдельно — для хостов, выполняющих роль Data node."
keywords:
  - создание кластера {{ ES }}
  - кластер {{ ES }}
  - {{ ES }}
---

# Создание {{ ES }}-кластера

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

[Кластер {{ mes-name }}](../concepts/index.md) — это группа из нескольких связанных друг с другом хостов {{ ES }}. Кластер {{ mes-name }} обеспечивает высокую производительность поиска путем распределения задач поиска и индексации по всем хостам кластера с [ролью](../concepts/hosts-roles.md) _Data node_. Подробнее о ролях в кластере {{ mes-name }} см. в разделе [{#T}](../concepts/hosts-roles.md).

{% note info %}

* Количество хостов с ролью _Data node_, которые можно создать вместе с {{ ES }}-кластером, зависит от выбранного [типа дисков](../concepts/storage.md#storage-type-selection) и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы дисков [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

## Создать кластер {#create-cluster}

{% note info %}

С 13 июня 2022 года прекращена поддержка [редакции](../concepts/es-editions.md) `Gold` в кластерах {{ mes-name }}. Создать новый кластер с этой редакцией невозможно.

{% endnote %}

При создании кластера {{ mes-name }} отдельно указываются параметры для хостов, выполняющих роль _Master node_, и отдельно — для хостов, выполняющих роль _Data node_.

Допускается использовать только хосты с ролью _Data node_ и не создавать выделенные хосты для роли _Master node_: в этом случае хосты с ролью _Data node_ будут совмещать две роли.

{% list tabs %}

- Консоль управления

  Чтобы создать кластер {{ mes-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать кластер {{ mes-name }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:
     1. Введите имя кластера {{ mes-name }} и его описание. Имя кластера {{ mes-name }} должно быть уникальным в рамках каталога.
     1. Выберите окружение, в котором нужно создать кластер {{ mes-name }} (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий приложений.
        * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mes-name }}. В prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
     1. Выберите из списка версию {{ ES }}.
     1. Выберите из списка [редакцию {{ ES }}](../concepts/es-editions.md).

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [облачную сеть](../../vpc/concepts/network.md#network) для размещения кластера {{ mes-name }} и [группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](cluster-connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру {{ mes-name }}.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_user }}** укажите пароль для пользователя `admin`.

     {% include [mes-superuser](../../_includes/mdb/mes-superuser.md) %}

  1. Задайте конфигурацию хостов с ролью _Data node_, выбрав вкладку **{{ ui-key.yacloud.opensearch.title_data-node }}**:
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите платформу, тип хостов и класс хостов.

        Класс хостов определяет технические характеристики [виртуальных машин](../../compute/concepts/vm.md), на которых будут развернуты ноды {{ ES }}. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера {{ mes-name }} меняются характеристики всех уже созданных экземпляров.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
        * Выберите [тип диска](../concepts/storage.md).

          {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

        * Выберите объем хранилища, который будет использоваться для данных.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** укажите конфигурацию хостов, создаваемых вместе с кластером {{ mes-name }}:
        1. Чтобы добавить хост, нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
        1. Чтобы изменить добавленный хост, наведите указатель на строку хоста и нажмите значок ![image](../../_assets/pencil.svg).

           При изменении хоста можно: {#change-data-node-settings}
           * Выбрать [зону доступности](../../overview/concepts/geo-scope.md) и [подсеть](../../vpc/concepts/network.md#subnet).
           * Включить публичный доступ.

             {% note warning %}

             Включить публичный доступ к хосту после создания кластера {{ mes-name }} невозможно.

             {% endnote %}

             Если для хоста {{ ES }} с ролью _Data node_ включен публичный доступ, к этому хосту или расположенной на нем Kibana можно подключиться через интернет. Подробнее см. в разделе [{#T}](cluster-connect.md).

             {% include [mes-tip-public-kibana](../../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

  1. При необходимости задайте конфигурацию хостов с ролью _Master node_, выбрав вкладку **Master node**:
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите платформу, тип хостов и класс хостов.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** настройте хранилище по аналогии с хостами с ролью _Data node_.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** нажмите кнопку **{{ ui-key.yacloud.elasticsearch.button_add-hosts }}**. Будут добавлены три хоста. Чтобы изменить один из добавленных хостов, наведите указатель на строку хоста и нажмите значок ![image](../../_assets/pencil.svg).

        При изменении хоста можно: {#change-master-node-settings}
        * Выбрать зону доступности и подсеть.
        * Включить публичный доступ.

          {% note tip %}

          Не рекомендуется включать публичный доступ для хостов с ролью _Master node_, это может быть небезопасно.

          {% endnote %}

  1. При необходимости задайте дополнительные настройки кластера {{ mes-name }}:

     {% include [Дополнительные настройки кластера MES](../../_includes/mdb/mes/extra-settings.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mes-name }}:
  1. Проверьте, есть ли в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) [подсети](../../vpc/concepts/network.md#subnet) для хостов кластера {{ mes-name }}:

     ```bash
     yc vpc subnet list
     ```

     
     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе [{{ vpc-full-name }}](../../vpc/).


  1. Посмотрите описание команды CLI для создания кластера {{ mes-name }}:

     ```bash
     {{ yc-mdb-es }} cluster create --help
     ```

  1. Укажите параметры кластера {{ mes-name }} в команде создания (в примере приведены не все параметры):

     
     ```bash
     {{ yc-mdb-es }} cluster create \
       --name <имя_кластера> \
       --environment <окружение:_prestable_или_production> \
       --network-name <имя_сети> \
       --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети>,assign-public-ip=<публичный_доступ>,type=<тип_хоста:_datanode_или_masternode> \
       --datanode-resource-preset <класс_хостов_с_ролью_Data_node> \
       --datanode-disk-size <размер_хранилища_в_гигабайтах_для_хостов_с_ролью_Data_node> \
       --datanode-disk-type <тип_диска_для_хостов_с_ролью_Data_node> \
       --masternode-resource-preset <класс_хостов_с_ролью_Master_node> \
       --masternode-disk-size <размер_хранилища_в_гигабайтах_для_хостов_с_ролью_Master_node> \
       --masternode-disk-type <тип_диска_для_хостов_с_ролью_Master_node> \
       --security-group-ids <список_идентификаторов_групп_безопасности> \
       --version <версия_{{ ES }}:_{{ versions.cli.str }}> \
       --edition <редакция_{{ ES }}:_basic_или_platinum> \
       --admin-password <пароль_пользователя_admin> \
       --plugins=<имя_плагина_1>,...,<имя_плагина_N> \
       --deletion-protection=<защита_от_удаления_кластера:_true_или_false>
     ```


     Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной [зоне доступности](../../overview/concepts/geo-scope.md) больше одной подсети.

     {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

     {% note info %}

     По умолчанию при создании кластера {{ mes-name }} устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера {{ mes-name }}](cluster-update.md#change-additional-settings).

     {% endnote %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

      
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы создать кластер {{ mes-name }}:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * Кластер базы данных — описание кластера {{ mes-name }} и его хостов.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     
     ```hcl
     resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
       name                = "<имя_кластера>"
       environment         = "<окружение,_PRESTABLE_или_PRODUCTION>"
       network_id          = "<идентификатор_сети>"
       deletion_protection = "<защита_от_удаления:_true_или_false>"

       config {
         version = "<(необязательно)_версия_{{ ES }}:_{{ versions.tf.str }}>"
         edition = "<(необязательно)_редакция_{{ ES }}:_basic_или_platinum>"

         admin_password = "<пароль_пользователя-администратора>"

         data_node {
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_диска>"
             disk_size          = <объем_хранилища,_ГБ>
           }
         }

         master_node {
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_диска>"
             disk_size          = <объем_хранилища,_ГБ>
           }
         }

         plugins = [ "<список_имен_плагинов>" ]

       }

       security_group_ids = [ "<список_групп_безопасности>" ]

       host {
         name             = "<имя_хоста>"
         zone             = "<зона_доступности>"
         type             = "<роль_хоста:_DATA_NODE_или_MASTER_NODE>"
         assign_public_ip = <публичный_доступ_к_хосту:_true_или_false>
         subnet_id        = "<идентификатор_подсети>"
       }
     }

     resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

     resource "yandex_vpc_subnet" "<имя_подсети>" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = "<идентификатор_сети>"
       v4_cidr_blocks = ["<диапазон>"]
     }
     ```




     Включенная защита от удаления кластера {{ mes-name }} не защищает содержимое БД.

     1. {% include [Maintenance window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер {{ mes-name }}.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

  Чтобы создать кластер {{ mes-name }}, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:
  * Идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором должен быть размещен кластер {{ mes-name }}, в параметре `folderId`.
  * Имя кластера {{ mes-name }} в параметре `name`.
  * Версию {{ ES }} в параметре `configSpec.version`.
  * Редакцию {{ ES }} в параметре `configSpec.edition`.
  * Конфигурацию кластера {{ mes-name }} в параметре `configSpec`, в том числе:
    * Класс хостов с ролью _Master node_ в параметре `configSpec.elasticsearchSpec.masterNode.resources`. Чтобы не создавать выделенных хостов с ролью _Master node_ — не задавайте значения для группы параметров `configSpec.elasticsearchSpec.masterNode`.
    * Класс хостов с ролью _Data node_ в параметре `configSpec.elasticsearchSpec.dataNode.resources`.
  * Конфигурацию хостов кластера {{ mes-name }} в одном или нескольких параметрах `hostSpecs`.
  * Идентификатор [сети](../../vpc/concepts/network.md#network) в параметре `networkId`.


  * Идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в параметре `securityGroupIds`.


  * Список плагинов в параметре `configSpec.elasticsearchSpec.plugins`.
  * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров {{ mes-name }}) в параметре `maintenanceWindow`.

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера {{ mes-name }}, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](cluster-connect.md#configuring-security-groups).

{% endnote %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Чтобы создать кластер {{ mes-name }} с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mes-name }} с тестовыми характеристиками:
  * Имя `my-es-clstr`.
  * Версия `{{ versions.cli.latest }}`.
  * Редакция `Platinum`.
  * Окружение `PRODUCTION`.
  * Сеть `default`.


  * Группа безопасности с идентификатором `enpp2s8l3irh********`.


  * Один публично доступный хост с ролью _Data node_ класса `{{ host-class }}` в подсети `{{ subnet-id }}`, в зоне доступности `{{ region-id }}-a`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
  * Пароль `esadminpwd` для пользователя `admin`.
  * Защита от случайного удаления кластера {{ mes-name }}.

  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-es }} cluster create \
    --name my-es-clstr \
    --environment production \
    --network-name default \
    --host zone-id={{ region-id }}-a,assign-public-ip=true,type=datanode \
    --datanode-resource-preset {{ host-class }} \
    --datanode-disk-type={{ disk-type-example }} \
    --datanode-disk-size=20 \
    --admin-password=esadminpwd \
    --security-group-ids enpp2s8l3irh******** \
    --version {{ versions.cli.latest }} \
    --edition platinum \
    --deletion-protection=true
  ```


- {{ TF }}

  Создайте кластер {{ mes-name }}. Конфигурационный файл для кластера {{ mes-name }} выглядит так:

  
  
  ```hcl
  resource "yandex_mdb_elasticsearch_cluster" "my-es-clstr" {
    name                = "my-es-clstr"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    deletion_protection = "true"

    config {
      edition = "basic"
      version = "{{ versions.tf.latest }}"

      admin_password = "esadminpwd"

      data_node {
        resources {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 20
        }
      }

    }

    security_group_ids = [ yandex_vpc_security_group.es-sg.id ]

    host {
      name             = "node"
      zone             = "{{ region-id }}-a"
      type             = "DATA_NODE"
      assign_public_ip = true
      subnet_id        = yandex_vpc_subnet.mysubnet.id
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

  resource "yandex_vpc_security_group" "es-sg" {
    name       = "es-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Kibana"
      port           = 443
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
      description    = "Elasticsearch"
      port           = 9200
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  ```




  Где применены тестовые характеристики:
  * Имя `my-es-clstr`.
  * Версия `{{ versions.tf.latest }}`.
  * Редакция `Basic`.
  * Окружение `PRODUCTION`.
  * Защита кластера {{ mes-name }} от удаления `deletion_protection`. Пока опция включена, кластер {{ mes-name }} удалить невозможно.
  * Облако с идентификатором `{{ tf-cloud-id }}`.
  * Каталог с идентификатором `{{ tf-folder-id }}`.
  * Новая сеть `mynet`.


  * Новая группа безопасности `es-sg`, разрешающая подключение к кластеру {{ mes-name }} из интернета через порты 443 (Kibana) и 9200 ({{ ES }}).


  * Один публично доступный хост с ролью _Data node_ класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
  * Пароль `esadminpwd` для пользователя `admin`.

{% endlist %}