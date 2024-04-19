Сервисному аккаунту можно назначать роли на любые ресурсы в любом облаке, если эти ресурсы относятся к той же организации, что и сервисный аккаунт. Также сервисному аккаунту можно назначать роли на саму организацию.

## Назначение роли на ресурс {#binding-role-resource}

Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту назначить роль на облако, этот сервисный аккаунт получит нужные разрешения на все ресурсы во всех каталогах этого облака.

[Узнайте](../../iam/concepts/access-control/resources-with-access-control.md), на какие ресурсы можно назначать роли.

Чтобы назначить роль на ресурс:

{% list tabs group=instructions %}

- Консоль управления {#console}

    Роли сервисному аккаунту назначаются так же, как пользовательскому аккаунту.
    
    Чтобы назначить сервисному аккаунту роль на облако или каталог:

    1. В [консоли управления]({{ link-console-main }}) выберите нужное облако или каталог.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
    1. В открывшемся окне выберите раздел **{{ ui-key.yacloud.common.resource-acl.label_service-accounts }}**.
    1. Выберите нужный сервисный аккаунт из списка или воспользуйтесь поиском.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль из списка или воспользуйтесь поиском.
    1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы назначить сервисному аккаунту роль на облако или каталог, выполните команду:

  ```bash
  yc resource-manager <категория_ресурса> add-access-binding <имя_или_идентификатор_ресурса> \
    --role <идентификатор_роли> \
    --subject serviceAccount:<идентификатор_сервисного_аккаунта>
  ```

  Где:

  * `<категория_ресурса>` — `cloud`, чтобы назначить роль на облако, или `folder`, чтобы назначить роль на каталог.
  * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначется роль.
  * `--role` — идентификатор роли, например `{{ roles-viewer }}`.
  * `--subject serviceAccount` — идентификатор сервисного аккаунта, которому назначается роль.

  Например, чтобы назначить сервисному аккаунту роль `{{ roles-viewer }}` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) `my-folder`:

  {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
       folder_id   = "<идентификатор_каталога>"
       role        = "<роль>"
       member      = "serviceAccount:<идентификатор_сервисного_аккаунта>"
     }
     ```

     Где:
     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Обязательный параметр.
     * `role` — назначаемая роль. Описание ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md). Обязательный параметр.
     * `member` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, которому назначается роль. Указывается в виде `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
     ```

- API {#api}

  {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}

## Назначение роли на организацию {#binding-role-organization}

Права доступа наследуются от организации ко всем созданным в ней ресурсам. Например, если сервисному аккаунту назначить роль на организацию, этот сервисный аккаунт получит нужные разрешения на все ресурсы всех облаков этой организации.

Чтобы предоставить сервисному аккаунту права доступа на организацию, необходима роль не ниже `{{ roles-organization-admin }}`. 

{% list tabs group=instructions %}

- {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  
  1. На панели слева выберите ![icon-acl](../../_assets/console-icons/persons-lock.svg) [**{{ ui-key.yacloud_org.pages.acl }}**]({{ link-org-acl }}).

  1. В фильтре **{{ ui-key.yacloud.common.resource-acl.placeholder_filter-by-type }}** выберите `{{ ui-key.yacloud.common.resource-acl.label_service-accounts }}`.

  1. Если у нужного сервисного аккаунта уже есть хотя бы одна роль, выберите его из списка или воспользуйтесь поиском. В строке аккаунта нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

     Если нужного сервисного аккаунта нет в списке, в правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**. В открывшемся окне перейдите в раздел **{{ ui-key.yacloud.common.resource-acl.label_service-accounts }}** и выберите аккаунт из списка или воспользуйтесь поиском.
  
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль из списка или воспользуйтесь поиском.
  
     Описание доступных ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md). 
  
  1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы назначить сервисному аккаунту роль на организацию, выполните команду:

  ```bash
  yc organization-manager organization add-access-binding <имя_или_идентификатор_организации> \
    --role <идентификатор_роли> \
    --subject serviceAccount:<идентификатор_сервисного_аккаунта>
  ```

  Где:
  * `<имя_или_идентификатор_организации>` — техническое название или идентификатор организации.
  * `--role` — идентификатор роли, например `{{ roles-viewer }}`.
  * `--subject serviceAccount` — идентификатор сервисного аккаунта, которому назначается роль.

  Например, чтобы назначить сервисному аккаунту роль `{{ roles-viewer }}` на организацию `MyOrg`:

  1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md).

  1. Получите список доступных вам организаций, чтобы узнать их идентификаторы и технические названия:

      ```bash
      yc organization-manager organization list
      ```

      Результат:

      ```bash
      +---------------------------------+---------------------------------+----------------------+
      |               ID                |              NAME               |        TITLE         |
      +---------------------------------+---------------------------------+----------------------+
      | bpf1smsil5q0********            | hdt5j5uw********                | MyOrg                |
      +---------------------------------+---------------------------------+----------------------+
      ```
  
      Техническое название организации находится в столбце `NAME`, идентификатор организации — в столбце `ID`.

  1. Узнайте идентификатор сервисного аккаунта по его имени:

      ```bash
      yc iam service-account get my-robot
      ```

      Результат:

      ```bash
      id: aje6o61dvog2********
      folder_id: b1gvmob95yys********
      created_at: "2018-10-15T18:01:25Z"
      name: my-robot
      ```

      Если вы не знаете имя сервисного аккаунта, получите полный список сервисных аккаунтов с их идентификаторами:

      ```bash
      yc iam service-account list
      ```

      Результат:
      
      ```bash
      +----------------------+------------------+-----------------+
      |          ID          |       NAME       |   DESCRIPTION   |
      +----------------------+------------------+-----------------+
      | aje6o61dvog2******** | my-robot         | my description  |
      +----------------------+------------------+-----------------+
      ```

  1. Назначьте сервисному аккаунту `my-robot` роль `{{ roles-viewer }}` на организацию с идентификатором `bpf1smsil5q0********`:

      ```bash
      yc organization-manager organization add-access-binding bpf1smsil5q0******** \
        --role viewer \
        --subject serviceAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %} 

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_organizationmanager_organization_iam_binding" "editor" {
       organization_id   = "<идентификатор_организации>"
       role              = "<роль>"
       members           = [
                             "serviceAccount:<идентификатор_сервисного_аккаунта>",
                           ]
     }
     ```

     Где:
     * `organization_id` — [идентификатор организации](../../organization/operations/org-profile.md). Обязательный параметр.
     * `role` — назначаемая роль. Описание ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md). Для каждой роли можно использовать только один `yandex_organization manager_organization_iam_binding`. Обязательный параметр.
     * `members` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, которому назначается роль. Указывается в виде `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.
    
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:
 
        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список назначенных ролей. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
 
  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.
	 
     После этого в указанной организации будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc organization-manager organization list-access-bindings <имя_или_идентификатор_организации>
     ```

- API {#api}

  Чтобы назначить сервисному аккаунту роль на организацию, воспользуйтесь методом REST API [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md):

  1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md).
  1. [Узнайте](../../resource-manager/operations/folder/get-id.md) ID каталога с сервисными аккаунтами.
  1. [Получите](../../iam/operations/iam-token/create.md) IAM-токен для авторизации в API {{ yandex-cloud }}.
  1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:

      ```bash
      export FOLDER_ID=b1gvmob95yys********
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
      ```

      Результат:


      ```json
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "my-robot",
         "description": "my description"
        }
       ]
      }
      ```

  1. Получите список организаций, чтобы узнать их идентификаторы:

      ```bash
      export IAM_TOKEN=CggaATEVAgA... 
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
	    -X GET "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations"
      ```

      Результат:

      ```bash
      {
       "organizations": [
        {
         "id": "bpfaidqca8vd********",
         "createdAt": "2023-04-07T08:11:54.313033Z",
         "name": "xvdq9q22********",
         "title": "MyOrg"
        }
       ]
      }
      ```

  1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, в свойстве `roleId` — нужную роль, например `{{ roles-viewer }}`, а в свойстве `subject` — тип `serviceAccount` и идентификатор сервисного аккаунта:

      **body.json:**

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "viewer",
            "subject": {
              "id": "ajebqtreob2d********",
              "type": "serviceAccount"
            }
          }
        }]
      }
      ```

  1. Назначьте роль сервисному аккаунту. Например, на организацию с идентификатором `bpfaidqca8vd********`:

      ```bash
      export ORGANIZATION_ID=bpfaidqca8vd********
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        -X POST "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}