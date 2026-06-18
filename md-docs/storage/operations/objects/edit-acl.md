# Редактирование ACL объекта

В Object Storage реализовано несколько механизмов для управления доступом к ресурсам. Алгоритм взаимодействия этих механизмов приведен в [Обзор способов управления доступом в Object Storage](../../security/overview.md).

Для управления доступом к объекту в бакете Object Storage можно воспользоваться [ACL](../../concepts/acl.md).

{% note info %}

Если ранее для объекта уже был задан [ACL](../../concepts/acl.md), то после применения изменений ACL будет полностью перезаписан.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Object Storage**.
    1. Выберите нужный бакет из списка.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Объекты** и найдите в списке нужный объект.
    1. Чтобы отредактировать ACL, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным объектом и выберите **ACL объекта**.

        Также можно нажать на имя объекта, на открывшейся странице справа сверху нажать ![image](../../../_assets/console-icons/ellipsis.svg) и выбрать **ACL объекта**.

        В открывшемся окне **Редактирование ACL** выдайте или отзовите необходимые разрешения:
        
        1. Выберите нужных [субъектов](../../../iam/concepts/access-control/index.md#subject) из списка. Для этого поместите курсор в поле для ввода данных субъекта и в появившейся форме выберите нужного [пользователя](../../../overview/roles-and-resources.md#users), [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), [группу пользователей](../../../organization/concepts/groups.md), [системную группу](../../../iam/concepts/access-control/system-group.md) или [публичную группу](../../../iam/concepts/access-control/public-group.md). При необходимости воспользуйтесь соответствующими вкладками формы или строкой поиска по имени или электронному адресу субъекта.
        
            Задать разрешение вы можете одновременно для нескольких субъектов, для этого выбирайте их поочередно.
        
        1. Задайте для выбранных субъектов необходимый [вид разрешений](../../concepts/acl.md#permissions-types) и нажмите **Добавить**.
        
        1. Если требуется задать субъектам другие виды разрешений, повторите два предыдущих шага.
        
        1. Чтобы отозвать выданное субъекту разрешение, нажмите **Отменить** в строке с этим разрешением.
        
        1. Нажмите кнопку **Сохранить**.

        {% note info %}
  
        В консоли управления разрешения можно выдать только тем сервисным аккаунтам, которые созданы в том же каталоге, что и сам бакет. Выдать разрешения для сервисных аккаунтов, относящихся к другим каталогам, можно с помощью Yandex Cloud CLI (только для ACL бакета), AWS CLI, Terraform или API.
  
        {% endnote %}

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  {% note info %}

  Чтобы управлять ACL объекта, назначьте аккаунту, от имени которого работает Yandex Cloud CLI, [роль](../../security/index.md#storage-admin) `storage.admin`.

  {% endnote %}


  Посмотрите текущий ACL объекта:

  ```bash
  yc storage s3api get-object-acl \
    --bucket <имя_бакета> \
    --key <ключ_объекта>
  ```

  Где:

  * `--bucket` — имя бакета.
  * `--key` — ключ объекта.

  Вы можете применить к объекту [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей Yandex Cloud). Эти настройки несовместимы: у объекта должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  _Предопределенный ACL_

  Выполните команду:

  ```bash
  yc storage s3api put-object-acl \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --acl <предопределенный_ACL>
  ```

  Где:

  * `--bucket` — имя бакета.
  * `--key` — ключ объекта.
  * `--acl` — предопределенный ACL. Список значений приведен в разделе [Предопределенные ACL](../../concepts/acl.md#predefined-acls).

  _Настройка отдельных разрешений_

  1. Чтобы выдать разрешения ACL для пользователя Yandex Cloud, сервисного аккаунта или группы пользователей, получите их идентификатор:

      * [Пользователь](../../../organization/operations/users-get.md).
      * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
      * Группа пользователей — перейдите на вкладку [**Группы**](https://center.yandex.cloud/organization/groups) в интерфейсе Cloud Center.

  1. Выполните команду:

      ```bash
      yc storage s3api put-object-acl \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        <тип_разрешения> <получатель_разрешения>
      ```

      Где:

      * `--bucket` — имя бакета.
      * `--key` — ключ объекта.
      * Возможные типы разрешений ACL:

          * `--grant-read` — доступ к чтению объекта.
          * `--grant-full-control` — полный доступ к объекту.
          * `--grant-read-acp` — доступ к чтению ACL объекта.
          * `--grant-write-acp` — доступ к редактированию ACL объекта.

          Вы можете задать несколько разрешений в одной команде.

      * Возможные получатели разрешений:

          * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
          * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей Yandex Cloud.
          * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — публичная группа всех пользователей интернета.

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  {% note info %}

  Чтобы управлять ACL объекта, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../../security/index.md#storage-admin) `storage.admin`.

  {% endnote %}


  Посмотрите текущий ACL объекта:

  ```bash
  aws s3api get-object-acl \
    --endpoint https://storage.yandexcloud.net \
    --bucket <имя_бакета> \
    --key <ключ_объекта>
  ```

  Где:
  * `--endpoint` — эндпоинт Object Storage.
  * `--bucket` — имя бакета.
  * `--key` — ключ объекта.

  Вы можете применить к объекту [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей Yandex Cloud). Эти настройки несовместимы: у объекта должен быть либо предопределенный ACL, либо набор отдельных разрешений.

  _Предопределенный ACL_

  Выполните команду:

  ```bash
  aws s3api put-object-acl \
    --endpoint https://storage.yandexcloud.net \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --acl <предопределенный_ACL>
  ```

  Где:

  * `--endpoint` — эндпоинт Object Storage.
  * `--bucket` — имя бакета.
  * `--key` — ключ объекта.
  * `--acl` — предопределенный ACL. Список значений приведен в разделе [Предопределенные ACL](../../concepts/acl.md#predefined-acls).

  _Настройка отдельных разрешений_

  1. Чтобы выдать разрешения ACL для пользователя Yandex Cloud, сервисного аккаунта или группы пользователей, получите их идентификатор:

      * [Пользователь](../../../organization/operations/users-get.md).
      * [Сервисный аккаунт](../../../iam/operations/sa/get-id.md).
      * Группа пользователей — перейдите на вкладку [**Группы**](https://center.yandex.cloud/organization/groups) в интерфейсе Cloud Center.

  1. Выполните команду:

      ```bash
      aws s3api put-object-acl \
        --endpoint https://storage.yandexcloud.net \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        <тип_разрешения> <получатель_разрешения>
      ```

        Где:
        * `--endpoint` — эндпоинт Object Storage.
        * `--bucket` — имя бакета.
        * `--key` — ключ объекта.
        * Возможные типы разрешений ACL:
          * `--grant-read` — доступ к чтению объекта.
          * `--grant-full-control` — полный доступ к объекту.
          * `--grant-read-acp` — доступ к чтению ACL объекта.
          * `--grant-write-acp` — доступ к редактированию ACL объекта.

          Вы можете задать несколько разрешений в одной команде.
        * Возможные получатели разрешений:
          * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
          * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей Yandex Cloud.
          * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — публичная группа всех пользователей интернета.

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}


  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.



  Чтобы отредактировать ACL объекта:

  1. Откройте файл конфигурации Terraform и добавьте параметр `acl` в описание объекта.

     ```hcl
     ...
     resource "yandex_storage_object" "cute-cat-picture" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "cat-pictures"
       key        = "cute-cat"
       source     = "/images/cats/cute-cat.jpg"
       acl        = "public-read"
     }
     ...
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.

        {% note info %}
        
        Кроме статических ключей доступа для аутентификации в Object Storage можно использовать IAM-токен. Подробнее смотрите в разделе [Создание бакета](../buckets/create.md) и в [документации провайдера](../../../terraform/resources/storage_object.md). 
        
        {% endnote %}

     * `secret_key` — значение секретного ключа доступа.
     * `acl` — [предопределенный ACL](../../concepts/acl.md#predefined-acls) объекта. Значение по умолчанию — `private`: пользователи Yandex Cloud получают разрешения в соответствии со своими ролями в IAM.

     Более подробная информация о параметрах ресурса `yandex_storage_object` в Terraform приведена в [документации провайдера](../../../terraform/resources/storage_object.md).

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

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы отредактировать ACL объекта, воспользуйтесь методом S3 API [objectPutAcl](../../s3/api-ref/acl/objectput.md).

  Чтобы загрузить объект с установкой ACL, воспользуйтесь методом S3 API [upload](../../s3/api-ref/object/upload.md) с заголовками `X-Amz-Acl`, `X-Amz-Grant-Read`, `X-Amz-Grant-Read-Acp`, `X-Amz-Grant-Write-Acp` и `X-Amz-Grant-Full-Control`.

{% endlist %}