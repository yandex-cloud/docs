

[GitHub](https://github.com/) allows storing function code from [{{ sf-full-name }}](../../functions/) and deploying new [function](../../functions/concepts/function.md) versions if there are updates in the repository.

In this tutorial, you will set up CI/CD between {{ sf-name }} and GitHub using a [{{ iam-full-name }}](../../iam/) workload identity federation and deploy functions from {{ sf-name }} by running GitHub Actions [workflows](https://docs.github.com/{{ lang }}/actions/concepts/workflows-and-actions/workflows).

To set up CI/CD:

1. [Get your cloud ready](#before-begin).
1. [Create a repository](#create-repository).
1. [Set up your infrastructure in {{ yandex-cloud }}](#prepare-infrastructure).
1. [Configure the repository](#configure-repo).
1. [Test the workflows](#check).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost for this tutorial includes:

* Fee for the number of function calls, computing resources allocated to a function, and outbound traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for function logging and log storage in a [log group](../../logging/concepts/log-group.md) (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).


## Create a repository {#create-repository}

[Create](https://docs.github.com/{{ lang }}/repositories/creating-and-managing-repositories/creating-a-new-repository) a new GitHub repository or use an existing one where you have permissions to view and run GitHub Actions.

You will need the GitHub repository and user names later.


## Set up your infrastructure in {{ yandex-cloud }} {#prepare-infrastructure}

### Create a service account {#create-sa}

GitHub will use a [service account](../../iam/concepts/users/service-accounts.md) with the `{{ roles-functions-admin }}` [role](../../functions/security/index.md#functions-admin) to create a function and its versions.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter the service account name: `ci-cd-github-sa`.
  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `{{ roles-functions-admin }}`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install.md](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account:

      ```bash
      yc iam service-account create --name ci-cd-github-sa
      ```

      Result:

      ```text
      id: ajehqs5gee2e********
      folder_id: b1g681qpemb4********
      created_at: "2025-07-12T17:53:28.180991864Z"
      name: ci-cd-github-sa
      ```

  1. Assign the `{{ roles-functions-admin }}` role to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role {{ roles-functions-admin }} \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: {{ roles-functions-admin }}
            subject:
              id: ajejocsfa1jj********
              type: serviceAccount
      ```

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the service account the `{{ roles-functions-admin }}` role for the folder, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

{% endlist %}


### Create a workload identity federation {#create-federation}

You need a [workload identity federation](../../iam/concepts/workload-identity.md) to set up the exchange of GitHub tokens for {{ yandex-cloud }} [IAM tokens](../../iam/concepts/authorization/iam-token.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Click **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
  1. In the **{{ ui-key.yacloud.iam.federations.field_issuer }}** field, enter the OIDC provider's URL: `https://token.actions.githubusercontent.com`.
  1. In the **{{ ui-key.yacloud.iam.federations.field_audiences }}** field, enter the token recipient: `https://github.com/<GitHub_user_name>`.
  1. In the **{{ ui-key.yacloud.iam.federations.field_jwks }}** field, enter the URL of the public key list: `https://token.actions.githubusercontent.com/.well-known/jwks`.
  1. In the **{{ ui-key.yacloud.iam.federations.field_name }}** field, enter the federation name: `ci-cd-github-federation`.
  1. Click **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc iam workload-identity oidc federation create \
    --name ci-cd-github-federation \
    --issuer "https://token.actions.githubusercontent.com" \
    --audiences "https://github.com/<GitHub_user_name>" \
    --jwks-url "https://token.actions.githubusercontent.com/.well-known/jwks"
  ```

  Where:

  * `--name`: Name of the new federation.
  * `--issuer`: URL of the OIDC provider.
  * `--audiences`: Resources to issue the token for. You can specify multiple resources at once, separated by commas.
  * `--jwks-url`: URL for retrieving the current public key issued by the OIDC provider and used for [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token) signature verification.

  Result:

  ```text
  id: ajeoerss1fa4********
  name: ci-cd-github-federation
  folder_id: b1g681qpemb4********
  enabled: true
  audiences:
    - https://github.com/eip********
  issuer: https://token.actions.githubusercontent.com
  jwks_url: https://token.actions.githubusercontent.com/.well-known/jwks
  created_at: "2025-07-24T18:20:33.546066838Z"
  ```

- API {#api}

  To create a workload identity federation, use the [create](../../iam/workload/oidc/workload-identity/api-ref/Federation/create.md) REST API method for the [Federation](../../iam/workload/oidc/workload-identity/api-ref/Federation/index.md) resource or the [FederationService/Create](../../iam/workload/oidc/workload-identity/api-ref/grpc/Federation/create.md) gRPC API call.

  In the request, specify the following settings:

  * `issuer`: `https://token.actions.githubusercontent.com`
  * `audiences`: `https://github.com/<GitHub_user_name>`
  * `jwks-url`/`jwks_url`: `https://token.actions.githubusercontent.com/.well-known/jwks`

{% endlist %}


### Create federated credentials for the service account {#create-credential}

With [federated credentials](../../iam/concepts/workload-identity.md#federated-credentials), you will set up a link between a workload identity federation, your service account, and GitHub.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Select the `ci-cd-github-sa` service account.
  1. Navigate to the ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}** tab.
  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** field, select `ci-cd-github-federation`.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** field, specify the external subject ID for your test environment: `repo:<GitHub_user_name>/<repository_name>:environment:preprod`.

      The `preprod` environment will be later used in the `ci.yml` and `ct.yml` files.

  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

  In a similar way, create federated credentials with the external subject ID for the production environment: `repo:<GitHub_user_name>/<repository_name>:ref:refs/heads/main`.

- {{ yandex-cloud }} CLI {#cli}

  To create federated credentials for your test and production environments, run the following commands:

  ```bash
  yc iam workload-identity federated-credential create \
    --service-account-id <service_account_ID> \
    --federation-id <federation_ID> \
    --external-subject-id "repo:<GitHub_user_name>/<repository_name>:environment:preprod"

  yc iam workload-identity federated-credential create \
    --service-account-id <service_account_ID> \
    --federation-id <federation_ID> \
    --external-subject-id "repo:<GitHub_user_name>/<repository_name>:ref:refs/heads/main"
  ```

  Where:

  * `--service-account-id`: `ci-cd-github-sa` service account ID.
  * `--federation-id`: ID of the `ci-cd-github-federation` workload identity federation.
  * `--external-subject-id`: External subject ID.

      The `preprod` environment will be later used in the `ci.yml` and `ct.yml` files.

  Result:

  ```text
  id: ajek9t6ojc53********
  service_account_id: ajejocsfa1jj********
  federation_id: ajeoerss1fa4********
  external_subject_id: repo:eip********/ci-cd-github-repo:environment:preprod
  created_at: "2025-07-24T18:21:01.103940710Z"

  id: aje82obioirm********
  service_account_id: ajejocsfa1jj********
  federation_id: ajeoerss1fa4********
  external_subject_id: repo:eip********/ci-cd-github-repo:ref:refs/heads/main
  created_at: "2025-07-24T18:21:13.925210300Z"
  ```

- API {#api}

  To create federated credentials, use the [create](../../iam/workload/workload-identity/api-ref/FederatedCredential/create.md) REST API method for the [FederatedCredential](../../iam/workload/workload-identity/api-ref/FederatedCredential/index.md) resource or the [FederatedCredentialService/Create](../../iam/workload/workload-identity/api-ref/grpc/FederatedCredential/create.md) gRPC API call.

  In the request, set the `externalSubjectId`/`external_subject_id` parameter as follows:

  * For the test environment: `repo:<GitHub_user_name>/<repository_name>:environment:preprod`.

      The `preprod` environment will be later used in the `ci.yml` and `ct.yml` files.

  * For the production environment: `repo:<GitHub_user_name>/<repository_name>:ref:refs/heads/main`.

{% endlist %}


## Configure the repository {#configure-repo}

### Prepare the project files {#prepare-files}

{% list tabs %}

- Repository

  Clone the repository:

  ```bash
  git clone https://github.com/yandex-cloud-examples/yc-serverless-ci-cd-github
  ```

  In the repository, you will see:

  * `.github/workflows` folder with workflow files: `cd.yml`, `ci.yml`, and `ct.yml`.
  * `index.js` function code with dependencies described in `package.json` and `package-lock.json`.

- Manually

  1. Create a directory named `yc-serverless-ci-cd-github` and open it.
  1. Create a file named `index.js` and paste this code into it:

      ```javascript
      const sharp = require('sharp');

      async function cropImage(imageBase64, width, height) {
          try {
              // Decode image from base64
              const buffer = Buffer.from(imageBase64, 'base64');

              const croppedBuffer = await sharp(buffer)
                  .resize(width, height) 
                  .toBuffer(); 

              const croppedImageBase64 = croppedBuffer.toString('base64');
              return croppedImageBase64;
          } catch (error) {
              console.error('Error cropping image:', error);
              throw error;
          }
      }

      module.exports.handler = async function (event, context) {
          return {
              content: await cropImage(event.queryStringParameters.content, event.queryStringParameters.width, event.queryStringParameters.height)
          };
      };
      ```

  1. Create a file named `package.json` and paste this code into it:

      ```json
      {
        "name": "from-github",
        "version": "1.0.0"
      }
      ```

  1. Run this command:

      ```bash
      npm install --package-lock-only
      ```

      The command will create the `package-lock.json` file.

  1. Create the `cd.yml`, `ci.yml`, and `ct.yml` files and paste the code with the parameters you need:

      {% cut "**cd.yml**" %}

      ```yml
      permissions:
        id-token: write # Required to request a JWT

      on: 
        push:
          branches:
            - main
          paths-ignore:
            - '.github/**' # To ignore changes in workflow files

        release:
          types:
            - published

        # Enables running this workflow manually from the Actions tab
        workflow_dispatch:

      env:
        FOLDER_ID: <folder_ID>
        SA_ID: <service_account_ID>
        FUNCTION_NAME: from-github-cd
        FUNCTION_RUNTIME: nodejs22
        FUNCTION_ENTRYPOINT: index.handler
        FUNCTION_MEMORY: "128mb"
        FUNCTION_SOURCEROOT: .
        
      jobs:
        build:
          runs-on: ubuntu-latest
          
          steps:
            - uses: actions/checkout@v4
            - name: Deploy Function
              id: sls-func
              uses: yc-actions/yc-sls-function@v3.1.0
              with:
                yc-sa-id: $not_var{{env.SA_ID}}
                folder-id: $not_var{{env.FOLDER_ID}}
                function-name: $not_var{{env.FUNCTION_NAME}}
                runtime: $not_var{{env.FUNCTION_RUNTIME}}
                entrypoint: $not_var{{env.FUNCTION_ENTRYPOINT}}
                memory: $not_var{{env.FUNCTION_MEMORY}}
                source-root: $not_var{{env.FUNCTION_SOURCEROOT}}
                include: |
                  **/*.json
                  **/*.js
      ```

      {% endcut %}

      {% cut "**ci.yml**" %}

      ```yml
      permissions:
        id-token: write # Required to request a JWT

      on: 
        push:
          branches: [ feature** ]
          paths-ignore:
            - '.github/**'

        # Enables running this workflow manually from the Actions tab
        workflow_dispatch:

      env:
        FOLDER_ID: <folder_ID>
        SA_ID: <service_account_ID>
        FUNCTION_NAME: from-github-ci
        FUNCTION_RUNTIME: nodejs22
        FUNCTION_ENTRYPOINT: index.handler
        FUNCTION_MEMORY: "128mb"
        FUNCTION_SOURCEROOT: .
        
      jobs:
        build:
          environment: preprod
          runs-on: ubuntu-latest
          
          steps:
            - uses: actions/checkout@v4
            - name: Deploy Function
              id: sls-func
              uses: yc-actions/yc-sls-function@v3.1.0
              with:
                yc-sa-id: $not_var{{env.SA_ID}}
                folder-id: $not_var{{env.FOLDER_ID}}
                function-name: $not_var{{env.FUNCTION_NAME}}
                runtime: $not_var{{env.FUNCTION_RUNTIME}}
                entrypoint: $not_var{{env.FUNCTION_ENTRYPOINT}}
                memory: $not_var{{env.FUNCTION_MEMORY}}
                source-root: $not_var{{env.FUNCTION_SOURCEROOT}}
                include: |
                  **/*.json
                  **/*.js
      ```

      {% endcut %}

      {% cut "**ct.yml**" %}

      ```yml
      permissions:
        id-token: write # Required to request a JWT

      on: 
        pull_request:
          branches: [ main ]
          paths-ignore:
            - '.github/**'
            
        # Enables running this workflow manually from the Actions tab
        workflow_dispatch:

      env:
        FOLDER_ID: <folder_ID>
        SA_ID: <service_account_ID>
        FUNCTION_NAME: from-github-ct
        FUNCTION_RUNTIME: nodejs22
        FUNCTION_ENTRYPOINT: index.handler
        FUNCTION_MEMORY: "128mb"
        FUNCTION_SOURCEROOT: .
        
      jobs:
        build:
          environment: preprod
          runs-on: ubuntu-latest
          
          steps:
            - uses: actions/checkout@v4
            - name: Deploy Function
              id: sls-func
              uses: yc-actions/yc-sls-function@v3.1.0
              with:
                yc-sa-id: $not_var{{env.SA_ID}}
                folder-id: $not_var{{env.FOLDER_ID}}
                function-name: $not_var{{env.FUNCTION_NAME}}
                runtime: $not_var{{env.FUNCTION_RUNTIME}}
                entrypoint: $not_var{{env.FUNCTION_ENTRYPOINT}}
                memory: $not_var{{env.FUNCTION_MEMORY}}
                source-root: $not_var{{env.FUNCTION_SOURCEROOT}}
                include: |
                  **/*.json
                  **/*.js
      ```

      {% endcut %}

      Where:

      * `FOLDER_ID`: ID of the folder you are using to complete this tutorial.
      * `SA_ID`: ID of the service account with federated [credentials](#create-credential).
      * `FUNCTION_NAME`: Function name. Here, examples use the following names:

          * `from-github-ci`
          * `from-github-ct`
          * `from-github-cd`

      * `FUNCTION_RUNTIME`: Function [runtime environment](../../functions/concepts/runtime/index.md).
      * `FUNCTION_ENTRYPOINT`: Function entry point.
      * `FUNCTION_MEMORY`: Function RAM amount.
      * `FUNCTION_SOURCEROOT`: Path to the function files in the repository.

{% endlist %}


### Push workflow files to the repository {#push-files}

{% list tabs %}

- CLI {#cli}

  1. Clone your repository if you have not done so already:

      ```bash
      git clone <repository_URL>
      ```

  1. Copy the workflow files you got to the local copy of your repository:

      * `.github/workflows/cd.yml`
      * `.github/workflows/ci.yml`
      * `.github/workflows/ct.yml`

  1. Push the changes to the remote repository:

      ```bash
      git add . && git commit -m "Added workflows" && git push
      ```

{% endlist %}


## Test the workflows {#check}

Run the [CI](#run-ci), [CT](#run-ct), and [CD](#run-cd) workflows one after the other and check their results.


### Run the CI workflow {#run-ci}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Switch to the `main` branch:

      ```bash
      git checkout main
      ```

  1. Pull changes from a remote repository:

      ```bash
      git pull
      ```

  1. Create a new branch, `feature/smoke-test`:

      ```bash
      git checkout -b feature/smoke-test
      ```

  1. Copy the function files to the root folder in your repository’s local copy:

      * `index.js`
      * `package.json`
      * `package-lock.json`

  1. Save, commit, and push the changes to the remote repository:

      ```bash
      git add .
      git commit -m "Added function"
      git push --set-upstream origin feature/smoke-test
      ```

      After pushing the changes, the `.github/workflows/ci.yml` workflow will start automatically.

      Wait for the workflow to complete. You can check the status and execution logs in the ![image](../../_assets/console-icons/circle-play.svg) **Actions** tab of your repository.

{% endlist %}


### Check the CI result {#check-ci}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `from-github-ci` function.
  1. Navigate to the ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. {% include [testing-function](../_tutorials_includes/ci-cd-github-functions/testing-function.md) %}

{% endlist %}


### Run the CT workflow {#run-ct}

{% list tabs group=instructions %}

- CLI {#cli}

  Using the GitHub interface, [create a pull request](https://docs.github.com/{{ lang }}/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) from the `feature/smoke-test` branch to the `main` branch.

  Once the pull request is created, the `.github/workflows/ct.yml` workflow will start automatically.

  Wait for the workflow to complete. You can check the status and execution logs in the ![image](../../_assets/console-icons/circle-play.svg) **Actions** tab of your repository.

{% endlist %}

### Check the CT result {#check-ct}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `from-github-ct` function.
  1. Navigate to the ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. {% include [testing-function](../_tutorials_includes/ci-cd-github-functions/testing-function.md) %}

{% endlist %}


### Run the CD workflow {#run-cd}

{% list tabs group=instructions %}

- CLI {#cli}

  Using the GitHub interface, [merge your pull request](https://docs.github.com/{{ lang }}/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request) into the `main` branch.

  This will automatically run the `.github/workflows/cd.yml` workflow.

  Wait for the workflow to complete. You can check the status and execution logs in the ![image](../../_assets/console-icons/circle-play.svg) **Actions** tab of your repository.

{% endlist %}

### Check the CD result {#check-cd}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `from-github-cd` function.
  1. Navigate to the ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. {% include [testing-function](../_tutorials_includes/ci-cd-github-functions/testing-function.md) %}

{% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the functions](../../functions/operations/function/function-delete.md).
1. [Delete the log group](../../logging/operations/delete-group.md).