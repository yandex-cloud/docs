# Configure your cloud

When a user registers with {{ yandex-cloud }}, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner. The `default` folder and `default` network will be created in the cloud.

The owner can create new folders and resources in this cloud, and manage access rights to them.

## Create a folder

{% list tabs group=instructions %}

- Management console {#console}

   {% include [create-folder](../../_includes/create-folder.md) %}

- CLI {#cli}

   1. View the description of the create folder command:

      ```
      yc resource-manager folder create --help
      ```

   1. Create a new folder:

      * with a name and without a description:

         ```
         yc resource-manager folder create \
             --name new-folder
         ```

         The folder naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * with a name and description:

         ```
         yc resource-manager folder create \
             --name new-folder \
             --description "my first folder with description"
         ```

- API {#api}

   To create a folder, use the [create](../../resource-manager/api-ref/Folder/create.md) method for the [Folder](../../resource-manager/api-ref/Folder/index.md).

{% endlist %}

## Update a folder {#change-folder}

The management console only allows you to change the name of a folder. To change its description, use the CLI or API.

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [home page]({{ link-console-main }}) of the management console, select the folder. This page displays folders for the selected cloud. If necessary, [switch to another cloud](../../resource-manager/operations/cloud/switch-cloud.md).
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the folder and select **{{ ui-key.yacloud.common.edit }}**.
   1. Enter a new name for the folder.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders.popup-edit_button_save }}**.

- CLI {#cli}

   1. View the description of the update folder command:

      ```
      yc resource-manager folder update --help
      ```
   1. If you know the folder ID or name, proceed to the next step. Otherwise, use one of these methods to get them:

      * Get a list of folders:

         ```
         $ yc resource-manager folder list
         +----------------------+--------------------+--------+--------+-------------+
         |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
         +----------------------+--------------------+--------+--------+-------------+
         | b1gppulhhm2aaufq9eug | yet-another-folder |        | ACTIVE |             |
         | b1gvmob95yysaplct532 | default            |        | ACTIVE |             |
         +----------------------+--------------------+--------+--------+-------------+
         ```

      * If you know the ID of the resource that belongs to the required folder, you can get the folder ID from the information about that resource:

         ```
         yc <SERVICE-NAME> <RESOURCE> get <RESOURCE-ID>
         ```

         Where:
         * `<SERVICE-NAME>`: Name of the service, such as `compute`.
         * `<RESOURCE>`: Resource category, e.g., `instance`.
         * `<RESOURCE-ID>`: Resource ID.

         For example, the `fhmp74bfis2aim728p2a` VM belongs to the `b1gpvjd9ir42nsng55ck` folder:

         ```
         yc compute instance get fhmp74bfis2ais728p2a
         id: fhmp74bfis2ais728p2a
         folder_id: b1gpvjd9ia42nsng55ck
         ...
         ```
   1. Change the folder parameters, e.g., name and description. You can specify the folder to update by its name or ID.

      ```
      yc resource-manager folder update default \
          --new-name myfolder \
          --description "this is my default-folder"
      ```

      The command will rename the `default` folder to `myfolder` and update its description.

      The folder naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}



- API {#api}

   To edit the folder, use the [update](../../resource-manager/api-ref/Folder/update.md) method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource.

{% endlist %}

## Assign folder roles {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

   1. {% include [grant-role-console-first-steps](../../_includes/iam/grant-role-console-first-steps.md) %}
   1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}
   1. Select a folder in the **{{ ui-key.yacloud.iam.users.label_folders-roles }}** section and click ![image](../../_assets/console-icons/plus.svg).
   1. Select a role from the list.

- CLI {#cli}

   1. View the description of the command to assign a role for a folder:

      ```
      yc resource-manager folder add-access-binding --help
      ```

   1. Select a folder (for example, `my-folder`):

      ```
      yc resource-manager folder list
      +----------------------+-----------+--------+--------+
      |          ID          |   NAME    | LABELS | STATUS |
      +----------------------+-----------+--------+--------+
      | b1gd129pp9ha0vnvf5g7 | my-folder |        | ACTIVE |
      +----------------------+-----------+--------+--------+
      ```

   1. Choose the [role](../../iam/concepts/access-control/roles.md).

      ```
      yc iam role list
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```
   1. Find out the user ID from the login or email address. To assign a role to a service account or a user group rather than to a single user, see the [examples](#examples) below.

      ```
      yc iam user-account get test-user
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```
   1. Assign the `editor` role for the `my-folder` folder to a user named `test-user`. In the subject, specify the `userAccount` type and user ID:

      ```
      yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
      ```

- API {#api}

   Use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource. You will need the folder ID and the ID of the user to whom you want to assign the role for the folder.

   1. Find out the folder ID using the [list](../../resource-manager/api-ref/Folder/list.md):
      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders?cloudId=b1gg8sgd16g7qca5onqs

      {
       "folders": [
        {
         "id": "b1g66mft1vopnevbn57j",
         "cloudId": "b1gd129pp9ha0vnvf5g7",
         "createdAt": "2018-10-17T12:44:31Z",
         "name": "my-folder",
         "status": "ACTIVE"
        }
       ]
      }
      ```

   1. Find out the user ID from the login using the [getByLogin](../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) method:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user

      {
       "id": "gfei8n54hmfhuk5nogse",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

   1. Assign the `editor` role for the `my-folder` folder to the user. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

      ```bash
      curl -X POST \
          -H 'Content-Type: application/json' \
          -H "Authorization: Bearer <IAM-TOKEN>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
      ```

{% endlist %}

## Assign multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

   Follow the guide at the [beginning of the section](#access-to-user) and assign the user multiple roles.

   To assign a role to another user, select the user on the [Users and roles]({{ link-console-access-management }}) tab and click **{{ ui-key.yacloud.iam.users.button_tune-role }}**.

- CLI {#cli}

   The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

   {% note alert %}

   The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

   {% endnote %}

   1. Make sure the resource has no roles assigned that you would rather not lose:

      ```
      yc resource-manager folder list-access-binding my-folder
      ```

   1. For example, assign a role to multiple users:

      ```
      yc resource-manager folder set-access-bindings my-folder \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

- API {#api}

   Assign the `editor` role to one user and the `viewer` role to another user:

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
       "accessBindingDeltas": [{
           "action": "ADD",
           "accessBinding": {
               "roleId": "editor",
               "subject": {
                   "id": "gfei8n54hmfhuk5nogse",
                   "type": "userAccount"
               }
           }
       },{
           "action": "ADD",
           "accessBinding": {
               "roleId": "viewer",
               "subject": {
                   "id": "helj89sfj80aj24nugsz",
                   "type": "userAccount"
       }}}]}' \
       https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
   ```

   You can also assign roles using the [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md).

   {% note alert %}

   The `setAccessBindings` method completely rewrites the access rights to the resource! All current resource roles will be deleted.

   {% endnote %}

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
       "accessBindings": [{
           "roleId": "editor",
           "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
       },{
           "roleId": "viewer",
           "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
       }]}' \
       https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:setAccessBindings
   ```

{% endlist %}

## Grant folder access for a service account {#access-to-sa}

In the management console, you can only assign a role for the folder where the service account was created. To assign it a role for another resource, use the CLI or API.

Allow the service account to manage the folder and its resources:

{% list tabs group=instructions %}

- Management console {#console}

   {% include [grant-role-console-sa](../../_includes/grant-role-console-sa.md) %}

- CLI {#cli}

   {% include [grant-role-for-sa-to-folder-via-cli](../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- API {#api}

   {% include [grant-role-for-sa-to-folder-via-api](../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}

## Allow access to resources for all users {#access-to-all}

{% include [grant-role-for-sa](../../_includes/iam/grant-role-for-all.md) %}