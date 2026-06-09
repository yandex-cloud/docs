# Удаление ресурса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.
  1. Перейдите в сервис **Cloud CDN**.
  1. Нажмите на имя необходимого ресурса.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить** и в открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления ресурсов:

     ```bash
     yc cdn resource delete --help
     ```

  1. Получите список всех ресурсов в каталоге по умолчанию:

     ```bash
     yc cdn resource list --format yaml
     ```

     Результат:

     ```text
     id: s0me1dkfjq********
     folder_id: s0mef01der7p********
     cname: testexample.com
     ...
     ssl_certificate:
       type: DONT_USE
       status: READY
     ```

  1. Удалите ресурс:

     ```bash
     yc cdn resource delete <идентификатор_ресурса>
     ```

     Подробнее о команде `yc cdn resource delete`  см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/delete.md).
  1. Убедитесь, что удаление прошло успешно. Для этого снова посмотрите список ресурсов в каталоге:

     ```bash
     yc cdn resource list
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить CDN-ресурс, созданный с помощью Terraform:
  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием ресурса.

     {% cut "Пример описания CDN-ресурса в конфигурации Terraform" %}

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

  1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.
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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить удаление CDN-ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc cdn resource list
     ```

- API {#api}

  Чтобы удалить ресурс, воспользуйтесь методом REST API [delete](../../api-ref/Resource/delete.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Delete](../../api-ref/grpc/Resource/delete.md).

{% endlist %}