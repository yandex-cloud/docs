# Getting started as a metadata steward



{% include notitle [preview](../../_includes/note-preview.md) %}



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

1. Navigate to the [management console]({{ link-console-main }}) and either log in to {{ yandex-cloud }} or sign up if you do not have an account yet.

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
  1. Go to the ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}** tab and click **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the source.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the source.
  1. Select **{{ ui-key.yacloud.data-catalog.label_source-database-type }}**: **PostgreSQL**
  1. Under **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.title }}**, set the following parameters:

     * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.folder_id.title }}**: Resource folder the {{ mpg-name }} cluster was created in.
     * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.connection_types.title }}**: **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.ConnectionType.managed.title }}**.
     * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.ConnectionType.ManagedConnection.cluster_id.title }}**: {{ mpg-name }} cluster you created earlier.
     * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.ConnectionType.ManagedConnection.connection_id.title }}**: Connection to the previously created {{ mpg-name }} cluster in {{ connection-manager-full-name }}.
     * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.database_name.title }}** in the {{ mpg-name }} cluster you created earlier.
     * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.ingest_all.title }}**: Optionally, enable this setting if you need to upload data from all databases.
     * **Network ID**: Specify the network ID.


  1. Click **{{ ui-key.yacloud.common.create }}**. 
  1. This will open a page with a list of sources in the metadata catalog. You will see **{{ ui-key.yacloud.data-catalog.label_empty-ingestion-count-short }}** in the line with the source you just created.
  1. Hover over this message and click **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}** in the window that opens. 
  1. Set a **{{ ui-key.yacloud.common.name }}** for the ingestion.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the ingestion.  
  1. In the **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.cron.title }}** field, select **{{ ui-key.data-catalog.console.form.cron.Cron.day.title }}**.
  1. In the **{{ ui-key.data-catalog.console.form.cron.HoursInterval.start.title }}** and **{{ ui-key.data-catalog.console.form.cron.HoursInterval.end.title }}** fields, specify the ingestion operation time.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Test the ingested metadata {#test-data-ingestion}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}** tab.

     In the window that opens, you will see the metadata you got from the {{ mpg-name }} cluster created earlier.

{% endlist %}

{% note tip %}

The metadata ingested from the source will also appear on the **{{ ui-key.yacloud.data-catalog.label_source-data-tab }}** tab in the same source.

{% endnote %}

## Create a classification and tags {#classification}

### Create a classification {#create-classification}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** tab and click **{{ ui-key.yacloud.data-catalog.label_create-classification-action }}**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the classification.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the classification.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create tags {#create-tags}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** tab and open the [previously created](#create-classification) classification.
  1. Click **{{ ui-key.yacloud.data-catalog.label_create-tag-action }}**.
  1. In the window that opens, set a **{{ ui-key.yacloud.common.name }}** for the tag.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the tag.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a domain and subdomains {#domains}

### Create a domain {#create-domain}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.data-catalog.label_domains }}** tab and click **{{ ui-key.yacloud.data-catalog.label_create-domain-action }}**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the domain. 
  1. Set a **{{ ui-key.yacloud.common.description }}** for the domain.
  1. Add one or more [previously created](#create-tags) tags.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create a subdomain {#create-subdomain}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.data-catalog.label_domains }}** tab and select the [previously created](#create-domain) domain.
  1. Click **{{ ui-key.yacloud.data-catalog.label_add-subdomain-action }}**.
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
  1. Go to the ![image](../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** tab and click **{{ ui-key.yacloud.data-catalog.label_create-glossary-action }}**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the glossary.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the glossary.
  1. Add one or more [previously created](#create-tags) tags.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create terms {#create-terms}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Go to the ![image](../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** tab and select the [previously created](#create-glossary) glossary.
  1. Click **{{ ui-key.yacloud.data-catalog.label_create-term-action }}**.
  1. Set a **{{ ui-key.yacloud.common.name }}** for the term.
  1. Set a **{{ ui-key.yacloud.common.description }}** for the term.
  1. Specify synonyms for the term.
  1. Add one or more [previously created](#create-tags) tags.
  1. Add linked terms.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Mark up the obtained data {#metadata-markup}

{% list tabs group=instructions %}

- Management console

  1. In the [management console]({{ link-console-main }}), navigate to the metadata catalog you [created earlier](#create-catalog).
  1. Navigate to the ![image](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the dataset you selected and select **{{ ui-key.yacloud.data-catalog.action_set-domain }}**, **{{ ui-key.yacloud.data-catalog.label_add-tags }}**, or **{{ ui-key.yacloud.data-catalog.label_add-terms }}**.
  1. In the window that opens, select an object in the hierarchy of domains, tags, or terms. Use search, if required.
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