# Доступ в бакет с помощью сервисного подключения из {{ vpc-full-name }}

{% note warning %}

Функциональность **Сервисные подключения** (VPC Private Endpoints) находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Вы можете организовать прямой доступ к бакетам {{ objstorage-name }} из облачных сетей {{ vpc-short-name }} с помощью [сервисного подключения {{ vpc-short-name }}](../../../vpc/concepts/private-endpoint.md). При таком подключении сервис {{ objstorage-name }} будет доступен по [внутренним IP-адресам](../../../vpc/concepts/address.md#internal-addresses) {{ vpc-short-name }} без использования доступа в интернет.

Чтобы организовать доступ в бакет с помощью сервисного подключения из {{ vpc-short-name }}:
1. [Создайте сервисное подключение {{ vpc-short-name }}](#create-endpoint).
1. [Настройте политику доступа для бакета](#setup-policy).
1. [Настройте ограничение для доступа только из сервисных подключений](#setup-service-restriction).

## Создайте сервисное подключение {{ vpc-short-name }} {#create-endpoint}

Для создания сервисного подключения необходима одна из следующих [ролей](../../../vpc/security/index.md#roles-list): 

* `vpc.privateEndpoints.editor`
* `vpc.privateEndpoints.admin`
* `vpc.privateAdmin`
* `vpc.admin`
* `admin`

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы хотите настроить сервисное подключение.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.vpc.switch_private-endpoints }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.private-endpoint.label_create-private-endpoint }}**.
  1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_name }}** укажите название сервисного подключения. Требования к названию:
  
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
  
  1. (Опционально) В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_description }}** добавьте описание.
  1. (Опционально) Добавьте [метки](../../concepts/tags.md):
  
     1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
     1. Введите метку в формате `ключ: значение`.
     1. Нажмите **Enter**.
  
  1. В блоке **{{ ui-key.yacloud.vpc.private-endpoint.label_network-section }}**:
  
     1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_network }}** укажите сеть, для которой хотите создать сервисное подключение.
     1. Чтобы назначить случайный приватный IP-адрес, в поле **{{ ui-key.yacloud.vpc.private-endpoint.field_address-type }}** выберите `{{ ui-key.yacloud.vpc.private-endpoint.label_address-type_auto }}`.
     1. Чтобы зарезервировать список адресов:
     
        1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_address-id }}** выберите `{{ ui-key.yacloud.vpc.private-endpoint.label_address-type_list }}`.
        1. Нажмите **Зарезервировать**.
        1. В открывшемся окне:
  
           * Укажите имя и описание IP-адреса.
           * Выберите [подсеть](../../../vpc/concepts/network.md#subnet).
           * Назначьте внутренний IPv4-адрес, например `172.16.0.3`.
           * Активируйте опцию **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**, чтобы адрес нельзя было удалить, пока вы не выключите защиту.
           * Добавьте метки.
           * Нажмите **{{ ui-key.yacloud.common.create }}**.
           * Повторите шаги для резервирования дополнительных IP-адресов.
  
     1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_service }}** выберите **{{ ui-key.yacloud.vpc.private-endpoint.label_endpoint-service_object-storage }}**.
     1. (Опционально) Активируйте опцию **{{ ui-key.yacloud.vpc.private-endpoint.label_dns-field-text }}**, чтобы при включении создать дополнительную DNS-запись A-типа для публичного [FQDN сервиса](../../../vpc/concepts/address.md#fqdn). В ней будет указан внутренний IP-адрес, выделенный для сервисного подключения.
  
        В зависимости от того, применен ли параметр, будут автоматически созданы следующие ресурсные записи для доступа в {{ objstorage-name }}:
        * параметр не используется:
        
          Имя | Тип | Значение
          --- | --- | ---
          storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
          *.storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
        
        * параметр используется:
        
          Имя | Тип | Значение
          --- | --- | ---
          storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
          *.storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
          {{ s3-storage-host }} | A | <внутренний_IP-адрес_сервисного_подключения>
          *.{{ s3-storage-host }} | A | <внутренний_IP-адрес_сервисного_подключения>
  
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды CLI для создания сервисного подключения:
  
      ```bash
      yc vpc private-endpoint create --help
      ```
  
  1. Создайте сервисное подключение к {{ objstorage-short-name }} в каталоге по умолчанию:
  
      ```bash
      yc vpc private-endpoint create \
        --name <имя_сервисного_подключения> \
        --description "<описание_сервисного_подключения>" \
        --network-name <имя_сети> \
        --object-storage 
      ```
  
      Где:
  
      * `--name` — (опционально) имя сервисного подключения.
      * `--description` — (опционально) описание сервисного подключения.
      * `--network-name` — имя [облачной сети](../../../vpc/concepts/network.md#network), в которой будет создано сервисное подключение. Также вы можете использовать [идентификатор сети](../../../vpc/operations/network-get-info.md) в параметре `--network-id`.
      * `--object-storage` — сервисное подключение к {{ objstorage-short-name }}. Другие типы сервисных подключений пока не доступны.
  
      При создании сервисного подключения можно использовать дополнительные параметры:
  
      * `--address-spec` — (опционально) параметры в формате `ключ=значение` для внутреннего IP-адреса, который будет назначен сервисному подключению:
        * `address` — (опционально) внутренний IP-адрес для сервисного подключения. Если IP-адрес не указан, он будет назначен случайно из диапазона указанной подсети.
        * `subnet-id` — (опционально) [идентификатор подсети](../../../vpc/operations/subnet-get-info.md), из которой будет взят IP-адрес для сервисного подключения. Если подсеть не указана, внутренний IP-адрес будет назначен случайно из диапазона одной из подсетей облачной сети.
  
          {% note info %}
  
          Чтобы создать сервисное подключение, в вашей сети должна быть хотя бы одна подсеть.
  
          {% endnote %}
  
      * `--private-dns-records-enabled` — (опционально) параметр для создания дополнительных [ресурсных записей](../../../dns/concepts/resource-record.md) в DNS для переопределения публичного FQDN сервиса, к которому создается подключение.
  
        В зависимости от того, применен ли параметр, будут автоматически созданы следующие ресурсные записи для доступа в {{ objstorage-name }}:
        * параметр не используется:
        
          Имя | Тип | Значение
          --- | --- | ---
          storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
          *.storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
        
        * параметр используется:
        
          Имя | Тип | Значение
          --- | --- | ---
          storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
          *.storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
          {{ s3-storage-host }} | A | <внутренний_IP-адрес_сервисного_подключения>
          *.{{ s3-storage-host }} | A | <внутренний_IP-адрес_сервисного_подключения>
  
  1. Проверьте, что сервисное подключение создалось:
  
      ```bash
      yc vpc private-endpoint list
      ```
      
      Результат выполнения команды:
  
      ```text
      +----------------------+-------------+--------------------------------+
      |          ID          |    NAME     |          DESCRIPTION           |
      +----------------------+-------------+--------------------------------+
      | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
      |                      |             | Storage                        |
      +----------------------+-------------+--------------------------------+
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.
  
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:
  
     ```hcl
     resource "yandex_vpc_private_endpoint" "my-vpc-endpoint" {
       name        = "<имя_сервисного_подключения>"
       description = "<описание_сервисного_подключения>"
       network_id  = "<идентификатор_облачной_сети>"
       
       # Сервисное подключение к Object Storage
       object_storage {}
  
       # Создание дополнительных ресурсных DNS-записей 
       dns_options {
         private_dns_records_enabled = <true_или_false>
       }
  
       endpoint_address {
         subnet_id = "<идентификатор_подсети>"
       }
     }
     ```
  
     Где:
     * `name` — имя сервисного подключения. Необязательный параметр.
     * `description` — описание сервисного подключения. Необязательный параметр.
     * `network_id` — имя [облачной сети](../../../vpc/concepts/network.md#network), в которой будет создано сервисное подключение. Обязательный параметр.
     * `object_storage` — сервисное подключение к {{ objstorage-short-name }}. Другие типы сервисных подключений пока не доступны.
     * `dns_options` — блок с параметрами создания DNS-записей:
         * `private_dns_records_enabled` — параметр для создания дополнительных ресурсных записей в DNS для переопределения публичного FQDN сервиса, к которому создается подключение. Необязательный параметр.
  
             В зависимости от того, применен ли параметр, будут автоматически созданы следующие ресурсные записи для доступа в {{ objstorage-name }}:
             * параметр не используется:
             
               Имя | Тип | Значение
               --- | --- | ---
               storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
               *.storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
             
             * параметр используется:
             
               Имя | Тип | Значение
               --- | --- | ---
               storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
               *.storage.pe.yandexcloud.net | A | <внутренний_IP-адрес_сервисного_подключения>
               {{ s3-storage-host }} | A | <внутренний_IP-адрес_сервисного_подключения>
               *.{{ s3-storage-host }} | A | <внутренний_IP-адрес_сервисного_подключения>
  
     * `endpoint_address` — блок с параметрами внутреннего IP-адреса сервисного подключения:
         * `subnet_id` — идентификатор подсети, из которой будет взят IP-адрес для сервисного подключения. Если подсеть не указана, внутренний IP-адрес будет назначен случайным образом из диапазона одной из подсетей облачной сети. Необязательный параметр.
  
        {% note info %}
  
        Чтобы создать сервисное подключение, в вашей сети должна быть хотя бы одна подсеть.
  
        {% endnote %}
  
     Более подробную информацию о параметрах ресурса `yandex_vpc_private_endpoint` см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_private_endpoint).
  
  1. Создайте ресурсы:
  
     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
  
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):
  
     ```bash
     yc vpc private-endpoint list
     ```

- API {#api}

  Чтобы создать сервисное подключение {{ vpc-short-name }}, воспользуйтесь методом REST API [create](../../../vpc/privatelink/api-ref/PrivateEndpoint/create.md) для ресурса [PrivateEndpoint](../../../vpc/privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Create](../../../vpc/privatelink/api-ref/grpc/PrivateEndpoint/create.md).

{% endlist %}

Сохраните идентификатор сервисного подключения.

Теперь бакеты {{ objstorage-name }} доступны по внутреннему IP-адресу {{ vpc-short-name }} без использования доступа в интернет.

## Настройте политику доступа для бакета {#setup-policy}

Чтобы разрешить доступ к бакету только по внутренним IP-адресам {{ vpc-short-name }}, настройте для бакета политику доступа для сервисного подключения.

{% note info %}

На уровне [политики доступа](../../concepts/policy.md) можно разрешить доступ в бакет из сервисных подключений {{ vpc-short-name }} с идентификаторами, указанными в политике. Однако, согласно [схеме механизмов доступа](../../security/overview.md#scheme), все еще остается возможность доступа в бакет из публичной сети, например с помощью [ACL](../../concepts/acl.md) объекта или при наличии другого разрешающего правила в политике.

Также при такой настройке остается возможность [копирования объектов на стороне сервера (Server Side Copy)](../objects/copy.md) в такой бакет и из него.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы настроили сервисное подключение {{ vpc-short-name }}.
  1. Перейдите в сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** в меню слева.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_policy }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.policy.button_policy-edit }}**.
  1. Введите идентификатор политики доступа, например `private-endpoint-policy`.
  1. Настройте правило:

      1. Введите идентификатор правила, например `private-endpoint-rule`.
      1. Настройте параметры правила:
          * **{{ ui-key.yacloud.storage.bucket.policy.field_effect }}** — разрешить.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_principal-type }}** — включить пользователей.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_user }}** — все пользователи.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_action }}** — выберите опцию **Все действия**.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_resource }}** — `<имя_бакета>/*`.

            Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.policy.button_add-resource }}** и введите `<имя_бакета>`.

            {% note info %}

            Ресурс бакета не включает в себя ресурсы всех его объектов. Чтобы правило в политике доступа относилось к бакету и всем объектам, их нужно указать как отдельные ресурсы: например, `samplebucket` и `samplebucket/*`.

            {% endnote %}

      1. Добавьте [условие](../../s3/api-ref/policy/conditions.md) для правила:

          * В поле **{{ ui-key.yacloud.storage.bucket.policy.field_key }}** выберите `private-endpoint-id`.
          * В поле **{{ ui-key.yacloud.storage.bucket.policy.field_operator }}** выберите `StringEquals`.
          * В поле **{{ ui-key.yacloud.storage.bucket.policy.field_value }}** укажите идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения настроек бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../s3/api-ref/policy/scheme.md) формата JSON:

      ```json
      {
        "Version": "2012-10-17",
        "Statement": {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "*",
          "Resource": [
            "arn:aws:s3:::<имя_бакета>/*",
            "arn:aws:s3:::<имя_бакета>"
          ],
          "Condition": {
            "StringEquals": {
              "yc:private-endpoint-id": "<идентификатор_подключения>"
            }
          }
        }
      }
      ```
      
      Где:
      
      * `<имя_бакета>` — имя бакета в {{ objstorage-name }}, к которому нужно применить политику доступа, например `my-s3-bucket`.
      * `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

  1. Сохраните готовую конфигурацию в файле `policy.json`.
  1. Выполните команду:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --policy-from-file <путь_к_файлу_с_политикой>
      ```

      После успешного применения политики доступа подключение к бакету будет возможно только из облачной сети {{ vpc-short-name }}, в которой было создано соответствующее сервисное подключение (Private Endpoint).

- AWS CLI {#aws-cli}

  {% note info %}

  Для управления политикой доступа с помощью AWS CLI сервисному аккаунту должна быть назначена [роль](../../security/index.md#storage-admin) `storage.admin`.

  {% endnote %}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../s3/api-ref/policy/scheme.md) формата JSON:

      ```json
      {
        "Version": "2012-10-17",
        "Statement": {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "*",
          "Resource": [
            "arn:aws:s3:::<имя_бакета>/*",
            "arn:aws:s3:::<имя_бакета>"
          ],
          "Condition": {
            "StringEquals": {
              "yc:private-endpoint-id": "<идентификатор_подключения>"
            }
          }
        }
      }
      ```
      
      Где:
      
      * `<имя_бакета>` — имя бакета в {{ objstorage-name }}, к которому нужно применить политику доступа, например `my-s3-bucket`.
      * `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

  1. Сохраните готовую конфигурацию в файле `policy.json`.

  1. Выполните команду:

      ```bash
      aws s3api put-bucket-policy \
        --endpoint https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --policy file://policy.json
      ```

  После успешного применения политики доступа подключение к бакету будет возможно только из облачной сети {{ vpc-short-name }}, в которой было создано соответствующее сервисное подключение (Private Endpoint).

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  По умолчанию для аутентификации в {{ objstorage-name }} {{ TF }} использует IAM-токен. Кроме IAM-токена для аутентификации в {{ objstorage-name }} можно использовать сервисный аккаунт и статические ключи доступа. Более подробную информацию об особенностях аутентификации {{ TF }} в {{ objstorage-name }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).

  {% note info %}
  
  Если вы работаете с {{ objstorage-name }} через {{ TF }} от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  1. Откройте файл конфигурации {{ TF }} и задайте политику с помощью ресурса `yandex_storage_bucket_policy`:

     ```hcl
     resource "yandex_storage_bucket_policy" "bpolicy" {
       bucket = "my-policy-bucket"
       policy = <<POLICY
     {
       "Version": "2012-10-17",
       "Statement": {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "*",
         "Resource": [
           "arn:aws:s3:::<имя_бакета>/*",
           "arn:aws:s3:::<имя_бакета>"
         ],
         "Condition": {
           "StringEquals": {
             "yc:private-endpoint-id": "<идентификатор_подключения>"
           }
         }
       }
     }
     POLICY
     }
     ```

     Где:
     * `<имя_бакета>` — имя бакета в {{ objstorage-name }}, к которому нужно применить политику доступа, например `my-s3-bucket`.
     * `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket_policy` см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket_policy).

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы настроить политику доступа для бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md) или методом S3 API [PutBucketPolicy](../../s3/api-ref/policy/put.md). Если ранее для бакета уже была настроена политика доступа, то после применения новой политики она будет полностью перезаписана.

{% endlist %}

Подробная информация о работе с политикой доступа бакета изложена на странице [Управление политикой доступа](policy.md).

## Настройте ограничение для доступа только из сервисных подключений {#setup-service-restriction}

Вы можете ограничить доступ в бакет на уровне сервиса, тогда доступ к бакету будет возможен только из сервисных подключений {{ vpc-short-name }}.

{% note warning %}

После включения данной опции доступ в бакет из публичной сети будет невозможен. Доступ в бакет с помощью [консоли управления]({{ link-console-main }}) можно включить отдельной опцией. См. также [Особенности копирования объектов на стороне сервера (Server Side Copy)](#server-side-copy).

{% endnote %}

### Разрешить доступ в бакет только из сервисных подключений {{ vpc-short-name }} на уровне сервиса {#enable-service-restriction}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы настроили сервисное подключение {{ vpc-short-name }}.
  1. Перейдите в сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. В блоке **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_label-strict-mode_2ttnd }}** активируйте опцию **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_description-strict-mode_9cpMe }}**.
  1. В поле **{{ ui-key.yacloud.storage.form.Service_onnectionsField.field_lable-service-connections_iGyHa }}** укажите идентификатор созданного сервисного подключения.
  1. (Опционально) Активируйте опцию **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_force-cloud-console-access_5bS8y }}**. Опция позволяет при включенном доступе только через сервисные подключения {{ vpc-short-name }} работать с бакетом с помощью консоли управления. При отключенной опции доступ к бакету остается только через API и CLI.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте дополнительные [ресурсные записи](../../../dns/concepts/resource-record.md) в DNS для переопределения публичного FQDN сервиса, к которому создается подключение. Для этого включите специальный параметр сервисного подключения {{ vpc-short-name }}:
  
      ```bash
      yc vpc private-endpoint update \
        --id <идентификатор_сервисного_подключения> \
        --private-dns-records-enabled
      ```

  1. Измените настройки бакета, указав параметры для включения доступа только из сервисных подключений {{ vpc-short-name }}:
  
      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --enable-private-endpoints true \
        --private-endpoints <идентификатор_сервисного_подключения> \
        --private-endpoints-force-cloudconsole-access true
      ```

      Где:
      * `--name` — имя бакета.
      * `--enable-private-endpoints` — параметр для включения доступа к бакету только из сервисных подключений {{ vpc-short-name }}. Если параметр не указан, доступ к бакету будет возможен как из публичной сети, так и из сервисных подключений {{ vpc-short-name }}.
      * `--private-endpoints` — список идентификаторов сервисных подключений {{ vpc-short-name }}, доступ из которых будет разрешен.

        {% note warning %}

        Если идентификаторы сервисных подключений {{ vpc-short-name }} не указаны, доступ к бакету будет невозможен отовсюду. Однако останется возможность [выключить](#disable) ограничения на доступ только из сервисных подключений {{ vpc-short-name }}.

        {% endnote %}

      * `--private-endpoints-force-cloudconsole-access` — (опционально) параметр для включения доступа к бакету с помощью консоли управления при включенном доступе только через сервисные подключения {{ vpc-short-name }}. При отключенной опции доступ в бакет остается только через API и CLI.

- API {#api}

  Чтобы разрешить доступ в бакет только из сервисных подключений {{ vpc-short-name }} на уровне сервиса, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/grpc/Bucket/index.md) или вызовом gRPC API [Bucket/Update](../../api-ref/grpc/Bucket/update.md).

{% endlist %}

### Восстановить доступ к бакету из публичной сети {#disable}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы настроили сервисное подключение {{ vpc-short-name }}.
  1. Перейдите в сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. В блоке **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_label-strict-mode_2ttnd }}** деактивируйте опцию **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_description-strict-mode_9cpMe }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Измените настройки бакета:
  
  ```bash
  yc storage bucket update \
    --name <имя_бакета> \
    --enable-private-endpoints false    
  ```

  Где:
  * `--name` — имя бакета.
  * `--enable-private-endpoints` — параметр для включения доступа к бакету только из сервисных подключений {{ vpc-short-name }}.

    {% note tip %}

    После того как ограничение на доступ только из сервисных подключений {{ vpc-short-name }} снято, список сервисных подключений, переданный ранее в параметре `--private-endpoints`, сохраняется в настройках бакета. При повторном ограничении доступа нет необходимости передавать список еще раз.

    {% endnote %}

- API {#api}

  Чтобы разрешить доступ в бакет только из сервисных подключений {{ vpc-short-name }} на уровне сервиса, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/grpc/Bucket/index.md) или вызовом gRPC API [Bucket/Update](../../api-ref/grpc/Bucket/update.md).

{% endlist %}

### Копирование объектов на стороне сервера (Server Side Copy) {#server-side-copy}

Особенности [копирования объектов на стороне сервера (Server Side Copy)](../objects/copy.md) в бакетах с включенным доступом только из сервисных подключений {{ vpc-short-name }} приведены в таблице:

Бакет-источник | Бакет-приемник | Условие для запуска копирования на стороне сервера^1^
--- | --- | ---
Доступ только из сервисных подключений {{ vpc-short-name }} | Доступ только из сервисных подключений {{ vpc-short-name }} | Запрос из сервисного подключения, которое указано в списке разрешенных для обоих бакетов
Доступ только из сервисных подключений {{ vpc-short-name }} | Доступ из публичной сети | Запрос из сервисного подключения, которое указано в списке разрешенных для бакета-источника
Доступ из публичной сети | Доступ только из сервисных подключений {{ vpc-short-name }} | Запрос из сервисного подключения, которое указано в списке разрешенных для бакета-приемника
Доступ из публичной сети | Доступ из публичной сети | Запрос из публичной сети или из сервисного подключения

^1^ При наличии у клиента прав на чтение из бакета-источника и запись в бакет-приемник.

#### См. также {#see-also}

* [Сервисные подключения {{ vpc-short-name }}](../../../vpc/concepts/private-endpoint.md)
* [Работа с сервисными подключениями {{ vpc-short-name }}](../../../vpc/operations/index.md#private-endpoint)
* [Политика доступа (bucket policy)](../../concepts/policy.md)
* [Подключение к {{ objstorage-name }} из {{ vpc-name }}](../../tutorials/storage-vpc-access.md)
* [{#T}](../../security/overview.md)