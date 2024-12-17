# Getting the Lockbox secret value on the GitHub side

[Workload Identity Federations](../../iam/concepts/workload-identity.md) allow you to configure a link between external systems and {{ yandex-cloud }} via the [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC) protocol. This allows external systems to perform actions on {{ yandex-cloud }} resources on behalf of service accounts without generating static credentials, such as authorized keys or IAM tokens. This is a more secure method that minimizes the risk of credential leakage and the possibility of unauthorized access.

This tutorial shows you as an example how to get the [{{ lockbox-full-name }}](../../lockbox/) [secret](../../lockbox/concepts/secret.md) value from the GitHub side under a {{ yandex-cloud }} service account. Similarly, you can perform any action via the {{ yandex-cloud }} [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.yaml), or [{{ TF }}]({{ tf-provider-link }}).

To get the {{ lockbox-name }} secret value under a GitHub account:

1. [Create a repository in GitHub](#create-github-repo).
1. [Prepare your cloud](#prepare-cloud).
1. [Configure a GitHub Actions script](#github-actions-workflow).

If you no longer need the resources you created, [delete them](#clear-out).

## Create a repository in GitHub {#create-github-repo}

[Create](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository) a new GitHub repository or use an existing one where you have permissions to view and run GitHub Actions.

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes a fee for storing a [secret](../../lockbox/concepts/secret.md) and requests to it (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).


### Create a service account federation {#federation-iam-accounts}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder you want to create a service account federation in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Go to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
   1. Click **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
   1. In the **{{ ui-key.yacloud.iam.federations.field_issuer }}** field, enter the OIDC provider's URL: `https://token.actions.githubusercontent.com`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_audiences }}** field, enter the token recipient: `https://github.com/<github_user_name>`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_jwks }}** field, enter the URL of the public key list: `https://token.actions.githubusercontent.com/.well-known/jwks`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_name }}** field, enter a name for the federation, e.g., `test-iam-federation`.
   1. Click **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

{% endlist %}

### Create a custom secret

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a secret.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret: `MY_SECRET`.
   1. Select **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
   1. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter a non-secret ID, e.g., `secret`.
   1. In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the confidential data you want to store.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create a service account.

1. Create a service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, e.g., `sa-lockbox`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   {% endlist %}

1. Assign the `{{ roles-lockbox-payloadviewer }}` [role](../../iam/concepts/access-control/roles.md) for the folder to the service account: 

   {% list tabs group=instructions %}

   - Management console {#console}

      1. On the management console [home page]({{ link-console-main }}), select a folder.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `sa-lockbox` account in the list and click ![image](../../_assets/console-icons/ellipsis.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** in the dialog that opens and select the `{{ roles-lockbox-payloadviewer }}` role.

   {% endlist %}

### Link the service account to the Federation

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account was created in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. From the list, select the `sa-lockbox` service account.
   1. Go to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
   1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
   1. In the **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** field, select the federation you created earlier.
   1. In the **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** field, specify the external account ID: `repo:<github_user_name>/<github_repository_name>:ref:refs/heads/main`.
   1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

{% endlist %}

## Configure a GitHub Actions script {#github-actions-workflow}

1. Clone your repository if you have not done so already:

   ```bash
   git clone <repository_URL>
   ```

1. In a local copy of your repository, create a file named `blank.yml` in the `.github/workflows` directory.
1. Insert the following code into the `blank.yml` file that will get the value of the {{ lockbox-name }} secret:

   ```yaml
   name: CI

   permissions:
     id-token: write # Required to request a JWT token

   # Controls when the workflow will run
   on:
     # Runs a script on push or pull request in the _main_ branch
     push:
       branches: [ "main" ]
     pull_request:
       branches: [ "main" ]
   
     # Allows running a script manually in the Actions tab
     workflow_dispatch:

   jobs:
     job:
       runs-on: ubuntu-latest
       steps:
       - name: Install OIDC Client from Core Package
         run: npm install @actions/core @actions/http-client
       # Getting the workflow task token
       - name: Get Id Token
         uses: actions/github-script@v7
         id: tokenid
         with:
           script: |
             const coredemo = require('@actions/core')
             let id_token = await coredemo.getIDToken()
             coredemo.setOutput('id_token', id_token)
       # Exchanging the workflow task token for an IAM token of a service account in {{ yandex-cloud }}
       - name: GetIAMToken
         run: |
           SA_ID="<service_account_ID>"
           IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=$SA_ID&subject_token= $not_var{{steps.tokenid.outputs.id_token}}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')
           echo "IAMToken=${IAMTOKEN}" >> $GITHUB_OUTPUT
         id: IAMtoken
       # Requesting secret value via the API using an IAM token in {{ yandex-cloud }}
       - name: GetLockboxPayload
         run: |
           SECRET_ID="<secret_ID>"
           SECRET_DATA=$(curl -sH "Authorization: Bearer $not_var{{steps.IAMtoken.outputs.IAMTOKEN}}" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload)
           echo "SECRET_DATA=${SECRET_DATA}" >> $GITHUB_OUTPUT
         id: getlockboxpayload
   ```

   Where:
   * `SA_ID`: Service account ID.
   * `SECRET_ID`: Custom secret ID.

1. Save the file and submit the changes to the remote repository:

   ```bash
   git add . && git commit -m "Added blank.yml" && git push
   ```

   Once you submit the code to the repository, the workflow will begin. You can see the script execution result logged on your repository's `Actions` tab:

   ```json
   {
   "entries": [
   {
      "key": "secret",
      "textValue": "67cH2£?pO********"
   }
   ],
   "versionId": "e6q8isknpcp7********"
   }
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [{{ lockbox-name }}](../../lockbox/operations/secret-delete.md) secret
* [Service account](../../iam/operations/sa/delete.md)

## See also {#see-also}

* [{#T}](../../tutorials/security/gitlab-lockbox-integration.md)