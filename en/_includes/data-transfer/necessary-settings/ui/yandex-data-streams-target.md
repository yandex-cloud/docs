* **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select a {{ ydb-full-name }} database registered in [{{ yds-full-name }}](../../../../data-streams/) as a target.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the data stream associated with the database.

* {% include [Field Service Account](../../fields/yds/ui/service-account-target.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

   Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
