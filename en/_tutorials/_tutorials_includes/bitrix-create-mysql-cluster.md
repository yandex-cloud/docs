{% list tabs group=instructions %}

- Management console {#console}

   1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-mysql }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter the cluster name, e.g., `Bitrix{{ MY }}`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select `s3-c2-m8`. This configuration is enough for 1C-Bitrix to run.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, set [storage type](../../managed-mysql/concepts/storage.md) to `network-ssd` and size to `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**​. In this tutorial, leave the default value, `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** which serves as a username for connecting to the DB. In this tutorial, leave the default value, `user1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** for 1C-Bitrix to access the {{ MY }} database, e.g., `p@s$woRd!`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:
      * In the **{{ ui-key.yacloud.mdb.forms.label_network }}** field, select `network-1` you created earlier.
      * In the **{{ ui-key.yacloud.mdb.forms.field_security-group }}** field, select the `bitrix-sg` security group.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, change the availability zone for the database if required. To do this, click ![pencil](../../_assets/console-icons/pencil.svg) in the line containing host info. In the window that opens, select the availability zone and click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

      We recommend selecting the same availability zone as when you created the VM. This reduces latency between the VM and the DB.

   1. To make your DB fault-tolerant, you can add more hosts for it. To do this, click **{{ ui-key.yacloud.mdb.forms.button_add-host }}** and specify the availability zone to place it in.
   1. Leave the other fields unchanged.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

   Creating a DB cluster may take a few minutes. To check that the new cluster is available, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** in the {{ yandex-cloud }} management console. On the **{{ ui-key.yacloud.mysql.switch_list }}** tab, the cluster status must be `Running` and its state, `Alive`.

{% endlist %}