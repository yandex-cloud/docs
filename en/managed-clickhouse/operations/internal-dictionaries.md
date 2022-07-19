# Adding your own geobase

{{ mch-name }} contains a built-in [geobase dictionary](../concepts/dictionaries.md#internal-dicts) and a set of functions to work with it. The built-in dictionary lets you:

* Get the name of a region in the required language by ID.
* Get the ID of a city, region, federal district, country, and continent by the region ID.
* Check whether one region is part of another.
* Get a chain of parent regions.

Learn more about geobase functions in the [{{ CH }} documentation]({{ ch.docs }}/query_language/functions/ym_dict_functions).

If you're not satisfied with the built-in geobase, you can add your own to {{ CH }} clusters:

1. [Create a geobase](#create-geobase).
1. [Upload it to {{ yandex-cloud }}](#upload-geobase).
1. [Connect it to the {{ CH }} cluster](#add-geobase).


## Creating a geobase {#create-geobase}

Geobases in {{ CH }} are text files containing the hierarchy and names of regions. You can add several alternative geobases to {{ CH }} to reflect alternative viewpoints on the regional structure of different countries. Learn more in the [{{ CH }} documentation]({{ ch.docs }}/query_language/dicts/internal_dicts/).

To create a geobase:

1. Create a `regions_hierarchy.txt` file with a hierarchy of regions. The file must be in [TSV tabular format](https://ru.wikipedia.org/wiki/TSV) without headers and with the following columns:
   * Region ID (UInt32)
   * Parent region ID (UInt32)
   * Region type (UInt8): 1 - continent, 3 - country, 4 - federal district, 5 - area, 6 - city. There are no values for other types.
   * Population (UInt32): Optional.
1. To add an alternative hierarchy of regions, create `regions_hierarchy_<suffix>.txt` files with the same structure. To use an alternative geobase, pass this suffix when calling the function. For example:

   * `regionToCountry(RegionID)`: Uses the default dictionary: `regions_hierarchy.txt`.
   * `regionToCountry(RegionID, 'ua')`: Uses the dictionary with the `ua` suffix: `regions_hierarchy_ua.txt`.

1. Create the file `regions_names.txt` with the region names. The file must be in [TSV tabular format](https://ru.wikipedia.org/wiki/TSV) without headers and with the following columns:
   * Region ID (UInt32)
   * Region name (String): Can't contain tab or newline characters, even escaped ones.
1. To add region names in other languages to your geobase, create `regions_names_<language code>.txt` files with the same structure. For example, you may create `regions_names_en.txt` for English and `regions_names_tr.txt` for Turkish.
1. Package your geobase files as `TAR`, `TAR.GZ`, or `ZIP` archives.

## Uploading a geobase to {{ yandex-cloud }} {#upload-geobase}

{{ mch-short-name }} only works with publicly readable geobases that are uploaded to {{ objstorage-full-name }}:

{% if audience != "internal" %}

1. [Upload](../../storage/operations/objects/upload.md) the geobase archive to {{ objstorage-full-name }}.

1. Configure access to the geobase archive using one of the following methods:

   * Use a [service account](../../iam/concepts/users/service-accounts.md) (recommended). This method lets you access the file without entering account information.

      1\. [Connect a service account to a cluster](s3-access.md#connect-service-account).
      2\. [Assign the account the role](s3-access.md#configure-acl) of `storage.viewer`.
      3\. In the bucket ACL, [grant the account](../../storage/operations/buckets/edit-acl.md) `READ` permission.

   * [Enable public access](../../storage/operations/objects/edit-acl.md) to the bucket containing the file.

1. [Get a link](s3-access.md#get-link-to-object) to the geobase archive.

{% else %}

1. Upload the geobase archive to {{ objstorage-full-name }}.

1. Set up public read access to the geobase file.

1. Get a link to the geobase.

{% endif %}

## Adding a geobase {#add-geobase}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **DBMS settings**, click **Settings**.
   1. In the **Geobase uri** field, provide a link to the geobase archive in {{ objstorage-full-name }}.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

{% endlist %}
