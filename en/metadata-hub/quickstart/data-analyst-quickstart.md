# Getting started as a metadata analyst

{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}

Using {{ data-catalog-full-name }} as a metadata analyst, you can analyze and visualize metadata on {{ yandex-cloud }} objects and links between them.

To get started:

1. [View the metadata catalog](#open-data-catalog).
1. [View the metadata information](#view-metadata).
1. [Find metadata using search](#search-data).
1. [Configure metadata filters](#create-filters).
1. [View marked up resources](#view-markup-data).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. Contact your working cloud or organization administrator for access to the resource catalog the metadata is processed in.

1. Make sure your account has the `data-catalog.dataConsumer` role for the working catalog to view and update {{ data-catalog-name }} resources.

    If you do not have the role, contact the metadata catalog administrator in your cloud or organization.

1. Check with your cloud or organization administrator as to which metadata catalog you should be using.

## View the metadata catalog {#open-data-catalog}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to your working resource catalog.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Select the metadata catalog you need.
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **Metadata search** tab to view the metadata available in the catalog.

{% endlist %}

## View metadata information {#view-metadata}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to your working metadata catalog.
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **Metadata search** tab and select the dataset.
  1. To view the general dataset information, navigate to the **Overview** tab and expand the list with the parameters you need.
  1. To view the object schema, navigate to the **Schema** tab and select the schema version from the drop-down list.
  1. To view links with other objects go to the **Lineage** tab.

     You can select the link depth, turn the **Display weak lineage** option on of off.

     {{ data-catalog-name }} displays links not just between objects but also between individual columns within objects. To view links between columns, expand the list of columns in the object of interest.

  1. Go to the **Queries** tab to view data queries.

{% endlist %}

## Find metadata using search {#search-data}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to your working metadata catalog.
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **Metadata search** tab.
  1. By default, you search across all data types. If you need only specific data types, select them in the drop-down list to the left of the search bar.
  1. Enter your search query in the **Search by metadata** field.
  1. To increase the relevance of search results, refine your search query and [configure metadata filters](#create-filters).

     The number of filters you can use depends on the data types you select. If you are working with several data types at the same time, only filters valid for all selected data types will be available.

     You can increase the number of available filters by carefully selecting your data types.

{% endlist %}

## Configure metadata filters {#create-filters}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to your working metadata catalog.
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **Metadata search** tab.
  1. Click ![image](../../_assets/console-icons/plus.svg) **Add filter**.
  1. Filter metadata by one or more tags created in the catalog.

     You can also add other filters. The number of filters you can use depends on the data types selected in the list to the left of the search bar. If you are working with several data types at the same time, only filters valid for all selected data types will be available.

     You can increase the number of available filters by carefully selecting your data types.

{% endlist %}

## View marked up resources {#view-markup-data}

### Domains {#domain-markup}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to your working metadata catalog.
  1. Go to the ![image](../../_assets/console-icons/globe.svg) **Domains** tab.
  1. Select the domain or subdomain from the list.
  1. Navigate to the **Search by metadata** tab. It will present the list of datasets marked up by the current domain or containing fields marked up by the current domain.
  1. To find specific data, enter your query in the search bar above the data list.
  1. To go to the dataset, click its name in the list.

{% endlist %}

### Terms {#term-markup}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to your working metadata catalog.
  1. Go to the ![image](../../_assets/console-icons/book.svg) **Terms and glossaries** tab.
  1. Select the glossary containing the term you are looking for.
  1. Select the term from the list.
  1. Navigate to the **Search by metadata** tab. It will present the list of datasets marked up by the current term or containing fields marked up by the current term.
  1. To find specific data, enter your query in the search bar above the data list.
  1. To go to the dataset, click its name in the list.

{% endlist %}

### Tags {#tags-markup}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to your working metadata catalog.
  1. Go to the ![image](../../_assets/console-icons/tag.svg) **Tags and classifications** tab.
  1. Select the classification containing the tag you are looking for.
  1. Select the tag from the list. The tag page will present the list of datasets marked up by the current tag or containing fields marked up by the current tag.
  1. To find specific data, enter your query in the search bar above the data list.
  1. To go to the dataset, click its name in the list.

{% endlist %}

## What's next {#what-is-next}

* [Create a term](../operations/data-catalog/create-term.md) in a glossary.
* [Create a child term](../operations/data-catalog/create-term-child.md).
* [Update a glossary](../operations/data-catalog/update-glossary.md).
* [Edit a term in a glossary](../operations/data-catalog/update-term.md).
* [Create a tag](../operations/data-catalog/create-tag.md) in a classification.
* [Update a classification](../operations/data-catalog/update-classification.md).
* [Edit a tag](../operations/data-catalog/update-tag.md) in a classification.
