

Before creating a connection, make sure you have selected the right folder. If you have access to {{ PG }}, {{ CH }}, {{ MY }}, {{ GP }}, {{ VLK }}, or {{ SD }} clusters previously created in that folder, they will automatically appear in the **{{ yandex-cloud }} connections** subsection. You will only need to create a connection to the appropriate database in the cluster.


{% note info %}

[{{ mtr-full-name }}](../../managed-trino/) is at the [Preview](../../overview/concepts/launch-stages.md) stage. Currently, you cannot create connections to {{ mtr-full-name }} in the {{ websql-full-name }} interface. However, if the current folder has a {{ mtr-full-name }} cluster and the user can access it, the connection will be displayed in {{ websql-name }}, available for use. 

{% endnote %}


{{ websql-name }} uses connections in {{ metadata-hub-full-name }} {{ connection-manager-name }}, so all connections configured in {{ connection-manager-name }} are automatically available in {{ websql-name }} provided that the user has the appropriate [roles](../../metadata-hub/security/index.md#service-roles).

To create a connection to a {{ yandex-cloud }} managed database cluster:

1. Make sure **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** is enabled in the cluster settings.
1. Open {{ websql-full-name }} [**Connections**]({{ websql-link }}).
1. In ![image](../../_assets/console-icons/folder-tree.svg) **Connections**, click ![image](../../_assets/console-icons/square-plus.svg).
1. In the **Database type** field, select the database you need: {{ PG }}, {{ CH }}, {{ MY }}, {{ VLK }}, {{ SD }}, or {{ GP }}.
1. In the **Cluster folder** field, select the folder hosting the required cluster.
1. In the **Cluster** field, select the managed database cluster you want to connect to. 
1. Specify the **Username** you will use to connect to cluster databases.
1. Enter the user **Password**.
1. List the **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them.
1. Click **Create**.
