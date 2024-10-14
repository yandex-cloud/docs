---
title: Как создать кластер {{ RD }}
description: Следуя данной инструкции, вы сможете создать кластер {{ RD }} с одним или несколькими хостами базы данных.
---

# Создание кластера {{ RD }}


[Кластер](../../glossary/cluster.md) {{ RD }} — это один или несколько хостов базы данных, между которыми можно настроить репликацию. Репликация работает по умолчанию в любом кластере из более чем 1 хоста: хост-мастер принимает запросы на запись, асинхронно дублируя изменения в репликах.

Подробнее об устройстве кластера {{ mrd-name }} см. в разделе [Взаимосвязь ресурсов сервиса](../concepts/index.md).

{% note info %}

* Количество хостов, которые можно создать вместе с кластером {{ RD }}, зависит от выбранного [типа диска](../concepts/storage.md#storage-type-selection), [класса хостов](../concepts/instance-types.md#available-flavors) и использования [шардирования](../concepts/sharding.md).
* Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

## Создать кластер {#create-cluster}

Для создания кластера {{ mrd-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mrd.editor }} или выше](../security/index.md#roles-list). О том, как назначить роль, см. [документацию {{ iam-name }}](../../iam/operations/roles/grant.md).

{% note info %}

Действуют следующие ограничения на способы создания шардированных кластеров:

* Кластер с одним шардом можно создать с помощью CLI, {{ TF }} или API.
* Кластер с двумя шардами нельзя создать, но можно [добавить шард](./shards.md#add) в существующий кластер с одним шардом.
* Кластер с тремя и более шардами можно создать с помощью консоли управления, CLI, {{ TF }} или API.

Для нешардированных кластеров ограничений нет.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}


  @[youtube](https://www.youtube.com/watch?v=ZFTa9O-NR_U&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=7&pp=iAQB)


  Чтобы создать кластер {{ mrd-name }}:

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
     * (Опционально) Добавьте метки.
     * Если требуется, включите [шардирование кластера](../concepts/sharding.md).

          {% note warning %}

          Отключить шардирование в кластере, для которого оно включено, невозможно. При необходимости можно создать нешардированный кластер и позже [включить в нем шардирование](./update.md#enable-sharding).

          {% endnote %}

     * Если требуется, включите поддержку шифрованных TLS-соединений с кластером.

          {% note warning %}

          Включить шифрование соединений можно только при создании нового кластера. Отключить шифрование в кластере, для которого оно включено, невозможно.

          {% endnote %}

     * При необходимости включите [использование FQDN вместо IP-адресов](../concepts/network.md#fqdn-ip-setting).

        {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

     * Выберите настройки [персистентности данных](../concepts/replication.md#persistence).

  1. В блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**:

     * В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** выберите платформу.
     * Укажите **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой будут развернуты хосты.
     * Выберите **{{ ui-key.yacloud.mdb.forms.section_resource }}**.


     * Выберите [тип диска](../concepts/storage.md):
       * либо более гибкое хранилище — на сетевых SSD-дисках (`network-ssd`) или на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`);
       * либо более быстрое хранилище — на локальных SSD-дисках (`local-ssd`).

       {% include [storages-step-settings-no-hdd](../../_includes/mdb/settings-storages-no-hdd.md) %}


       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}


     * Выберите размер хранилища. Доступный размер хранилища ограничен [квотами и лимитами](../concepts/limits.md#mrd-limits).


    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите:
       * Облачную сеть для размещения кластера.
       * Группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.


   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** задайте конфигурацию хостов:

      * Чтобы изменить настройки отдельного хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке с его именем.

          * **{{ ui-key.yacloud.mdb.forms.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
          * **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}** — укажите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.
          * **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** — разрешает доступ к хосту из интернета, если кластер создается с включенной настройкой **{{ ui-key.yacloud.redis.field_tls-support }}**.
          * **{{ ui-key.yacloud.mdb.forms.host_column_replica-priority }}** — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * **{{ ui-key.yacloud.mdb.forms.host_column_shard-name }}** — позволяет изменить имя шарда для хоста. Поле доступно, только если кластер создается с включенной настройкой **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}**.

      * Чтобы добавить хосты в кластер, нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

      Если вы включили шардирование в кластере и выбрали тип диска **local-ssd**, добавьте не менее двух хостов на шард.

   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * В поле **{{ ui-key.yacloud.mdb.forms.config_field_password }}** укажите пароль пользователя.

         {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

      * Если требуется, задайте [настройки СУБД](../concepts/settings-list.md).

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** задайте дополнительные настройки кластера:

      {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mrd-name }}:


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
        --disk-type-id <network-ssd|network-ssd-nonreplicated|local-ssd> \
        --password=<пароль_пользователя> \
        --backup-window-start <время> \
        --deletion-protection \
        --announce-hostnames <использование_FQDN_вместо_IP-адресов>
      ```


      Где:
      * `--environment` — окружение: `prestable` или `production`.


      * `--host` — параметры хоста:
         * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
         * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
         * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
         * `replica-priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
      * `--disk-type-id` — тип диска.

         {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

      * `websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.


      * `--backup-window-start` — время начала резервного копирования в формате `ЧЧ:ММ:СС`.
      * `--deletion-protection` — защита от удаления кластера.

      * `--announce-hostnames` — настройка, определяющая, [использовать ли FQDN вместо IP-адресов](../concepts/network.md#fqdn-ip-setting): `true` или `false`.

        {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

      Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности создано 2 и больше подсетей.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Если вы создаёте шардированный кластер с типом диска **local-ssd**, укажите в команде не менее двух хостов на шард.

      {% note info %}

      По умолчанию при создании кластера устанавливается режим [технического обслуживания](../concepts/maintenance.md) `anytime` — в любое время. Вы можете установить конкретное время обслуживания при [изменении настроек кластера](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mrd-name }}:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * Кластер базы данных — описание кластера и его хостов. При необходимости здесь же можно задать [настройки СУБД](../concepts/settings-list.md).


       * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.
       * Подсети — описание [подсетей](../../vpc/concepts/network.md#network), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.


       Пример структуры конфигурационного файла для создания нешардированного кластера с поддержкой SSL:



       ```hcl
       resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
         name                = "<имя_кластера>"
         environment         = "<окружение>"
         network_id          = "<идентификатор_сети>"
         security_group_ids  = [ "<список_идентификаторов_групп_безопасности>" ]
         tls_enabled         = true
         deletion_protection = <защита_от_удаления>
         announce_hostnames  = <использование_FQDN_вместо_IP-адресов>

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
       * `announce_hostnames` — настройка, определяющая, [использовать ли FQDN вместо IP-адресов](../concepts/network.md#fqdn-ip-setting): `true` или `false`.

            {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

       * `version` — версия {{ RD }}: {{ versions.tf.str }}.
       * `host` — параметры хоста:
         * `zone_id` — зона доступности.
         * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
         * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
         * `replica_priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).

       {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

       {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

       Если вы создаёте шардированный кластер с типом диска **local-ssd**, укажите в конфигурационном файле не менее двух хостов на шард.

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
  * Флаг `announceHostnames`, который определяет, [использовать ли FQDN вместо IP-адресов](../concepts/network.md#fqdn-ip-setting) — `true` или `false`.

    {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

  * Настройки публичного доступа к хостам в параметре `hostSpecs[].assignPublicIp`.
  * Настройки доступа из [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) в параметре `configSpec.access.dataTransfer`.

  Если вы создаёте шардированный кластер с типом диска **local-ssd**, укажите в теле запроса не менее двух хостов на шард.

{% endlist %}


{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).

{% endnote %}


## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ RD }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ RD }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ RD }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ RD }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_redis_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ RD }} в переменную окружения:

        ```bash
        export REDIS_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../managed-redis/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ RD }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_redis_cluster.old ${REDIS_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id` и `status`.
        * В блоке `config` добавьте параметр `password`.
        * Если в блоке `config` указано значение параметра `notify_keyspace_events = "\"\""`, удалите этот параметр.
        * Если указано значение параметра `sharded = false`, в блоках `host` удалите параметры `shard_name`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия.

    1. В директории `imported-cluster` [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. В этой же директории [настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Проверьте корректность файлов конфигурации {{ TF }}:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

{% endlist %}

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
  * Один хост класса `{{ mrd-host-class }}` в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a` и группе безопасности с идентификатором `{{ security-group }}`, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`.
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
    --resource-preset {{ mrd-host-class }} \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
    --security-group-ids {{ security-group }} \
    --enable-tls \
    --disk-type-id {{ disk-type-example }} \
    --disk-size 16 \
    --password=user1user1 \
    --deletion-protection
  ```


- {{ TF }} {#tf}

  Создайте кластер {{ mrd-name }} и сеть для него с тестовыми характеристиками:

    * Имя `myredis`.
    * Версия `{{ versions.tf.latest }}`.
    * Окружение — `PRODUCTION`.
    * Облако с идентификатором `{{ tf-cloud-id }}`.
    * Каталог с идентификатором `{{ tf-folder-id }}`.
    * Новая сеть `mynet`.
    * Один хост класса `{{ mrd-host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
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
      resource_preset_id = "{{ mrd-host-class }}"
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
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```




{% endlist %}

### Создание шардированного кластера с одним шардом {#creating-a-single-shard-sharded-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте [шардированный](../concepts/sharding.md) кластер {{ mrd-name }} с тестовыми характеристиками:

  * Имя `myredis`.
  * Версия `{{ versions.cli.latest }}`.
  * Окружение `production`.
  * С включенным шардированием.
  * С поддержкой SSL-соединений.
  * С защитой от случайного удаления кластера.
  * Сеть `default`.
  * Группа безопасности с идентификатором `{{ security-group }}`.
  * Класс хостов `{{ mrd-host-class }}`.
  * Один хост в шарде `shard1`, в подсети `b0rcctk2rvtr********`, в зоне доступности `{{ region-id }}-a`, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
  * Пароль `user1user1`.

  Выполните следующую команду:


  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name myredis \
    --redis-version {{ versions.cli.latest }} \
    --environment production \
    --sharded \
    --enable-tls \
    --deletion-protection \
    --network-name default \
    --security-group-ids {{ security-group }} \
    --resource-preset {{ mrd-host-class }} \
    --host shard-name=shard1,subnet-id=b0rcctk2rvtr********,zone-id=ru-central1-a,assign-public-ip=true,replica-priority=50 \
    --disk-type-id {{ disk-type-example }} \
    --disk-size 16 \
    --password user1user1
  ```


- {{ TF }} {#tf}

  Создайте [шардированный](../concepts/sharding.md) кластер {{ mrd-name }} и сеть для него с тестовыми характеристиками:

  * Имя `myredis`.
  * Версия `{{ versions.cli.latest }}`.
  * Окружение `PRODUCTION`.
  * С включенным шардированием.
  * С поддержкой SSL-соединений.
  * С защитой от случайного удаления кластера.
  * Новая сеть `mynet`, которая будет состоять из одной подсети. Эта новая подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
  * Новая группа безопасности `redis-sg`, разрешающая подключения через порт `{{ port-mrd-tls }}` с любых адресов подсети `mysubnet`.
  * Класс хостов `{{ mrd-host-class }}`.
  * Один хост в шарде `shard1`, в подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`, с публичным доступом и [приоритетом хоста](../concepts/replication.md#master-failover) `50`.
  * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) размером 16 ГБ.
  * Пароль `user1user1`.

  Конфигурационный файл для такого кластера выглядит так:



  ```hcl
  resource "yandex_mdb_redis_cluster" "myredis" {
    name                = "myredis"
    environment         = "PRODUCTION"
    sharded             = true
    tls_enabled         = true
    deletion_protection = true
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
  
    config {
      version  = "{{ versions.tf.latest }}"
      password = "user1user1"
    }
  
    resources {
      resource_preset_id = "{{ mrd-host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }
  
    host {
      shard_name = "shard1"
      subnet_id  = yandex_vpc_subnet.mysubnet.id
      zone       = "ru-central1-a"
      assign_public_ip = true
      replica_priority = 50
    }
  }
  
  resource "yandex_vpc_network" "mynet" { name = "mynet" }
  
  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  
  resource "yandex_vpc_security_group" "redis-sg" {
    name       = "redis-sg"
    network_id = yandex_vpc_network.mynet.id
  
    ingress {
      description    = "Redis"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
  }
  ```



{% endlist %}

### Создание шардированного кластера с тремя шардами {#creating-a-sharded-cluster}


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
    * Три хоста класса `{{ mrd-host-class }}`, по одному в каждой подсети.
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
        resource_preset_id = "{{ mrd-host-class }}"
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
        subnet_id  = yandex_vpc_subnet.subnet-d.id
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
    }
    ```




{% endlist %}
