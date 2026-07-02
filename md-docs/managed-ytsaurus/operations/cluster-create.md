[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for YTsaurus](../index.md) > [Пошаговые инструкции](index.md) > Создание кластера

# Создание кластера YTsaurus

Каждый [кластер](../../glossary/cluster.md) Managed Service for YTsaurus состоит из набора компонентов YTsaurus.

Компоненты, доступные для настройки:
* exec- и tablet-ноды;
* хранилища;
* HTTP- и RPC-прокси.

Служебные компоненты, недоступные для настройки:
* master-ноды;
* storage-ноды;
* system-ноды.

## Роли для создания кластера {#roles}

Для создания кластера Managed Service for YTsaurus и работы с ним вашему аккаунту в Yandex Cloud нужны роли:

* [managed-ytsaurus.editor](../security/index.md#managed-ytsaurus-editor) или выше — чтобы создать кластер;
* [vpc.user](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
* [mdb.viewer](../../iam/roles-reference.md#mdb-viewer) — чтобы просматривать кластеры управляемых баз данных (MDB) на дашборде в [консоли управления](https://console.yandex.cloud).

О назначении ролей читайте в [документации Yandex Identity and Access Management](../../iam/operations/roles/grant.md).

## Создать кластер {#create-cluster}

{% note info %}

Создание кластера YTsaurus занимает длительное время. В зависимости от выбранной конфигурации время создания может занимать от одного часа.

{% endnote %}

В Managed Service for YTsaurus можно создать [Demo-кластер](#demo-cluster) с минимальной рабочей конфигурацией для ознакомления с сервисом или [Production-кластер](#production-cluster) с ручной настройкой конфигурации кластера. 

### Demo-кластер {#demo-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер Managed Service for YTsaurus.
    1. Перейдите в сервис **Managed Service for YTsaurus**.
    1. Нажмите кнопку **Создать кластер**.
    1. Выберите **Demo-кластер** для создания кластера с минимальной рабочей конфигурацией.
    1. В блоке **Базовые параметры**:
        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):
            1. Нажмите кнопку **Добавить метку**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
    
    1. В блоке **Сетевые настройки** выберите:
        * [Зону доступности](../../overview/concepts/geo-scope.md) для размещения кластера.
        * [Подсеть](../../vpc/operations/subnet-create.md).
        * (Опционально) [Группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера.
    
        {% note warning %}
           
        Сетевые настройки нельзя изменить после создания кластера.
           
        {% endnote %}
    
    1. В блоке **Конфигурация кластера** ознакомьтесь с параметрами конфигурации кластера.
    1. Нажмите кнопку **Создать**.
    1. Дождитесь, когда кластер будет готов к работе: его статус на панели Managed Service for YTsaurus сменится на **Running**. Это может занять продолжительное время.

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

    Чтобы создать кластер YTsaurus:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер YTsaurus — описание кластера.

        * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

        * Подсети — описание [подсетей](../../vpc/concepts/network.md#subnet), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_ytsaurus_cluster" "<имя_кластера>" {

          description        = "<описание_кластера>"
          name               = "<имя_кластера>"
          zone_id            = yandex_vpc_subnet.<имя_подсети>.zone
          subnet_id          = yandex_vpc_subnet.<имя_подсети>.id
          security_group_ids = [<список_идентификаторов_групп_безопасности>]

          spec = {
            storage = {
              hdd = {
                size_gb = 2048
                count   = 3
              }
              ssd = {
                size_gb = 465
                type    = "network-ssd-nonreplicated"
                count   = 3
              }
            }
            compute = [
              {
                preset = "c8-m32"
                disks = [
                  {
                    size_gb   = 93
                    type      = "network-ssd-nonreplicated"
                  }
                ]
                scale_policy = {
                  fixed = {
                    size = 3
                  }
                }
              }
            ]
            tablet = {
              preset = "c8-m16"
              count  = 3
            }
            proxy = {
              http = {
                count = 2
              }
              rpc = {
                count = 2
              }
            }
          }
        }

        resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

        resource "yandex_vpc_subnet" "<имя_подсети>" {
          name           = "<имя_подсети>"
          zone           = "<зона_доступности>"
          network_id     = yandex_vpc_network.<имя_сети>.id
          v4_cidr_blocks = ["<диапазон>"]
        }
        ```

        Где:

        * `description` — описание кластера.
        * `name` — имя кластера.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера YTsaurus:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска.
                    * `count` — количество дисков.

                {% note warning %}

                Тип и размер диска для кластера YTsaurus нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

        Подробная информация о ресурсах, которые вы можете создать с помощью Terraform, в [документации провайдера](../../terraform/resources/ytsaurus_cluster.md).

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте кластер YTsaurus.

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

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "zoneId": "<зона_доступности>",
          "subnetId": "<идентификатор_подсети>",
          "securityGroupIds": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "sizeGb": "2048",
                "count": "3"
              },
              "ssd": {
                "sizeGb": "465",
                "type": "network-ssd-nonreplicated",
                "count": "3"
              }
            },
            "compute": [
              {
                "preset": "c8-m32",
                "disks": [
                  {
                    "type": "network-ssd-nonreplicated",
                    "sizeGb": "93"
                  }
                ],
                "scalePolicy": {
                  "fixed": {
                    "size": "3"
                  }
                }
              }
            ],
            "tablet": {
              "preset": "c8-m16",
              "count": "3"
            },
            "proxy": {
              "http": {
                "count": "2"
              },
              "rpc": {
                "count": "2"
              }
            }
          }
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `securityGroupIds` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера YTsaurus:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `type` — тип диска.
                    * `count` — количество дисков.

                {% note warning %}

                Тип и размер диска для кластера YTsaurus нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска.
                    * `sizeGb` — размер диска в ГБ.

                * `scalePolicy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://ytsaurus.api.cloud.yandex.net/ytsaurus/v1/clusters'
            --data '@body.json'
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

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "zone_id": "<зона_доступности>",
          "subnet_id": "<идентификатор_подсети>",
          "security_group_ids": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "size_gb": "2048",
                "count": "3"
              },
              "ssd": {
                "size_gb": "465",
                "type": "network-ssd-nonreplicated",
                "count": "3"
              }
            },
            "compute": [
              {
                "preset": "c8-m32",
                "disks": [
                  {
                    "type": "network-ssd-nonreplicated",
                    "size_gb": "93"
                  }
                ],
                "scale_policy": {
                  "fixed": {
                    "size": "3"
                  }
                }
              }
            ],
            "tablet": {
              "preset": "c8-m16",
              "count": "3"
            },
            "proxy": {
              "http": {
                "count": "2"
              },
              "rpc": {
                "count": "2"
              }
            }
          }
        }
        ```

        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера YTsaurus:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска.
                    * `count` — количество дисков.

                {% note warning %}

                Тип и размер диска для кластера YTsaurus нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска.
                    * `size_gb` — размер диска в ГБ.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            ytsaurus.api.cloud.yandex.net:443 \
            yandex.cloud.ytsaurus.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

### Production-кластер {#production-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер Managed Service for YTsaurus.
    1. Перейдите в сервис **Managed Service for YTsaurus**.
    1. Нажмите кнопку **Создать кластер**.
    1. Выберите **Production-кластер** для создания кластера с ручной настройкой конфигурации.
    1. В блоке **Базовые параметры**:
        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):
            1. Нажмите кнопку **Добавить метку**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

    1. В блоке **Сетевые настройки** выберите:
       * [Зону доступности](../../overview/concepts/geo-scope.md) для размещения кластера.
       * [Подсеть](../../vpc/operations/subnet-create.md).
       * (Опционально) [Группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера.

       {% note warning %}
       
       Сетевые настройки нельзя изменить после создания кластера.
       
       {% endnote %}

    1. В блоке **Хранилище** нажмите кнопку **Добавить** и выберите тип, размер, количество дисков.

       От выбранного типа зависит, с каким шагом можно будет изменить размер диска:
          * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
          * Нереплицируемые SSD-диски — с шагом 93 ГБ.

       Хранилище с типом `HDD` является обязательным и добавлено по умолчанию. При необходимости отредактируйте количество и размер дисков.

       {% note warning %}
       
       Тип и размер диска для кластера YTsaurus нельзя изменить после создания.
       
       {% endnote %}
    
    1. В блоке **Конфигурация exec-нод** задайте:
       * количество нод;
       * [конфигурацию вычислительных ресурсов](../concepts/component-types.md#exec-node);
       * тип и размер хранилища, которое будет использоваться для выполнения заданий.

    1. В блоке **Конфигурация tablet-нод** задайте:
       * количество нод;
       * [конфигурацию вычислительных ресурсов](../concepts/component-types.md#tablet-node).

       Для использования tablet-нод необходимо добавить хранилище с типом `SSD` или `Нереплицируемый SSD`.

       {% note warning %}
       
       Количество tablet-нод нельзя изменить после создания кластера.
       
       {% endnote %}
    
    1. В блоках **Конфигурация HTTP** и **Конфигурация RPC** задайте количество прокси.

       {% note warning %}
       
       Количество proxy-нод нельзя изменить после создания кластера.
       
       {% endnote %}

    1. Нажмите кнопку **Создать**.
    1. Дождитесь, когда кластер будет готов к работе: его статус на панели Managed Service for YTsaurus сменится на **Running**. Это может занять продолжительное время.

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

    Чтобы создать кластер YTsaurus:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер YTsaurus — описание кластера.

        * Сеть — описание [облачной сети](../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

        * Подсети — описание [подсетей](../../vpc/concepts/network.md#subnet), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_ytsaurus_cluster" "<имя_кластера>" {

          description        = "<описание_кластера>"
          name               = "<имя_кластера>"
          zone_id            = yandex_vpc_subnet.<имя_подсети>.zone
          subnet_id          = yandex_vpc_subnet.<имя_подсети>.id
          security_group_ids = [<список_идентификаторов_групп_безопасности>]

          labels = {
            <список_меток>
          }

          spec = {
            storage = {
              hdd = {
                size_gb = <размер_диска_в_ГБ>
                count   = <количество_дисков>
              }
              ssd = {
                size_gb = <размер_диска_в_ГБ>
                type    = "<тип_диска>"
                count   = <количество_дисков>
              }
            }
            compute = [
              {
                preset = "<конфигурация_вычислительных_ресурсов>"
                disks = [
                  {
                    size_gb   = <размер_диска_в_ГБ>
                    type      = "<тип_диска>"
                  }
                ]
                scale_policy = {
                  fixed = {
                    size = <количество_exec-нод>
                  }
                }
                name = "default"
              }
            ]
            tablet = {
              preset = "<конфигурация_вычислительных_ресурсов>"
              count  = <количество_tablet-нод>
            }
            proxy = {
              http = {
                count = <количество_HTTP-прокси>
              }
              rpc = {
                count = <количество_RPC-прокси>
              }
            },
            odin = {
              checks_ttl = "<частота_проверок>"
            }
          }
        }

        resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

        resource "yandex_vpc_subnet" "<имя_подсети>" {
          name           = "<имя_подсети>"
          zone           = "<зона_доступности>"
          network_id     = yandex_vpc_network.<имя_сети>.id
          v4_cidr_blocks = ["<диапазон>"]
        }
        ```

        Где:

        * `description` — описание кластера.
        * `name` — имя кластера.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`.
        * `spec` — конфигурация компонентов кластера YTsaurus:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска: `network-ssd` или `network-ssd-nonreplicated`.
                    * `count` — количество дисков.

                От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                Наличие HDD-диска является обязательным.

                {% note warning %}

                Тип и размер диска для кластера YTsaurus нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска: `network-hdd`, `network-ssd` или `network-ssd-nonreplicated`.

                    От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                    * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                    * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.
                * `name` — имя exec-пула.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается с единицами измерения: `h` — часы, `m` — минуты, `s` — секунды. Например: `336h0m0s` (2 недели).

        Подробная информация о ресурсах, которые вы можете создать с помощью Terraform, в [документации провайдера](../../terraform/resources/ytsaurus_cluster.md).

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте кластер Managed Service for YTsaurus.

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

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "zoneId": "<зона_доступности>",
          "subnetId": "<идентификатор_подсети>",
          "securityGroupIds": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "sizeGb": "<размер_диска_в_ГБ>",
                "count": "<количество_дисков>"
              },
              "ssd": {
                "sizeGb": "<размер_диска_в_ГБ>",
                "type": "<тип_диска>",
                "count": "<количество_дисков>"
              }
            },
            "compute": [
              {
                "preset": "<конфигурация_вычислительных_ресурсов>",
                "disks": [
                  {
                    "type": "<тип_диска>",
                    "sizeGb": "<размер_диска_в_ГБ>"
                  }
                ],
                "scalePolicy": {
                  "fixed": {
                    "size": "<количество_exec-нод>"
                  }
                },
                "name": "default"
              }
            ],
            "tablet": {
              "preset": "<конфигурация_вычислительных_ресурсов>",
              "count": "<количество_tablet-нод>"
            },
            "proxy": {
              "http": {
                "count": "<количество_HTTP-прокси>"
              },
              "rpc": {
                "count": "<количество_RPC-прокси>"
              }
            },
            "odin": {
              "checksTtl": "<частота_проверок_в_секундах>"
            }
          }
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `securityGroupIds` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера YTsaurus:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `type` — тип диска: `network-ssd` или `network-ssd-nonreplicated`.
                    * `count` — количество дисков.

                От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                Наличие HDD-диска является обязательным.

                {% note warning %}

                Тип и размер диска для кластера YTsaurus нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска: `network-hdd`, `network-ssd` или `network-ssd-nonreplicated`.
                    * `sizeGb` — размер диска в ГБ.

                    От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                    * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                    * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                * `scalePolicy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.
                * `name` — имя exec-пула.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

            * `odin.checksTtl` — частота проверок внутреннего мониторинга Odin. Указывается в секундах (`s`). Например: `1209600s` (2 недели).

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://ytsaurus.api.cloud.yandex.net/ytsaurus/v1/clusters' \
            --data '@body.json'
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

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "zone_id": "<зона_доступности>",
          "subnet_id": "<идентификатор_подсети>",
          "security_group_ids": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "size_gb": "<размер_диска_в_ГБ>",
                "count": "<количество_дисков>"
              },
              "ssd": {
                "size_gb": "<размер_диска_в_ГБ>",
                "type": "<тип_диска>",
                "count": "<количество_дисков>"
              }
            },
            "compute": [
              {
                "preset": "<конфигурация_вычислительных_ресурсов>",
                "disks": [
                  {
                    "type": "<тип_диска>",
                    "size_gb": "<размер_диска_в_ГБ>"
                  }
                ],
                "scale_policy": {
                  "fixed": {
                    "size": "<количество_exec-нод>"
                  }
                },
                "name": "default"
              }
            ],
            "tablet": {
              "preset": "<конфигурация_вычислительных_ресурсов>",
              "count": "<количество_tablet-нод>"
            },
            "proxy": {
              "http": {
                "count": "<количество_HTTP-прокси>"
              },
              "rpc": {
                "count": "<количество_RPC-прокси>"
              }
            },
            "odin": {
              "checks_ttl": "<частота_проверок_в_секундах>"
            }
          }
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера YTsaurus:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска: `network-ssd` или `network-ssd-nonreplicated`.
                    * `count` — количество дисков.

                От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                Наличие HDD-диска является обязательным.

                {% note warning %}

                Тип и размер диска для кластера YTsaurus нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска: `network-hdd`, `network-ssd` или `network-ssd-nonreplicated`.
                    * `size_gb` — размер диска в ГБ.

                    От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                    * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                    * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.
                * `name` — имя exec-пула.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается в секундах (`s`). Например: `1209600s` (2 недели).

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            ytsaurus.api.cloud.yandex.net:443 \
            yandex.cloud.ytsaurus.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

