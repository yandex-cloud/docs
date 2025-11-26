---
title: How to create an {{ oslogin }} profile
description: Follow this guide to create an {{ oslogin }} profile.
---

# Creating an {{ oslogin }} profile

By default, [enabling the {{ oslogin }} access](./os-login-access.md) automatically creates [{{ oslogin }} profiles](../concepts/os-login.md#os-login-profiles) for all users within your {{ org-name }}. At the same time, each user or [service account](../../iam/concepts/users/service-accounts.md) may have multiple {{ oslogin }} profiles, which you can create manually. Different profiles allow you to connect to [VMs](../../compute/concepts/vm.md) or [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes as different local users of those VMs or {{ k8s }} nodes.

For service accounts, {{ oslogin }} profiles are not created automatically. To connect to a VM or {{ k8s }} node as a service account, you need to manually create its {{ oslogin }} profile.

{% note info %}

{% include [os-login-profile-tab-access-notice](../../_includes/organization/os-login-profile-tab-access-notice.md) %}

{% endnote %}

To create an {{ oslogin }} profile:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

      [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
 
  1. From the list, select the user you want to create an {{ oslogin }} profile for.
  
      Use the filter or search as needed.
  
  1. On the user page, go to the **{{ ui-key.yacloud_org.user.title_oslogin-profiles }}** tab and click **{{ ui-key.yacloud_org.entity.oslogin-profile.action.create }}**. In the window that opens, do the following:

      1. Enter the OS username that will be assigned to the organization user or service account when connecting to the VM. It must be unique within the folder.

          {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

      1. In the **{{ ui-key.yacloud_org.form.oslogin.field_uid }}** field, enter a unique numeric user ID (UID). It must be unique within the system.

          {% include [user-defined-uid-range-notice](../../_includes/organization/user-defined-uid-range-notice.md) %}

      1. (Optional) In the **{{ ui-key.yacloud_org.form.oslogin.field_home-directory }}** field, enter the path to the user's home folder.

      1. (Optional) In the **{{ ui-key.yacloud_org.form.oslogin.field_shell }}** field, specify the path to the command shell executable file.

      1. Click **{{ ui-key.yacloud_org.forms.action.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating an {{ oslogin }} profile:

      ```bash
      yc organization-manager oslogin profile create --help
      ```

  1. Get the ID of the required organization:

      ```bash
      yc organization-manager organization list
      ```

      Result:

      ```text
      +----------------------+-------------------------+-----------------------+--------+
      |          ID          |          NAME           |         TITLE         | LABELS |
      +----------------------+-------------------------+-----------------------+--------+
      | bpf1smsil5q0******** | sample-organization-1   | My organization       |        |
      | bpf2c65rqcl8******** | sample-organization-new | New organization      |        |
      +----------------------+-------------------------+-----------------------+--------+
      ```

  1. Get the required user ID by specifying the ID of the organization it belongs to:

      ```bash
      yc organization-manager user list \
        --organization-id <organization_ID>
      ```

      Result:

      ```text
      +----------------------+----------+-------------------+---------------+-----------------------+
      |          ID          | USERNAME |       EMAIL       | FEDERATION ID | LAST AUTHENTICATED AT |
      +----------------------+----------+-------------------+---------------+-----------------------+
      | rser11gh89el******** | user01   | user01@example.ru |               |                       |
      | mber02hy54km******** | user02   | user02@example.ru |               |                       |
      +----------------------+----------+-------------------+---------------+-----------------------+
      ```

      To create an {{ oslogin }} profile for a service account, [get](../../iam/operations/sa/get-id.md) the service account ID.

  1. Create an {{ oslogin }} profile for the selected user or service account:

      ```bash
      yc organization-manager oslogin profile create \
        --organization-id <organization_ID> \
        --subject-id <user_or_service_account_ID> \
        --login <login> \
        --uid <numeric_ID> \
        --home-directory <path_to_home_folder> \
        --shell <path_to_command_shell_executable_file>
      ```

      Where:

      * `--organization-id`: Organization ID you got earlier.
      * `--subject-id`: User or service account ID you got earlier.
      * `--login`: OS username the user will get when connected to the VM. It must be unique within the folder.

          {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

      * `--uid`: Unique numeric user ID (UID). It must be unique within the system.

          {% include [user-defined-uid-range-notice](../../_includes/organization/user-defined-uid-range-notice.md) %}

      * `--home-directory`: Path to the user's home folder on the VM. This is an optional parameter. The default value is `/home/<username>`.
      * `--shell`: Path to the command shell executable file on the VM. This is an optional parameter. The default value is `/bin/bash`.

      Result:

      ```text
      id: aje6ddct3de5********
      organization_id: bpf1smsil5q0********
      subject_id: rser11gh89el********
      login: new-os-login
      uid: "100500"
      home_directory: home/username
      shell: bin/bash
      ```

- API {#api}

  Use the [createProfile](../../organization/api-ref/OsLogin/createProfile.md) REST API method for the [OsLogin](../../organization/api-ref/OsLogin/index.md) resource or the [OsLoginService/CreateProfile](../../organization/api-ref/grpc/OsLogin/createProfile.md) gRPC API call.

{% endlist %}

You can only create an {{ oslogin }} profile for a service account using the [{{ yandex-cloud }} CLI](../cli-ref/oslogin/profile/create.md) or [API](../../organization/api-ref/OsLogin/createProfile.md).

#### See also {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via {{ oslogin }}](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an {{ oslogin }} profile for VM management via Ansible](../tutorials/sa-oslogin-ansible.md)