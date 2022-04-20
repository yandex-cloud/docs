# Binding a public IP to a virtual machine

If you created a virtual machine without a public IP, you can bind it to an IP [you reserved](../../../vpc/operations/get-static-ip.md) in {{ vpc-name }} or to one automatically selected by {{ compute-name }} from among available IPs.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Select the VM.
   1. Under **Network interface**, in the top right-hand corner, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Add public IP**.
   1. In the window that opens:
      * In the **Public IP** field, choose **Auto** assignment of IP addresses or choose a reserved address from a **List**
      * (option) If you selected **Auto** under **Public IP**, enable the **DDoS protection** option. For more information, see [{#T}](../../../vpc/ddos-protection/index.md).
      * If you selected **List** in the **Public IP** field, select the address that you would like to bind to your VM.
      * Click **Add**.

{% endlist %}