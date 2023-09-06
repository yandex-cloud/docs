# Удаление ресурса

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/basket.svg) **{{ ui-key.yacloud.common.delete }}** и в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ресурсов:

     ```bash
     yc cdn resource delete --help
     ```

  1. Получите список всех ресурсов в каталоге по умолчанию:

     ```bash
     yc cdn resource list --format yaml
     ```

     Результат:

     ```bash
     id: someidkfjqjfl325fw
     folder_id: somefolder7p3l5eobbd
     cname: testexample.com
     ...
     ssl_certificate:
       type: DONT_USE
       status: READY
     ```

  1. Удалите ресурс:

     ```bash
     yc cdn resource delete <идентификатор ресурса>
     ```

     Подробнее о команде `yc cdn resource delete`  см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/delete.md).
  1. Убедитесь, что удаление прошло успешно. Для этого снова посмотрите список ресурсов в каталоге:

     ```bash
     yc cdn resource list
     ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить CDN-ресурс, созданный с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием ресурса.

     {% cut "Пример описания CDN-ресурса в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_cdn_resource" "my_resource" {
         cname               = "cdn1.yandex-example.ru"
         active              = false
         origin_protocol     = "https"
         secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
         origin_group_id     = yandex_cdn_origin_group.my_group.id
         ...
         options {
           edge_cache_settings = "345600"
           ignore_cookie       = true
           ...
         }
     }
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить удаление CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc cdn resource list
     ```

- API

  Чтобы удалить ресурс, воспользуйтесь методом REST API [delete](../../api-ref/Resource/delete.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Delete](../../api-ref/grpc/resource_service.md#Delete).

{% endlist %}