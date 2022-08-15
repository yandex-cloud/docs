# Installing Jaeger

[Jaeger](https://www.jaegertracing.io/) is an open-source distributed tracing platform. Jaeger enables you to monitor request status and debug distributed microservice application systems after faults.

Jaeger is able to use the following types of data storage:
* [{{ ydb-full-name }}](../../../ydb/) when installed from [{{ marketplace-full-name }}](/marketplace).
* [Other data storage systems](https://github.com/jaegertracing/helm-charts/tree/main/charts/jaeger#storage) when installed via a Helm chart.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

### Before you start {#before-you-begin}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the [`jq` utility](https://stedolan.github.io/jq/) for JSON filtering:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. To enable [pods](../../concepts/index.md#pod) in the {{ k8s }} cluster to connect to {{ ydb-name }}, configure [security groups](../connect/security-groups.md). Add a rule for incoming traffic:
   * Port range: `2135`.
   * Protocol: `TCP`.
   * Source type: `Security group`.
   * Security group: Current (`Self`).

### {{ ydb-name }} setup {#create-ydb}

1. [Create a database](../../../ydb/operations/manage-database.md#create-db) with a suitable configuration and `Dedicated` as your [DB type](../../../ydb/concepts/serverless-and-dedicated.md).

   {% note warning %}

   A `Dedicated` database is required for Jaeger to work properly.

   {% endnote %}

1. [Create a directory](../../../ydb/operations/schema.md#directories) named `jaeger`.

### Creating a service account {#create-sa-key}.

To enable Jaeger to communicate with {{ ydb-name }}, create a [service account](../../../iam/concepts/users/service-accounts.md) and obtain a key for it.
1. [Create a service account](../../../iam/operations/sa/create.md) with a suitable [role in the {{ k8s }} cluster](../../security/index.md#yc-api).
1. Create a service account key and save it to your local machine:

   ```bash
   yc iam key create \
     --service-account-id <service account ID> \
     --folder-id <folder ID> \
     --cloud-id <cloud ID> \
     --description jaeger-over-ydb \
     --format json \
     -o key.json
   ```

   Result:

   ```text
   {
     "id": "<service account key ID>",
     "service_account_id": "<service account ID>",
     "created_at": "2022-01-27T03:29:45.139311367Z",
     "description": "jaeger-over-ydb",
     "key_algorithm": "RSA_2048"
   }
   ```

   {% note info %}

   Save the service account and the service account key IDs: you will use them for subsequent installation steps.

   {% endnote %}

1. Save the service account key in Base64 format:

   ```bash
   jq -r .private_key key.json > key.pem
   ```

### Installing Jaeger {#install-jaeger}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select **Jaeger over {{ ydb-short-name }} Backend** and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **{{ ydb-name }} endpoint**: Specify a name for the {{ ydb-name }} endpoint, for example, `lb.etnk1hv0jol3cu5pojp7.ydb.mdb.yandexcloud.net:2135`.
   * **Database**: Specify a database name, for example, `/ru-central1/b1gkgm9daf4605njnmn8/etnk2hv0jol5cu5pojp7`.
   * **Database directory**: `jaeger`.
   * **Use metadata to authenticate from inside a VM**: Select this option if authentication in the virtual machine is required.
   * **Service account key ID**: Specify the service account key ID.
   * **Service account key**: Specify the service account ID.
   * **Service account private key**: Copy the contents of the `key.pem` file to this field.
   * **Install jaeger-agent**: Select this option to install [jaeger-agent](https://hub.docker.com/r/jaegertracing/jaeger-agent/).

   The endpoint and the DB names were returned when [preparing the {{ ydb-name }} DB](#create-ydb) whereas the service account settings were retrieved in the [previous subsection](#create-sa-key).
1. Click **Install**.

## Installation using a Helm chart {#helm-install}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the {{ k8s }} [Helm 3]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/install){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/install){% endif %} package manager.
1. Add the `jaegertracing` repository:

   ```bash
   helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
   ```

1. Install Jaeger:

   ```bash
   helm install jaeger jaegertracing/jaeger
   ```

1. If required, install the [jaeger-operator](https://github.com/jaegertracing/jaeger-operator) {{ k8s }} operator:

   ```bash
   helm install jaegertracing/jaeger-operator
   ```

   For more information about this installation type, see the [Jaeger documentation](https://github.com/jaegertracing/helm-charts).