---
noIndex: true
---

# Creating a {{ metastore-name }} server

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a server.
   1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![image](../../../_assets/data-proc/data-proc.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** from the drop-down list.
   1. In the left-hand panel, click ![image](../../../_assets/data-proc/metastore.svg) **Metastore server**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Enter the server name in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The name must be unique within the folder.
   1. (Optional) Add a server description.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet where the {{ metastore-name }} server will be hosted.
   1. If the cloud network uses [security groups](../../../vpc/concepts/security-groups.md), set up the default security group to work with {{ metastore-name }}. To do this, [add](../../../vpc/operations/security-group-add-rule.md) the following rules to it:

      * For incoming client traffic:

         * Port range: `30000-32767`.
         * Protocol: ``Any``.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

      * For incoming load balancer traffic:

         * Port range: `10256`.
         * Protocol: ``Any``.
         * Source: `Load balancer health checks`.

   1. If needed, enable the server protection from accidental deletion by user.

      With the protection enabled, you will still be able to connect to the server manually and delete the data.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
