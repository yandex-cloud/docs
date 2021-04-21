# Adding your own geobase

{{ mch-name }} contains a built-in [geobase dictionary](../concepts/dictionaries.md#internal-dicts) and a set of functions for working with it. The built-in dictionary lets you:

* Get the name of a region in the required language by its ID.
* Get the ID of a city, region, federal district, country, and continent by the region ID.
* Check whether one region is part of another.
* Get a chain of parent regions.

Learn more about geobase functions in the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/functions/ym_dict_functions).

If you're not satisfied with the built-in geobase, you can add your own to {{ CH }} clusters:

1. [Create a geobase](#create-geobase).
1. [Upload the geobase to {{ yandex-cloud }}](#upload-geobase).
1. [Add the geobase to the {{ CH }} cluster](#add-geobase).

## Creating a geobase {#create-geobase}

Geobases in {{ CH }} are text files containing the hierarchy and names of regions. You can add several alternative geobases to {{ CH }} to reflect alternative viewpoints on the regional structure of different countries. Learn more in the [{{ CH }} documentation](https://clickhouse.yandex/docs/en/query_language/dicts/internal_dicts/).

To create a geobase:

1. Create a `regions_hierarchy.txt` file with a hierarchy of regions. The file must be in [TSV tabular format](https://ru.wikipedia.org/wiki/TSV) without headers and with the following columns:
   * Region ID (UInt32).
   * Parent region ID (UInt32).
   * Region type (UInt8): 1 - continent, 3 - country, 4 - federal district, 5 - area, 6 - city. There are no values for other types.
   * Population (UInt32): Optional.
1. To add an alternative hierarchy of regions, create `regions_hierarchy_<suffix>.txt` files with the same structure. To use an alternative geobase, pass this suffix when calling the function. For example:

   ```
   regionToCountry(RegionID) — Uses the default dictionary: regions_hierarchy.txt.
   regionToCountry(RegionID, 'ua') — Uses the dictionary with the ua suffix: regions_hierarchy_ua.txt.
   ```
1. Create the file `regions_names.txt` with the region names. The file must be in [TSV tabular format](https://ru.wikipedia.org/wiki/TSV) without headers and with the following columns:
   * Region ID (UInt32).
   * region name (String) — Can't contain tabs or newlines, even escaped ones.
1. To add region names in other languages to your geobase, create `regions_names_<language code>.txt` files with the same structure. For example, you may create `regions_names_en.txt` for English and `regions_names_tr.txt` for Turkish.
1. Package your geobase files as `TAR`, `TAR.GZ`, or `ZIP` archives.

## Uploading a geobase to {{ yandex-cloud }} {#upload-geobase}

{{ mch-short-name }} only works with publicly readable geobases that are uploaded to {{ objstorage-name }}:

1. [Upload](../../storage/operations/objects/upload.md) archive with a geobase in {{ objstorage-name }}.

1. [Set up public read access](../../storage/operations/objects/edit-acl.md) to the geobase file.

1. [Get](../../storage/operations/objects/link-for-download.md) a public link to the geobase.

## Adding a geobase {#add-geobase}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **DBMS settings**, click **Configure**.
  1. In the **Geobase uri** field, provide a public link to the geobase archive in {{ objstorage-name }}.

{% endlist %}

