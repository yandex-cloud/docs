# Getting started with {{ org-name }}

An _organization_ is the highest resource in the {{ yandex-cloud }} resource model hierarchy. Organizations store the resources of all other services. Also, organizations are used for managing users and their authentication and authorization settings.

Each organization owns one or more [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud). A cloud contains [folders](../resource-manager/concepts/resources-hierarchy.md#folder). Folders host most {{ yandex-cloud }} resources, such as managed database clusters, virtual machines, disks, networks, and others. {{ yandex-cloud }} resource access rights are managed using roles.

The following diagram shows the relationships between {{ yandex-cloud }} organizations, folders, resources, and users:

![users-and-resources](../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet. For information on how to get started with {{ yandex-cloud }}, see [Getting started with {{ yandex-cloud }}](../getting-started/).
1. Accept the user agreement.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).

## Create an organization {#create-organization}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [create-new-org](../_includes/organization/create-new-org.md) %}

{% endlist %}

After registering, you will become the organization owner. You will be able to manage employee accounts, connect and disconnect services.

## Manage users {#manage-users}

### Add a user to your organization {#add-user-to-organization}

You can connect your employees using their Yandex accounts for access to the corporate services. If your company already uses a different account management system (such as Active Directory or Google Workspace), you can [create an identity federation](#create-federation) so that your employees can use their corporate accounts to access {{ yandex-cloud }} services.

To connect employees with Yandex accounts:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [add-yandex-user](../_includes/organization/add-yandex-user.md) %}

{% endlist %}

The user will be connected to the organization as soon as they accept the invitation via the emailed link and select the appropriate account to log in. After that, you will be able to [assign them the required roles](#add-role).

For more information about users, see [Organization membership](../organization/concepts//membership.md).

### Create a user group {#create-group}

In organizations with a lot of users, you may need to grant the same access permissions for {{ yandex-cloud }} resources to multiple users at once. In which case it is easier to issue roles and permissions to groups rather than individual users. Group members can get access to {{ yandex-cloud }} organizations, clouds, folders, and service accounts.

To create a user group:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![groups](../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. In the top-right corner of the page, click ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.

  1. Enter a name and description for the [group](../organization/concepts/groups.md).

      The name must be unique within the organization and satisfy the relevant requirements:

      {% include [group-name-format](../_includes/organization/group-name-format.md) %}

  1. Click **{{ ui-key.yacloud_org.groups.action_create-group }}**.

{% endlist %}

### Add the user to the group {#add-member-group}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![groups](../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** and click the row with the name of the [group](../organization/concepts/groups.md) you need.
  
  1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab.
  
  1. Click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
  
  1. In the window that opens, select the users or [service accounts](../iam/concepts/users/service-accounts.md). You may want to use the search feature.
  
  1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

{% endlist %}

## Manage access {#security}

### Assign a role to a user {#add-role}

To grant a user permission to access a resource, assign a role for the resource to that user. You can assign roles for a cloud, folder, and other resources from the list. If you need to grant access to a resource that is not on the list, assign the role for the parent resource it inherits permissions from. You can also assign roles to users to manage the organization.

To assign a role to a user:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [assign-role-to-user](../_includes/organization/assign-role-to-user.md) %}

{% endlist %}

### Assign a role for a cloud or folder to a user group {#group-add-role-cloud}

{% list tabs group=instructions %}

- Management console {#console}

  1. Log in to the [management console]({{ link-console-main }}) with the cloud administrator or owner account.

  1. On the left side of the screen, click the line with the name of the [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../resource-manager/concepts/resources-hierarchy.md#folder) for which you want to assign a role to a user group.

  1. At the top of the screen, go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**. In the window that opens:

      1. Go to the **{{ ui-key.yacloud_org.pages.groups }}** tab and select the [group](../organization/concepts/groups.md) you need or search by group name.

          You can also assign a role to one of the [system](../iam/concepts/access-control/system-group.md) groups:

          * `All users in organization X`: The group includes all users in organization `X`.
          * `All users in federation N`: The group includes all users in federation `N`.

      1. Click ![plus](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the [role](../iam/concepts/access-control/roles.md) you want to assign to the group for the cloud or folder you selected earlier. You can assign multiple roles.

      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Assign a role for an organization to a user group {#group-add-role-organization}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![persons-lock](../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. At the top right, click **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

  1. Go to the **{{ ui-key.yacloud_org.pages.groups }}** tab and select the [group](../organization/concepts/groups.md) you need or search by group name.

     You can also assign a role to one of the [system](../iam/concepts/access-control/system-group.md) groups:

     * `All users in organization X`: The group includes all users in organization `X`.
     * `All users in federation N`: The group includes all users in federation `N`.

  1. Click ![plus](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the [role](../iam/concepts/access-control/roles.md) for the organization you want to assign to the group. You can assign multiple roles.

  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Additional features {#additional-functionality}

### Create an identity federation {#create-federation}

If your company has a user and access management system (e.g., Active Directory or Google Workspace), you can use it to authenticate employees in {{ org-full-name }}. In which case you do not need to create a new Yandex account for every employee. They can get access to {{ yandex-cloud }} services using their corporate accounts.

To learn more, see [Identity federation](./concepts/add-federation.md).

### Enable access via {{ oslogin }} {#os-login-access}

With {{ oslogin }}, you can manage SSH access to VMs by relying solely on the [{{ iam-full-name }}](../iam/concepts/index.md) mechanisms. There is no need to upload SSH keys to each new VM when creating it. You can use {{ oslogin }} to access both [{{ compute-full-name }} VM instances](../compute/concepts/vm.md#project) and [individual nodes in node groups](../managed-kubernetes/concepts/index.md#node-group) within [{{ managed-k8s-full-name }} clusters](../managed-kubernetes/concepts/index.md#kubernetes-cluster).

{{ oslogin }} benefits:

* Instant update of user [access permissions](../iam/concepts/access-control/roles.md) within a VM when revoking or assigning roles. If you revoke the roles, the user will lose access to all VMs with {{ oslogin }} access enabled.
* Multiple available options to access VMs: you can use both short-lived SSH certificates and SSH keys including those added to the organization user profile.

To learn more, see {#T}.

## What's next {#what-is-next}

* [Learn more about the relationships between organizations and other services](./concepts/organization.md)
* [Managing organizations](./operations/organizations-overview.md)
* [Managing user groups](./operations/manage-groups.md)
* [Managing identity federations](./operations/manage-federations.md)
* [Access control for user groups with different roles](./tutorials/user-group-access-control.md)
