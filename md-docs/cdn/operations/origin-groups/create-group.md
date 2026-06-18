# Создание группы источников

Чтобы создать [группу источников](../../concepts/origins.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать группу источников.
  1. Перейдите в сервис **Cloud CDN**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Группы источников**.
  1. Нажмите кнопку **Создать группу источников**.
  1. Введите название группы источников.
  1. Настройте **Источники**:
     * Укажите **Тип источника**: `Сервер`, `Бакет` или `L7-балансировщик`. Подробнее о типах см. в разделе [Источники и их группы](../../concepts/origins.md).
     * Укажите источник.
     * Выберите **Приоритет**: `Основной` или `Резервный`. Подробнее о приоритетах см. в разделе [Группы источников](../../concepts/origins.md#groups).
     * Добавьте другие источники, если необходимо.
  1. Выберите провайдера CDN. Единственное возможное значение — `Yandex Cloud CDN`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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
     * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [Группы источников](../../concepts/origins.md#groups).

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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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
     * `provider_type` — провайдер CDN. Необязательный параметр. Единственное возможное значение: `ourcdn` — провайдер Yandex Cloud CDN.
     * `origin` — спецификация источника:
         * `source` — [IP-адрес](../../../vpc/concepts/address.md) или доменное имя источника.
         * `enabled` — флаг, указывающий, включен ли источник.
         * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах смотрите в разделе [Группы источников](../../concepts/origins.md#groups).
     
     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, смотрите в [документации провайдера](../../../terraform/resources/cdn_origin_group.md).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform создаст все требуемые ресурсы. Проверить создание CDN-ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc cdn origin-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/OriginGroup/create.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Create](../../api-ref/grpc/OriginGroup/create.md).

{% endlist %}