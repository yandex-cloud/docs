# Accessing the {{ yandex-cloud }} API from a {{ managed-k8s-name }} cluster using a workload identity federation in {{ iam-name }}

{% include [wlif-mk8s-description](../../_includes/managed-kubernetes/wlif-mk8s-description.md) %}

![image](../../_assets/managed-kubernetes/mk8s-wlif.svg)

{% note warning %}

Full integration with a workload identity federation via the `yc-metadata-server` DaemonSet controller on nodes for automatic exchange of {{ k8s }} service account tokens for an IAM token is available for clusters with a [current {{ k8s }} version](../../managed-kubernetes/concepts/k8s-supported-versions.md) in the `RAPID` [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md).

Partial integration with [manual exchange](#manual-token-exchange) of {{ k8s }} service account tokens for an IAM token is available for clusters with all current {{ k8s }} versions in all release channels.

{% endnote %}

This tutorial exemplifies getting the value of a {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md) from a {{ managed-k8s-name }} using an {{ iam-name }} [service account](../../iam/concepts/users/service-accounts.md). 

Similarly, you can perform any action via the [{{ yandex-cloud }} CLI](../../cli/quickstart.md), [{{ TF }}](../../terraform/quickstart.md), an [SDK](../../overview/sdk/overview.md), or the [API](../../api-design-guide/).

{% note info %}

This tutorial demonstrates an example of integrating a {{ managed-k8s-name }} cluster with a workload identity federation. For a tutorial on integrating a custom {{ k8s }} installation, see [Getting the {{ lockbox-full-name }} secret value on the custom {{ k8s }} installation side](../../tutorials/security/wlif-k8s-integration.md).

{% endnote %}

To configure access to a {{ lockbox-name }} secret from a {{ managed-k8s-name }} cluster via the {{ yandex-cloud }} API using a workload identity federation:

1. [Get your cloud ready](#prepare-cloud).
1. [Configure the {{ managed-k8s-name }} cluster](#prepare-cluster).
1. [Create a workload identity federation](#create-wlif).
1. [Set up an {{ iam-short-name }} service account](#prepare-sa).
1. [Set up an {{ k8s }} service account](#prepare-sa-k8s).
1. [Link the {{ iam-short-name }} service account to the federation](#connect-sa).
1. [Create a {{ lockbox-name }} secret](#create-secret).
1. [Test the integration](#check-integration).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Fee for computing resources and disks for {{ managed-k8s-name }} cluster [nodes](../../managed-kubernetes/concepts/index.md#node-group) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using the {{ managed-k8s-name }} [master](../../managed-kubernetes/concepts/index.md#master) and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for a {{ managed-k8s-name }} cluster's [public IP addresses](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for storing the [secret](../../lockbox/concepts/secret.md) and requests to it (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).

## Set up a {{ managed-k8s-name }} cluster {#prepare-cluster}

{% include [wlif-mk8s-cluster-setup](../../_includes/managed-kubernetes/wlif-mk8s-cluster-setup.md) %}

## Create a workload identity federation {#create-wlif}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to access via the {{ yandex-cloud }} API.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Click **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
  1. In the **{{ ui-key.yacloud.iam.federations.field_issuer }}** field, enter the **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}** value you got earlier, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
  1. In the **{{ ui-key.yacloud.iam.federations.field_audiences }}** field, also enter the **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}** value.
  1. In the **{{ ui-key.yacloud.iam.federations.field_jwks }}** field, enter the **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-jwks-uri_x2AJJ }}** value you got earlier, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.
  1. In the **{{ ui-key.yacloud.iam.federations.field_name }}** field, enter a name for the federation, e.g., `test-iam-federation`.
  1. Click **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc iam workload-identity oidc federation create \
    --name <federation_name> \
    --issuer "<issuer_URL>" \
    --audiences "<issuer_URL>" \
    --jwks-url "<JWKS_URL>"
  ```

  Where:
  * `--name`: Name of the new federation, e.g., `test-iam-federation`.
  * `--issuer` and `--audiences`: Issuer URL value you got earlier, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
  * `--jwks-url`: JWKS URL value you got earlier, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.

  Result:

  ```text
  id: aje2c4qv19lf********
  name: test-iam-federation
  folder_id: b1gfq9pe6rd2********
  enabled: true
  audiences:
    - https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********
  issuer: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********
  jwks_url: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json
  created_at: "2024-12-28T16:04:31.530652473Z"
  ```

  Save the federation ID for later use.

- {{ TF }} {#tf}

  1. In the {{ TF }} configuration file, define the parameters of the federation you want to create:

      ```hcl
      resource "yandex_iam_workload_identity_oidc_federation" "wlif" {
        name        = "<federation_name>"
        folder_id   = "<folder_ID>"
        issuer      = "<issuer_URL>"
        audiences   = ["<issuer_URL>"]
        jwks_url    = "<JWKS_URL>"
      }
      ```

      Where:
      * `name`: Name of the new federation, e.g., `test-iam-federation`.
      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you are creating the workload identity federation in.
      * `issuer` and `audiences`: Issuer URL value you got earlier, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
      * `jwks_url`: JWKS URL value you got earlier, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm creating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Save the federation ID for later use.

- API {#api}

  To create a workload identity federation, use the [create](../../iam/workload/oidc/workload-identity/api-ref/Federation/create.md) REST API method for the [Federation](../../iam/workload/oidc/workload-identity/api-ref/Federation/index.md) resource or the [FederationService/Create](../../iam/workload/oidc/workload-identity/api-ref/grpc/Federation/create.md) gRPC API call.

{% endlist %}

{% endlist %}

## Set up an {{ iam-short-name }} service account {#prepare-sa}

1. Create a service account named {{ iam-short-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with the {{ lockbox-name }} secret.
      1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, e.g., `sa-lockbox`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
      1. Select the service account you created and save its ID, as you will need it later.

    - CLI {#cli}

      Run this command:

      ```bash
      yc iam service-account create --name sa-lockbox
      ```

      Result:

      ```text
      done (2s)
      id: aje7s96nvmdp********
      folder_id: b1gsm0k26v1l********
      created_at: "2026-03-12T12:16:01Z"
      name: sa-lockbox
      ```

      Save the {{ iam-short-name }} service account ID for later use.

    - {{ TF }} {#tf}

      1. In the configuration file, describe the resources you want to create:
    
          ```hcl
          resource "yandex_iam_service_account" "sa" {
            name        = "<service_account_name>"
            folder_id   = "<folder_ID>"
          }
          ```

          Where:
          * `name`: Service account name, e.g., `sa-lockbox`.
          * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    
      1. Make sure the configuration files are correct.

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm creating the resources.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

          Save the {{ iam-short-name }} service account ID for later use.

    - API {#api}

      Use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

    {% endlist %}

1. Assign the `{{ roles-lockbox-payloadviewer }}` [role](../../iam/concepts/access-control/roles.md) for the folder to the service account: 

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you created the service account.
      1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. In the window that opens, select **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
      1. Select the service account you created earlier.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `{{ roles-lockbox-payloadviewer }}` [role](../../lockbox/security/index.md#lockbox-payloadViewer).
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

    - CLI {#cli}

      Run this command by specifying the folder and service account IDs:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:<service_account_ID>
      ```

    - {{ TF }} {#tf}

      1. In the configuration file, describe the resources you want to create:

          ```hcl
          resource "yandex_resourcemanager_folder_iam_member" "lockbox" {
            folder_id   = "<folder_ID>"
            role        = "{{ roles-lockbox-payloadviewer }}"
            member      = "serviceAccount:<service_account_ID>"
          }
          ```

          Where:
          * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
          * `role`: Role being assigned, e.g., `{{ roles-lockbox-payloadviewer }}`.
          * `member`: [ID of the service account](../../iam/operations/sa/get-id.md) you are assigning the role to. Use this format: `serviceAccount:<service_account_ID>`.

      1. Make sure the configuration files are correct.

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm creating the resources.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    - API {#api}

      Use the [UpdateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

    {% endlist %}

## Set up an {{ k8s }} service account {#prepare-sa-k8s}

1. [Connect](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) to the {{ managed-k8s-name }} cluster using `kubectl`.
1. Create a manifest named `service-account.yaml` for the {{ k8s }} service account with the following contents:

    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: wlif
      annotations:
        yandex.cloud/federated-yc-service-account-id: <IAM_service_account_ID>
    ```

1. Apply the manifest:

    ```bash
    kubectl apply -f service-account.yaml
    ```

1. To check the `ServiceAccount` resource you created, run this command:

    ```bash
    kubectl describe serviceaccount wlif
    ```

    Result:

    ```text
    Name:                wlif
    Namespace:           default
    ...
    ```

1. Save the values of the `Name` and `Namespace` fields, as you will need them later.

## Link the {{ iam-short-name }} service account to the federation {#connect-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the service account was created in.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the list of service accounts, select `sa-lockbox`.
  1. Navigate to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** field, select the federation you created earlier.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** field, specify the ID of the previously created {{ k8s }} service account in `system:serviceaccount:<namespace>:<{{ k8s }}_service_account_name>` format, where:
      * `namespace`: {{ k8s }} service account's `Namespace` field value, e.g., `default`.
      * `account_name`: {{ k8s }} service account's `Name` field value, e.g., `wlif`.

  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc iam workload-identity federated-credential create \
    --service-account-id <{{ iam-short-name }}_service_account_ID> \
    --federation-id <federation_ID> \
    --external-subject-id "system:serviceaccount:<namespace>:<{{ k8s }}_service_account_name>"
  ```

  Where:
  * `--service-account-id`: {{ iam-short-name }} service account ID you got earlier.
  * `--federation-id`: Workload identity federation ID you got earlier.
  * `--external-subject-id`: External subject ID, where:
    * `namespace`: {{ k8s }} service account's `Namespace` field value, e.g., `default`.
    * `{{ k8s }}_service_account_name`: {{ k8s }} service account's `Name` field value, e.g., `wlif`.

  Result:

  ```text
  id: aje401v1sup8********
  service_account_id: ajek7v5j65cg********
  federation_id: aje2c4qv19lf********
  external_subject_id: system:serviceaccount:default:wlif
  created_at: "2024-12-28T16:33:47.057632267Z"
  ```

- {{ TF }} {#tf}

  1. In the {{ TF }} configuration file, define the parameters of the federated credentials you want to create:

      ```hcl
      resource "yandex_iam_workload_identity_federated_credential" "fc" {
        service_account_id  = "<service_account_ID>"
        federation_id       = "<federation_ID>"
        external_subject_id = "system:serviceaccount:<namespace>:<{{ k8s }}_service_account_name>"
      }
      ```

      Where:
      * `service_account_id`: {{ iam-short-name }} service account ID you got earlier.
      * `federation_id`: Workload identity federation ID you got earlier.
      * `external-subject-id`: External subject ID, where:
        * `namespace`: {{ k8s }} service account's `Namespace` field value, e.g., `default`.
        * `external_subject_id_service_account_name`: {{ k8s }} service account's `Name` field value, e.g., `wlif`.

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm creating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  To create federated credentials, use the [create](../../iam/workload/workload-identity/api-ref/FederatedCredential/create.md) REST API method for the [FederatedCredential](../../iam/workload/workload-identity/api-ref/FederatedCredential/index.md) resource or the [FederatedCredentialService/Create](../../iam/workload/workload-identity/api-ref/grpc/FederatedCredential/create.md) gRPC API call.

{% endlist %}

## Create a {{ lockbox-name }} secret {#create-secret}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your secret.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret: `MY_SECRET`.
  1. Select **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter a non-secret ID, e.g., `test-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the confidential data you want to store, e.g., `hello-world`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Save the ID of the secret. You will need it later.

- CLI {#cli}

  Run this command:

  ```bash
  yc lockbox secret create \
    --name <secret_name> \
    --payload "<array_with_secret_contents>" \
  ```

  Where:
  * `--name`: Secret name, e.g., `MY_SECRET`.
  * `--payload`: Secret contents as a YAML or JSON array, e.g., `"[{'key': 'test-secret', 'text_value': 'hello-world'}]"`.

  Result:
  
  ```text
  done (1s)
  id: e6qduvprvcon********
  folder_id: b1gsm0k26v1l********
  created_at: "2026-03-12T13:02:15.543Z"
  name: MY_SECRET
  status: ACTIVE
  current_version:
    id: e6qr13mvsl8t********
    secret_id: e6qduvprvcon********
    created_at: "2026-03-12T13:02:15.543Z"
    status: ACTIVE
    payload_entry_keys:
      - test-secret
  ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the secret parameters:

     ```hcl
     resource "yandex_lockbox_secret" "my_secret" {
       name = "<secret_name>"
     }
     ```

     Where `name` is the secret's name, e.g., `MY_SECRET`.


  1. Check the secret's configuration for validity.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm creating the secret.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Save the ID of the secret. You will need it later.

  1. Describe the secret's content properties in the configuration file:

      ```hcl
      resource "yandex_lockbox_secret_version_hashed" "my_version" {
        secret_id    = "<secret_ID>"
        key_1        = "<secret_1_key>"
        text_value_1 = "<secret_1_value>"

      }
      ```

      Where:

      * `secret_id`: ID of the secret you are creating a version for.
      * `key_1`: Secret key. A non-secret name for the value by which you will identify it, such as `test-secret`.
      * `text_value_1`: Secret data in plain text, e.g., `hello-world`.

  1. Check the secret's content configuration for validity.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm creating the secret's content.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

{% endlist %}

## Test the integration {#check-integration}

{% note tip %}

Below is a scenario that uses the `yc-metadata-server` DaemonSet controller on nodes for automatic exchange of {{ k8s }} service account tokens for an IAM token available to clusters in the `RAPID` [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md). For clusters in other release channels, see [{#T}](#manual-token-exchange).

{% endnote %}

1. [Connect](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) to the {{ managed-k8s-name }} cluster using `kubectl`.
1. Create a test pod manifest named `pod.yaml` with the following contents:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: test-wlif
    spec:
      containers:
        - image: nginx
          name: nginx
      serviceAccountName: wlif
    ```

    Where `spec:serviceAccountName` is the name of the {{ k8s }} service account you created earlier.

1. Apply the manifest:

    ```bash
    kubectl apply -f pod.yaml
    ```

1. Make sure the status of the new pod switched to `Running`:

    ```bash
    kubectl get pod test-wlif
    ```

    Result:

    ```
    NAME        READY   STATUS    RESTARTS   AGE
    test-wlif   1/1     Running   0          1m
    ```

1. Access the container:

    ```bash
    kubectl exec test-wlif -it -- bash
    ```

1. Install `jq`:

    ```bash
    apt-get update >/dev/null 2>&1 && apt-get install -y jq >/dev/null 2>&1
    ```

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md):

    ```bash
    IAMTOKEN=$(curl -s -H 'Metadata-Flavor: Google' \
      http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token \
      | jq -r '.access_token')
    ```

1. Get the {{ lockbox-name }} secret:

    ```bash
    curl -sH "Authorization: Bearer ${IAMTOKEN}" \
      "https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/<secret_ID>/payload"
    ```

    Result:

    ```json
    {
     "entries": [
      {
       "key": "test-secret",
       "textValue": "hello-world"
      }
     ],
     "versionId": "e6qsqiadrsnh********"
    }
    ```

### Manual exchange of a {{ k8s }} service account token for an IAM token {#manual-token-exchange}

1. [Connect](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) to the {{ managed-k8s-name }} cluster using `kubectl`.
1. Create a test pod manifest named `pod.yaml` with the following contents:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: test-wlif
    spec:
      containers:
        - image: nginx
          name: nginx
          volumeMounts:
            - mountPath: /var/run/secrets/tokens
              name: sa-token
      serviceAccountName: wlif
      volumes:
        - name: sa-token
          projected:
            sources:
              - serviceAccountToken:
                path: sa-token
                expirationSeconds: 7200
                audience: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********
    ```

    Where:
    * `spec:serviceAccountName`: Name of the {{ k8s }} service account you created earlier.
    * `spec:volumes:projected:sources:serviceAccountToken:audience`: **{{ ui-key.yacloud.iam.federations.field_audiences }}** value set when creating the federation.

1. Apply the manifest:

    ```bash
    kubectl apply -f pod.yaml
    ```

1. Make sure the status of the new pod switched to `Running`:

    ```bash
    kubectl get pod test-wlif
    ```

    Result:

    ```
    NAME        READY   STATUS    RESTARTS   AGE
    test-wlif   1/1     Running   0          1m
    ```

1. Access the container:

    ```bash
    kubectl exec test-wlif -it -- bash
    ```

1. Set the required variables:

    ```bash
    SA_ID="<{{ iam-short-name }}_service_account_ID>" && \
    SECRET_ID="<{{ lockbox-short-name }}_secret_ID>" && \
    SA_TOKEN="$(cat /var/run/secrets/tokens/sa-token)"
    ```

    Where:
    * `SA_ID`: {{ iam-short-name }} service account ID you got earlier.
    * `SECRET_ID`: {{ lockbox-name }} secret ID you got earlier.
    * `SA_TOKEN`: {{ k8s }} service account token.

1. Install `jq`:

    ```bash
    apt-get update >/dev/null 2>&1 && apt-get install -y jq >/dev/null 2>&1
    ```

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md):

    ```bash
    IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" \
      -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=${SA_ID}&subject_token=${SA_TOKEN}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" \
      -X POST https://{{ auth-main-host }}/oauth/token | jq -r '.access_token')
    ```

1. Get the {{ lockbox-name }} secret:

    ```bash
    curl -sH "Authorization: Bearer ${IAMTOKEN}" \
      "https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/${SECRET_ID}/payload"
    ```

    Result:

    ```json
    {
     "entries": [
      {
       "key": "test-secret",
       "textValue": "hello-world"
      }
     ],
     "versionId": "e6qsqiadrsnh********"
    }
    ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../lockbox/operations/secret-delete.md) the {{ lockbox-name }} secret.
* [Delete](../../managed-kubernetes/operations/node-group/node-group-delete.md) the {{ managed-k8s-name }} node group.
* [Delete](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ managed-k8s-name }} cluster.

### See also {#see-also}

* [{#T}](../../iam/concepts/workload-identity.md)
* [Getting the {{ lockbox-full-name }} secret value on the custom {{ k8s }} installation side](../../tutorials/security/wlif-k8s-integration.md)