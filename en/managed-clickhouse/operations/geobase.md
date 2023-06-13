# Adding your own geobase in {{ mch-name }}

Geobases in {{ CH }} are text files containing the hierarchy and names of regions. You can add several alternative geobases to {{ CH }} to support different stances on how regions pertain to countries. For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/ru/sql-reference/dictionaries/internal-dicts/).

To add your own geobase to a {{ CH }} cluster:

1. [Create a geobase](#create).
1. [Upload the geobase to {{ objstorage-full-name }}](#upload).
1. [Add the geobase to a {{ CH }} cluster](#add).

## Creating a geobase {#create}

1. Create a `regions_hierarchy.txt` file with a hierarchy of regions. The file must be in [TSV tabular format](https://ru.wikipedia.org/wiki/TSV) without headers and with the following columns:
   * Region ID (UInt32)
   * Parent region ID (UInt32)
   * Region type (UInt8):
      * `1`: Continent.
      * `3`: Country.
      * `4`: Federal district.
      * `5`: Region.
      * `6`: City.
   * Population (UInt32): Optional.
1. To add an alternative hierarchy of regions, create `regions_hierarchy_<suffix>.txt` files with the same structure. To use an alternative geobase, pass this suffix when invoking the function, e.g.:

   * `regionToCountry(RegionID)` — Uses the default dictionary: `regions_hierarchy.txt`.
   * `regionToCountry(RegionID, 'alt')`: Uses the dictionary with the `alt` suffix: `regions_hierarchy_alt.txt`.

1. Create the file `regions_names.txt` with the region names. The file must be in [TSV tabular format](https://ru.wikipedia.org/wiki/TSV) without headers and with the following columns:

   * Region ID (UInt32)
   * Region name (String): Can't contain tab or newline characters, even escaped ones.

1. To add region names in other languages to your geobase, create `regions_names_<language code>.txt` files with the same structure. For example, you may create `regions_names_en.txt` for English and `regions_names_tr.txt` for Turkish.
1. Create a `tar`, `tar.gz`, or `zip` archive from the geobase files.

## Uploading a geobase to {{ objstorage-full-name }} {#upload}

{{ mch-short-name }} only works with publicly readable geobases that are uploaded to {{ objstorage-full-name }}:


1. [Upload](../../storage/operations/objects/upload.md) the geobase archive to {{ objstorage-full-name }}.

1. Configure access to the geobase archive using one of the following methods:

   * Use a [service account](../../iam/concepts/users/service-accounts.md) (recommended). This method enables you to access the file without entering account information.

      1\. [Connect a service account to a cluster](s3-access.md#connect-service-account).
      2\. [Assign the account the role](s3-access.md#configure-acl) of `storage.viewer`.
      3\. In the bucket ACL, [grant the account](../../storage/operations/buckets/edit-acl.md) `READ` permission.

   * [Enable public access](../../storage/operations/objects/edit-acl.md) to the bucket containing the file.

1. [Get a link](s3-access.md#get-link-to-object) to the geobase archive.


## Adding the geobase to the {{ CH }} cluster {#add}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **DBMS settings**, click **Settings**.
   1. In the **Geobase uri** field, provide a link to the geobase archive in {{ objstorage-full-name }}.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a geobase:

   1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-ch }} cluster update-config --help
      ```

   1. Run the command by passing the link to the archive with the added geobase in the `geobase_uri` parameter:

      ```bash
      {{ yc-mdb-ch }} cluster update-config <cluster ID or name> \
           --set geobase_uri="<link to geobase archive in {{ objstorage-name }}>"
      ```

      You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Add the `geobase_uri` parameter with a link to the archive with the geobase to connect in {{ objstorage-full-name }} to the {{ mch-name }} cluster settings:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        clickhouse {
          config {
            geobase_uri = "<link to geobase archive in {{ objstorage-full-name }}>"
            ...
          }
        ...
        }
      ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To add a geobase to a {{ CH }} cluster, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the link to the geobase archive in {{ objstorage-name }} in the `geobaseUri` parameter.

   {% note warning %}

   This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the names of the fields to be changed in the `updateMask` parameter.

   {% endnote %}

{% endlist %}

