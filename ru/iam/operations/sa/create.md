# Создание сервисного аккаунта

Создайте [сервисный аккаунт](../../concepts/users/service-accounts.md), чтобы управлять ресурсами от имени другой учетной записи.

{% note info %}

Сервисный аккаунт создается внутри [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder). После создания сервисного аккаунта сменить каталог нельзя.

{% include [sa-binding-roles](../../../_includes/iam/sa-binding-roles.md) %}

{% endnote %}

## Создать сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-sa-via-console-without-role](../../../_includes/iam/create-sa-via-console-without-role.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания сервисного аккаунта:

      ```bash
      yc iam service-account create --help
      ```

  1. Создайте сервисный аккаунт с именем `my-robot`:

      ```bash
      yc iam service-account create --name my-robot
      ```

      Требования к формату имени:

      {% include [name-format](../../../_includes/name-format.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
    
     ```hcl
     resource "yandex_iam_service_account" "sa" {
       name        = "<имя_сервисного_аккаунта>"
       description = "<описание_сервисного_аккаунта>"
       folder_id   = "<идентификатор_каталога>"
     }
     ```

     * `name` — имя сервисного аккаунта. Обязательный параметр.
     * `description` — описание сервисного аккаунта. Необязательный параметр.
     * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.

     Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account).
    
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание сервисного аккаунта: введите в терминал слово `yes` и нажмите **Enter**.

        После этого будет создан сервисный аккаунт. Проверить появление сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
        
        ```bash
        yc iam service-account list
        ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../api-ref/grpc/service_account_service.md#Create).

{% endlist %}


## Примеры {#examples}

### Добавить описание при создании {#add-description}

Создайте сервисный аккаунт с именем и описанием:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam service-account create --name my-robot \
    --description "this is my favorite service account"
  ```

- {{ TF }} {#tf}

  ```hcl
   resource "yandex_iam_service_account" "sa" {
     name        = "my-robot"
     description = "this is my favorite service account"
   }
  ```

- API {#api}

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{
          "folderId": "b1gvmob95yys********",
          "name": "my-robot",
          "description": "this is my favorite service account"
      }' \
      https://iam.{{ api-host }}/iam/v1/serviceAccounts
  ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](assign-role-for-sa.md).
* [{#T}](set-access-bindings.md).
* [{#T}](../../concepts/users/service-accounts.md#sa-key).
