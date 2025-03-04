# Getting the {{ lockbox-full-name }} secret value on the {{ k8s }} side

{% include [move-groups-api](../../_includes/iam/wlif-instructions-intro.md) %}

This tutorial shows you as an example how to get the [{{ lockbox-full-name }}](../../lockbox/) [secret](../../lockbox/concepts/secret) value from the {{ k8s }} side under a {{ yandex-cloud }} service account. Similarly, you can perform any action via the {{ yandex-cloud }} [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.yaml), or [{{ TF }}]({{ tf-provider-link }}).

{% note warning %}

Currently, you cannot set up a link between a workload identity federation and a {{ managed-k8s-full-name }} cluster. Only custom {{ k8s }} installations are supported.

{% endnote %}

To get the {{ lockbox-name }} secret value under a {{ k8s }} account:

1. [Prepare the {{ k8s }} cluster](#prepare-k8s-cluster).
1. [Get your cloud ready](#prepare-cloud).
1. [Configure a scenario in {{ k8s }}](#k8s-workflow).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the {{ k8s }} cluster {#prepare-k8s-cluster}

1. Create a new {{ k8s }} cluster or use an existing one.

   Make sure your cluster meets the following requirements:

   * You are using {{ k8s }} 1.20 or higher.
      Earlier {{ k8s }} versions use a different `ServiceAccount` token format incompatible with the instructions provided here.
   * You have configured `kube-apiserver` to [support projection of `ServiceAccount` tokens](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#serviceaccount-token-volume-projection).

   {% note info %}

   This tutorial applies to both public and private {{ k8s }} clusters.

   {% endnote %}

1. Create a manifest named `service-account.yaml` with the following contents:

   ```yaml
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: wlif
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
   ```
   Name:                wlif
   Namespace:           default
   ```

   You will need the `Name` and `Namespace` field values to further configure integration on the {{ yandex-cloud }} side.

1. Create a manifest named `pod.yaml` with the following contents:

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
             audience: ycaud
   ```

   In the `audience` field, specify the token recipient, e.g., `ycaud`.

1. Apply the manifest:

   ```bash
   kubectl apply -f pod.yaml
   ```

1. Make sure the pod you created has the `RUNNING` status:

   ```bash
   kubectl get pod test-wlif
   ```

   Result:

   ```
   NAME        READY   STATUS    RESTARTS   AGE
   test-wlif   1/1     Running   0          1m
   ```

1. Get `URL Issuer` for your {{ k8s }} cluster:

   ```bash
   kubectl get --raw /.well-known/openid-configuration | jq -r .issuer
   ```

1. Create a file with a public key set (JWKS):
   
   ```bash
   kubectl get --raw /openid/v1/jwks > cluster-jwks.json
   ```

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:
1. Fee for storing the [secret](../../lockbox/concepts/secret.md) and requests to the secret (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).
1. Fee for data storage in a bucket and data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).

### Upload a file with a public key set to a public bucket

1. Create a public bucket:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
      1. Select **{{ objstorage-name }}**.
      1. In the top panel, click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
      1. On the bucket creation page:
         1. Enter a name for the bucket according to the [naming requirements](../../storage/concepts/bucket.md#naming).
         
         1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** field, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.

         1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

   {% endlist %}

1. Upload the `cluster-jwks.json` file you created earlier into the bucket:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the new bucket.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
      1. Click **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
      1. In the top panel, click ![image](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
      1. In the window that opens, select the `cluster-jwks.json` file and click **Open**.
      1. Click **{{ ui-key.yacloud.storage.button_upload }}**.
      1. Refresh the page.

   {% endlist %}

1. Get a link to the uploaded file:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Click the file name.
      1. Click ![link](../../_assets/storage/link.svg) **{{ ui-key.yacloud.storage.file.button_generate }}** in the top-right corner.
      1. Copy the link.

   {% endlist %}

### Create a workload identity federation {#federation-iam-accounts}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a workload identity federation.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. In the left-hand panel, select ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
   1. Click **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
   1. In the **{{ ui-key.yacloud.iam.federations.field_issuer }}** field, enter `URL Issuer` for your {{ k8s }} cluster, which you got earlier, e.g., `https://kubernetes.default.svc.cluster.local`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_audiences }}** field, enter the token recipient you specified when creating the pod, e.g., `ycaud`.
   1. In the **{{ ui-key.yacloud.iam.federations.field_jwks }}** field, enter a link to the `cluster-jwks.json` file in the bucket.
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
      1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, e.g., `sa-lockbox`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   {% endlist %}

1. Assign the `{{ roles-lockbox-payloadviewer }}` [role](../../iam/concepts/access-control/roles.md) for the folder to the service account: 

   {% list tabs group=instructions %}

   - Management console {#console}

      1. On the management console [home page]({{ link-console-main }}), select a folder.
      1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `sa-lockbox` account in the list and click ![image](../../_assets/console-icons/ellipsis.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** in the dialog that opens and select the `{{ roles-lockbox-payloadviewer }}` role.

   {% endlist %}

### Link the service account to the Federation

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account was created in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. In the list of service accounts, select `sa-lockbox`.
   1. Navigate to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
   1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
   1. In the **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** field, select the federation you created earlier.
   1. In the **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** field, specify the external account ID: `system:serviceaccount:<namespace>:<account_name>`.
   
      Where:
      * `namespace`: The `Namespace` field value in the output of the `kubectl describe serviceaccount <account_name>` command, e.g., `default`.
      * `account_name`: Name of the account you created, e.g., `wlif`.

   1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

{% endlist %}

## Configure a scenario in {{ k8s }} {#k8s-workflow}

1. Fill in the variables:

   ```bash
   SA_ID="<service_account_ID>"
   SECRET_ID="<secret_ID>"
   ```

   Where:
   * `SA_ID`: Service account ID.
   * `SECRET_ID`: Custom secret ID.

1. Get the {{ k8s }} service account token:

   ```bash
   SA_TOKEN=`kubectl exec -it test-wlif -- cat /var/run/secrets/tokens/sa-token`
   ```

1. Exchange the {{ k8s }} service account token for the IAM token of the {{ yandex-cloud }} service account:
   
   ```bash
   IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=$SA_ID&subject_token=$SA_TOKEN&subject_token_type=urn:ietf:params:oauth:token-type:id_token" -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')
   ```

1. Request the secret via the API using the {{ yandex-cloud }} IAM token:

   ```bash
   SECRET_DATA=$(curl -sH "Authorization: Bearer ${IAMTOKEN}" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload)
   echo ${SECRET_DATA}
   ```

   Result:

   ```json
   { "entries": [ { "key": "secret", "textValue": "67cH2£?pO********" } ], "versionId": "e6q8isknpcp7********" }
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [{{ lockbox-name }} secret](../../lockbox/operations/secret-delete.md) 
* [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md)
* [Service account](../../iam/operations/sa/delete.md)

## See also {#see-also}

* [{#T}](../../tutorials/security/wlif-gitlab-integration.md)
* [{#T}](../../tutorials/security/wlif-github-integration.md)