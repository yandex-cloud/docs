# Managing a {{ mdb-lb }} load balancer

In {{ mmy-name }}, you can use a [{{ mdb-lb }} load balancer](../concepts/load-balancer.md) that automatically distributes queries across database hosts based on their role and availability.

{% include [preview-tp](../../_includes/mdb/preview-support.md) %}

You can:

* [Get a load balancer's FQDN](#fqdn).
* [Enable or disable a load balancer](#enable-balancer)

## Getting a load balancer's FQDN {#fqdn}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name.
  1. Copy the value into the **Load balancer FQDN** field.

{% endlist %}

## Enabling a load balancer {#enable-balancer}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select the cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **DB Proxy**, enable **DB Proxy balancing** and specify replica-level load balancing settings under **Port settings**:

      {% include [lb-settings](../../_includes/mdb/mmy/load-balancer-settings.md) %}

  If you no longer need the load balancer, disable **DB Proxy balancing** following the same steps.

{% endlist %}

