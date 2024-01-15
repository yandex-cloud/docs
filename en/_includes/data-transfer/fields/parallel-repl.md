**{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeIncrement.increment_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementSettings.parallel_settings.title }}**: Specify the number of workers required for parallel copy processes. This setting is available for the sources {{ ydb-short-name }}, {{ KF }}, and {{ DS }}. If multiple replication processes are run, they will share the partitions of the topic being replicated. 

{% note info %}

For {{ ydb-short-name }}, we recommend setting the number of workers to a value not exceeding the total number of table partitions, or else some resources will be idle. If a custom changefeed is not specified, as soon as a transfer is activated it will create a changefeed with the number of partitions equal to the number of {{ ydb-short-name }} table tablets as of the last activation.

{% endnote %}