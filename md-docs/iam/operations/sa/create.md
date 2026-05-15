# Создание сервисного аккаунта

{% note warning %}

Создание сервисных аккаунтов может быть запрещено [политиками авторизации](../../concepts/access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

Создайте [сервисный аккаунт](../../concepts/users/service-accounts.md), чтобы управлять ресурсами от имени другой учетной записи.

Чтобы создать сервисный аккаунт, у вас должна быть [роль](../../security/index.md#iam-serviceAccounts-admin) `iam.serviceAccounts.admin` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

{% note info %}

Сервисный аккаунт создается внутри [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder). После создания сервисного аккаунта сменить каталог нельзя.

Сервисному аккаунту можно назначать роли на любые ресурсы в любом облаке, если эти ресурсы относятся к той же организации, что и сервисный аккаунт. Также сервисному аккаунту можно назначать роли на саму организацию.

{% endnote %}

## Создать сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта.
  
     Требования к формату имени:
  
     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.
  
     Имя сервисного аккаунта должно быть уникальным в рамках облака.
  
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды создания сервисного аккаунта:

      ```bash
      yc iam service-account create --help
      ```

  1. Создайте сервисный аккаунт с именем `my-robot`:

      ```bash
      yc iam service-account create --name my-robot
      ```

      Требования к формату имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

     Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в Terraform, см. в [документации провайдера](../../../terraform/resources/iam_service_account.md).
    
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

        После этого будет создан сервисный аккаунт. Проверить появление сервисного аккаунта можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
        
        ```bash
        yc iam service-account list
        ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../api-ref/grpc/ServiceAccount/create.md).

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

- Terraform {#tf}

  ```hcl
   resource "yandex_iam_service_account" "sa" {
     name        = "my-robot"
     description = "this is my favorite service account"
   }
  ```

- API {#api}

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{
      "folderId": "b1gvmob95yys********",
      "name": "my-robot",
      "description": "this is my favorite service account"
    }' \
    https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts
  ```

{% endlist %}

#### См. также {#see-also}

* [Получение списка сервисных аккаунтов каталога](list-get.md)
* [Назначение роли сервисному аккаунту](assign-role-for-sa.md)
* [Настройка прав доступа к сервисному аккаунту](set-access-bindings.md)
* [Ключи сервисного аккаунта](../../concepts/users/service-accounts.md#sa-key)