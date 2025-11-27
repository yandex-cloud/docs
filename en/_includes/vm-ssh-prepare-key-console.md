1. In the [management console]({{ link-console-main }}), select the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) where you want to [create](../compute/operations/vm-create/create-linux-vm.md) your VM.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
1. In the window that opens, select `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` and click **{{ ui-key.yacloud.common.add }}**.

    {% include [where-generated-keys](./compute/create/where-generated-keys.md) %}

    {% include [ssh-add-to-org-profile](./compute/create/ssh-add-to-org-profile.md) %}

{% cut "UNPROTECTED PRIVATE KEY FILE warning" %}
    
On Unix-like systems, after you unpack a private key to the `.ssh` directory, the key gets permissions that are too high. This prompts the `UNPROTECTED PRIVATE KEY FILE` warning when connecting to the VM. To reduce the permissions, run this command:

```bash
chmod 600 <path_to_private_key_file>
```
    
{% endcut %}
    
    