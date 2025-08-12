---
title: '{{ metadata-hub-full-name }} quotas and limits'
description: '{{ metadata-hub-full-name }} applies quotas on the number of connections, number of namespaces, and number of schemas per cloud. For more information about the service limitations, read this article.'
---

# Quotas in {{ metadata-hub-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

{{ metadata-hub-full-name }} has the following limits:

* [_Quotas_]({{ link-console-quotas }}) are organizational constraints that can be changed by support on request.

## {{ connection-manager-name }} quotas {#connection-manager-quota}

{% include [connection-manager-quotas](../../_includes/metadata-hub/connection-manager-quotas.md) %}

## {{ metastore-name }} quotas {#metastore-quota}

{% include [metastore-quotas](../../_includes/metadata-hub/metastore-quotas.md) %}

## {{ schema-registry-name }} quotas {#schema-registry-quota}

{% include [schema-registry-quotas](../../_includes/metadata-hub/schema-registry-quotas.md) %}

## {{ data-catalog-name }} quotas {#data-catalog-quota}

{% include [data-registry-quotas](../../_includes/metadata-hub/data-catalog-quotas.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}