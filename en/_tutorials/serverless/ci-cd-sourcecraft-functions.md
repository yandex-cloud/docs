In this tutorial, you will set up [CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) between {{ sf-name }} and {{ src-name }}. To make this work, you will create a repository, set up function deployment, and check the result. The integration between {{ src-name }} and {{ yandex-cloud }} will be implemented using a [service connection]({{ link-src-docs }}/sourcecraft/concepts/service-connections).

{% include [service-connection-role-warning](../../_includes/sourcecraft/service-connection-role-warning.md) %}

To set up CI/CD for {{ sf-name }} function deployment from a {{ src-name }} repository, do the following:
1. [Create a service account](#create-sa).
1. [Create a repository](#repository).
1. [Create a service connection](#create-service-connection).
1. [Edit the CI/CD configuration](#push-changes).
1. [Test CI/CD](#check-ci-cd).
1. [Check the function updates](#check-function).

If you no longer need the resources you created, [delete them](#clear-out).

## Required paid resources {#paid-resources}

The infrastructure support cost includes fees for function invocation count, computing resources allocated for the function, and outbound traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).

## Create a service account {#create-sa}

This [service account](../../iam/concepts/users/service-accounts.md) will be used to create a function and its versions.

{% list tabs group=instructions %}

- Management console {#console}

  1. Log in to the {{ yandex-cloud }} [management console]({{ link-console-main }}).
  1. On the left side of the screen, click the line with the name of the folder where you want to deploy a function from {{ sf-name }}.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
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

## Create a repository {#repository}

The repository will be created from the [yc-cloud-functions-template]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template). This repository will store function code examples for different programming languages and frameworks, as well as CI/CD process settings.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_create-repository }}**.
  1. In the window that opens, select **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_create-blank }}**.
  1. Under **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_new-repo-details }}**:
      * In the **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_owner-field }}** field, select the [organization]({{ link-src-docs }}/sourcecraft/concepts/#org) in which you created the {{ yandex-cloud }} service account.
      * In the **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_repo-field }}** field, specify a name for the repository. 

        The name must be unique within the organization. The name may contain the following [ASCII characters](https://en.wikipedia.org/wiki/ASCII): lowercase and uppercase Latin letters, numbers, commas, hyphens, and underscores.

        The address to access the repository at is displayed below the name.

      * Optionally, in the **{{ ui-key.sourcecraft.ui_modules_repoSettings.field_description }}** field, enter a description for the repository.

  1. Under **{{ ui-key.sourcecraft.ui_modules_repoCreate.section_template }}**, click **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_browse-templates }}**. Select [yc-cloud-functions-template]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template) and click **{{ ui-key.sourcecraft.ui_modules_repo.button_use-template }}**.

      To view the template contents, click **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_preview-template }}**.

      The template contains:
      * [.sourcecraft/ci.yaml]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template/browse/.sourcecraft/ci.yaml) file with a pre-installed configuration of a CI/CD process you can run [manually]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) to publish your function to a specific [runtime](../../functions/concepts/runtime/index.md#runtimes) or automatically for the `nodejs22` runtime when creating a commit to the repository main branch.
      * Directories with function code examples for different programming languages and frameworks.
  1. Click **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_create-repo }}**.

{% endlist %}

