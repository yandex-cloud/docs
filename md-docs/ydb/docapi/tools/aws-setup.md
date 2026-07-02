[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for YDB](../../index.md) > Document API, совместимый с Amazon DynamoDB > Инструменты > Настройка инструментов AWS

# Настройка инструментов AWS

Для работы с БД через Document API в режиме совместимости с AWS DynamoDB вы можете использовать инструменты AWS:

* [AWS CLI](https://aws.amazon.com/ru/cli/) — интерфейс командной строки AWS.
* [AWS SDK](https://aws.amazon.com/ru/tools/#sdk) — инструменты для разработки.

{% note warning %}

Через Document API возможен доступ только к [документным таблицам](../../concepts/dynamodb-tables.md).

{% endnote %}

Для работы инструментов AWS выполните следующие настройки:

1. Создайте сервисный аккаунт, от имени которого вы будете работать с базой.

    Сервисный аккаунт должен быть создан в том же каталоге, в котором располагается база данных.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
      1. Перейдите в сервис **Identity and Access Management**.
      1. Нажмите кнопку **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта.
      
         Требования к формату имени:
      
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
      
         Имя сервисного аккаунта должно быть уникальным в рамках облака.
      
      1. Нажмите кнопку **Создать**.

    - CLI {#cli}

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Посмотрите описание команды создания сервисного аккаунта:

          ```bash
          yc iam service-account create --help
          ```

      1. Создайте сервисный аккаунт с именем `my-robot`:

          ```bash
          yc iam service-account create --name my-robot
          ```

          Требования к имени сервисного аккаунта:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

    - API {#api}

      Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md).

    {% endlist %}

1. Назначьте сервисному аккаунту роль `editor`.

    Сервисному аккаунту можно назначать роли на любые ресурсы в любом облаке, если эти ресурсы относятся к той же организации, что и сервисный аккаунт. Также сервисному аккаунту можно назначать роли на саму организацию.
    
    ## Назначение роли на ресурс {#binding-role-resource}
    
    Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту назначить роль на облако, этот сервисный аккаунт получит нужные разрешения на все ресурсы во всех каталогах этого облака.
    
    Чтобы назначить роль на ресурс, нужна роль `admin` или `service-name.admin`, где `service-name`— название сервиса, на ресурс которого назначается роль.
    
    [Узнайте](../../../iam/concepts/access-control/resources-with-access-control.md), на какие ресурсы можно назначать роли.
    
    Чтобы назначить роль на ресурс:
    
    {% list tabs group=instructions %}
    
    - Консоль управления {#console}
    
        Роли сервисному аккаунту назначаются так же, как пользовательскому аккаунту.
        
        Чтобы назначить сервисному аккаунту роль на облако или каталог:
    
        1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите облако или каталог.
        1. Перейдите на вкладку **Права доступа**.
        1. Нажмите кнопку **Настроить доступ**.
        1. В открывшемся окне выберите раздел **Сервисные аккаунты**.
        1. Выберите нужный сервисный аккаунт из списка или воспользуйтесь поиском.
        1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка или воспользуйтесь поиском.
        1. Нажмите кнопку **Сохранить**.
    
    - CLI {#cli}
    
      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
      Чтобы назначить сервисному аккаунту роль на облако или каталог, выполните команду:
    
      ```bash
      yc resource-manager <категория_ресурса> add-access-binding <имя_или_идентификатор_ресурса> \
        --role <идентификатор_роли> \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```
    
      Где:
    
      * `<категория_ресурса>` — `cloud`, чтобы назначить роль на облако, или `folder`, чтобы назначить роль на каталог.
      * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначается роль.
      * `--role` — идентификатор роли, например `viewer`.
      * `--subject serviceAccount` — идентификатор сервисного аккаунта, которому назначается роль.
    
      Например, чтобы назначить сервисному аккаунту роль `viewer` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) `my-folder`:
    
      1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md).
      
      1. Узнайте идентификатор сервисного аккаунта по его имени:
      
          ```bash
          yc iam service-account get my-robot
          ```
      
          Результат:
      
          ```text
          id: aje6o61dvog2********
          folder_id: b1gvmob95yys********
          created_at: "2018-10-15T18:01:25Z"
          name: my-robot
          ```
      
          Если вы не знаете имя сервисного аккаунта, получите список сервисных аккаунтов с их идентификаторами:
      
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
      
      1. Назначьте роль `viewer` сервисному аккаунту `my-robot`, используя его идентификатор:
      
          ```bash
          yc resource-manager folder add-access-binding my-folder \
            --role viewer \
            --subject serviceAccount:aje6o61dvog2********
          ```
    
    - Terraform {#tf}
    
      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.
    
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
         * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Обязательный параметр.
         * `role` — назначаемая роль. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md). Обязательный параметр.
         * `member` — [идентификатор](../../../iam/operations/sa/get-id.md) сервисного аккаунта, которому назначается роль. Указывается в виде `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.
    
         Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../../terraform/index.md).
    
      1. Проверьте корректность конфигурационных файлов.
    
         1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
         1. Выполните проверку с помощью команды:
    
            ```
            terraform plan
            ```
    
         Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
    
      1. Разверните облачные ресурсы.
    
         1. Если в конфигурации нет ошибок, выполните команду:
    
            ```
            terraform apply
            ```
    
         1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.
    
         После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
    
         ```bash
         yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
         ```
    
    - API {#api}
    
      Чтобы назначить сервисному аккаунту роль на облако или каталог, воспользуйтесь методом REST API `updateAccessBindings` для ресурса [Cloud](../../../resource-manager/api-ref/Cloud/index.md) или [Folder](../../../resource-manager/api-ref/Folder/index.md):
      
      1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md).
      1. [Узнайте](../../../resource-manager/operations/folder/get-id.md) ID каталога с сервисными аккаунтами.
      1. [Получите](../../../iam/operations/iam-token/create.md) IAM-токен для аутентификации в API Yandex Cloud.
      1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:
      
          ```bash
          export FOLDER_ID=b1gvmob95yys********
          export IAM_TOKEN=CggaATEVAgA...
          curl \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            "https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
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
      
      1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, в свойстве `roleId` — нужную роль, например `editor`, а в свойстве `subject` — тип `serviceAccount` и идентификатор сервисного аккаунта:
      
          **body.json:**
          ```json
          {
            "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                "roleId": "editor",
                "subject": {
                  "id": "ajebqtreob2d********",
                  "type": "serviceAccount"
                }
              }
            }]
          }
          ```
      1. Назначьте роль сервисному аккаунту. Например, на каталог с идентификатором `b1gvmob95yys********`:
         
         ```bash
         export FOLDER_ID=b1gvmob95yys********
         export IAM_TOKEN=CggaAT********
         curl \
           --request POST \
           --header "Content-Type: application/json" \
           --header "Authorization: Bearer ${IAM_TOKEN}" \
           --data '@body.json' \
           "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:updateAccessBindings"
         ```
    
    {% endlist %}
    
    ## Назначение роли на организацию {#binding-role-organization}
    
    Права доступа наследуются от организации ко всем созданным в ней ресурсам. Например, если сервисному аккаунту назначить роль на организацию, этот сервисный аккаунт получит нужные разрешения на все ресурсы всех облаков этой организации.
    
    Чтобы предоставить сервисному аккаунту права доступа к организации, необходима роль не ниже `organization-manager.admin`.
    
    {% list tabs group=instructions %}
    
    - Интерфейс Cloud Center {#cloud-center}
    
      1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
    
      1. На панели слева выберите ![persons-lock](../../../_assets/console-icons/persons-lock.svg) **Права доступа**.
    
      1. В фильтре **Тип аккаунта** выберите `Сервисные аккаунты`.
    
      1. Если у нужного сервисного аккаунта уже есть хотя бы одна роль, в строке с этим аккаунтом нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **Назначить роли**.
    
          Если нужного сервисного аккаунта нет в списке, в правом верхнем углу страницы нажмите кнопку **Назначить роли**. В открывшемся окне перейдите в раздел **Сервисные аккаунты** и выберите аккаунт из списка или воспользуйтесь поиском.
    
      1. Нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../../iam/concepts/access-control/roles.md), которую хотите назначить сервисному аккаунту. Вы можете назначить несколько ролей.
    
          Описание доступных ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md).
    
      1. Нажмите кнопку **Сохранить**.
    
    - CLI {#cli}
    
      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
      Чтобы назначить сервисному аккаунту роль на организацию, выполните команду:
    
      ```bash
      yc organization-manager organization add-access-binding <имя_или_идентификатор_организации> \
        --role <идентификатор_роли> \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```
    
      Где:
      * `<имя_или_идентификатор_организации>` — техническое название или [идентификатор](../../../organization/operations/organization-get-id.md) организации.
      * `--role` — идентификатор роли, например `viewer`.
      * `--subject serviceAccount` — идентификатор сервисного аккаунта, которому назначается роль.
    
      Например, чтобы назначить сервисному аккаунту роль `viewer` на организацию `MyOrg`:
    
      1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md).
    
      1. Получите список доступных вам организаций, чтобы узнать их идентификаторы и технические названия:
    
          ```bash
          yc organization-manager organization list
          ```
    
          Результат:
    
          ```text
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
    
          ```text
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
    
      1. Назначьте сервисному аккаунту `my-robot` роль `viewer` на организацию с идентификатором `bpf1smsil5q0********`:
    
          ```bash
          yc organization-manager organization add-access-binding bpf1smsil5q0******** \
            --role viewer \
            --subject serviceAccount:aje6o61dvog2********
          ```
    
    - Terraform {#tf}
    
      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.
    
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
         * `organization_id` — [идентификатор](../../../organization/operations/organization-get-id.md) организации. Обязательный параметр.
         * `role` — назначаемая роль. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md). Для каждой роли можно использовать только один `yandex_organization manager_organization_iam_binding`. Обязательный параметр.
         * `members` — [идентификатор](../../../iam/operations/sa/get-id.md) сервисного аккаунта, которому назначается роль. Указывается в виде `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.
    
         Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../../terraform/index.md).
    
      1. Проверьте корректность конфигурационных файлов.
        
         1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
         1. Выполните проверку с помощью команды:
     
            ```
            terraform plan
            ```
    
         Если конфигурация описана верно, в терминале отобразится список назначенных ролей. Если в конфигурации есть ошибки, Terraform на них укажет.
     
      1. Разверните облачные ресурсы.
      
         1. Если в конфигурации нет ошибок, выполните команду:
    
            ```
            terraform apply
            ```
    
         1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.
    	 
         После этого в указанной организации будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
    
         ```bash
         yc organization-manager organization list-access-bindings <имя_или_идентификатор_организации>
         ```
    
    - API {#api}
    
      Чтобы назначить сервисному аккаунту роль на организацию, воспользуйтесь методом REST API [updateAccessBindings](../../../organization/api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../../../organization/api-ref/Organization/index.md):
    
      1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md).
      1. [Узнайте](../../../resource-manager/operations/folder/get-id.md) ID каталога с сервисными аккаунтами.
      1. [Получите](../../../iam/operations/iam-token/create.md) IAM-токен для аутентификации в API Yandex Cloud.
      1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:
    
          ```bash
          export FOLDER_ID=b1gvmob95yys********
          export IAM_TOKEN=CggaATEVAgA...
          curl \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            "https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
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
          curl \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --request GET \
            "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations"
          ```
    
          Результат:
    
          ```text
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
    
      1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, в свойстве `roleId` — нужную роль, например `viewer`, а в свойстве `subject` — тип `serviceAccount` и идентификатор сервисного аккаунта:
    
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
          curl \
            --header "Content-Type: application/json" \
            --header "Authorization: Bearer ${IAM_TOKEN}" \
            --data '@body.json' \
            --request POST \
            "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
          ```
    
    {% endlist %}

1. Получите идентификатор ключа и ключ доступа созданного сервисного аккаунта:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
      1. В списке сервисов выберите **Identity and Access Management**.
      1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и выберите нужный сервисный аккаунт.
      1. Нажмите кнопку **Создать новый ключ** на верхней панели.
      1. Выберите пункт **Создать статический ключ доступа**.
      1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

    - CLI {#cli}

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Посмотрите описание команды создания статического ключа доступа:

          ```bash
          yc iam access-key create --help
          ```

      1. Выберите сервисный аккаунт, например `my-robot`:

          ```bash
          yc iam service-account list
          +----------------------+------------------+-------------------------------+
          |          ID          |       NAME       |          DESCRIPTION          |
          +----------------------+------------------+-------------------------------+
          | aje6o61dvog2******** | my-robot         |                               |
          ...
          ```

      1. Создайте ключ доступа для сервисного аккаунта `my-robot`:

          ```bash
          yc iam access-key create --service-account-name my-robot
    
          access_key:
            id: aje6t3vsbj8l********
            service_account_id: ajepg0mjt06s********
            created_at: "2018-11-22T14:37:51Z"
            key_id: 0n8X6WY6S24N********
          secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI********
          ```

      1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

    - API {#api}

      Чтобы создать ключ доступа, воспользуйтесь методом [create](../../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../../iam/awscompatibility/api-ref/AccessKey/index.md).

    {% endlist %}

1. Установите [AWS CLI](https://aws.amazon.com/ru/cli/).
1. Настройте окружение AWS CLI: Запустите команду `aws configure` и последовательно введите сохраненные ранее идентификатор ключа и секретный ключ. Для значения региона используйте `ru-central1`:

    ```bash
    aws configure
    AWS Access Key ID [None]: AKIAIOSFODNN********
    AWS Secret Access Key [None]: wJalr********/*******/bPxRfiCYEX********
    Default region name [None]: ru-central1
    Default output format [None]:
    ```

    В результате будут созданы файлы `~/.aws/credentials` и `~/.aws/config` (`C:\Users\USERNAME\.aws\credentials` и `C:\Users\USERNAME\.aws\config` в Windows).
1. Проверьте корректность настройки, запустив команду листинга таблиц в [созданной](../../operations/manage-databases.md) ранее БД. В качестве значения `--endpoint` укажите Document API эндпоинт, доступный на вкладке **Обзор** вашей базы данных в [консоли управления](https://console.yandex.cloud).

    ```bash
    aws dynamodb list-tables \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaom********/etnudu2n9ri3********
    ```

    Результат:

    ```text
    {
        "TableNames": [
        ]
    }
    ```