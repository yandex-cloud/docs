---
title: Getting started with {{ maf-full-name }}
description: To get started with {{ maf-full-name }}, create a service cluster and open the {{ AF }} web interface.
keywords:
  - keyword: airflow
  - keyword: airflow cluster
  - keyword: '{{ AF }} cluster'
  - keywrod: Apache Airflow cluster
  - keyword: '{{ AF }}'
  - keyword: Apache Airflow
  - keyword: create {{ AF }} cluster
  - keyword: create airflow cluster
  - keyword: use {{ AF }}
  - keyword: get started with {{ AF }}
  - keyword: get started with {{ maf-name }}
  - keyword: '{{ AF }} web interface'
  - keyword: open {{ AF }} web interface
  - keyword: open airflow web interface
---

# Getting started with {{ maf-name }}

To get started with {{ maf-name }}:

1. [Create a cluster](#cluster-create).
1. [Open the {{ AF }} web interface](#web-gui).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

   {% include [sg-ui-access](../_includes/mdb/maf/note-sg-ui-access.md) %}

1. [Assign](../iam/operations/roles/grant.md) the following roles to your {{ yandex-cloud }} account:

    * [{{ roles.maf.editor }}](security/index.md#managed-airflow-editor): To create a cluster.
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user): To use the cluster [network](../vpc/concepts/network.md#network).
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user): To link a service account to the cluster.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Create a {{ objstorage-full-name }}](../storage/operations/buckets/create.md) bucket for storing {{ maf-name }} [DAG files](concepts/index.md#about-the-service).
1. [Create a service account](../iam/operations/sa/create.md).
1. [Assign the service account](../iam/operations/sa/assign-role-for-sa.md) the `{{ roles.maf.integrationProvider }}` role for a folder or bucket.
1. [Grant the `READ` permission](../storage/operations/buckets/edit-acl.md) for the bucket to the service account.

## Create a cluster {#cluster-create}

1. In the management console, select the folder where you want to create a {{ maf-name }} cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
1. Click **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
1. Set the cluster parameters and click **{{ ui-key.yacloud.common.create }}**. For more information, see [Creating clusters](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ maf-name }} dashboard will change to **Running** and its state, to **Alive**. This may take some time.

## Open the {{ AF }} web interface {#web-gui}

You can manage {{ AF }} through the web interface. Only users with the [{{ roles.maf.user }}](security/index.md#managed-airflow-user) role or higher can use it. To get started with the {{ AF }} web interface:

{% include [web interface](../_includes/mdb/maf/web-interface.md) %}

In addition to the web interface, you can use the [{{ AF }} API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html). For more information, see [{#T}](operations/af-interfaces.md).

## What's next {#whats-next}

* Read about [{{ maf-name }} concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [using {{ AF }} interfaces](operations/af-interfaces.md).
* Create DAG files and [upload them](operations/upload-dags.md) to the {{ maf-name }} cluster. For a DAG file example, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).
