# {{ GL }} integration with {{ tracker-full-name }}


In [{{ tracker-name }} issues]({{ link-tracker-cloudless }}about-tracker#zadacha), you can automatically add links to {{ GL }} [merge requests]({{ gl.docs }}/ee/user/project/merge_requests/) by specifying the appropriate issue [key]({{ link-tracker-cloudless }}glossary#key) in the name or description of a new merge request. The links will be placed in [Links to external applications]({{ link-tracker-cloudless }}external-links).

You can also enable automatic creation of issue comments with information about merge requests. Auto comments are only available for [{{ mgl-name }}](../../managed-gitlab/).

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

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for a [disk](../../compute/concepts/disk.md) and a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for the number of {{ tracker-name }} users with full access if there are more than 5 of them (see [{{ tracker-name }} pricing]({{ link-tracker-cloudless }}cloud/pricing)).
* Fee for using a [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Enable {{ tracker-full-name }} {#enable-tracker}

[Enable {{ tracker-name }}]({{ link-tracker-cloudless }}enable-tracker) for your [{{ yandex-cloud }} organization](../../organization/).

## Create a {{ GL }} instance {#create-gitlab}

Create a [{{ mgl-name }} instance](../../managed-gitlab/concepts/index.md#instance) or a [VM](../../compute/concepts/vm.md) with the [{{ GL }} image](../../compute/concepts/image.md).

{% list tabs group=gl_installation %}

- {{ mgl-name }} instance {#instance-mgl}

    Create a {{ mgl-name }} instance by following [this guide](../../managed-gitlab/quickstart.md#instance-create).

- VM with a {{ GL }} image {#gl-image-vm}

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
    1. Fill in the fields as follows:
        * **Project name**: Enter a name for the project.
        * **Project URL**: Select the administrator user in the field next to the {{ mgl-name }} instance FQDN.

        Leave the other fields unchanged.
    1. Click **Create project**.

- VM with a {{ GL }} image {#gl-image-vm}

    1. On the {{ compute-full-name }} page, select the created [VM](../../compute/concepts/vm.md) and copy its [public IP](../../vpc/concepts/address.md#public-addresses).
    1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
    1. Get the {{ GL }} administrator password with the following VM command:

        ```bash
        sudo cat /etc/gitlab/initial_root_password
        ```

    1. Copy the password without spaces from the `Password` line to the clipboard or a separate file.
    1. In your browser, open `http://<VM_public_IP_address>`. This will take you to the {{ GL }} web interface.
    1. Log in as the administrator:
        * **Username or email**: `root`.
        * **Password**: Password you copied in the previous step.

        If you are unable to log in, [reset the administrator password]({{ gl.docs }}/ee/security/reset_user_password.html#reset-your-root-password).
    1. [Change the administrator password]({{ gl.docs }}/ee/user/profile/user_passwords.html#change-your-password).
    1. Log in as the administrator with the new password.
    1. Select **Create a project**.
    1. Give your project a name.
    1. Click **Create project**.

{% endlist %}

## Create a hook for integration {#create-hook}

{% include notitle [create hook](../../_includes/managed-gitlab/create-hook.md) %}

## Test the hook {#test-hook}

{% include notitle [test hook](../../_includes/managed-gitlab/test-hook.md) %}

## Check the result {#check-result}

1. [Create an issue]({{ link-tracker-cloudless }}user/create-ticket#create-task) in {{ tracker-name }}.
1. [Create a merge request]({{ gl.docs }}/ee/user/project/merge_requests/creating_merge_requests.html) in {{ GL }} and specify the [issue key]({{ link-tracker-cloudless }}glossary#key)in its name or description.
1. Make sure the {{ tracker-name }} issue now contains a link to the {{ GL }} merge request under [Links to external applications]({{ link-tracker-cloudless }}external-links).
    If you used {{ mgl-name }} and enabled auto comments when [creating a hook](#create-hook), the issue will show a comment with the merge request link and details.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ mgl-name }} instance](../../managed-gitlab/operations/instance/instance-delete.md) or the [{{ GL }} image VM](../../compute/operations/vm-control/vm-delete.md).
1. If you reserved a public static IP address for the VM, release and [delete it](../../vpc/operations/address-delete.md).
