1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
1. Go to the page of the VM from the previously created group.
1. Copy **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** from the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section.
1. [Connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
1. Stop the web service to simulate a failure on the web server:

   ```bash
   sudo service nginx stop
   ```

1. Open your website in a browser. The website should open, even though one of the web servers has failed.
1. After the check is complete, restart the web service:

   ```bash
   sudo service nginx start
   ```