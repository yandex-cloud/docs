---
title: "How to view a chart of network connections in {{ vpc-full-name }}"
description: "Follow this guide to view a chart of network connections."
---

# Chart of network connections

To view the chart of your VM or cluster network connections:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the desired resource.
   1. Select the appropriate service from the list of services, such as **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** for VMs or **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** for clusters.
   1. Select the desired resource from the list.
   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.
   1. Find the **Connections quota utilization** chart.

   The chart values may be higher than the values within the resource. This is due to the record delete delay:

   {% include [conditions-for-deleting-records](../../_includes/vpc/conditions-for-deleting-records.md) %}

{% endlist %}
