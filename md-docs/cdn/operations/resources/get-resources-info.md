# Получение информации о ресурсе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [ресурс](../../concepts/resource.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите CDN-ресурс.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о ресурсе.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [ресурсе](../../concepts/resource.md):

      ```bash
      yc cdn resource get --help
      ```

  1. Получите информацию о ресурсе, указав его идентификатор или имя:
      
      ```bash
      yc cdn resource get <идентификатор_ресурса>
      ```

      Результат:

      ```text
      id: bc8v43fzihmv********
      folder_id: b1ggmp8es27t********
      cname: cdn-res-group.test.com
      created_at: "2023-10-25T11:18:13.630839Z"
      updated_at: "2023-10-25T11:18:13.630858Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "345600"
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        stale:
          enabled: true
          value:
          - error
          - updating
      origin_group_id: "27272********"
      origin_group_name: test-cdn-group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [ресурсе](../../concepts/resource.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_cdn_resource" "my_resource" {
        resource_id = "<идентификатор_ресурса>"
      }

      output "resource_active" {
        value = data.yandex_cdn_resource.my_resource.active
      }
      ```

      Где:

      * `data "yandex_cdn_resource"` — описание CDN-ресурса в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "resource_active"` — выходная переменная, которая содержит информацию о статусе активности CDN-ресурса:
         * `value` — возвращаемое значение.

     Вместо `active` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_cdn_resource` см. в [документации провайдера]({{ tf-provider-datasources-link }}/cdn_resource).

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

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      resource_active = true
      ```

- API {#api}

  Чтобы получить подробную информацию о [ресурсе](../../concepts/resource.md), воспользуйтесь методом REST API [get](../../api-ref/Resource/get.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Get](../../api-ref/grpc/Resource/get.md).

{% endlist %}

## Получение доменного имени {{ cdn-name }} провайдера {#get-cname}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится ресурс.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите созданный CDN-ресурс.
  1. На странице **{{ ui-key.yacloud.common.overview }}** в разделе **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** отобразится доменное имя вида `{{ cname-example-yc }}`.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о ресурсе с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_cdn_resource" "my_resource" {
        resource_id = "<идентификатор_ресурса>"
      }

      output "provider_cname" {
        value = data.yandex_cdn_resource.my_resource.provider_cname
      }
      ```

      Где:

      * `data "yandex_cdn_resource"` — описание CDN-ресурса в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "provider_cname"` — выходная переменная, которая содержит информацию о доменном имени:
         * `value` — возвращаемое значение.

     Вместо `provider_cname` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_cdn_resource` см. в [документации провайдера]({{ tf-provider-datasources-link }}/cdn_resource).

  1. Получите информацию о ресурсах:

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

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      provider_cname = "{{ cname-example-yc }}"
      ```

{% endlist %}