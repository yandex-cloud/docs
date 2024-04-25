---
title: "How to set up access to a queue"
description: "Follow this guide to set up access to a queue."
---

# Queue access management page

Use the queue access management page to:

* Configure queue access permissions.

* Check how different access types override or complement each other.

* View [roles in issues](queue-access-types.md#task-role) and the number of issues a user has access to or in which the user is an assignee, reporter, or follower. The number of issues may be displayed differently based on the permissions of the user viewing this page. For example, if your access to certain issues is restricted, such issues will not be counted.

## How to open the queue access management page {#open-settings}

The queue access management page is available in the queue settings. To open settings:

1. In the left-hand panel, click **Queues** and select a queue from the list.

1. Click **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}** → **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-permissions }}**. If you do not see the **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}** button, it means you have no rights to configure the queue. If you need these rights, contact the queue owner.

The queue access rights setup page will open. To view all [access permissions](queue-access-types.md) for a user or group, use the search at the top of the screen or click the user or group.

## Who can configure queue accesses

Queue accesses can be configured by its owner. By default, all users in the organization have full access to issues in the queue.

## Users that always have access to the queue {#implicit-access}

Some users always have access to the queue, and you cannot restrict their access. These users are:


* [Organization administrators](../role-model.md#admin)
* {{ tracker-name }} robot



##### See also

* [Queue access permissions](queue-access-types.md)
* [Permission configuration examples](queue-access-examples.md)
