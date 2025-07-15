# Getting started as a metadata steward

{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}

When using {{ data-catalog-full-name }} as a metadata steward, you can collect and organize metadata on {{ yandex-cloud }} objects and links between them.

{{ data-catalog-name }} can collect metadata from the following services:

* {{ mch-full-name }}
* {{ mmy-full-name }}
* {{ mpg-full-name }}
* {{ data-transfer-full-name }}

To get started:

1. [Create a metadata catalog](#create-catalog).
1. [Create a metadata source](#create-source).
1. [Create data ingestions](#create-ingestions) from sources on a schedule.
1. [Test the ingested metadata](#test-data-ingestion).
1. [Create a classification and tags](#classification).
1. [Create a domain and subdomains](#domains).
1. [Create a glossary and terms](#glossary).
1. [Mark up the obtained data](#metadata-markup).

## Required paid resources {#paid-resources}

The cost of infrastructure support includes a fee for {{ mpg-full-name }} cluster computing resources, storage volume, and backups (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a resource folder, create one:

   {% include [create-folder](../../_includes/create-folder.md) %}

1. [Assign](../../iam/operations/roles/grant.md) your {{ yandex-cloud }} account the following roles for the resource folder:

    * `data-catalog.dataSteward`: To create and manage Data Catalog resources.
    * [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).

    {% include [note-managing-roles](../../_includes/mdb/note-managing-roles.md) %}

1. [Create a {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster) to supply data from as a test load.

## Create a metadata catalog {#create-catalog}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the resource folder you [prepared earlier](#before-you-begin).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Click **{{ ui-key.yacloud.data-catalog.action_create-catalog }}**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the metadata catalog.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the metadata catalog.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a metadata source and ingestion {#create-source}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **Sources** tab and click **Create data source**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the source.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the source.
  1. Select **PostgreSQL** as **Database type**.
  1. Under **PostgreSQL source**, provide the following parameters:

     * **User folder in cloud**: Resource folder the {{ mpg-name }} was created in.
     * **Installation type**: **{{ mpg-name }} cluster**.
     * **Managed DB cluster**: {{ mpg-name }} cluster you created earlier.
     * **Connection ID**: Connection to the previously created {{ mpg-name }} cluster in {{ connection-manager-full-name }}.
     * **Database name**: Name of the database in the previously created {{ mpg-name }} cluster.

  1. Click **{{ ui-key.yacloud.common.create }}**. 
  1. This will open a page with a list of sources in the metadata catalog. You will see **No ingestion** in the line with the source you just created.
  1. Hover over this message and click **Create ingestion** in the window that opens. 
  1. Set a **{{ ui-key.yacloud.common.name }}** for the ingestion.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the ingestion.  
  1. In the **Schedule** field, select **Daily**.
  1. In the **Time intervals** field, specify ingestion running time.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Test the ingested metadata {#test-data-ingestion}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **Metadata search** tab.

     In the window that opens, you will see the metadata you got from the {{ mpg-name }} cluster created earlier.

{% endlist %}

{% note tip %}

The metadata ingested from the source will also appear on the **Exported data** tab in the same source.

{% endnote %}

## Create a classification and tags {#classification}

### Create a classification {#create-classification}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/tag.svg) **Tags and classifications** tab and click **Create classification**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the classification.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the classification.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create tags {#create-tags}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/tag.svg) **Tags and classifications** tab and open the [previously created](#create-classification) classification.
  1. Click **Create tag**.
  1. In the window that opens, set a **{{ ui-key.yacloud.common.name }}** for the tag.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the tag.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a domain and subdomains {#domains}

### Create a domain {#create-domain}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/globe.svg) **Domains** tab and click **Create domain**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the domain. 
  1. Set a **{{ ui-key.yacloud.common.description }}** for the domain.
  1. Add one or more [previously created](#create-tags) tags.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create a subdomain {#create-subdomain}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/globe.svg) **Domains** tab and select the [previously created](#create-domain) domain.
  1. Click **Add subdomain**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the subdomain. 
  1. Set a **{{ ui-key.yacloud.common.description }}** for the subdomain.
  1. Add one or more [previously created](#create-tags) tags.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a glossary and terms {#glossary}

### Create a glossary {#create-glossary}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/book.svg) **Terms and glossaries** tab and click **Create glossary**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the glossary.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the glossary.
  1. Add one or more [previously created](#create-tags) tags.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create terms {#create-terms}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/book.svg) **Terms and glossaries** tab and select the [previously created](#create-glossary) glossary.
  1. Click **Create term**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the term.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the term.
  1. Specify synonyms for the term.
  1. Add one or more [previously created](#create-tags) tags.
  1. Add related terms.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Mark up the obtained data {#metadata-markup}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **Metadata search** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the dataset you selected and go **Assign domain**, **Add tags**, or **Add term**.
  1. In the window that opens, select an object in the hierarchy of domains, tags, or terms. You may want to use the search feature.
  1. Add the selected objects.

{% endlist %}

## What's next {#what-is-next}

* [Create a term](../operations/data-catalog/create-term.md) in a glossary.
* [Create a child term](../operations/data-catalog/create-term-child.md).
* [Update a glossary](../operations/data-catalog/update-glossary.md).
* [Edit a term in a glossary](../operations/data-catalog/update-term.md).
* [Create a tag](../operations/data-catalog/create-tag.md) in a classification.
* [Update a classification](../operations/data-catalog/update-classification.md).
* [Edit a tag](../operations/data-catalog/update-tag.md) in a classification.