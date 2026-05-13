# Удалить метку контейнера

{% list tabs group=instructions %}

- CLI {#cli}
    
    Чтобы удалить метку контейнера, выполните команду:

    ```
    yc serverless container remove-labels <имя_контейнера> --labels <ключ>
    ```

    Результат:

    ```
    id: flh7r96juaqq********
    folder_id: aoek6qrs8tjh********
    created_at: "2021-08-17T07:53:10.219Z"
    name: my-beta-container
    description: my beta container description
    url: https://flh7r96juaqq********.containers.yandexcloud.net/
    status: ACTIVE
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить метку контейнера, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и в ресурсе `yandex_serverless_container` удалите метку в блоке `labels`:
     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name   = "my first container with description"
       memory = 256
       image {
          url = "cr.yandex/yc/test-image:v1"
       }
       labels = {
          label1 = "new-label"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в Terraform, см. в [документации провайдера](../../terraform/resources/serverless_container.md).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить удаление метки для контейнера можно в [CLI](../../cli/index.md):

  ```
  yc serverless container get <имя_или_идентификатор_контейнера>
  ```

- API {#api}

  Чтобы удалить метку контейнера, воспользуйтесь методом REST API [update](../containers/api-ref/Container/update.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Update](../containers/api-ref/grpc/Container/update.md).

{% endlist %}