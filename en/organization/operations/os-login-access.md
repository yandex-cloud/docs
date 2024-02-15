---
title: "How to enable OS Login access in your organization"
description: "Follow this guide to enable access to your organization's VMs through OS Login."
---

# Enabling access via OS Login

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

To create virtual machine instances with [OS Login](../concepts/os-login.md) access, enable this feature at the organization level. This will allow you to [enable](../../compute/operations/vm-control/vm-update.md#enable-oslogin-access) OS Login access for VM instances created from a ready-made image with OS Login support or [configure](../../compute/operations/vm-connect/enable-os-login.md) the OS Login agent on an already running VM instance. For more information about how to connect via OS Login, see [{#T}](../../compute/operations/vm-connect/os-login.md).

{% note info %}

Images with OS Login support are available on [{{ marketplace-full-name }}](/marketplace) and are identified by `OS Login` in the title.

{% endnote %}

To enable OS Login access at the organization level:

{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

  1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  1. [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. Enable **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.

{% endlist %}
