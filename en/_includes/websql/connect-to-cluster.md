Before creating a connection, make sure that you have selected the required folder. If you have access to {{ PG }}, {{ CH }}, or {{ MY }} clusters previously created in that folder, they will automatically appear in the **{{ yandex-cloud }} connections** subsection. You will only need to create a connection to the appropriate database in the cluster.

Connections to clusters created in {{ metadata-hub-name }} {{ connection-manager-name }} will also be displayed automatically, provided you have the [roles](../../metadata-hub/security/index.md#service-roles) to manage these connections in {{ connection-manager-name }}.

To create a connection to a managed database cluster:

1. Make sure **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** is enabled in the cluster settings.
1. Open the {{ websql-full-name }} [**Connections**]({{ websql-link }}).
1. Under ![image](../../_assets/console-icons/folder-tree.svg) **Connections**, click ![image](../../_assets/console-icons/square-plus.svg).
1. **Name** the connection.
1. In the **Database type** field, select the database you need: {{ PG }}, {{ CH }}, or {{ MY }}.
1. In the **Cluster** field, select the managed database cluster you want to connect to.
1. Specify the **Username** you will use to connect to cluster DBs.
1. Enter the **Password** for the user.
1. List the **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them configured.
1. Click **Create**.
