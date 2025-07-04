{% note warning %}

After you recover a {{ baremetal-name }} server from another server’s backup, you may lose network access to the target server. This is because the network settings recovered from the backup, namely the network interface MAC addresses, were taken from the source server.

To restore the network on the target VM, update the MAC addresses in the server's network interface settings using the KVM console. You can get current MAC addresses in the server OS using the `ip a` command or in the [management console]({{ link-console-main }}) on the server information page under **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** and **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**. For more information on setting up network interfaces in a particular OS, see the relevant OS guides.

{% endnote %}