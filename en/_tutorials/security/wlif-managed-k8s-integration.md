# Accessing the {{ yandex-cloud }} API from a {{ managed-k8s-name }} cluster using a workload identity federation in {{ iam-name }}

{% include [wlif-mk8s-description](../../_includes/managed-kubernetes/wlif-mk8s-description.md) %}

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
1. [Link the {{ iam-short-name }} service account to the federation](#connect-sa).
1. [Create a {{ lockbox-name }} secret](#create-secret).
1. [Test the integration](#check-integration).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for computing resources and disks for {{ managed-k8s-name }} cluster [nodes](../../managed-kubernetes/concepts/index.md#node-group) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using the {{ managed-k8s-name }} [master](../../managed-kubernetes/concepts/index.md#master) and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for a {{ managed-k8s-name }} cluster's [public IP addresses](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for storing the [secret](../../lockbox/concepts/secret.md) and requests to it (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).

## Set up a {{ managed-k8s-name }} cluster {#prepare-cluster}

{% note warning %}

Integration with a workload identity federation only works for {{ managed-k8s-name }} clusters 1.30 or higher in the `rapid` [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md).

To use the {{ yandex-cloud }} API, your cluster nodes must have internet access.

{% endnote %}

1. If you do not have a {{ managed-k8s-name }} cluster yet:

    1. [Create a cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md). 
    1. [Create](../../managed-kubernetes/operations/node-group/node-group-create.md) a node group.
    1. [Set up](../../managed-kubernetes/operations/connect/security-groups.md) security groups for the cluster and node group.
1. To use the {{ yandex-cloud }} API, your cluster nodes must have internet access. Make sure your cluster nodes have public IP addresses assigned to them or the subnet they reside in has a configured [NAT gateway](../../vpc/concepts/gateways.md#nat-gateway). Also make sure the security group rules allow unrestricted outgoing traffic for your cluster nodes.
1. Set up integration with a workload identity federation:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with your cluster.
      1. In the list of services, select **{{ managed-k8s-name }}**.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the cluster and select **Edit**.
      1. In the **Identity and access management** field, enable workload identity federations.
      1. Click **Save**.
      1. Under **Identity and access management** on the cluster overview page, copy and save the **Issuer URL** and **JWKS URL** values. You will need them later.

    {% endlist %}

1. Create a {{ k8s }} service account:
    1. [Connect](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) to the {{ managed-k8s-name }} cluster using `kubectl`.
    1. Create a manifest named `service-account.yaml` for the {{ k8s }} service account with the following contents:

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

        ```text
        Name:                wlif
        Namespace:           default
        ...
        ```

    1. Save the values of the `Name` and `Namespace` fields, as you will need them later.

## Create a workload identity federation {#create-wlif}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to access via the {{ yandex-cloud }} API.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Click **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
  1. In the **{{ ui-key.yacloud.iam.federations.field_issuer }}** field, enter the **Issuer URL** value you previously saved, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
  1. In the **{{ ui-key.yacloud.iam.federations.field_audiences }}** field, enter the **Issuer URL** value as well.
  1. In the **{{ ui-key.yacloud.iam.federations.field_jwks }}** field, enter the **JWKS URL** value you previously saved, e.g., `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.
  1. In the **{{ ui-key.yacloud.iam.federations.field_name }}** field, enter a name for the federation, e.g., `test-iam-federation`.
  1. Click **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

{% endlist %}

## Set up an {{ iam-short-name }} service account {#prepare-sa}

1. Create a service account named {{ iam-short-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with the {{ lockbox-name }} secret.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, e.g., `sa-lockbox`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
      1. Select the service account you created and save its ID, as you will need it later.

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

    {% endlist %}

## Link the {{ iam-short-name }} service account to the federation {#connect-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the service account was created in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the list of service accounts, select `sa-lockbox`.
  1. Navigate to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** field, select the federation you created earlier.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** field, specify the ID of the previously created {{ k8s }} service account in `system:serviceaccount:<namespace>:<account_name>` format, where:
      * `namespace`: `Namespace` field value for the {{ k8s }} service account, e.g., `default`.
      * `account_name`: `Name` field value for the {{ k8s }} service account, e.g., `wlif`.

  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

{% endlist %}

## Create a {{ lockbox-name }} secret {#create-secret}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your secret.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret: `MY_SECRET`.
  1. Select `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}` **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter a non-secret ID, e.g., `test-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the confidential data you want to store, e.g., `hello-world`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Save the ID of the secret. You will need it later.

{% endlist %}

## Test the integration {#check-integration}

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
     "versionId": "e6qsqiadrsnhduubgijb"
    }
    ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../lockbox/operations/secret-delete.md) the {{ lockbox-name }} secret.
* [Delete](../../managed-kubernetes/operations/node-group/node-group-delete.md) the {{ managed-k8s-name }} node group.
* [Delete](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ managed-k8s-name }} cluster.

## See also {#see-also}

* [{#T}](../../iam/concepts/workload-identity.md)
* [Getting the {{ lockbox-full-name }} secret value on the custom {{ k8s }} installation side](../../tutorials/security/wlif-k8s-integration.md)