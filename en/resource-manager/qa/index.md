---
title: '{{ resmgr-full-name }}. FAQ'
description: How do I get my activity logs in {{ resmgr-full-name }}? Find answers to this and other questions in this article.
---

# General questions about {{ resmgr-name }}

#### Why can't I move my cloud to a different organization? {#transfer-issue}

The `publicAccessBindings` error may occur if the user has roles for the migrating cloud, its folders or resources, but the user has not been added to the new organization.

Before the migration, you need to perform one of the following actions for each such user:

* Add the user to the new organization if they still need access to the resources.
* Revoke their roles for the migrated cloud, folders, and resources if access is no longer required.

When done, you can repeat the migration. The roles of federated users in the new organization need to be reassigned.

For more details, see [Changing an organization for a cloud](../operations/cloud/change-organization.md).

{% include [logs](../../_qa/logs.md) %}

{% include [transfer-cloud](../../_qa/transfer-cloud.md) %}
