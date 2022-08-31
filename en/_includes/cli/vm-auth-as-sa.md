The authentication process from inside a VM is simplified for a service account:
{% if audience != "internal" %}
1. [Link your service account](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a virtual machine.
{% else %}
1. Link your service account to a virtual machine.
{% endif %}
1. Authenticate from inside a VM:
   {% if audience != "internal" %}
   1. Connect to the virtual machine [over SSH](../../compute/operations/vm-connect/ssh.md){% if product == "cloud-il" %} or [via RDP](../../compute/operations/vm-connect/rdp.md){% endif %}.
   {% else %}
   1. Connect to the virtual machine over SSH or via RDP.
   {% endif %}

   1. Create a new profile:

      ```
      yc config profile create my-robot-profile
      ```

{% if product == "cloud-il" %}
1. Add the hostname and the port for sending requests to {{ yandex-cloud }} to the CLI profile:

   ```
   yc config set endpoint {{ api-host }}:443
   ```   
{% endif %}

1. Configure your profile to run commands.

    {% include [add-folder](../cli-add-folder.md) %}

