
1. In the top-right corner of the workbook, click **Create** → ![image](../../../_assets/console-icons/thunderbolt.svg) **Connection**.



1. Under **Databases**, select the **{{ CH }}** connection.

   
   1. In the window that opens, select `Specify manually` for the connection type and provide the following connection parameters:

      * Host name: `rc1a-ckg8nrosr2lim5iz.{{ dns-zone }}`
      * HTTP interface port: `8443` (default)
      * Username: `samples_ro`
      * Password: `MsgfcjEhJk`

   1. Enable the **SQL query access level** option and select **Allow subqueries in datasets and source parameterization**.
   1. Click **Check connection** and make sure you get a green check mark.
   1. Click **Create connection**.
   1. Enter the connection name: `Sample ClickHouse`.
   1. Click **Create**.

      ![create-connection](../../../_assets/datalens/operations/connection/create-sample-connection-parametrization.png)



Wait for the connection to be saved.