## Create a service connection {#create-service-connection}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. Navigate to the ![image](../../_assets/console-icons/briefcase.svg) **{{ ui-key.sourcecraft.ui_lib.organizations }}** tab.
  1. Select the organization where you created the {{ yandex-cloud }} service account.
  1. On the organization page, in the ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.ui_lib.settings }}** section, go to the ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_service-connections }}** section.
  1. Click **{{ ui-key.sourcecraft.ui_modules_serviceConnections.button_add-connection }}**.
  1. In the window that opens, do the following:
      * Under **{{ ui-key.sourcecraft.ui_modules_serviceConnections.section_basic }}**, give the connection a name, e.g., `default-service-connection`, and add an optional description.
      * Under **{{ ui-key.sourcecraft.ui_modules_serviceConnections.section_scope }}**, select the repositories and branches the service connection will be available to, e.g., the repository you created earlier.
      * Under **{{ ui-key.sourcecraft.ui_modules_serviceConnections.section_cloud-settings }}**, select:
        * Folder for which you have assigned a role to the service account.
        * Service account you created earlier.

        {% note tip %}

        To re-request the list of clouds, folders, and service accounts from {{ yandex-cloud }}, click ![image](../../_assets/console-icons/arrow-rotate-right.svg) **Synchronize**. This can be of use if alongside creating a service connection you also created a folder or service account.

        {% endnote %}

  1. Click **{{ ui-key.sourcecraft.ui_modules_serviceConnections.button_create-connection }}**.

      Wait for the operation to complete. The page that opens will display the service connection details.

      A {{ iam-full-name }} [workload identity federation](../../iam/concepts/workload-identity.md) will be automatically created in {{ yandex-cloud }}.

      To view the parameters of the new OIDC provider, click the federation name under ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.sourcecraft.ui_modules_serviceConnections.title_oidc-federation }}**.

{% endlist %}

## Edit the CI/CD configuration {#push-changes}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.ui_modules_orgCommon.link_your-craftspace }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_lib.repositories }}**.
  1. Select the repository you created earlier.
  1. Select `.sourcecraft/ci.yaml`.
  1. In the top-right corner, click ![image](../../_assets/console-icons/pencil.svg) **Edit**.
  1. In the `deploy-nodejs-function` [workflow]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#workflows), edit the parameters of your new function:
      * `YC_FUNCTION_NAME`: Function name, e.g., `test-function-nodejs`.
      * `YC_FUNCTION_RUNTIME`: [Runtime environment](../../functions/concepts/runtime/index.md#runtimes), e.g., `nodejs22`.
      * `YC_FUNCTION_ENTRYPOINT`: Function entry point, e.g., `index.handler`. Specify it based on your runtime environment as described in [this guide](../../functions/quickstart/create-function/index.md).
      * `SOURCE_PATH`: Repository path to the function code, e.g., `./nodejs`.

      You can also add optional parameters:
      * `ENVIRONMENT`: Environment variables for the function, e.g., `MY_ENV=SOURCECRAFT`. This is an equivalent of the `--environment` parameter in the [yc serverless function version create](../../cli/cli-ref/serverless/cli-ref/function/version/create.md) {{ yandex-cloud }} CLI command.
      * `PUBLIC`: Make the function publicly available. This parameter takes the `true` value. This is an equivalent of the [yc serverless function allow-unauthenticated-invoke](../../cli/cli-ref/serverless/cli-ref/function/allow-unauthenticated-invoke.md) {{ yandex-cloud }} CLI command.

  1. In the top-right corner, click **{{ ui-key.sourcecraft.ui_modules_repo.action_commit }}**.
  1. Commit:

      1. Enter a message about the changes.
      1. Under **{{ ui-key.sourcecraft.ui_modules_repo.field_commit-branch }}**, select **{{ ui-key.sourcecraft.ui_modules_repo.field_text_commit-directly-to-the-branch }} main**.
      1. Under **{{ ui-key.sourcecraft.ui_modules_repo.field_after-commit-action }}**, select **{{ ui-key.sourcecraft.ui_modules_repo.option_just-commit }}**.
      1. Click **{{ ui-key.sourcecraft.ui_modules_repo.button_commit }}**.

{% endlist %}

After saving the changes, the `deploy-nodejs-function` workflow will start.

Similarly, you can edit the function code in `nodejs/index.js`. This will also trigger the workflow for publishing the new function version.

{% note tip %}

The example below shows how to automatically start a workflow for the `nodejs22` runtime environment. For other runtimes, use [manual]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) startup or edit the `on` section in `.sourcecraft/ci.yaml`.

{% cut "Automatic startup example for python312" %}

