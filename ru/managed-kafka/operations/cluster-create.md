# Создание кластера

Кластер {{ mkf-name }} — это один или несколько хостов-брокеров, на которых размещены топики и соответствующие топикам разделы. Производители и потребители могут работать с этими топиками, подключившись к хостам кластера.

Количество хостов-брокеров, которые можно создать вместе с кластером {{ KF }}, зависит от выбранного [типа хранилища](../concepts/storage.md):

* При использовании хранилища на **локальных SSD-дисках** или на **нереплицируемых SSD-дисках** вы можете создать кластер из трех или более хостов-брокеров (минимум три брокера необходимо, чтобы обеспечить отказоустойчивость).
* При использовании хранилища на **сетевых HDD-дисках** или **сетевых SSD-дисках** вы можете добавить любое количество хостов-брокеров в пределах [текущей квоты](../concepts/limits.md).

После создания кластера в него можно добавить дополнительные брокеры, если для этого достаточно [ресурсов каталога](../concepts/limits.md).

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

## Как создать кластер {{ mkf-name }} {#create-cluster}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. В блоке **Базовые параметры**:
     1. Введите имя кластера и, при необходимости, его описание. Имя кластера должно быть уникальным в рамках каталога.
     1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mkf-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
     1. Выберите версию {{ KF }}.
     1. Чтобы управлять топиками через Admin API {{ KF }}:

         {% include [mkf-admin-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

         1. Включите настройку **Управление топиками через API**.
         1. После создания кластера [создайте учетную запись администратора](./cluster-accounts.md#create-account).
     1. Чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md), включите настройку **Реестр схем данных**.

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

  1. В блоке **Класс хоста** выберите платформу, тип хостов и класс хостов.

     Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты [брокеры {{ KF }}](../concepts/brokers.md). Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

     При [изменении класса хостов](cluster-update.md#change-resource-preset) для кластера меняются характеристики всех уже созданных экземпляров.

  1. В блоке **Хранилище**:
     * Выберите [тип хранилища](../concepts/storage.md):
       * либо более гибкое хранилище — на сетевых HDD-дисках (`network-hdd`), на сетевых SSD-дисках (`network-ssd`) или на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`);
       * либо более быстрое хранилище — на локальных SSD-дисках (`local-ssd`).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}
      
     * Выберите объем хранилища, который будет использоваться для данных.

  1. В блоке **Сетевые настройки**:
     
     1. Выберите одну или несколько [зон доступности](../../overview/concepts/geo-scope.md), в которых нужно разместить брокеры {{ KF }}.
     1. Выберите [сеть](../../vpc/concepts/network.md).
     1. Выберите подсети в каждой зоне доступности для этой сети. Чтобы [создать новую подсеть](../../vpc/operations/subnet-create.md), нажмите на кнопку **Создать новую** рядом с нужной зоной доступности.
     

        {% note info %}

        Для кластера из нескольких хостов-брокеров нужно указать подсети в каждой зоне доступности, даже если вы планируете разместить брокеры только в некоторых из них. Эти подсети понадобятся для размещения трех хостов {{ ZK }} — по одному в каждой зоне доступности. Подробнее см. в разделе [Взаимосвязь ресурсов в {{ mkf-name }}](../concepts/index.md).

        {% endnote %}

     1. Выберите группы безопасности для сетевого трафика кластера.

     1. Для доступа к хостам-брокерам из интернета выберите опцию **Публичный доступ**. В этом случае подключаться к ним можно только с использованием SSL-соединения. Подробнее см. в разделе [{#T}](connect.md).

        {% note warning %}

        Запросить публичный доступ после создания кластера невозможно.

        {% endnote %}

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

      {% include [Дополнительные настройки кластера MKF](../../_includes/mdb/mkf/extra-settings.md) %}

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
         --version <версия: 2.1, 2.6 или 2.8> \
         --network-name <имя сети> \
         --brokers-count <количество брокеров в зоне> \
         --resource-preset <класс хоста> \
         --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
         --disk-size <размер хранилища в гигабайтах> \
         --assign-public-ip <публичный доступ> \
         --security-group-ids <список идентификаторов групп безопасности> \
         --deletion-protection=<защита от удаления кластера: true или false>
      ```

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

      При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

  1. Чтобы управлять топиками через Admin API {{ KF }}:

      {% include [mkf-topic-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

      1. Задайте значение `true` для параметра `--unmanaged-topics` при создании кластера:

          ```bash
          {{ yc-mdb-kf }} cluster create \
             ...
             --unmanaged-topics true
          ```

      1. После создания кластера [создайте учетную запись администратора](./cluster-accounts.md#create-account).

  
  1. Чтобы создать кластер, размещенный на группах [выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids` при создании кластера:

      ```bash
      {{ yc-mdb-kf }} cluster create \
         ...
         --host-group-ids <идентификаторы групп выделенных хостов>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}

- Terraform

    {% include [terraform-definition](../../_includes/tutorials/terraform-definition.md) %}

    
    Если у вас еще нет Terraform, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
            version          = "<версия Apache Kafka: 2.1, 2.6 или 2.8>"
            schema_registry  = "<управление схемами данных: true или false>"
            kafka {
              resources {
                disk_size          = <размер хранилища в гигабайтах>
                disk_type_id       = "<тип хранилища: network-ssd, network-hdd, network-ssd-nonreplicated или local-ssd>"
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

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

- API

    Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Идентификаторы групп безопасности в параметре `securityGroupIds`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    Чтобы управлять топиками через Admin API {{ KF }}:

    {% include [mkf-topic-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

    1. Передайте значение `true` для параметра `unmanagedTopics`.
    1. После создания кластера [создайте учетную запись администратора](./cluster-accounts.md#create-account).

    Чтобы управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md), передайте значение `true` для параметра `configSpec.schemaRegistry`.

    {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    
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

  Допустим, нужно создать кластер {{ mkf-name }} со следующими характеристиками:

  
  * С именем `mykf`.
  * В окружении `production`.
  * С {{ KF }} версии `2.6`.
  * В сети `{{ network-name }}`.
  * В группе безопасности `{{ security-group }}`.
  * С одним хостом класса `{{ host-class }}`, в зоне доступности `{{ zone-id }}`.
  * С одним брокером.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 10 ГБ.
  * С публичным доступом.
  * С защитой от случайного удаления кластера.

  Запустите следующую команду:

  
  ```bash
  {{ yc-mdb-kf }} cluster create \
     --name mykf \
     --environment production \
     --version 2.6 \
     --network-name {{ network-name }} \
     --zone-ids {{ zone-id }} \
     --brokers-count 1 \
     --resource-preset {{ host-class }} \
     --disk-size 10 \
     --disk-type {{ disk-type-example }} \
     --assign-public-ip \
     --security-group-ids {{ security-group }} \
     --deletion-protection=true
  ```

- Terraform

  Допустим, нужно создать кластер {{ mkf-name }} со следующими характеристиками:

    * В облаке с идентификатором `{{ tf-cloud-id }}`.
    * В каталоге с идентификатором `{{ tf-folder-id }}`.
    * С именем `mykf`.
    * В окружении `PRODUCTION`.
    * С {{ KF }} версии `2.6`.
    * В новой сети `mynet` с подсетью `mysubnet`.
    * В новой группе безопасности `mykf-sg`, разрешающей подключение к кластеру из интернета по порту `9091`.
    * С одним хостом класса `{{ host-class }}`, в зоне доступности `{{ zone-id }}`.
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
      zone      = "{{ zone-id }}"
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
        version          = "2.6"
        kafka {
          resources {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }

        zones = [
          "{{ zone-id }}"
        ]
      }
    }

    resource "yandex_vpc_network" "mynet" {
      name = "mynet"
    }

    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ zone-id }}"
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
