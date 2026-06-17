# Изменение группы источников

## Редактирование группы {#editing-groups}

Чтобы изменить [группу источников](../../concepts/origins.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать группу ресурсов.
  1. Перейдите в сервис **Cloud CDN**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Группы источников**.
  1. Выберите группу, которую хотите отредактировать.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Внесите необходимые изменения.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для редактирования группы источников:

     ```bash
     yc cdn origin-group update --help
     ```

  1. Получите список всех групп источников в каталоге по умолчанию:

     ```bash
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```text
     - id: "90209"
       folder_id: b1g86q4m5vej********
       name: test-group-1
     ...
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```

  1. Измените параметры группы источников, указав ее идентификатор:

     ```bash
     yc cdn origin-group update --id <идентификатор_группы_источников> \
       --name <новое_имя_группы> \
       --origin source=<IP-адрес_или_доменное_имя_нового_источника>,enabled=true \
       --origin source=<IP-адрес_или_доменное_имя_нового_источника>,enabled=true,backup=true
     ```

     Где `--origin` — спецификация источника:
     * `source` — IP-адрес или доменное имя нового источника.
     * `enabled` — флаг, указывающий, включен ли источник.
     * `backup` — флаг, указывающий, является ли источник резервным.

     Результат:

     ```text
     id: "90209"
     folder_id: b1g86q4m5vej********
     name: test-group-22
     ...
       origin_group_id: "90209"
       source: www.site1.com
       enabled: true
     ```

     Подробнее о команде `yc cdn origin-group update` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/origin-group/update.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием ресурса `yandex_cdn_origin_group`:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

     ```bash
     yc cdn origin-group get <идентификатор_группы_источников>
     ```

- API {#api}

  Чтобы изменить группу источников, воспользуйтесь методом REST API [update](../../api-ref/OriginGroup/update.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Update](../../api-ref/grpc/OriginGroup/update.md).

{% endlist %}

## Удаление одного источника из группы {#group-source-deletion}

{% note info %}

Удалить можно только резервные источники.

{% endnote %}

Чтобы удалить источник из группы источников:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать группу ресурсов.
  1. Перейдите в сервис **Cloud CDN**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Группы источников** и нажмите на имя группы, из которой хотите удалить источник.
  1. Выберите нужный источник и нажмите кнопку **Удалить** на панели внизу.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Origin/delete.md) для ресурса [Origin](../../api-ref/Origin/index.md) или вызовом gRPC API [OriginService/Delete](../../api-ref/grpc/Origin/delete.md).

{% endlist %}

## Удаление нескольких источников из группы {#summ-group-source-deletion}

{% note info %}

Удалить можно только резервные источники.

{% endnote %}

Чтобы удалить несколько источников из группы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать группу ресурсов.
  1. Перейдите в сервис **Cloud CDN**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Группы источников** и нажмите на имя группы, из которой хотите удалить источники.
  1. Выберите нужные источники и нажмите кнопку **Удалить** на панели внизу.
  1. В открывшемся окне нажмите кнопку **Удалить**.

{% endlist %}