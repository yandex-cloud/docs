The authentication process from inside a VM is simplified for a service account:
{% if audience != "internal" %}
1. [Link the service account](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a VM.
{% else %}
1. Link the service account to a VM.
{% endif %}
1. Authenticate from inside a VM:
   {% if audience != "internal" %}
   1. {% if product == "yandex-cloud" %}[Connect](../../compute/operations/vm-connect/ssh.md) to a virtual machine over {% if lang == "ru" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}.{% endif %}{% if product == "cloud-il" %}Connect to a virtual machine over [SSH](../../compute/operations/vm-connect/ssh.md) or [RDP](../../compute/operations/vm-connect/rdp.md).{% endif %}
   {% else %}
   1. Connect to the VM via SSH or RDP.
   {% endif %}
   1. Create a new profile:

      ```
      yc config profile create my-robot-profile
      ```

{% if product == "cloud-il" %}
1. Add the domain name and port for requests to {{ yandex-cloud }} to your CLI profile:

   ```
   yc config set endpoint {{ api-host }}:443
   ```
{% endif %}

1. Configure your profile to run commands.

   {% include [add-folder](../cli-add-folder.md) %}
