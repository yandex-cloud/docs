# Getting started with {{ resmgr-full-name }}

When a user registers with {{ yandex-cloud }}, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner. In this cloud, the `default` folder and `default` network will be created.

The owner can create new folders and resources in this cloud, and manage access rights to them.

1. To create a folder in the cloud:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Grant a user access to the created folder:

    1. In the [management console]({{ link-console-main }}), select the appropriate folder.
    1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. In the window that opens, select **{{ ui-key.yacloud_components.acl.label.user-accounts }}**.
    1. Select a user from the list or search by user.
    1. Click ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**.
    1. Select the `resource-manager.editor` role. This role enables you to read folder information, including the list of access permissions, as well as edit and delete the folder.
    1. Click **{{ ui-key.yacloud.common.save }}**.

{% note info %}

For more information about managing roles, see [Roles](../iam/concepts/access-control/roles.md).

{% endnote %}

#### What's next {#what-is-next}

* [Assign folder roles](operations/folder/set-access-bindings.md).
* [Assign cloud roles](operations/cloud/set-access-bindings.md).
* [Create a new cloud](operations/cloud/create).