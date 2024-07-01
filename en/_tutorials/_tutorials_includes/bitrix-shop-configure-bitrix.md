Install and configure 1C-Bitrix:

1. Open the 1C-Bitrix: Site Management web interface at `http://<VM_public_IP_address>/` in your browser. A page will open prompting you to install 1C-Bitrix.

1. Click **Next** on the installer welcome screen.

   ![Step 1](../../_assets/tutorials/bitrix-shop/bitrix-shop1.png)

1. Read the license agreement and select **I accept the license agreement**. Then click **Next**.

   ![Step 2](../../_assets/tutorials/bitrix-shop/bitrix-shop2.png)

1. You do not need to register the product (you can disable this option). Make sure the **Install in UTF-8 encoding** option is selected and click **Next**.

   ![Step 3](../../_assets/tutorials/bitrix-shop/bitrix-shop3.png)

1. 1C-Bitrix will check if the server is configured correctly. Click **Next** at the bottom of the page.

   ![Step 4](../../_assets/tutorials/bitrix-shop/bitrix-shop4.png)

1. Configure the database:
   1. In the **Server** field, enter the fully qualified domain name (FQDN) of the DB you created. To find out this name:
      1. Open the folder page in the [management console]({{ link-console-main }}) in a new browser tab.
      1. Select **{{ mmy-name }}**.
      1. In the table, click the row of the DB cluster you created.
      1. Go to the **Hosts** tab.
      1. Hover over the **Hostname** field value and click ![copy](../../_assets/console-icons/copy.svg).
   1. In the **Username** and **Password** fields, specify the data you entered when creating the DB.
   1. In the **Database name** field, specify the DB name (`db1` in this example).
   1. Leave the default values in the other fields.
   1. Click **Next**.

   ![Step 5](../../_assets/tutorials/bitrix-shop/bitrix-shop5.png)

1. Wait for the system installation and DB initialization to complete.

   ![Step 6](../../_assets/tutorials/bitrix-shop/bitrix-shop6.png)

1. Create an administrator (a user to manage the system). Fill in the fields with your personal data and click **Next**.

   ![Step 7](../../_assets/tutorials/bitrix-shop/bitrix-shop7.png)

1. Select the **Online store** template and click **Next**.

   ![Step 8](../../_assets/tutorials/bitrix-shop/bitrix-shop8.png)

1. Confirm the selection of the only template and click **Next**.

   ![Step 9](../../_assets/tutorials/bitrix-shop/bitrix-shop9.png)

1. Select a color for the previously selected template and click **Next**.

   ![Step 10](../../_assets/tutorials/bitrix-shop/bitrix-shop10.png)

1. Fill in the fields according to your requirements for the online store and click **Next**.

   ![Step 11](../../_assets/tutorials/bitrix-shop/bitrix-shop11.png)

1. If necessary, enable the inventory management function and specify when to reserve items at the warehouse. Click **Next**.

   ![Step 12](../../_assets/tutorials/bitrix-shop/bitrix-shop12.png)

1. Enter your company information and click **Next**.

   ![Step 13](../../_assets/tutorials/bitrix-shop/bitrix-shop13.png)

1. Select the types of payers your online store should work with and click **Next**.

   ![Step 14](../../_assets/tutorials/bitrix-shop/bitrix-shop14.png)

1. Select the payment and delivery methods your online store supports and click **Next**.

   ![Step 15](../../_assets/tutorials/bitrix-shop/bitrix-shop15.png)

1. Wait for the system installation to complete.

   ![Step 16](../../_assets/tutorials/bitrix-shop/bitrix-shop16.png)

1. When the installation is complete, click **Go to site**.

   ![Step 17](../../_assets/tutorials/bitrix-shop/bitrix-shop17.png)

1. The online store interface will open in edit mode.

   ![Step 18](../../_assets/tutorials/bitrix-shop/bitrix-shop18.png)

1. Click **Exit** in the top-right corner of the page to see the site home page as a regular user. To return to edit mode, log in to the website using the 1C-Bitrix administrator credentials.

   ![Step 19](../../_assets/tutorials/bitrix-shop/bitrix-shop19.png)

{% note tip %}

To get system backups, [create disk snapshots](../../compute/operations/disk-control/create-snapshot.md) on your VM from time to time.

{% endnote %}