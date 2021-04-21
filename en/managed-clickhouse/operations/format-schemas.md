# Managing data format schemas

{% include [mch-format-schemas-intro](../../_includes/mdb/mch-format-schemas-intro.md) %}

Examples of working with the Cap'n Proto and Protobuf formats when inserting data into a cluster are given in [{#T}](insert.md).

## Before connecting the format schema {#prereq}

{{ mch-name }} only works with format schemas loaded in {{ objstorage-name }}. Before connecting the schema to a cluster:

1. Prepare a file with a format schema (see the documentation for [Cap'n Proto](https://capnproto.org/language.html) and [Protobuf](https://developers.google.com/protocol-buffers/docs/tutorials)).
1. [Upload the file](../../storage/operations/objects/upload.md) with a format schema in {{ objstorage-name }}.
1. [Get a link](../../storage/operations/objects/link-for-download.md) to this file.

## Connecting the format schema {#add-format-schema}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ mch-name }}**.
    1. Click on the name of the cluster you need and select the **Data format schemas** tab.
    1. Click **Add schema**.
    1. In the **Add schema** dialog box, fill out the form by completing the **URL** field with the previously generated link to the format schema file.
    1. Click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To connect a format schema to a cluster, run the command:

  - For **Cap'n Proto**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<format schema name>" \
        --cluster-name="<cluster name>" \
        --type="capnproto" \
        --uri="<link to file in {{ objstorage-name }}>"
    ```

  - For **Protobuf**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<format schema name>" \
        --cluster-name="<cluster name>" \
        --type="protobuf" \
        --uri="<link to file in {{ objstorage-name }}>"
    ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endtabs %}

## Changing a format schema {#update-format-schema}

{{ mch-name }} doesn't track changes in the format schema file that is in the {{ objstorage-name }} bucket.

To update the contents of a schema that is already connected to the cluster:

1. [Upload the file](../../storage/operations/objects/upload.md) with the current format schema in {{ objstorage-name }}.

1. [Get a link](../../storage/operations/objects/link-for-download.md) to this file.

1. Change the parameters of the format schema that is connected to {{ mch-name }} by providing a new link to the format schema file.

   {% list tabs %}

    - Management console
      1. Go to the folder page and select **{{ mch-name }}**.
      1. Click on the name of the cluster you need and select the **Data format schemas** tab.
      1. Select the schema, click ![image](../../_assets/dots.svg) and select **Change**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     To change the link to the file in object storage with the format schema, run the command:

     ```bash
     {{ yc-mdb-ch }} format-schema update "<data schema name>" \
         --cluster-name="<cluster name>" \
         --uri="<new link to file in {{ objstorage-name }}>"
     ```

     The schema name can be requested with a [list of format schemas in the cluster](#list-format-schemas); the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   {% endtabs %}

## Disabling a format schema {#disable-format-schema}

{% note info %}

After disabling a format schema, the corresponding object is kept in the {{ objstorage-name }} bucket. If this object with the format schema is no longer needed, you can [delete](../../storage/operations/objects/delete.md) it.

{% endnote %}

{% list tabs %}

- Management console
   1. Go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Data format schemas** tab.
   1. Select the schema, click ![image](../../_assets/dots.svg) and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To disable a format schema, run the command:

  ```bash
  {{ yc-mdb-ch }} format-schema delete "<format schema name>" \
      --cluster-name="<cluster name>"
  ```

  The schema name can be requested with a [list of format schemas in the cluster](#list-format-schemas); the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endtabs %}

## Getting a list of format schemas in a cluster {#list-format-schemas}

{% list tabs %}

- Management console
   1. Go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Data format schemas** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of format schemas in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} format-schema list --cluster-name="<cluster name>"
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

{% endtabs %}

## Getting detailed information about a format schema {get-format-schema}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get detailed information about a format schema, run the command:

  ```bash
  {{ yc-mdb-ch }} format-schema get "<format schema name>" \
      --cluster-name="<cluster name>"
  ```

  The schema name can be requested with a [list of format schemas in the cluster](#list-format-schemas); the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endtabs %}

