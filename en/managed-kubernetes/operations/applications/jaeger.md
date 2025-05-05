---
title: Installing Jaeger over {{ ydb-short-name }} Backend
description: Follow this guide to install Jaeger over {{ ydb-short-name }} Backend.
---

# Installing Jaeger over {{ ydb-short-name }} Backend


[Jaeger](https://www.jaegertracing.io/) is an open-source distributed tracing platform. Jaeger enables you to monitor request status and debug distributed microservice application systems after faults.

Jaeger is able to use the following types of data storage:
* [{{ ydb-full-name }}](../../../ydb/) when installed from [{{ marketplace-full-name }}](/marketplace).
* [Other data storage systems](https://github.com/jaegertracing/helm-charts/tree/main/charts/jaeger#storage) when installed via a Helm chart.

## Installation using {{ marketplace-name }} {#marketplace-install}

### Getting started {#before-you-begin}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the [`jq`](https://stedolan.github.io/jq/) JSON stream processor.

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. To enable [pods](../../concepts/index.md#pod) in the {{ k8s }} cluster to connect to {{ ydb-name }}, configure [security groups](../connect/security-groups.md). Add a rule for incoming traffic:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `2135`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

### Preparing {{ ydb-name }} {#create-ydb}

1. [Create a database](../../../ydb/operations/manage-databases.md#create-db-dedicated) with a suitable configuration and `Dedicated` as your [DB type](../../../ydb/concepts/serverless-and-dedicated.md).

   {% note warning %}

   A `Dedicated` database is required for Jaeger to work properly.

   {% endnote %}

1. [Create a directory](../../../ydb/operations/schema.md#directories) named `jaeger`.

### Creating a service account {#create-sa-key}

To enable Jaeger to communicate with {{ ydb-name }}, create a [service account](../../../iam/concepts/users/service-accounts.md) and obtain a key for it.
1. [Create a service account](../../../iam/operations/sa/create.md) with a suitable [role in the {{ k8s }} cluster](../../security/index.md#yc-api).
1. Create a service account key and save it to your local machine:

   ```bash
   yc iam key create \
     --service-account-id <service_account_ID> \
     --folder-id <folder_ID> \
     --cloud-id <cloud_ID> \
     --description jaeger-over-ydb \
     --format json \
     -o key.json
   ```

   Result:

   ```text
   {
     "id": "<service_account_key_ID>",
     "service_account_id": "<service_account_ID>",
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

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the cluster you need and select the ![Marketplace](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Jaeger over {{ ydb-name }} Backend](/marketplace/products/yc/jaeger-ydb-store) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `jaeger-space`. If you leave the default namespace, Jaeger may work incorrectly.
   * **Application name**: Specify the application name.
   * **{{ ydb-name }} endpoint**: Specify a name for the {{ ydb-name }} endpoint, e.g., `lb.etnk1hv0jol3********.{{ ydb.host-dedicated }}:{{ ydb.port-dedicated }}`.
   * **Database**: Specify a database name, e.g., `/{{ region-id }}/b1gkgm9daf46********/etnk2hv0jol5********`.
   * **Database directory**: `jaeger`.
   * **Use metadata to authenticate from inside a VM**: Select this option if authentication in the virtual machine is required.
   * **Service account key ID**: Specify the service account key ID.
   * **Service account key**: Specify the service account ID.
   * **Service account private key**: Copy the contents of the `key.pem` file to this field.
   * **Install jaeger-agent**: Select this option to install [jaeger-agent](https://hub.docker.com/r/jaegertracing/jaeger-agent/).

   The endpoint and the DB names were returned when [preparing the {{ ydb-name }} DB](#create-ydb) whereas the service account settings were retrieved in the [previous subsection](#create-sa-key).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Add a repository named `jaegertracing`:

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

## Use cases {#examples}

* [{#T}](../../tutorials/marketplace/jaeger-over-ydb.md).

## See also {#see-also}

* [Jaeger documentation](https://www.jaegertracing.io/docs/).