# Создать репозиторий

{% note info %}

[Репозиторий](../../concepts/repository.md) начнет отображаться только после [загрузки](../docker-image/docker-image-push.md) в него [Docker-образа](../../concepts/docker-image.md).

{% endnote %}

Чтобы создать репозиторий:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурса `yandex_container_repository`:

     ```hcl
     resource "yandex_container_registry" "my-registry" {
       name = "test-registry"
     }

     resource "yandex_container_repository" "my-repository" {
       name = "${yandex_container_registry.my-registry.id}/<имя_репозитория>"
     }

     output "my-registry-id" {
       value = yandex_container_registry.my-registry.id
     }

     output "my-repository-name" {
       value = yandex_container_repository.my-repository.name
     }
     ```

     Где `name` — имя репозитория в формате `<идентификатор_реестра>/<имя_репозитория>`. Вы можете получить идентификатор [реестра](../../concepts/registry.md) из [списка реестров в каталоге](../registry/registry-list.md#registry-list).

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/container_repository).
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
     yc container repository list --registry-id <идентификатор_реестра>
     ```

- API {#api}

  Чтобы создать репозиторий, воспользуйтесь методом REST API [upsert](../../api-ref/Repository/upsert.md) для ресурса [Repository](../../api-ref/Repository/index.md), или вызовом gRPC API [RepositoryService/Upsert](../../api-ref/grpc/Repository/upsert.md).

{% endlist %}