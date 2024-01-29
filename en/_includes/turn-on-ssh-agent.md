Launch the SSH agent:

{% list tabs group=operating_system %}

- Linux/MacOS {#linux-macos}

   1. Run this command:

      ```bash
      ssh-agent -s
      ```

   1. For the SSH agent to start on login, add the launch command to the `~/.profile` file:

      ```bash
      ssh-agent -s
      ```

- Windows {#windows}

   1. Open the **Start** button context menu.
   1. Select **Computer Management**.
   1. Go to **Services and Applications** → **Services**.
   1. Open the context menu of the **SSH agent** service and select **Properties**.
   1. On the **Main** tab, change the startup type from **Off** to **Automatic**.
   1. Click **OK** and start the service.

{% endlist %}
