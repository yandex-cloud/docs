In this tutorial, you will set up [CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) between {{ sf-name }} and {{ src-name }}. To make this work, you will create a repository, set up function deployment, and check the result.

To set up CI/CD:

1. [Create a service account and authorized key](#iam).
1. [Create a repository](#repository).
1. [Create a secret in your repository](#create-secret).
1. [Push your changes to the repository](#push-changes).
1. [Check the CI/CD process](#check-ci-cd).
1. [Check the function updates](#check-function).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The infrastructure support cost includes fees for function invocation count, computing resources allocated for the function, and outbound traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).


## Create a service account and authorized key {#iam}

{{ src-name }} will use this [service account](../../iam/concepts/users/service-accounts.md) to create a function and its versions.

### Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** from the list of services.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter the service account name: `functions-cicd-sa`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `{{ roles-functions-admin }}` [role](../../functions/security/index.md#functions-admin).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  1. Create a service account named `functions-cicd-sa`:

      ```bash
      yc iam service-account create --name functions-cicd-sa
      ```

      Result:

      ```bash
      id: ajehb3tcdfa1********
      folder_id: b1g86q4m5vej********
      created_at: "2025-05-28T16:05:14.237381531Z"
      name: functions-cicd-sa
      ```

  1. Assign the `{{ roles-functions-admin }}` [role](../../functions/security/index.md#functions-admin) for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role {{ roles-functions-admin }} \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```bash
      done (3s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: {{ roles-functions-admin }}
            subject:
              id: ajehb3tcdfa1********
              type: serviceAccount
      ```

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the `{{ roles-functions-admin }}` [role](../../functions/security/index.md#functions-admin) for a folder to a service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}


### Create an authorized key {#create-key}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** from the list of services.
  1. Select the `functions-cicd-sa` service account.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Select the encryption algorithm.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**. Make sure the file is saved on the computer. You will need its contents to [create a secret](#create-secret). You will not be able to view the public key in the management console.

- CLI {#cli}

  Run this command:

  ```bash
  yc iam key create --service-account-name sa-function -o functions-cicd-sa_key_file.json
  ```

  If successful, the authorized key data will be written to the `functions-cicd-sa_key_file.json` file, e.g.:

  ```json
  {
    "id": "ajek6nubd5g3********",
    "service_account_id": "ajelprpohp7r********",
    "created_at": "2025-05-28T16:17:17.721526532Z",
    "key_algorithm": "RSA_2048",
    "public_key": "-----BEGIN PUBLIC KEY-----\nMI...QAB\n-----END PUBLIC KEY-----\n",
    "private_key": "PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID \u003cajek6nubd5g3********\u003e\n-----BEGIN PRIVATE KEY-----\nMI...WdQ=\n-----END PRIVATE KEY-----\n"
  }
  ```

- API {#api}

  To create an authorized access key, use the [create](../../iam/api-ref/Key/create.md) REST API method for the [Key](../../iam/api-ref/Key/index.md) resource or the  [Key/Create](../../iam/api-ref/grpc/Key/create.md) gRPC API call.

{% endlist %}


## Create a repository {#repository}

The repository will store the function parameters and code, and the CI/CD process settings.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_create-repository }}**.
  1. In the window that opens, select **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_create-blank }}**.
  1. {% include [repo-create-details](../../_includes/sourcecraft/repo-create-details.md) %}
  1. Click **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_create-repo }}**.

{% endlist %}


## Create a secret in the repository {#create-secret}

The [secret]({{ link-src-docs }}/sourcecraft/operations/secrets) will store the encrypted authorized service account key for access to the function.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.ui_modules_orgCommon.link_your-craftspace }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_lib.repositories }}**.
  1. Select the repository you created earlier.
  1. Under ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.ui_modules_repo.title_navigation-repository-settings }}** on the repository page, go to ![image](../../_assets/console-icons/vault.svg) **{{ ui-key.sourcecraft.ui_lib.tab_secrets }}**.
  1. On the page with secrets, click **{{ ui-key.sourcecraft.ui_modules_secrets.action_new-secrete }}**.
  1. In the window that opens:

      * In the **{{ ui-key.sourcecraft.ui_modules_secrets.field_name }}** field, name your secret: `authorized-key`.
      * In the **{{ ui-key.sourcecraft.ui_modules_secrets.field_secret }}** field, paste the authorized key file contents [you saved earlier](#create-key).

  1. Click **{{ ui-key.sourcecraft.ui_modules_secrets.action_add-secret }}**.

{% endlist %}


## Push your changes to the repository {#push-changes}

Create the following files in the repository:

* `index.js` with function code.
* `.sourcecraft/ci.yaml` with function parameters and CI/CD settings.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.ui_modules_orgCommon.link_your-craftspace }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_lib.repositories }}**.
  1. Select the repository you created earlier.
  1. Click **{{ ui-key.sourcecraft.ui_modules_repoMain.action_go-to-browse }}**.
  1. To the right of the branch name, click ![image](../../_assets/console-icons/square-plus.svg) → ![image](../../_assets/console-icons/file.svg) **{{ ui-key.sourcecraft.ui_modules_repo.file }}**.
  1. Enter `index.js` for the file name and click **{{ ui-key.sourcecraft.ui_modules_repo.action_create-file }}**.
  1. Paste the following code into `index.js`:

      ```javascript
      module.exports.handler = async function (event, context) {
          return {
              statusCode: 200,
              body: 'Hello from SourceCraft!',
          };
      };
      ```

  1. Repeat these steps to create a file named `.sourcecraft/ci.yaml`. Paste the code below into it stating the ID of the folder you want to create your function in:

      ```yaml
      on:
        push:
          - workflows: cicd
            filter:
              branches: [ main ]
      workflows:
        cicd:
          tasks:
            - name: deploy-latest
              env:
                TMP_PATH: ./tmp
                YC_AUTHORIZED_KEY_JSON: ${{ secrets.<secret_name> }}
                YC_FOLDER_ID: <folder_ID>
                YC_FUNCTION_NAME: cicd-test
                YC_FUNCTION_RUNTIME: nodejs22
                YC_FUNCTION_ENTRYPOINT: index.handler
                YC_FUNCTION_MEMORY: 128m
              cubes:
                - name: install-and-configure-yc
                  script:
                    - curl -o ./yc-install.sh -L https://storage.yandexcloud.net/yandexcloud-yc/install.sh
                    - chmod +x ./yc-install.sh && ./yc-install.sh -i /tmp/yc -n && mv /tmp/yc/bin/yc /usr/bin/yc
                    - echo "$YC_AUTHORIZED_KEY_JSON" > key.json
                    - yc config profile create sa-profile
                    - yc config set service-account-key key.json
                    - yc config set format json
                    - yc config set folder-id $YC_FOLDER_ID

                - name: check-and-create-function
                  script:
                    - |
                      echo "Checking if function exists..."
                      if ! yc serverless function get --name=$YC_FUNCTION_NAME; then
                        echo "Function does not exist. Creating new function..."
                        yc serverless function create --name=$YC_FUNCTION_NAME
                      else
                        echo "Function already exists. Proceeding to version deployment..."
                      fi

                - name: deploy-function-version
                  script:
                    - mkdir -p $TMP_PATH
                    - cp ./*.js* $TMP_PATH
                    - echo "Deploying new function version..."
                    - |
                      yc serverless function version create \
                        --function-name=$YC_FUNCTION_NAME \
                        --runtime $YC_FUNCTION_RUNTIME \
                        --entrypoint $YC_FUNCTION_ENTRYPOINT \
                        --memory $YC_FUNCTION_MEMORY \
                        --execution-timeout 5s \
                        --source-path $TMP_PATH
      ```

      Where:

      * `YC_FOLDER_ID`: ID of the folder to host your function.
      * `YC_FUNCTION_NAME`: Function name.
      * `YC_FUNCTION_RUNTIME`: Runtime environment.
      * `YC_FUNCTION_ENTRYPOINT`: Entry point.
      * `YC_FUNCTION_MEMORY`: Amount of RAM.

  1. In the top-right corner, click **{{ ui-key.sourcecraft.ui_modules_repo.action_commit }}**.
  1. Commit:
      1. Enter a message about the changes.
      1. Under **{{ ui-key.sourcecraft.ui_modules_repo.field_commit-branch }}**, select **{{ ui-key.sourcecraft.ui_modules_repo.field_text_commit-directly-to-the-branch }}** main.
      1. Under **{{ ui-key.sourcecraft.ui_modules_repo.field_after-commit-action }}**, select **{{ ui-key.sourcecraft.ui_modules_repo.option_just-commit }}**.
      1. Click **{{ ui-key.sourcecraft.ui_modules_repo.button_commit-and-go-to-read-mode }}**.

{% endlist %}


## Check the CI/CD process {#check-ci-cd}

Make sure the CI/CD process completes successfully.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.ui_modules_orgCommon.link_your-craftspace }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_lib.repositories }}**.
  1. Select the repository you created earlier.
  1. Under ![image](../../_assets/console-icons/code.svg) **{{ ui-key.sourcecraft.ui_modules_repo.title_navigation-code }}** on the repository page, go to ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.ui_modules_repo.action_cicd }}**.
  1. In the automation executions list, you will see a new execution with the ![image](../../_assets/console-icons/circle.svg) **{{ ui-key.sourcecraft.ui_modules_cicd.value_status-created }}** status. Wait for the status to change to ![image](../../_assets/console-icons/circle-check.svg) **{{ ui-key.sourcecraft.ui_modules_cicd.value_succeeded }}**.

{% endlist %}


## Check that the function was created {#check-function}

Make sure {{ sf-name }} now features a function named `cicd-test`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you specified in the `.sourcecraft/ci.yaml` file.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. The list should now contain `cicd-test`. Select it.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, you should now see the function's version with the same timestamp as the [CI/CD process execution](#check-ci-cd).
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
  1. In the code editor, `index.js` should now feature this code:

      ```javascript
      module.exports.handler = async function (event, context) {
          return {
              statusCode: 200,
              body: 'Hello from SourceCraft!',
          };
      };
      ```

- CLI {#cli}

  1. Get a list of functions in the folder specified in `.sourcecraft/ci.yaml`:
      ```
      yc serverless function list
      ```

      Result:
      ```
      +----------------------+-----------+----------------------+--------+
      |          ID          |   NAME    |      FOLDER ID       | STATUS |
      +----------------------+-----------+----------------------+--------+
      | b097d9ous3ge******** | cicd-test | aoek49ghmknn******** | ACTIVE |
      +----------------------+-----------+----------------------+--------+
      ```

      The command output should now contain the function named `cicd-test`.

  1. Get a list of versions of the `cicd-test` function:

      ```bash
      yc serverless function version list --function-id <function_ID>
      ```

      Result:
    
      ```text
      +----------------------+----------------------+----------+---------------+---------+---------------------+
      |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
      +----------------------+----------------------+----------+---------------+---------+---------------------+
      | b097d9ousd36******** | b097d9ous3ge******** | nodejs22 | index.handler | $latest | 2025-05-28 05:05:12 |
      +----------------------+----------------------+----------+---------------+---------+---------------------+
      ```

      The command output should now contain the function's version with the same timestamp as the [CI/CD process execution](#check-ci-cd).

- API {#api}

  To get a list of functions, use the [list](../../functions/functions/api-ref/Function/list.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/List](../../functions/functions/api-ref/grpc/Function/list.md) gRPC API call.

  The list should now feature the `cicd-test` function.
  
  To get a list of function versions, use the [listVersions](../../functions/functions/api-ref/Function/listVersions.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/ListVersions](../../functions/functions/api-ref/grpc/Function/listVersions.md) gRPC API call.

  The list should now contain a new version of the function with the same timestamp as the [CI/CD process execution](#check-ci-cd).

{% endlist %}


## Delete the resources you created {#clear-out}

If you no longer need the resources you created, delete them:

1. [Delete the function](../../functions/operations/function/function-delete.md).
1. [Delete the service account](../../iam/operations/sa/delete.md).
