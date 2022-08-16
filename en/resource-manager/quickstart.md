# Getting started with {{ resmgr-full-name }}

When a user registers with {{ yandex-cloud }}, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner. The `default` folder and `default`network will be created in the cloud.

The owner can create new folders and resources in this cloud, and manage access rights to them.

1. To create a folder in the cloud:

   {% include [create-folder](../_includes/create-folder.md) %}

2. Grant a user access to the created folder:

   1. On the [start page]({{ link-console-main }}) of the management console, select the folder.
   1. Go to **Access rights**.
   1. Click **Assign bindings**.
   1. In the **Configure access bindings** window, click **Select user**.
   1. Select a user from the list or search for a user.
   1. Click **Add role**.
   1. Select the `resource-manager.editor` role. This role enables you to read folder information, including the access rights list, as well as edit and delete the folder.
   1. Click **Save**.

{% note info %}

For more information about managing roles, see [Roles](../iam/concepts/access-control/roles.md).

{% endnote %}

#### What's next {#what-is-next}

* [Assign folder roles](operations/folder/set-access-bindings.md).
* [Assign cloud roles](operations/cloud/set-access-bindings.md).
* [Create a new cloud](operations/cloud/create).