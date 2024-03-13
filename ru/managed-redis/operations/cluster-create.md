---
title: "Как создать {{ RD }}-кластер"
description: "Следуя данной инструкции, вы сможете создать {{ RD }}-кластер с одним или несколькими хостами базы данных."
---

# Создание {{ RD }}-кластера

{{ RD }}-[кластер](../../glossary/cluster.md) — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста: хост-мастер принимает запросы на запись, асинхронно дублируя изменения в репликах.

Подробнее об устройстве кластера {{ mrd-name }} см. в разделе [{#T}](../concepts/index.md).

{% note info %}

* Количество хостов, которые можно создать вместе с {{ RD }}-кластером, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection), [класса хостов](../concepts/instance-types.md#available-flavors) и использования [шардирования](../concepts/sharding.md).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

## Как создать кластер {{ RD }} {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  @[youtube](https://www.youtube.com/watch?v=ZFTa9O-NR_U&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=7&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором нужно создать кластер БД.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

     * Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**. Имя кластера должно быть уникальным в рамках каталога.
     * (Опционально) Добавьте описание кластера.
     * Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
       * `PRODUCTION` — для стабильных версий ваших приложений.
       * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
     * Выберите версию СУБД.
     * Если требуется, включите [шардирование кластера](../concepts/sharding.md).

          {% note warning %}

          Включить шардирование можно только при создании нового кластера. Шардировать уже созданный нешардированный кластер невозможно, как и отключить шардирование кластера, для которого оно включено.

          {% endnote %}

     * Если требуется, включите поддержку шифрованных SSL-соединений с кластером.

          {% note warning %}

          Включить шифрование соединений можно только при создании нового кластера. Отключить шифрование в кластере, для которого оно включено, невозможно.

          {% endnote %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}**:

     * В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** выберите платформу.
     * Укажите **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой будут развернуты хосты.
     * Выберите конфигурацию [хостов](../concepts/instance-types.md) — она определяет технические характеристики виртуальных машин, на которых будут развернуты хосты БД. При изменении конфигурации меняются характеристики всех уже созданных хостов.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

       
       * Выберите [тип диска](../concepts/storage.md):
           * либо более гибкое хранилище — на сетевых SSD-дисках (`network-ssd`) или на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`);
           * либо более быстрое хранилище — на локальных SSD-дисках (`local-ssd`).

           {% include [storages-step-settings-no-hdd](../../_includes/mdb/settings-storages-no-hdd.md) %}


       

       * Выберите размер хранилища. Доступный размер хранилища ограничен [квотами и лимитами](../concepts/limits.md#mrd-limits).

   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_config }}** в поле **{{ ui-key.yacloud.mdb.forms.config_field_password }}** укажите пароль пользователя.

       {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

   
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:
       * Облачную сеть для размещения кластера.
       * Группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:

      * Чтобы изменить настройки отдельного хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке с его именем.

          * **{{ ui-key.yacloud.mdb.forms.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
          * **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}** — укажите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.
          * **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** — разрешает доступ к хосту из интернета, если кластер создается с включенной настройкой **{{ ui-key.yacloud.redis.field_tls-support }}**.
          * **{{ ui-key.yacloud.mdb.forms.host_column_shard-name }}** — позволяет изменить имя шарда для хоста. Поле доступно только если кластер создается с включенной настройкой **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}**.

      * Чтобы добавить хосты в кластер, нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

  1. При необходимости задайте дополнительные настройки кластера:

      {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

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
      {{ yc-mdb-rd }} cluster create --help
      ```

  1. При создании кластера с помощью CLI нельзя напрямую указать тип хоста и объем оперативной памяти. Вместо этого выберите подходящий [класс хостов](../concepts/instance-types.md). Чтобы просмотреть доступные классы хостов, выполните команду:

     ```bash
     {{ yc-mdb-rd }} resource-preset list
     ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все флаги):

      
      ```bash
      {{ yc-mdb-rd }} cluster create \
        --name <имя_кластера> \
        --environment <окружение> \
        --network-name <имя_сети> \
        --host zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<публичный_доступ>,`
              `replica-priority=<приоритет_хоста> \
        --security-group-ids <список_идентификаторов_групп_безопасности> \
        --enable-tls \
        --resource-preset <класс_хоста> \
        --disk-size <размер_хранилища_ГБ> \
        --password=<пароль_пользователя> \
        --backup-window-start <время> \
        --deletion-protection=<защита_от_удаления>
      ```


      Где:
      * `--environment` — окружение: `prestable` или `production`.

      
      * `--host` — параметры хоста:
         * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
         * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
         * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
         * `replica-priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover). 

      
      * `--backup-window-start` — время начала резервного копирования в формате `ЧЧ:ММ:СС`.
      * `--deletion-protection` — защита от удаления кластера: `true` или `false`.

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% note info %}

      По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * Кластер базы данных — описание кластера и его хостов. При необходимости здесь же можно задать [настройки СУБД](../concepts/settings-list.md).

       
       * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
       * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.


       Пример структуры конфигурационного файла для создания шардированного кластера с поддержкой SSL:

       
       
       ```hcl
       resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
         name                = "<имя_кластера>"
         environment         = "<окружение>"
         network_id          = "<идентификатор_сети>"
         security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
         tls_enabled         = true
         deletion_protection = <защита_от_удаления>

         config {
           password = "<пароль>"
           version  = "<версия_{{ RD }}>"
         }

         resources {
           resource_preset_id = "<класс_хоста>"
           disk_type_id       = "<тип_диска>"
           disk_size          = <размер_хранилища_ГБ>
         }

         host {
           zone             = "<зона_доступности>"
           subnet_id        = "<идентификатор_подсети>"
           assign_public_ip = <публичный_доступ>
           replica_priority = <приоритет_хоста>
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




       Где:
       * `environment` — окружение: `PRESTABLE` или `PRODUCTION`.
       * `deletion_protection` — защита от удаления кластера: `true` или `false`.
       * `version` — версия {{ RD }}: {{ versions.tf.str }}.
       * `host` — параметры хоста:
         * `zone_id` — зона доступности.
         * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
         * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
         * `replica_priority` — приоритет хоста.

       {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

       {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

       {% include [Maintenance window](../../_includes/mdb/mrd/terraform/maintenance-window.md) %}

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-mrd }}).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся [FQDN хостов кластера](../concepts/network.md#hostname). Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

       {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

  Чтобы создать кластер {{ RD }}, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:
  * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  * Идентификаторы групп безопасности в параметре `securityGroupIds`.
  * Флаг `tlsEnabled=true` для создания кластера с поддержкой шифрованных SSL-соединений.
  * Настройки публичного доступа к хостам в параметре `hostSpecs[].assignPublicIp`.

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).

{% endnote %}


## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

  Создайте кластер {{ mrd-name }} с тестовыми характеристиками:

  * Имя `myredis`.
  * Версия `{{ versions.cli.latest }}`.
  * Окружение — `production`.
  * Сеть `default`.
  * Один хост класса `hm1.nano` в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a` и группе безопасности с идентификатором `{{ security-group }}`, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`.
  * С поддержкой SSL-соединений.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
  * Пароль `user1user1`.
  * С защитой от случайного удаления кластера.

  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name myredis \
    --redis-version {{ versions.cli.latest }} \
    --environment production \
    --network-name default \
    --resource-preset hm1.nano \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
    --security-group-ids {{ security-group }} \
    --enable-tls \
    --disk-type-id {{ disk-type-example }} \
    --disk-size 16 \
    --password=user1user1 \
    --deletion-protection=true
  ```


