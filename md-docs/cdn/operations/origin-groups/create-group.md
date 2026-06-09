# Создание группы источников

Чтобы создать [группу источников](../../concepts/origins.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать группу источников.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_origins-group-create }}**.
  1. Введите название группы источников.
  1. Настройте **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
     * Укажите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).
     * Укажите источник.
     * Выберите **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.value_active }}` или `{{ ui-key.yacloud.cdn.value_backup }}`. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).
     * Добавьте другие источники, если необходимо.
  1. Выберите провайдера CDN. Единственное возможное значение — `{{ cdn-full-name }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для создания группы источников:

     ```bash
     yc cdn origin-group create --help
     ```

  1. Создайте группу источников в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc cdn origin-group create --name <имя_группы_источников> \
       --origin source=<IP-адрес_или_доменное_имя_источника>,enabled=true \
       --origin source=<IP-адрес_или_доменное_имя_источника>,enabled=true,backup=true
     ```

     Где `--origin` — спецификация [источника](../../concepts/resource.md):
     * `source` — [IP-адрес](../../../vpc/concepts/address.md) или доменное имя источника.
     * `enabled` — флаг, указывающий, включен ли источник.
     * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).

     Результат:

     ```text
     id: "89018"
     folder_id: b1g86q4m5vej********
     name: test-group
     use_next: true
     origins:
     - id: "559295"
       origin_group_id: "89018"
       source: www.example2.com
       enabled: true
       backup: true
     - id: "559294"
       origin_group_id: "89018"
       source: www.example1.com
       enabled: true
     ```

     Подробнее о команде `yc cdn origin-group create` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/origin-group/create.md).

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурса `yandex_cdn_origin_group`.

     ```hcl
     resource "yandex_cdn_origin_group" "my_group" {
       name          = "<имя_группы_источников>"
       use_next      = true
       provider_type = "<CDN-провайдер>"
       origin {
       source = "<IP-адрес_или_доменное_имя_источника_1>"
       }
       origin {
       source = "<IP-адрес_или_доменное_имя_источника_2>"
       }
       origin {
       source = "<IP-адрес_или_доменное_имя_источника_3>"
       backup = false
       }
     }
     ```
     
     Где:
     * `name` — имя группы источников.
     * `use_next` — указывает, использовать ли следующий [источник](../../concepts/resource.md) из списка.
     * `provider_type` — провайдер CDN. Необязательный параметр. Единственное возможное значение: `ourcdn` — провайдер {{ cdn-full-name }}.
     * `origin` — спецификация источника:
         * `source` — [IP-адрес](../../../vpc/concepts/address.md) или доменное имя источника.
         * `enabled` — флаг, указывающий, включен ли источник.
         * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).
     
     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_origin_group).

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

     {{ TF }} создаст все требуемые ресурсы. Проверить создание CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc cdn origin-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/OriginGroup/create.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Create](../../api-ref/grpc/OriginGroup/create.md).

{% endlist %}