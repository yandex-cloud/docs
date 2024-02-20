# {{ GL }} integration with {{ tracker-full-name }}

In [{{ tracker-name }} issues](../../tracker/about-tracker.md#zadacha), you can automatically add links to [Merge Requests]({{ gl.docs }}/ee/user/project/merge_requests/) from {{ GL }}. To do this, specify the appropriate issue's [key](../../tracker/glossary.md#key) in the name or description of a new Merge Request. The links will be placed in [{{ ui-key.startrek.ui_components_issue-links_ExternalLinksCollapse.external-relations }}](../../tracker/external-links.md).

You can also enable automatic creation of issue comments with information about Merge Requests. Auto comments are only available for [{{ mgl-name }}](../../managed-gitlab/).

To set up integration with {{ GL }} in {{ tracker-name }}:

1. [Connect {{ tracker-full-name }}](#enable-tracker).
1. [Create a {{ GL }} instance](#create-gitlab).
1. [(Optional) Create a {{ GL }} project](#create-project).
1. [Create a hook for integration](#create-hook).
1. [Test the hook](#test-hook).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Connect {{ tracker-full-name }} {#enable-tracker}

[Enable {{ tracker-name }}](../../tracker/enable-tracker.md) for your [{{ yandex-cloud }} organization](../../organization/).

## Create a {{ GL }} instance {#create-gitlab}

Create a [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance) or a [VM](../../compute/concepts/vm.md) with the [{{ GL }} image](../../compute/concepts/image.md).

{% list tabs group=gl_installation %}


- {{ mgl-name }} instance {#instance-mgl}

   Create a {{ mgl-name }} instance by following [this guide](../../managed-gitlab/quickstart.md#instance-create).


- VM running a {{ GL }} image {#gl-image-vm}

   Launch {{ GL }} on a VM with a [public IP](../../vpc/concepts/address.md#public-addresses).

   {% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

{% endlist %}

## (Optional) Create a {{ GL }} project {#create-project}

To set up integration for an individual {{ GL }} project, create one.

{% list tabs group=gl_installation %}

- {{ mgl-name }} instance {#instance-mgl}

   1. Log in to the [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance) web interface.
   1. Click **Create a project**.
   1. Click **Create blank project**.
   1. Fill out the fields below:
      * **Project name**: Enter a name for the project.
      * **Project URL**: Select the administrator user in the field next to the {{ mgl-name }} instance FQDN.

      Leave the other fields unchanged.
   1. Click **Create project**.

- VM running a {{ GL }} image {#gl-image-vm}

   1. On the {{ compute-full-name }} page, select the created [VM](../../compute/concepts/vm.md) and copy its [public IP](../../vpc/concepts/address.md#public-addresses).
   1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.
   1. Get the {{ GL }} administrator password using the following VM command:

      ```bash
      sudo cat /etc/gitlab/initial_root_password
      ```

   1. Copy the password (without spaces) from the `Password` row to the clipboard or a separate file.
   1. Open `http://<VM_public_IP_address>` in your browser. This will take you to the {{ GL }} web interface.
   1. Log in using the administrator account:
      * **Username or email**: `root`
      * **Password**: Password you copied earlier

      If you are unable to log in, [reset the administrator account password]({{ gl.docs }}/ee/security/reset_user_password.html#reset-your-root-password).
   1. [Change the administrator account password]({{ gl.docs }}/ee/user/profile/user_passwords.html#change-your-password).
   1. Log in to the system again using the administrator account and the new password.
   1. Select **Create a project**.
   1. Give your project a name.
   1. Click **Create project**.

{% endlist %}

## Create a hook for integration {#create-hook}

{% include notitle [create hook](../../_includes/managed-gitlab/create-hook.md) %}

## Test the hook {#test-hook}

{% include notitle [test hook](../../_includes/managed-gitlab/test-hook.md) %}

## Check the result {#check-result}

1. [Create an issue](../../tracker/user/create-ticket.md#create-task) in {{ tracker-name }}.
1. [Create a Merge Request]({{ gl.docs }}/ee/user/project/merge_requests/creating_merge_requests.html) in {{ GL }} and specify the [issue key](../../tracker/glossary.md#key) in its name or description.
1. Make sure the {{ tracker-name }} issue now contains a link to the {{ GL }} Merge Request under [{{ ui-key.startrek.ui_components_issue-links_ExternalLinksCollapse.external-relations}}](../../tracker/external-links.md).

   If you used {{ mgl-name }} and enabled auto comments when [creating a hook](#create-hook), the issue will show a comment with the Merge Request link and details.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ mgl-name }} instance](../../managed-gitlab/operations/instance/instance-delete.md) or the [created VM with the {{ GL }} image](../../compute/operations/vm-control/vm-delete.md).
1. If you reserved a public static IP address for the VM, release and [delete it](../../vpc/operations/address-delete.md).
