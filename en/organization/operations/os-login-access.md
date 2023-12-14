# Enabling access via OS Login

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

To create virtual machine instances with [OS Login](../concepts/os-login.md) access, enable this feature at the organization level. This will allow you to enable OS Login access for VM instances created from a ready-made image with OS Login support or configure the OS Login agent on an already running VM instance. For more information, see [{#T}](../../compute/operations/vm-connect/os-login.md).

{% note info %}

Images with OS Login support are available on [{{ marketplace-full-name }}](/marketplace) and are identified by `OS Login` in the title.

{% endnote %}

To enable OS Login access at the organization level:

{% list tabs %}

- {{ org-name }}

  1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **Security settings**.
  1. Enable **Access via OS Login using SSH keys**.

{% endlist %}