{% list tabs group=instructions %}

- Terraform {#tf}

    Создайте кластер Managed Service for YTsaurus и сеть для него с тестовыми характеристиками:

    * Имя — `my-ytsaurus-cluster`.
    * Сеть — `my-network`.
    * Подсеть — `my-subnet`. Зона доступности подсети — `ru-central1-a`, диапазон — `10.1.0.0/16`.
    * Хранилище:

        * `4` HDD-диска, размер — `4096` ГБ.
        * `3` SSD-диска с типом `network-ssd`, размер — `512` ГБ.

    * Exec-ноды:

        * Количество нод — `5`.
        * [Конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node) — `c8-m32`.
        * Тип диска — `network-ssd`, размер — `512` ГБ.

    * Tablet-ноды:

        * Количество нод — `3`.
        * [Конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node) — `c8-m16`.

    * По `5` HTTP-прокси и RPC-прокси.

    Конфигурационный файл для такого кластера выглядит так:

    ```hcl
    resource "yandex_ytsaurus_cluster" "my-ytsaurus-cluster" {

      name               = "my-ytsaurus-cluster"
      zone_id            = yandex_vpc_subnet.my-subnet.zone
      subnet_id          = yandex_vpc_subnet.my-subnet.id

      spec = {
        storage = {
          hdd = {
            size_gb = 4096
            count   = 4
          }
          ssd = {
            size_gb = 512
            type    = "network-ssd"
            count   = 3
          }
        }
        compute = [
          {
            preset = "c8-m32"
            disks = [
              {
                size_gb   = 512
                type      = "network-ssd"
              }
            ]
            scale_policy = {
              fixed = {
                size = 5
              }
            }
          }
        ]
        tablet = {
          preset = "c8-m16"
          count  = 3
        }
        proxy = {
          http = {
            count = 5
          }
          rpc = {
            count = 5
          }
        }
      }
    }

    resource "yandex_vpc_network" "my-network" { name = "my-network" }

    resource "yandex_vpc_subnet" "my-subnet" {
      name           = "my-subnet"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.my-network.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }
    ```

{% endlist %}