- {{ TF }} {#tf}

  Создайте кластер {{ mrd-name }} и сеть для него с тестовыми характеристиками:

    * Имя `myredis`.
    * Версия `{{ versions.tf.latest }}`.
    * Окружение — `PRODUCTION`.
    * Облако с идентификатором `{{ tf-cloud-id }}`.
    * Каталог с идентификатором `{{ tf-folder-id }}`.
    * Новая сеть `mynet`.
    * Один хост класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    * Новая группа безопасности `redis-sg`, разрешающая подключения через порт `{{ port-mrd-tls }}` с любых адресов подсети `mysubnet`.
    * С поддержкой SSL-соединений.
    * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
    * Пароль `user1user1`.
    * С защитой от случайного удаления кластера.

  Конфигурационный файл для такого кластера выглядит так:

  
  
  ```hcl
  resource "yandex_mdb_redis_cluster" "myredis" {
    name                = "myredis"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.redis-sg.id ]
    tls_enabled         = true
    deletion_protection = true

    config {
      password = "user1user1"
      version  = "{{ versions.tf.latest }}"
    }

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }

    host {
      zone             = "{{ region-id }}-a"
      subnet_id        = yandex_vpc_subnet.mysubnet.id
      assign_public_ip = true
      replica_priority = 50
    }
  }

  resource "yandex_vpc_network" "mynet" { name = "mynet" }

  resource "yandex_vpc_security_group" "redis-sg" {
    name       = "redis-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }

    egress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```




{% endlist %}

### Создание шардированного кластера {#creating-a-sharded-cluster}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    Создайте [шардированный](../concepts/sharding.md) кластер {{ mrd-name }} с тестовыми характеристиками:

    * Имя `myredis`.
    * Версия `{{ versions.tf.latest }}`.
    * Окружение `PRODUCTION`.
    * Облако с идентификатором `{{ tf-cloud-id }}`.
    * Каталог с идентификатором `{{ tf-folder-id }}`.
    * Новая сеть `mynet`.
    * Три подсети в сети `mynet`, по одной в каждой зоне доступности:
      * `subnet-a` с диапазоном `10.1.0.0/24`;
      * `subnet-b` с диапазоном `10.2.0.0/24`;
      * `subnet-d` с диапазоном `10.3.0.0/24`.
    * Три хоста класса `{{ host-class }}`, по одному в каждой подсети.
    * Новая группа безопасности `redis-sg`, разрешающая подключения через порты `{{ port-mrd }}` и `{{ port-mrd-sentinel }}` ([Redis Sentinel](./connect/index.md)) с любых адресов подсетей.
    * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
    * Пароль `user1user1`.
    * С защитой от случайного удаления кластера.

    Конфигурационный файл для такого кластера выглядит так:

    
    
    ```hcl
    resource "yandex_mdb_redis_cluster" "myredis" {
      name                = "myredis"
      environment         = "PRODUCTION"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
      sharded             = true
      deletion_protection = true

      config {
        password = "user1user1"
        version  = "{{ versions.tf.latest }}"
      }

      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 16
      }

      host {
        zone       = "{{ region-id }}-a"
        subnet_id  = yandex_vpc_subnet.subnet-a.id
        shard_name = "shard1"
      }

      host {
        zone       = "{{ region-id }}-b"
        subnet_id  = yandex_vpc_subnet.subnet-b.id
        shard_name = "shard2"
      }

      host {
        zone       = "{{ region-id }}-d"
        subnet_id  = yandex_vpc.subnet.subnet-d.id
        shard_name = "shard3"
      }
    }

    resource "yandex_vpc_network" "mynet" { name = "mynet" }

    resource "yandex_vpc_subnet" "subnet-a" {
      name           = "subnet-a"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-b" {
      name           = "subnet-b"
      zone           = "{{ region-id }}-b"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-d" {
      name           = "subnet-d"
      zone           = "{{ region-id }}-d"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.3.0.0/24"]
    }

    resource "yandex_vpc_security_group" "redis-sg" {
      name       = "redis-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      egress {
        description    = "Redis"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      ingress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      egress {
        description    = "Redis Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
    }
    ```




{% endlist %}
