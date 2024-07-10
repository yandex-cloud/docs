{{ AB }} has the following requirements for a Microsoft SQL Server data source:

1. Make sure your database is accessible from the computer running {{ AB }}.
1. Create a dedicated read-only {{ AB }} user with access to all tables that require replication.

For more information, see the [{{ AB }} documentation](https://docs.airbyte.com/integrations/sources/mssql).

{{ AB }} is already built into {{ data-transfer-name }}, so you do not have to create a separate VM to deploy it and add a user. All you have to do is grant {{ data-transfer-name }} [network access](../../../../data-transfer/concepts/network.md) to the source database.
