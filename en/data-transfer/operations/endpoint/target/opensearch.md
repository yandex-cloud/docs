---
title: "How to set up an {{ OS }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up an {{ OS }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring an {{ OS }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mos-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


## {{ mos-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mos.viewer }}` role](../../../../managed-opensearch/security/index.md#mos-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

{% endnote %}


Connection with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed OpenSearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-opensearch.md) %}

{% endlist %}


## Custom installation {#on-premise}

Connecting to nodes with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise OpenSearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-opensearch.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete tables included in the transfer (used by default).

         Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.sanitize_doc_keys.title }}**: Use this option to automatically replace keys that are not valid for {{ OS }} in the target fields.

      {% include [sanitize-rules](../../../../_includes/data-transfer/necessary-settings/ui/es-os-sanitize-rules.md) %}

{% endlist %}
