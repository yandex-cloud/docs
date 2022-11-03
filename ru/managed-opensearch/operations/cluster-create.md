---
title: Создание кластера Elasticsearch
description: "Кластер управляемого сервиса Elasticsearch — это группа из нескольких связанных друг с другом хостов Elasticsearch. При создании кластера Elasticsearch отдельно указываются параметры для хостов, выполняющих роль Master node, и отдельно — для хостов, выполняющих роль Data node."
keywords:
  - создание кластера Elasticsearch
  - кластер Elasticsearch
  - Elasticsearch
---

# Создание кластера

Кластер {{ mes-name }} — это группа из нескольких связанных друг с другом хостов {{ ES }}. Кластер обеспечивает высокую производительность поиска путем распределения задач поиска и индексации по всем хостам кластера с ролью _Data node_. Подробнее о ролях в кластере см. в разделе [{#T}](../concepts/hosts-roles.md).

{% note info %}

* Количество хостов с ролью _Data node_, которые можно создать вместе с {{ ES }}-кластером, зависит от выбранного {% if audience != "internal" %}[типа хранилища](../concepts/storage.md#storage-type-selection){% else %}[типа хранилища](../concepts/storage.md){% endif %} и [класса хостов](../concepts/instance-types.md#available-flavors).
* Доступные типы хранилища [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md#available-flavors).

{% endnote %}

## Создать кластер {#create-cluster}

{% note info %}

С 13 июня 2022 года прекращена поддержка [редакции](../concepts/es-editions.md) `Gold` в кластерах {{ mes-name}}. Создать новый кластер с этой редакцией невозможно.

{% endnote %}

При создании кластера отдельно указываются параметры для хостов, выполняющих роль _Master node_, и отдельно — для хостов, выполняющих роль _Data node_.

Допускается использовать только хосты с ролью _Data node_ и не создавать выделенные хосты для роли _Master node_: в этом случае хосты с ролью _Data node_ будут совмещать две роли.

{% list tabs %}

- Консоль управления

  Чтобы создать кластер:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
  1. Выберите сервис **{{ mes-name }}**.
  1. Нажмите кнопку **Создать кластер**.
  1. В блоке **Базовые параметры**:

     1. Введите имя кластера и, при необходимости, его описание. Имя кластера должно быть уникальным в рамках каталога.
     1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
        * `PRODUCTION` — для стабильных версий ваших приложений.
        * `PRESTABLE` — для тестирования, в том числе самого сервиса {{ mes-name }}. В Prestable-окружении раньше появляются новая функциональность, улучшения и исправления ошибок. При этом не все обновления обеспечивают обратную совместимость.
     1. Выберите из списка версию {{ ES }}.
     1. Выберите из списка [редакцию {{ ES }}](../concepts/es-editions.md).

  1. В блоке **Сетевые настройки** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](cluster-connect.md#configuring-security-groups) для того, чтобы можно было подключаться к кластеру.
  1. В блоке **Пользователь** укажите пароль для пользователя `admin`.

     {% include [mes-superuser](../../_includes/mdb/mes-superuser.md) %}

  1. Задайте конфигурацию хостов с ролью _Data node_, выбрав вкладку **Data node**:
     1. В блоке **Класс хоста** выберите платформу, тип хостов и класс хостов.

        Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ ES }}. Все доступные варианты перечислены в разделе [{#T}](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных экземпляров.

     1. В блоке **Хранилище**:

        * Выберите [тип хранилища](../concepts/storage.md).

            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

        * Выберите объем хранилища, который будет использоваться для данных.

     1. В блоке **Хосты** укажите конфигурацию хостов, создаваемых вместе с кластером:
        1. Чтобы добавить хост, нажмите кнопку **Добавить хост**.
        1. Чтобы изменить добавленный хост, наведите курсор на строку хоста и нажмите значок ![image](../../_assets/pencil.svg).

            При изменении хоста можно: {#change-data-node-settings}

            * Выбрать зону доступности и подсеть.
            * Включить публичный доступ.

                {% note warning %}

                Назначить публичный IP-адрес хосту после создания кластера невозможно.

                {% endnote %}

                Если для хоста {{ ES }} с ролью _Data node_ включен публичный доступ, к этому хосту или расположенной на нем Kibana можно подключиться через интернет. Подробнее см. в разделе [{#T}](cluster-connect.md).

                {% include [mes-tip-public-kibana](../../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

  1. При необходимости задайте конфигурацию хостов с ролью _Master node_, выбрав вкладку **Master node**:

     1. В блоке **Класс хоста** выберите платформу, тип хостов и класс хостов.
     1. В блоке **Хранилище** настройте хранилище по аналогии с хостами с ролью _Data node_.
     1. В блоке **Хосты** нажмите кнопку **Добавить хосты**. Будут добавлены три хоста. Чтобы изменить один из добавленных хостов, наведите курсор на строку хоста и нажмите значок ![image](../../_assets/pencil.svg).

        При изменении хоста можно: {#change-master-node-settings}

        * Выбрать зону доступности и подсеть.
        * Включить публичный доступ.

            {% note tip %}

            Не рекомендуется включать публичный доступ для хостов с ролью _Master node_, т. к. это может быть небезопасно.

            {% endnote %}

  1. При необходимости задайте дополнительные настройки кластера:

      {% include [Дополнительные настройки кластера MES](../../_includes/mdb/mes/extra-settings.md) %}

  1. При необходимости задайте [настройки СУБД](../concepts/settings-list.md).

  1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер:

    1. Проверьте, есть ли в каталоге подсети для хостов кластера:

        ```bash
        yc vpc subnet list
        ```

        {% if audience != "internal" %}
        
        Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-full-name }}.
        
        {% else %}
        
        Если ни одной подсети в каталоге нет, создайте нужные подсети в сервисе {{ vpc-full-name }}.
        
        {% endif %}

    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-mdb-es }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все параметры):

        ```bash
        {{ yc-mdb-es }} cluster create \
          --name <имя кластера> \
          --environment <окружение: prestable или production> \
          --network-name <имя сети> \
          --host zone-id=<зона доступности>,subnet-id=<идентификатор подсети>,assign-public-ip=<публичный доступ>,type=<тип хоста: datanode или masternode> \
          --datanode-resource-preset <класс хостов c ролью Data node> \
          --datanode-disk-size <размер хранилища в гигабайтах для хостов с ролью Data node> \
          --datanode-disk-type <тип хранилища для хостов с ролью Data node> \
          --masternode-resource-preset <класс хостов с ролью Master node> \
          --masternode-disk-size <размер хранилища в гигабайтах для хостов с ролью Master node> \
          --masternode-disk-type <тип хранилища для хостов с ролью Master node> \
          --security-group-ids <список идентификаторов групп безопасности> \
          --version <версия {{ ES }}: {{ versions.cli.str }}> \
          --edition <редакция {{ ES }}: basic или platinum> \
          --admin-password <пароль пользователя admin> \
          --plugins=<имя плагина 1>,...,<имя плагина N> \
          --deletion-protection=<защита от удаления кластера: true или false>
        ```

        Идентификатор подсети `subnet-id` необходимо указывать, если в выбранной зоне доступности больше одной подсети.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

    {% if audience != "internal" %}
    
    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    {% endif %}

    Чтобы создать кластер:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

        * Кластер базы данных — описание кластера и его хостов.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        Пример структуры конфигурационного файла:

        {% if product == "yandex-cloud" %}

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

        resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
          name        = "<имя кластера>"
          environment = "<окружение, PRESTABLE или PRODUCTION>"
          network_id  = "<идентификатор сети>"

          config {
            version = "<(необязательно) версия {{ ES }}: {{ versions.tf.str }}>"
            edition = "<(необязательно) редакция {{ ES }}: basic или platinum>"

            admin_password = "<пароль пользователя-администратора>"

            data_node {
              resources {
                resource_preset_id = "<класс хоста>"
                disk_type_id       = "<тип хранилища>"
                disk_size          = <объем хранилища, ГБ>
              }
            }

            master_node {
              resources {
                resource_preset_id = "<класс хоста>"
                disk_type_id       = "<тип хранилища>"
                disk_size          = <объем хранилища, ГБ>
              }
            }

            plugins = [ "<список имен плагинов>" ]

          }

          security_group_ids = [ "<список групп безопасности>" ]

          host {
            name = "<имя хоста>"
            zone = "<зона доступности>"
            type = "<роль хоста: DATA_NODE или MASTER_NODE>"
            assign_public_ip = <публичный доступ к хосту: true или false>
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

        {% endif %}

        {% if product == "cloud-il" %}

        ```hcl
        terraform {
          required_providers {
            yandex = {
              source = "yandex-cloud/yandex"
            }
          }
        }

        provider "yandex" {
          endpoint  = "{{ api-host }}:443"
          token     = "<статический ключ сервисного аккаунта>"
          cloud_id  = "<идентификатор облака>"
          folder_id = "<идентификатор каталога>"
          zone      = "<зона доступности>"
        }

        resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
          name        = "<имя кластера>"
          environment = "<окружение, PRESTABLE или PRODUCTION>"
          network_id  = "<идентификатор сети>"

          config {
            version = "<(необязательно) версия {{ ES }}: {{ versions.tf.str }}>"
            edition = "<(необязательно) редакция {{ ES }}: basic, gold или platinum>"

            admin_password = "<пароль пользователя-администратора>"

            data_node {
              resources {
                resource_preset_id = "<класс хоста>"
                disk_type_id       = "<тип хранилища>"
                disk_size          = <объем хранилища, ГБ>
              }
            }

            master_node {
              resources {
                resource_preset_id = "<класс хоста>"
                disk_type_id       = "<тип хранилища>"
                disk_size          = <объем хранилища, ГБ>
              }
            }

            plugins = [ "<список имен плагинов>" ]

          }

          security_group_ids = [ "<список групп безопасности>" ]

          host {
            name = "<имя хоста>"
            zone = "<зона доступности>"
            type = "<роль хоста: DATA_NODE или MASTER_NODE>"
            assign_public_ip = <публичный доступ к хосту: true или false>
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

        {% endif %}

        1. {% include [Maintenance window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

        Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

  Чтобы создать кластер, воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Версию {{ ES }} в параметре `configSpec.version`.
    * Редакцию {{ ES }} в параметре `configSpec.edition`.
    * Конфигурацию кластера в параметре `configSpec`, в том числе:
        * Класс хостов с ролью _Master node_ в параметре `configSpec.elasticsearchSpec.masterNode.resources`. Чтобы не создавать выделенных хостов с ролью _Master node_ — не задавайте значения для группы параметров `configSpec.elasticsearchSpec.masterNode`.
        * Класс хостов с ролью _Data node_ в параметре `configSpec.elasticsearchSpec.dataNode.resources`.
    * Конфигурацию хостов кластера в одном или нескольких параметрах `hostSpecs`.
    * Идентификатор сети в параметре `networkId`.
    * Идентификаторы групп безопасности в параметре `securityGroupIds`.
    * Список плагинов в параметре `configSpec.elasticsearchSpec.plugins`.
    * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}

{% endlist %}

{% note warning %}

Если вы указали идентификаторы групп безопасности при создании кластера, то для подключения к нему может потребоваться дополнительная [настройка групп безопасности](cluster-connect.md#configuring-security-groups).

{% endnote %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

    Чтобы создать кластер с одним хостом, передайте один параметр `--host`.

    Создайте кластер {{ mes-name }} с тестовыми характеристиками:

    * Имя `my-es-clstr`.
    * Версия `{{ versions.cli.latest }}`.
    * Редакция `Platinum`.
    * Окружение `PRODUCTION`.
    * Сеть `default`.
    * Группа безопасности с идентификатором `enpp2s8l3irhk5eromd7`.
    * Один публично доступный хост с ролью _Data node_ класса `{{ host-class }}` в подсети `{{ subnet-id }}`, в зоне доступности `{{ region-id }}-a`.
    * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
    * Пароль `esadminpwd` для пользователя `admin`.
    * Защита от случайного удаления кластера.

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
      --security-group-ids enpp2s8l3irhk5eromd7 \
      --version {{ versions.cli.latest }} \
      --edition platinum \
      --deletion-protection=true
    ```

- {{ TF }}

    Создайте кластер {{ mes-name }} с тестовыми характеристиками:

    * Имя `my-es-clstr`.
    * Версия `{{ versions.tf.latest }}`.
    * Редакция `Basic`.
    * Окружение `PRODUCTION`.
    * Облако с идентификатором `{{ tf-cloud-id }}`.
    * Каталог с идентификатором `{{ tf-folder-id }}`.
    * Новая сеть `mynet`.
    * Новая группа безопасности `es-sg`, разрешающая подключение к кластеру из интернета через порты 443 (Kibana) и 9200 ({{ ES }}).
    * Один публично доступный хост с ролью _Data node_ класса `{{ host-class }}` в новой подсети `mysubnet`, в зоне доступности `{{ region-id }}-a`. Подсеть `mysubnet` будет иметь диапазон `10.5.0.0/24`.
    * Хранилище на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
    * Пароль `esadminpwd` для пользователя `admin`.

    Конфигурационный файл для такого кластера выглядит так:

    {% if product == "yandex-cloud" %}

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

    resource "yandex_mdb_elasticsearch_cluster" "my-es-clstr" {
      name        = "my-es-clstr"
      environment = "PRODUCTION"
      network_id  = yandex_vpc_network.mynet.id

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
        name = "node"
        zone = "{{ region-id }}-a"
        type = "DATA_NODE"
        assign_public_ip = true
        subnet_id = yandex_vpc_subnet.mysubnet.id
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

    {% endif %}

    {% if product == "cloud-il" %}

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    }

    provider "yandex" {
      endpoint  = "{{ api-host }}:443"
      token     = "<статический ключ сервисного аккаунта>"
      cloud_id  = "{{ tf-cloud-id }}"
      folder_id = "{{ tf-folder-id }}"
      zone      = "{{ region-id }}-a"
    }

    resource "yandex_mdb_elasticsearch_cluster" "my-es-clstr" {
      name        = "my-es-clstr"
      environment = "PRODUCTION"
      network_id  = yandex_vpc_network.mynet.id

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
        name = "node"
        zone = "{{ region-id }}-a"
        type = "DATA_NODE"
        assign_public_ip = true
        subnet_id = yandex_vpc_subnet.mysubnet.id
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

    {% endif %}

{% endlist %}
