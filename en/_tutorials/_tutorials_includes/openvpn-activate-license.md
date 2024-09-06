{% note info %}

If you have up to two VPN connections, use the product for free (no activation required).

{% endnote %}

To activate the license:

1. Create an account on [openvpn.net](https://myaccount.openvpn.com/signup).
1. Enter the confirmation code sent to your email address.
1. In the **Where would you like to Go?** window, select the **Remember my choice** option and select the **Access serve** product.
1. In the **Tell us more** window, select the purpose: **Business use** or **Personal use**.
1. On the **Subscriptions** tab, select the maximum number of connections in the **How many VPN connections do you need?** field and click **Create**.
1. Your subscription will be displayed on the screen: **Subscription 1**.
1. To copy the activation key, click **Copy Key** under **Subscription Key**.

Wait until the VM status changes to `RUNNING` and enter the activation key in the admin panel at `https://<VM_public_IP_address>/admin/`.

You can look up the VM's public IP address in the [management console]({{ link-console-main }}) by checking the **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** field under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page.