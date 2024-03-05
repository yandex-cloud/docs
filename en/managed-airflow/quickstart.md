---
title: "Getting started with {{ maf-full-name }}"
description: "To start working with {{ maf-full-name }}, create a service cluster and open the {{ AF }} web interface."
---

# Getting started with {{ maf-name }}

{% include [note-preview](../_includes/note-preview-by-request.md) %}

To get started with the service:

1. [Create a {{ maf-name }} cluster](#cluster-create).
1. [Open the {{ AF }} web interface](#web-gui).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.


1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

   {% include [sg-ui-access](../_includes/mdb/maf/note-sg-ui-access.md) %}

1. [Create a {{ objstorage-full-name }} bucket](../storage/operations/buckets/create.md) for storing {{ maf-name }} [DAG files](concepts/index.md#about-the-service).
1. [Create a service account](../iam/operations/sa/create.md).
1. [Assign the service account the `storage.viewer` role](../iam/operations/sa/assign-role-for-sa.md) for the folder or bucket.
1. [Create a static access key](../iam/operations/sa/create-access-key.md) for the service account.


## Create a cluster {#cluster-create}

1. In the management console, select the directory where you want to create a cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
1. Click **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
1. Set the cluster parameters and click **{{ ui-key.yacloud.common.create }}**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ maf-name }} dashboard will change to **{{ ui-key.yacloud.ydb.sql.label_status_running }}** and its state, to **Alive**. This may take some time.

## Open the {{ AF }} web interface {#web-gui}

You can manage {{ AF }} through the web interface. To start using it:

{% include [web interface](../_includes/mdb/maf/web-interface.md) %}

In addition to the web interface, you can use the [{{ AF }} API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html). Learn more about how to work with it in [{#T}](operations/af-interfaces.md).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating clusters](operations/cluster-create.md) and [working with {{ AF }} interfaces](operations/af-interfaces.md).
* Create DAG files and [upload them](operations/upload-dags.md) to the {{ maf-name }} cluster. For a DAG file example, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).
