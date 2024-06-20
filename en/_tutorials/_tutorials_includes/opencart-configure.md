1. Open the web interface of the OpenCart online store. In the browser, open `http://<VM_public_IP_address>/`. The OpenCart settings page opens.
1. Read the license and click **Continue**.

   ![Step 1](../../_assets/tutorials/opencart/opencart1.png)

1. Make sure that all lines with system requirements are marked with green ticks and click **Continue**.

   ![Step 2](../../_assets/tutorials/opencart/opencart2.png)

1. Set up access to the DB:

   {% list tabs %}

   - Local server {{ MY }}

      DB connection attributes are generated in a special file when a VM is created:
      1. Log in to the created VM via SSH.
      1. Switch to `sudo -i` administration mode.
      1. Open `default_passwords.txt` in the admin's home directory:

         ```bash
         root@opencart:~# cat default_passwords.txt
         MYSQL_USER=opencart
         MYSQL_PASS=qDbvN1R6tA6ET
         MYSQL_ROOT_PASS=5DiVb80l1kXVz
         MYSQL_DB=opencart
         ```

      1. On the OpenCart setup page, in the DB section, enter the relevant data:
         * **Username**: `MYSQL_USER` variable value.
         * **Database**: `MYSQL_DB` variable value.
         * **Password**: `MYSQL_PASS` variable value.

         Leave the other fields unchanged.

   - Cluster {{ mmy-name }}

      If you are using a {{ mmy-name }} cluster, enter the required cluster attributes:
      * **Hostname**: Enter the [fully qualified domain name (FQDN)](../../compute/concepts/network.md#hostname) of the created DB. To find out this name:
         1. Open the folder page in the [management console]({{ link-console-main }}) in a new browser tab.
         1. Go to the **{{ mmy-name }}** section.
         1. Select the cluster you created in the table.
         1. Select the **Hosts** tab in the left menu.
         1. Hover over the **Hostname** field (for example, `rc1c-vok617m35g3dj23i`) and copy the database's FQDN by clicking ![copy](../../_assets/console-icons/copy.svg).
      * **Username**: Username (`user1` in the example).
      * **Database**: DB name (`db1` in the example).
      * **Password**: User password you specified.

      Leave the other fields unchanged.

   {% endlist %}

1. Enter the administrator's name, password, and current email address. Then click **Continue**.

   ![Step 3](../../_assets/tutorials/opencart/opencart3.png)

1. A page will open to notify you that system configuration is complete. To configure the online store, click **Login to your administration** and enter your admin username and password.

   ![Step 4](../../_assets/tutorials/opencart/opencart4.png)

1. When the installation is complete, log in to the VM via SSH and delete the installation files you no longer need:

   ```bash
   user@opencart:~$ sudo -i
   root@opencart:~# rm -rf /var/www/opencart/install/
   ```

1. To test the home page, go to `http://<VM_public_IP_address>/`. You will see your website home page the way your online store visitors will see it.

   ![Step 5](../../_assets/tutorials/opencart/opencart5.png)