```yaml
on:
  push:
    - workflows: [deploy-python-function] 
      filter: 
        branches: ["master", "main"]
```

{% endcut %}

{% endnote %}

To deploy a function from {{ sf-name }} in CI/CD configuration, use `yc-function`, a ready-made {{ src-name }} [cube]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#cubes) suitable for common use cases.

For more complex {{ sf-name }} deployment where you need all the [{{ yandex-cloud }} CLI](../../cli/cli-ref/serverless/cli-ref/function/index.md) capabilities, you can use the `yc-iam` and `yc-cli` cubes.

{% cut "Examples of CI/CD configuration with ready-made yc-iam and yc-cli cubes" %}

```yaml
on:
  push:
    - workflows: [cicd]
      filter:
        branches: ["master", "main"]

tokens:
  # Token name (can be any).
  <token_name>:
    service_connection: default-service-connection
    # Requested access scope:
    # org: All repositories
    # repo: Specific repository
    # ref: Branch or tag
    scope: repo

workflows:
  cicd:
    tasks:
      - name: deploy-latest
        env:
          SOURCE_PATH: "./nodejs"
          YC_FUNCTION_NAME: "test-function-nodejs"
          YC_FUNCTION_RUNTIME: "nodejs22"
          YC_FUNCTION_ENTRYPOINT: "index.handler"
          # The cube exchanges the {{ src-name }} token for the {{ yandex-cloud }} IAM token
          # and saves it to the `IAM_TOKEN` variable within the `outputs` section.
        cubes:
          - name: get-iam-token
            env:
              ID_TOKEN: ${{ tokens.<token_name>.id_token}}
              YC_SA_ID: ${{ tokens.<token_name>.service_account_id }}
            image: {{ registry }}/sourcecraft/yc-iam:latest

          # The cube with pre-installed {{ yandex-cloud }} CLI retrieves 
          # the `IAM_TOKEN` variable from `outputs` and uses it to check if there is a function from {{ sf-name }}
          # with a certain name; if that function does not exist, the cube creates it.
          - name: check-and-create-function
            env:
              # Substitute to the `outputs` section the name of the IAM token cube,
              # e.g., `get-iam-token`.
              YC_IAM_TOKEN: ${{ cubes.<IAM_token_cube_name>.outputs.IAM_TOKEN }}
              YC_FOLDER_ID: ${{ tokens.<token_name>.folder_id }}
            image:
              name: {{ registry }}/sourcecraft/yc-cli:latest
              entrypoint: ""
            script:
              - |
                yc config set folder-id $YC_FOLDER_ID
                echo "Checking if function exists..."
                if ! yc serverless function get --name=$YC_FUNCTION_NAME; then
                  echo "Function does not exist. Creating new function..."
                  yc serverless function create --name=$YC_FUNCTION_NAME
                else
                  echo "Function already exists. Proceeding to version deployment..."
                fi

          # The cube with pre-installed {{ yandex-cloud }} CLI retrieves 
          # the `IAM_TOKEN` variable from `outputs` and uses it to create a new version of the function from {{ sf-name }}.
          - name: deploy-function-version
            env:
              # Substitute to the `outputs` section the name of the IAM token cube,
              # e.g., `get-iam-token`.
              YC_IAM_TOKEN: ${{ cubes.<IAM_token_cube_name>.outputs.IAM_TOKEN }}
              YC_FOLDER_ID: ${{ tokens.<token_name>.folder_id }}
            image:
              name: {{ registry }}/sourcecraft/yc-cli:latest
              entrypoint: ""
            script:
              - mkdir -p ./tmp
              - cp "$SOURCE_PATH"/*.js* ./tmp
              - echo "Deploying new function version..."
              - |
                yc config set folder-id $YC_FOLDER_ID
                yc serverless function version create \
                  --function-name=$YC_FUNCTION_NAME \
                  --runtime $YC_FUNCTION_RUNTIME \
                  --entrypoint $YC_FUNCTION_ENTRYPOINT \
                  --execution-timeout 5s \
                  --source-path ./tmp
```

