After the `wordpress` VM's [status](../../../compute/concepts/vm-statuses.md) changes to `RUNNING`, do the following:
1. Under **Network** on the VM page in the [management console]({{ link-console-main }}), find the VM's public IP address and enter it in the [A](../../../dns/concepts/resource-record.md#a) [resource record](../../../dns/concepts/dns-zone.md) you previously created.

   ![add-ssh](../../../_assets/tutorials/wordpress/vm-create-5.png)

1. Open the domain name you configured or the VM's address in the browser.
1. Select the language and click **Continue**.

   ![choose-language](../../../_assets/tutorials/wordpress/wordpress-1.png)

1. Fill out information to access the website:
   1. Enter any name for the website (for example, `yc-wordpress`).
   1. Specify the username to be used to log in to the admin panel (for example, `yc-user`).
   1. Enter the password to be used to log in to the admin panel.
   1. Enter your email address.

   ![credentials](../../../_assets/tutorials/wordpress/wordpress-2.png)

1. Click **Install WordPress**.
1. If the installation is successful, click **Log in**.

   ![login](../../../_assets/tutorials/wordpress/wordpress-3.png)

1. Log in to the website with the username and password specified in the previous steps. This will open the admin panel where you can start working with your website.
1. Make sure the website is accessible by opening the VM's public IP address in your browser.