Configure Joomla by following [this guide](https://docs.joomla.org/J3.x:Installing_Joomla) on the project website. During the configuration process, you will need the DB connection settings.
1. Get the addresses of the DB cluster hosts in the management console:
   1. Open the folder where the DB cluster was created and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Select the `joomla-pg-tutorial-db-cluster` cluster.
   1. Go to the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
   1. In the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** field, copy the host addresses.
1. At the **Database** step, fill in the following fields in the Joomla web installer:
   * **Database type**: `{{ PG }}`.
   * **DB server name**:

      ```text
      <address_of_host_1>,<address_of_host_2>,<address_of_host_3> port=6432 sslmode=verify-full target_session_attrs=read-write
      ```

   * **Username**: `joomla`.
   * **Password**: Enter the DB user's password.
   * **DB name**: `joomla-pg-tutorial-db`.
1. For security reasons, Joomla may ask you to create or delete a special test file. On the VM, go to the `/var/www/html/installation` folder and create or delete the specified file there.
1. Create an empty file named `configuration.php` to safe configuration and configure write permissions for the folder:

   ```bash
   sudo touch /var/www/html/configuration.php
   sudo chmod 655 /var/www/html/configuration.php
   sudo chown -R apache:apache /var/www/html/
   sudo restorecon -R /var/www/html
   ```

1. After the installation is completed, delete the `installation` directory. This is a Joomla security requirement:

   ```bash
   sudo rm -rf /var/www/html/installation
   ```
