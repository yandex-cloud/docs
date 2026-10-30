# Creating a {{ mtr-name }} cluster

The [{{ TR }} cluster](../../concepts/components/trino.md) is created in a namespace within the [project](../projects/create-project.md). If you already have a project and a namespace within it, you can create a cluster in that namespace.

## Using the CLI {#cli}

1. Make sure there is a namespace in the project. If not, [create one](../projects/manage-namespaces.md#create-namespace).
1. Create the `TrinoCluster` resource file, e.g., using the `touch trinocluster.yaml` command.
1. Open the file and paste the configuration below into it:

    {% list tabs %}

    - Minimum configuration

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-cluster-min.md) %}

    - Configuration with settings and access rules

        An example with logging settings (`spec.config`) and access rules for catalogs, schemas, and tables (`spec.accessControl`). To learn more about access rules, see [Access management](../../concepts/components/trino.md#access-control).

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-cluster-full.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f trinocluster.yaml -n <namespace>`. Optionally, you can specify the namespace in the `metadata.namespace` resource property and skip it in the command.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. Select the namespace you want to create the cluster in.
1. In the left-hand menu, select **Trino** → **Clusters**.
1. Click **Create cluster**.
1. Fill out the fields as follows:

    **Basic properties**

    * **Name**: Cluster name. Written in `metadata.name`.
    * **Trino version**: {{ TR }} version. The list of values ​​is formed from the `TrinoImageCatalog` operator.
    * **Deletion protection**: Toggle for protection against accidental cluster deletion. Disabled by default.

    **Coordinator configuration**

    * **Requested CPUs**: Guaranteed number of CPUs for the coordinator pod.
    * **Requested RAM**: Guaranteed RAM for the coordinator pod.
    * **CPU limit**: Maximum number of CPUs for the coordinator pod.
    * **RAM limit**: Maximum RAM for the coordinator pod.

    **Worker configuration**

    * **Number of workers**: Number of worker pods. Minimum `1`.
    * **Requested CPUs**: Guaranteed number of CPUs for the worker pod.
    * **Requested RAM**: Guaranteed RAM for the worker pod.
    * **CPU limit**: Maximum number of CPUs for the worker pod.
    * **RAM limit**: Maximum RAM for the worker pod.

    **Additional settings** (optional)

    Section for adding {{ TR }} settings in the _key-value_ format. You can add each key only once.

    **Access settings** (optional)

    Section for access rules pertaining to {{ TR }} resources. Subsections:

    * **Catalog rules**: `user`, `catalog`, `privileges` (`all`, `read-only`, `none`).
    * **Schema rules**: `user`, `catalog`, `schema`, `owner`.
    * **Table rules**: `user`, `catalog`, `schema`, `table`, `privileges` (`SELECT`, `INSERT`, `DELETE`, `UPDATE`, `OWNERSHIP`, `GRANT_SELECT`), plus row filter and column restrictions.
    * **Function rules**: `user`, `catalog`, `schema`, `function`, `privileges` (`EXECUTE`, `GRANT_EXECUTE`, `OWNERSHIP`).
    * **Procedure rules**: `user`, `catalog`, `schema`, `procedure`, `privileges` (`EXECUTE`, `GRANT_EXECUTE`).
    * **Query rules**: `user`, `queryOwner`, `privileges` (`execute`, `view`, `kill`). If `queryOwner` is specified, the `execute` privilege is not available.

    In the _User_ field, you can enter the value as a regular expression or select from {{ iam-name }}. For a service account, specify the `ServiceAccount` resource name in Kubernetes, not the IAM subject ID. If the mapping field (e.g., _Catalog_, _Schema_, or _Table_) is left blank, {{ TR }} substitutes `.*`.

1. Click **Create**.

Done. The cluster has now appeared in the **Clusters** list. Once created, the cluster status is displayed in the **Status** column. Go to the cluster card for detailed info.

## Connecting to a cluster {#connect}

Once the cluster enters the `Running` state, you can connect to it using the coordinator's address.

### Getting connection addresses {#get-connection-addresses}

{% list tabs %}

- CLI

    Run this command:

    ```bash
    kubectl get trinocluster <cluster_name> -n <namespace> -o jsonpath='{.status.fqdn}'
    ```

    Response structure:

    * `external`: External address of the coordinator for connection via {{ TR }} clients (CLI, JDBC). Specify a full URL in `https://...` format.
    * `webUI`: Trino UI address, a full URL in `https://...` format.

- Management console

    1. Open your project.
    1. In the left-hand menu, select **Trino** → **Clusters**.
    1. Select the cluster.
    1. On the **Overview** tab, find the addresses for connection. For detailed connection info, click **Connect**.

{% endlist %}

### {{ TR }} CLI {#trino-cli}

To connect via an external address, use TLS and {{ iam-name }} authentication via a browser. For Trino CLI, prepare a trusted certificate store, TrustStore. The commands for Linux and macOS are listed below.

{% note tip %}

You can find the ready-to-use commands for creating a TrustStore and connecting in the management console: open your cluster card and click **Connect**.

{% endnote %}

#### IAM user login {#trino-cli-user}

1. Install the Trino CLI as per the [official guide](https://trino.io/docs/current/client/cli.html). To create a TrustStore, you will need `keytool` from JDK.
1. Get the certificate authority (CA) certificate and create a TrustStore. If you already have a TrustStore configured for this cluster, use it for the connection.

    Save the CA certificate from the `<cluster_name>-trino-ingress-tls` secret resource in the cluster namespace:

    ```bash
    mkdir -p ~/.trino
    kubectl get secret <cluster_name>-trino-ingress-tls -n <namespace> \
      -o jsonpath='{.data.ca\.crt}' | base64 -d > ~/.trino/stackland-ca.crt
    ```

    If you do not have access to the secret, get the CA certificate from the {{ stackland-name }} administrator and save it at `~/.trino/stackland-ca.crt`.

    Import the certificate into the TrustStore.

    ```bash
    keytool -importcert -trustcacerts -noprompt \
      -alias stackland \
      -file ~/.trino/stackland-ca.crt \
      -keystore ~/.trino/truststore.jks \
      -storetype JKS \
      -storepass stackland
    ```

    In the example, the TrustStore password is `stackland`; specify the same password when connecting.

1. Add the CA certificate to your OS trusted certificates to sign in via a browser:

    {% list tabs %}

    - Linux (Debian, Ubuntu)

        ```bash
        sudo cp ~/.trino/stackland-ca.crt /usr/local/share/ca-certificates/stackland.crt
        sudo update-ca-certificates
        ```

    - Linux (RHEL, Fedora)

        ```bash
        sudo cp ~/.trino/stackland-ca.crt /etc/pki/ca-trust/source/anchors/stackland.crt
        sudo update-ca-trust
        ```

    - macOS

        ```bash
        sudo security add-trusted-cert -d -r trustRoot \
          -k /Library/Keychains/System.keychain ~/.trino/stackland-ca.crt
        ```

    {% endlist %}

    If the browser uses its own certificate store, add the CA into it as well. Restart your browser.

1. Connect to the cluster. Under `--server`, specify the `status.fqdn.external` value which is the full coordinator URL in `https://...` format:

    ```bash
    trino --server https://<coordinator_FQDN> \
      --external-authentication \
      --truststore-path ~/.trino/truststore.jks \
      --truststore-password stackland
    ```

    When the CLI prompts you to authenticate, open the provided link in your browser and sign in to {{ iam-name }}. The `current_user` value matches the IAM login you used during the OAuth authentication. The `--user` parameter is optional. If required, provide `--user '<IAM_login>'` as a hint for the login form, or to run queries as another user if permitted by `spec.accessControl` rules.

1. To test the connection, run a query in the Trino CLI:

    ```sql
    SELECT current_user, version();
    ```

    In the `current_user` column, you should see the IAM login you used to sign in.

#### Service account login {#trino-cli-service-account}

For automation and CI, connect with a service account IAM token (`t1.*`) instead of browser-based OAuth authentication.

1. Create a service account in your cluster’s namespace:

    ```bash
    kubectl create serviceaccount <service_account_name> -n <namespace>
    ```

    Wait until the IAM service account ID appears in the `iam.stackland.yandex.cloud/service-account-id` annotation.

1. Add rules to the cluster’s `spec.accessControl` section. In the `user` field, specify the `ServiceAccount` resource name in Kubernetes, not the IAM subject ID. To learn more, see [Access management](../../concepts/components/trino.md#access-control).
1. Get an IAM token for your service account (in `t1.*` format) via the IAM API.
1. Create a TrustStore by following steps 1-2 of the [IAM user login](#trino-cli-user) section. You do not need to add the CA to your OS trusted certificates for browser logins.
1. Connect to the cluster. Under `--server`, specify the `status.fqdn.external` value:

    ```bash
    trino --server https://<coordinator_FQDN> \
      --access-token '<IAM_token>' \
      --truststore-path ~/.trino/truststore.jks \
      --truststore-password stackland
    ```

1. Test the connection:

    ```sql
    SELECT current_user, version();
    ```

    Under `current_user`, you should see the name of the `ServiceAccount` resource from `spec.accessControl`.

### JDBC {#jdbc}

Use the {{ TR }} JDBC driver with a URL in this format:

```
jdbc:trino://<coordinator_FQDN>:443
```

Get the`<coordinator_FQDN>` value from `status.fqdn.external` (the part of the URL without the `https://` schema).
