---
title: Metadata catalog
description: '{{ data-catalog-name }} allows you to collect, analyze, and mark up metadata drawn from various sources. You can upload structural metadata, e.g., list of tables in a managed database cluster, their schemas, and links between tables. The main entity in {{ data-catalog-name }} is a metadata catalog. A catalog servers both as a storage for metadata and workspace for its markup.'
---

# Metadata catalog


{% note info %}

{% include [preview-pp](../../_includes/preview-pp.md) %}

{% endnote %}

{% include [data-catalog-definition](../../_includes/metadata-hub/data-catalog-definition.md) %}

The main entity in {{ data-catalog-name }} is a _metadata catalog_. 

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-concept.md) %}

## Uploading metadata {#metadata-upload}

To upload metadata, use _sources_ and _ingestions_.

A [source](data-catalog-sources.md) is a connection through which the metadata is uploaded. This connection stores information about the database or service metadata is ingested from as well as authentication data.

A source can connect to both clusters of managed databases in {{ yandex-cloud }} and to custom installations of these databases. It can also fetch object links based on ongoing data delivery in {{ data-transfer-full-name }}.

An ingestion is a process that connects to the data storage or service specified in the source and uploads its metadata into the catalog. In an ingestion, you can configure:

* Filters to get only relevant metadata.
* Profiling to export the statistical data you need.

An ingestion is exclusively associated with a specific source. However, a source can have multiple associated ingestions. This means you can create multiple ingestions for one source, each with its own filters.

You can run an ingestion manually or configure it to run on a schedule. A scheduled ingestion always runs only once, even if the schedule specifies a period and not a specific hour.

{{ data-catalog-name }} has quotas for the maximum number of sources and ingestions in a catalog.

## Data storage {#data-store}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-storage-concept.md) %}

## Metadata markup {#metadata-markup}

### Domains and subdomains {#domains-and-subdomains}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-domain-concept.md) %}

### Classifications and tags {#classifications-and-tags}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-classification-tag-concept.md) %}

### Glossaries and terms {#glossaries-and-terms}

{% include [data-catalog-concept](../../_includes/metadata-hub/data-catalog-glossary-term.md) %}

## Use cases {#examples}

* [{#T}](../operations/data-catalog/create-term.md) in a glossary.
* [{#T}](../operations/data-catalog/create-term-child.md).
* [{#T}](../operations/data-catalog/update-glossary.md).
* [{#T}](../operations/data-catalog/update-term.md).
* [{#T}](../operations/data-catalog/create-tag.md) in a classification.
* [{#T}](../operations/data-catalog/update-classification.md).
* [{#T}](../operations/data-catalog/update-tag.md) in a classification.