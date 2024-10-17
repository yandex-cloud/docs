---
title: How to create an OS Login profile
description: Follow this guide to create an OS Login profile.
---

# Creating an OS Login profile

By default, [enabling the setting](./os-login-access.md) creates OS Login profiles for all users within your organization. If necessary, you can create additional profiles or edit existing ones. You can use OS Login profiles as user profiles when working within [VMs](../../compute/concepts/vm.md) or {{ k8s }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes.

To create an OS Login profile for a user:

{% list tabs group=instructions %}

- {{ org-name }} interface {#console}

  1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  1. [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.
  1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg).
  1. Select a user from the list.
  1. Go to the **{{ ui-key.yacloud_org.page.user.title_tab-os-login }}** tab.
  1. Click **{{ ui-key.yacloud_org.entity.oslogin-profile.action.create }}**.
  1. Enter the username.

      {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

  1. Enter a unique numeric user ID (UID) within the range of `1,000` to `65,534`.
  1. (Optional) Enter the path to the user's home directory.
  1. (Optional) Enter the path to the shell's executable file.
  1. Click **{{ ui-key.yacloud_org.forms.action.create }}**.

- API {#api}

  Use the [createProfile](../../organization/api-ref/OsLogin/createProfile.md) REST API method for the [OsLogin](../../organization/api-ref/OsLogin/index.md) resource or the [OsLoginService/CreateProfile](../../organization/api-ref/grpc/OsLogin/createProfile.md) gRPC API call.

{% endlist %}

{% note info %}

If manually entering the UID, please use values within the range of `1,000` to `65,534`. Using this range will prevent matches between the OS Login profile UID and those of OS system profiles.

{% endnote %}

#### See also {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an OS Login profile for VM management via Ansible](../tutorials/sa-oslogin-ansible.md)