{% endcut %}

## Test CI/CD {#check-ci-cd}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.ui_modules_orgCommon.link_your-craftspace }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_lib.repositories }}**.
  1. Select the repository you created earlier.
  1. Under ![image](../../_assets/console-icons/code.svg) **{{ ui-key.sourcecraft.ui_modules_repo.title_navigation-code }}** on the repository page, go to ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.ui_modules_repo.action_cicd }}**.
  1. In the automation executions list, you will see a new execution with the ![image](../../_assets/console-icons/circle.svg) **{{ ui-key.sourcecraft.ui_modules_cicd.value_status-created }}** status. Wait for the status to change to ![image](../../_assets/console-icons/circle-check.svg) **{{ ui-key.sourcecraft.ui_modules_cicd.value_succeeded }}**.

{% endlist %}

## Check that the function was created {#check-function}

Make sure in {{ sf-name }} there is now a function with the name you specified in `.sourcecraft/ci.yaml`, e.g., `test-function-nodejs`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you previously created the service account.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. The list should now contain `test-function-nodejs`. Select it.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, you should now see the function's version with the same timestamp as the [CI/CD process execution](#check-ci-cd).
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
  1. In the code editor, `index.js` should now feature this code:

      ```javascript
      // Example Node.js function handler
          export const handler = async function (event, context) {
              // Log the incoming event for debugging
              console.log('Received event:', event);

              // Access request body (if it's a POST request)
              const requestBody = event.body ? JSON.parse(event.body) : {};

              // Access query parameters
              const name = event.queryStringParameters ? event.queryStringParameters.name : 'World';

              return {
                  statusCode: 200,
                  headers: {
                      'Content-Type': 'application/json',
                  },
                  body: JSON.stringify({
                      message: `Hello, ${name}! Your request body was:`,
                      data: requestBody,
                  }),
              };
          };
      ```

- CLI {#cli}

  1. Get a list of functions in the folder specified in `.sourcecraft/ci.yaml`:

      ```bash
      yc serverless function list
      ```

      Result:

      ```text
      +----------------------+----------------------+----------------------+--------+
      |          ID          |         NAME         |      FOLDER ID       | STATUS |
      +----------------------+----------------------+----------------------+--------+
      | b097d9ous3ge******** | test-function-nodejs | aoek49ghmknn******** | ACTIVE |
      +----------------------+----------------------+----------------------+--------+
      ```

      The command output should now contain the function named `test-function-nodejs` .

  1. Get a list of versions of the `test-function-nodejs` function:

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

  The list should now feature the `test-function-nodejs` function.

  To get a list of function versions, use the [listVersions](../../functions/functions/api-ref/Function/listVersions.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/ListVersions](../../functions/functions/api-ref/grpc/Function/listVersions.md) gRPC API call.

  The list should now contain a new version of the function with the same timestamp as the [CI/CD process execution](#check-ci-cd).

{% endlist %}

## Delete the resources you created {#clear-out}

If you no longer need the resources you created, delete them:

1. [Delete the function](../../functions/operations/function/function-delete.md).
1. [Delete the service account](../../iam/operations/sa/delete.md).

## See also {#see-also}

* [Setting up CI/CD to deploy an application to {{ serverless-containers-full-name }} using GitHub Actions]({{ link-src-docs }}/sourcecraft/tutorials/ci-cd-sourcecraft-github-actions)
* [Configuring a service connection to {{ yandex-cloud }} in {{ src-name }}]({{ link-src-docs }}/sourcecraft/operations/service-connections)
* [Integration with GitHub Actions in {{ src-name }}]({{ link-src-docs }}/sourcecraft/concepts/gh-actions)
* [yc-cloud-functions-template]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template) repository in {{ src-name }}
* [yc-ci-cd-serverless]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless) repository in {{ src-name }}