# Getting started with {{ resmgr-full-name }}

When a user registers with {{ yandex-cloud }}, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner. The `default` folder and `default`network will be created in the cloud.

The owner can create new folders and resources in this cloud, and manage access rights to them.

1. To create a folder in the cloud:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Grant a user access to the created folder:

   1. On the [start page]({{ link-console-main }}) of the management console, select the folder.
   1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the **{{ ui-key.yacloud.component.acl.update-dialog.label_title }}** window, click **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}**.
   1. Select a user from the list or search by user.
   1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}**.
   1. Select the `resource-manager.editor` role. This role enables you to read folder information, including the access rights list, as well as edit and delete the folder.
   1. Click **{{ ui-key.yacloud.common.save }}**.

{% note info %}

For more information about managing roles, see [Roles](../iam/concepts/access-control/roles.md).

{% endnote %}

#### What's next {#what-is-next}

* [Assign folder roles](operations/folder/set-access-bindings.md).
* [Assign cloud roles](operations/cloud/set-access-bindings.md).
* [Create a new cloud](operations/cloud/create).