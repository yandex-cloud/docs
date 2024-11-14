---
title: How to create an OS Login profile
description: Follow this guide to create an OS Login profile.
---

# Creating an OS Login profile

By default, [enabling the setting](./os-login-access.md) creates OS Login profiles for all users within your organization. If necessary, you can create additional profiles or edit existing ones. You can use OS Login profiles as user profiles when working within [VMs](../../compute/concepts/vm.md) or {{ k8s }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes.

To create an OS Login profile for a user:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

      [Switch](./manage-organizations.md#switch-to-another-org) to an organization or federation of your choice as needed.

  1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
 
  1. From the list, select the user you want to create an {{ oslogin }} profile for.
  
      You may want to use the filter or search feature.
  
  1. On the user page, click the **{{ ui-key.yacloud_org.page.user.title_tab-os-login }}** tab and click **{{ ui-key.yacloud_org.entity.oslogin-profile.action.create }}**. In the window that opens:

      1. Enter the username in the OS that will be assigned to the user when connecting to the VM. It must be unique within the folder.

          {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

      1. In the **{{ ui-key.yacloud_org.form.oslogin.field_uid }}** field, enter a unique numeric user ID (UID) within the range of `1000` to `65534`. It must be unique within the system.

      1. (Optional) In the **{{ ui-key.yacloud_org.form.oslogin.field_home-directory }}** field, enter the path to the user's home folder.

      1. (Optional) In the **{{ ui-key.yacloud_org.form.oslogin.field_shell }}** field, specify the path to the command shell executable file.

      1. Click **{{ ui-key.yacloud_org.forms.action.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating an OS Login profile:

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


  1. Create an OS Login profile for the selected user:

      ```bash
      yc organization-manager oslogin profile create \
        --organization-id <organization_ID> \
        --subject-id <user_ID> \
        --login <login> \
        --uid <numeric_ID> \
        --home-directory <path_to_home_folder> \
        --shell <path_to_command_shell_executable_file>
      ```

      Where:

      * `--organization-id`: Organization ID you got earlier.
      * `--subject-id`: User ID you got earlier.
      * `--login`: Username in the OS that will be assigned to the user when connecting to the VM. It must be unique within the folder.

          {% include [note-info-user-name-limits](../../_includes/organization/note-info-user-name-limits.md) %}

      * `--uid`: Unique numeric user ID (UID) within the range of `1000` to `65534`. It must be unique within the system.
      * (Optional) `--home-directory`: Path to the user's home folder. The default value is `/home/<username>`.
      * (Optional) `--shell`: Path to the command shell executable file. The default value is `/bin/bash`.

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

{% note info %}

If you set the UID manually, use values in the range of `1000` to `65534`. Using this range will prevent matches between the OS Login profile UID and those of OS system profiles.

{% endnote %}

#### See also {#see-also}

* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/add-ssh.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
* [Connecting to a {{ k8s }} node via OS Login](../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Using a service account with an OS Login profile for VM management via Ansible](../tutorials/sa-oslogin-ansible.md)