# Getting the Lockbox secret value on the {{ GL }} side

[Workload Identity Federations](../../iam/concepts/workload-identity) allow you to configure a link between external systems and {{ yandex-cloud }} via the [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC) protocol. This allows external systems to perform actions on {{ yandex-cloud }} resources on behalf of service accounts without generating static credentials, such as authorized keys or IAM tokens. This is a more secure method that minimizes the risk of credential leakage and the possibility of unauthorized access.

This tutorial shows you as an example how to get the [{{ lockbox-full-name }}](../../lockbox/) [secret](../../lockbox/concepts/secret) value from the {{ GL }} side under a {{ yandex-cloud }} service account. Similarly, you can perform any action via the {{ yandex-cloud }} [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.yaml), or [{{ TF }}]({{ tf-provider-link }}).

To get the {{ lockbox-name }} secret value under a {{ GL }} account:

1. [Create a {{ GL }} project](#create-gitlab-project)
1. [Prepare your cloud](#prepare-cloud).
1. [Configure a {{ GL }} CI/CD script](#gitlab-actions-workflow).

If you no longer need the resources you created, [delete them](#clear-out).

## Create a {{ GL }} project {#create-gitlab-project}

[Create a new {{ GL }} project]({{ gl.docs }}/ee/user/project/) or use an existing one where you have permissions to view and run {{ GL }} CI/CD pipelines.

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes a fee for storing a [secret](../../lockbox/concepts/secret.md) and requests to it (see [{{ lockbox-name }}](../../lockbox/pricing.md) pricing).


### Create a workload identity federation {#federation-iam-accounts}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder you want to create a workload identity federation in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Go to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
   1. Click **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
   1. In the **{{ ui-key.yacloud.iam.federations.field_issuer }}** field, enter the OIDC provider's URL: `https://gitlab.com`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_audiences }}** field, enter the token recipient: `https://gitlab.com/<group_name>/<gitlab_project_name>`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_jwks }}** field, enter the URL of the public key list: `https://gitlab.com/oauth/discovery/keys`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_name }}** field, enter a name for the federation, e.g., `test-iam-federation`.
   1. Click **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

   {% note info %}

   If using a custom installation of {{ GL }}, replace `https://gitlab.com` with the address of your installation in all mentioned values.

   {% endnote %}

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

### Create a service account

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

### Link the service account to the federation

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account was created in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. From the list, select the `sa-lockbox` service account.
   1. Go to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
   1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
   1. In the **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** field, select the federation you created earlier.
   1. In the **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** field, specify the external account ID: `project_path:<group_name>/<gitlab_project_name>:ref_type:branch:ref:<repository_branch_name>`.
   1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

{% endlist %}

## Configure a {{ GL }} CI/CD script {#gitlab-ci-workflow}

1. Clone your repository if you have not done so already:

   ```bash
   git clone <repository_URL>
   ```

1. In a local copy of your repository, create a file named `.gitlab-ci.yml` in the root directory.
1. Insert the following code into the `.gitlab-ci.yml` file that will get the value of the {{ lockbox-name }} secret:

   ```yaml
   stages:
   - check_token

   check_token:
     stage: check_token
     image: 
       name: ubuntu
     id_tokens:
       GITLAB_OIDC_TOKEN:
         aud: https://gitlab.com/<group_name>/<gitlab_project_name>
     script:
      - apt update && apt install curl jq -y
      # Exchanging the workflow task token for an IAM token of a service account in {{ yandex-cloud }}
      - SA_ID="<service_account_ID>"      
      - >-
       IAM_TOKEN="$(curl -s
       -H "Content-Type: application/x-www-form-urlencoded" 
       -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=${SA_ID}&subject_token=${GITLAB_OIDC_TOKEN}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" 
       -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')"
      # Requesting secret value via the API using an IAM token in {{ yandex-cloud }}
      - SECRET_ID="<secret_ID>"
      - >-
       SECRET_DATA=$(curl -sH "Authorization: Bearer ${IAM_TOKEN}" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload)
      - echo ${SECRET_DATA}
     tags:
       - app-test
   ```

   Where:
   * `aud`: Token recipient specified when creating the workload identity federation.
   * `SA_ID`: Service account ID.
   * `SECRET_ID`: Custom secret ID.

1. Save the file and submit the changes to the remote repository:

   ```bash
   git add . && git commit -m "Added .gitlab-ci.yml" && git push
   ```

   Once you submit the code to the repository, the workflow will begin.

1. In {{ GL }} left-hand menu, navigate to **Build** → **Pipelines**.
1. Make sure the build's status is **Passed**. This means that the build was successful.
1. In the {{ GL }} left-hand menu, go to **Build** → **Jobs**.
1. Click the last completed task to see the result of executing the script in the log:

   ```json
   { "entries": [ { "key": "secret", "textValue": "67cH2£?pO********" } ], "versionId": "e6q8isknpcp7********" }
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [{{ lockbox-name }}](../../lockbox/operations/secret-delete.md) secret
* [Service account](../../iam/operations/sa/delete.md)

## See also {#see-also}

* [{#T}](../../tutorials/security/gitlab-lockbox-integration.md)
* [{#T}](../../tutorials/security/wlif-github-integration.md)