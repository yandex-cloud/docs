# Inviting a new user and assigning roles

In this tutorial, you will learn how to invite a new user to your organization and grant them permissions to create a VM in a folder. The tutorial includes instructions for both the administrator and the user. For the steps the user must complete, see [User actions](#user-actions).

To invite a user to your organization and grant them access to a folder and other resources:

1. [Prepare {{ yandex-cloud }}](#before-begin).
1. [Set up your infrastructure](#prepare-infrastructure).
1. [Invite the user to the organization and assign roles](#add-account).
1. Make sure the user has [accepted the invitation and can access the resources](#user-actions).

If you no longer need the paid resources you created, [delete them](#clear-out).

## Required paid resources {#paid-resources}

The cost of infrastructure support includes fees for computing resources, OS, storage, amount of outgoing traffic, and VM public IP address (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Prepare {{ yandex-cloud }} {#before-begin}

Sign up for {{ yandex-cloud }} and create a [billing account](../../billing/concepts/billing-account.md):

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create a new account.
1. On the **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** page, make sure you have a billing account linked and it has the `ACTIVE` or `TRIAL_ACTIVE` [status](../../billing/concepts/billing-account-statuses.md). If you do not have a billing account, [create one](../../billing/quickstart/index.md).

## Set up the infrastructure {#prepare-infrastructure}

[_Organization_](../../overview/roles-and-resources.md) is a workspace that consolidates various types of {{ yandex-cloud }} resources and users. Any Yandex user can create an organization in {{ org-full-name }}. After you create an organization, you become its [owner](../../organization/security/index.md#organization-manager-organizations-owner) and can manage its settings.

To create an organization, follow these steps:

1. [Go]({{ link-org-cloud-center }}) to {{ org-full-name }}.

    Your next steps will depend on whether you are a member of any organization in {{ org-full-name }}.

1. Create an organization:

    {% list tabs %}

    - You are not a member of an organization

      If you are not yet a member of an organization in {{ org-full-name }}, when clicking the link, you will be prompted to create a new organization:

      1. Enter your organization name, e.g., `Example organization`.
      1. Click **{{ ui-key.yacloud_components.organization.action.create }}**.

    - If you are a member of an organization

      If you are currently a member of an organization in {{ org-full-name }}, when clicking the link, you will see the [{{ org-full-name }}]({{ link-org-cloud-center }}) interface in {{ cloud-center }}.

      To avoid tampering with the infrastructure in existing organizations, create a new organization:

      1. In the top-left corner, next to the organization name, click ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_components.organization.action.create-organization }}**.
      1. In the window that opens, enter a name for the organization: `Example organization`.
      1. Click **{{ ui-key.yacloud_components.organization.action.create }}**.

    {% endlist %}

If you want to allocate isolated resources to a user within an organization:

1. [Create a cloud](../../resource-manager/operations/cloud/create.md) named `testing` in `Example organization`.

1. [Create a folder](../../resource-manager/operations/folder/create.md) named `test-folder` in the `testing` cloud.

If the user does not need isolated resources, you can grant them access to existing clouds and folders, e.g., the default ones.

## Invite the user to the organization and assign roles {#add-account}

{% note tip %}

To make sure the user gets all required permissions the first time they log in, assign roles immediately after sending the invitation. Once the invitation is accepted, you will be able to assign more roles or revoke those already assigned.

{% endnote %}

### Send an invitation to the user {#send-invitation}

For the user to access {{ yandex-cloud }} resources, invite them to the organization you created:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
    1. In the top-right corner, click ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** and select ![person-planet-earth](../../_assets/console-icons/person-planet-earth.svg) **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
    1. Enter the user's email.

        {% include [send-invitation](../../_includes/organization/send-invitation.md) %}
    1. Click **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

{% endlist %}

### Assign the user a role for a cloud {#add-cloud-role}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), [select](../../resource-manager/operations/cloud/switch-cloud.md) the `testing` cloud.
    1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. In the window that opens, select **{{ ui-key.yacloud_org.common.resource-acl.label_invitee-accounts }}**.
    1. Select a user from the list or use the user search option.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `resource-manager.clouds.member` role.
    1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

### Assign the user a role for the folder {#add-folder-role}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to `test-folder`.
    1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. In the window that opens, select **{{ ui-key.yacloud_org.common.resource-acl.label_invitee-accounts }}**.
    1. Select a user from the list or use the user search option.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `compute.editor` role.

       {% note tip %}

       You can also assign other roles depending on the actions you want to allow on folder resources. For the full list of roles, see the [{{ iam-full-name }}](../../iam/roles-reference.md) documentation.

       {% endnote %}

    1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

Then instruct the user to complete [these steps](#user-actions).


## User actions {#user-actions}

### Accept the invitation to the organization {#accept-invitation}

1. In the invitation email, click **Accept invitation**.
1. On the page that opens, click **Accept**.
1. Select an account to log in.

You now have access to `Example organization` and its resources.

### Check access to the cloud {#cloud-access-user-action}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [management console]({{ link-console-main }}) and click your profile image in the left-hand panel.
  1. Select `Example organization`.
  1. In the left-hand panel, select the `testing` cloud. You will see the list of cloud folders.

     This means you have access to the `testing` cloud.

{% endlist %}

### Check access to the folder {#catalog-access-user-action}

Make sure you have access to `test-folder`. Once you open the folder, create a VM in it:

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [management console]({{ link-console-main }}) and click your profile image in the left-hand panel.
  1. Select `Example organization`.
  1. In the left-hand panel, select `test-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Select ![image](../../_assets/console-icons/server.svg) **Virtual machines**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}** and set the VM parameters:

     1. Select **Basic setup**.
     1. Under **Operating systems and products**, select **Ubuntu 24.04 LTS**.
     1. Under **Computing resources**, specify the computing resource configuration for the VM.
     1. Under **Disks**, specify the size and type of the disk.
     1. Enter the **VM name**.
     1. Set the **Login** of the VM administrator.
     1. In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**. In the window that opens:
        1. Enter a **Name** for the SSH key.
        1. Under **SSH key**, select **Enter manually**, then upload or paste the contents of the public SSH key. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the [SSH](https://en.wikipedia.org/wiki/Secure_Shell) connection to the VM on your own.
        1. Click **{{ ui-key.yacloud.common.add }}**.

           The system will add the SSH key to your organization user profile.

           If, due to organization restrictions, you cannot add SSH keys to your user profile, the system will save the key to the VM user profile.
     1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

If the VM is created successfully, you can access the cloud and use {{ compute-name }} resources. Report this to the administrator.

## Delete the resources you created {#clear-out}

If the user no longer needs the VM they created, [delete it](../../compute/operations/vm-control/vm-delete.md) to avoid paying the fee.
