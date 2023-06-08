# Configure your cloud

When a user registers with {{ yandex-cloud }}, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner. The `default` folder and `default`network will be created in the cloud.

The owner can create new folders and resources in this cloud, and manage access rights to them.

## Create a folder

{% list tabs %}

- Management console

   {% include [create-folder](../../_includes/create-folder.md) %}

- CLI

   1. See a description of the create folder command:

      ```
      $ yc resource-manager folder create --help
      ```

   2. Create a new folder:

      * with a name and without a description:
         ```
         $ yc resource-manager folder create \
             --name new-folder
         ```

         {% include [name-format](../../_includes/name-format.md) %}

      * with a name and description:

         ```
         $ yc resource-manager folder create \
             --name new-folder \
             --description "my first folder with description"
         ```

- API

   To create a folder, use the [create](../../resource-manager/api-ref/Folder/create.md) method for the [Folder](../../resource-manager/api-ref/Folder/index.md).

{% endlist %}

## Update a folder {#change-folder}

The management console only allows you to change the name of a folder. To change its description, use the CLI or API.

{% list tabs %}

- Management console

   1. Select the folder on the management console [home page]({{ link-console-main }}). This page displays folders for the selected cloud. If necessary, [switch to another cloud](../../resource-manager/operations/cloud/switch-cloud.md).
   2. Click ![image](../../_assets/options.svg) next to the folder and select **Rename**.
   3. Enter a new name for the folder.
   4. Click **Rename**.

- CLI

   1. See the description of the update folder command:

      ```
      $ yc resource-manager folder update --help
      ```
   2. If you know the folder ID or name, proceed to the next step. If not, use one of these methods to get them:

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
         $ yc <SERVICE-NAME> <RESOURCE> get <RESOURCE-ID>
         ```

         Where:
         * `<SERVICE-NAME>` is the name of the service, such as `compute`.
         * `<RESOURCE>`: The resource type, such as `instance`.
         * `<RESOURCE-ID>` is the resource ID.

         For example, the `fhmp74bfis2aim728p2a` VM belongs to the `b1gpvjd9ir42nsng55ck` folder:

         ```
         $ yc compute instance get fhmp74bfis2ais728p2a
         id: fhmp74bfis2ais728p2a
         folder_id: b1gpvjd9ia42nsng55ck
         ...
         ```
   3. Change the folder parameters, such as name and description. You can specify the folder to update by its name or ID.

      ```
      $ yc resource-manager folder update default \
          --new-name myfolder \
          --description "this is my default-folder"
      ```

      The command will rename the `default` folder to `myfolder` and update its description.

      {% include [name-format](../../_includes/name-format.md) %}



- API

   To edit the folder, use the [update](../../resource-manager/api-ref/Folder/update.md) method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource.

{% endlist %}