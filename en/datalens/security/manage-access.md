---
title: Object access permissions
description: In this tutorial, you will learn about object access management in {{ datalens-short-name }}.
---

# Object access permissions

Permission differentiation in {{ datalens-short-name }} is implemented at the directory and object level. The available operations depend on what access permissions were assigned.

If you create or copy a directory or object, the permissions for them are inherited from the parent directory at the time of creation or copying. Note that access permissions do not change automatically when you move the objects later.


You can grant users access to a directory or any service object:

* [Connection](../concepts/connection.md)
* [Dataset](../dataset/index.md)
* [Chart](../concepts/chart/index.md)
* [Dashboard](../concepts/dashboard.md)

{% note info %}

To control access to individual fields or their values, use [RLS](./row-level-security.md). This will allow you, for example, to display different information for different users on a single dashboard.

{% endnote %}



Permissions can be granted to individual users or the **All** group that includes users who passed [authentication](../../iam/concepts/authorization/index.md#authentication). Users can also request permissions on their own via the request form. For more information, see [{#T}](../operations/permission/request.md).


You can grant the following permissions to objects and directories in {{ datalens-short-name }}:

* [{{ permission-execute }}](#permission-execute)
* [{{ permission-read }}](#permission-read)
* [{{ permission-write }}](#permission-write)
* [{{ permission-admin }}](#permission-admin)

### {{ permission-execute }} {#permission-execute}

A user with the `{{ permission-execute }}` permission for a connection can make requests to it but cannot create datasets. Regardless of the dataset permissions, the user cannot access a list of tables in a dataset or view the SQL subquery the dataset is based on.

A user with the `{{ permission-execute }}` permission for a dataset can run queries against it but cannot create or edit charts or view the dataset.

{% note warning %}

You can grant the `{{ permission-execute }}` access permission only for connections and datasets.

{% endnote %}

Granting users the `{{ permission-execute }}` permission allows you to:

* Reduce the number of requests to the source, thereby reducing the load on the connection source.

* Better control what data can be shown from a dataset. You can hide some source fields so that users cannot view all fields.

* Restrict the creation of subqueries to the source database. A user with the `{{ permission-execute }}` permission cannot write subqueries.

### {{ permission-read }} {#permission-read}

A user with the `{{ permission-read }}` permission can view dashboards, widgets, datasets, and directories.

{% note warning %}

The `{{ permission-read }}` permission does not allow copying datasets, because they contain the [RLS](row-level-security.md) settings. A user can only copy datasets if granted the `{{ permission-write }}` or `{{ permission-admin }}` permission.

{% endnote %}

### {{ permission-write }} {#permission-write}

A user with the `{{ permission-write }}` permission can edit dashboards, widgets, connections, datasets, and directories.

The `{{ permission-write }}` permission includes everything included in the `{{ permission-read }}` permission.

### {{ permission-admin }} {#permission-admin}

A user with the `{{ permission-admin }}` permission can edit available objects and directories, as well as change permissions. The directory administrator can assign permissions for all nested directories and objects.

The `{{ permission-admin }}` permission includes everything included in the `{{ permission-write }}` permission.


## Table of permissions {#permission-table}

Access object<br/>Action | {{ permission-execute }} | {{ permission-read }} | {{ permission-write }} | {{ permission-admin }}
----|----|----|----|----
**Directory** |
Viewing a directory | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Editing a directory | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Renaming a directory | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Moving a folder | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Deleting a directory | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Editing access permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Connection** |
Make requests<br/>to a connection | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Create a dataset<br/>over a connection | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
View<br/>connection parameters | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Editing a connection | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
 Moving a connection | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Deleting a connection | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Editing access permissions | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Dataset** |
Running queries<br/>to a dataset | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Create a chart<br/>on a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Viewing a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Editing a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Copying a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Moving a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Deleting a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Editing access permissions | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Chart** |
Viewing a chart | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Editing a chart | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Copying a chart | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Deleting a chart | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Moving a chart | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Editing access permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Granting public access | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Dashboard** |
Viewing a dashboard | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Editing a dashboard | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Copying a dashboard | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Deleting a dashboard | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Moving a dashboard | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Editing access permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Granting public access | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Report** ^1^ |
Viewing a dashboard | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Editing a dashboard | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Copying a dashboard | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Deleting a dashboard | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Moving a dashboard | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Editing access permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)


^1^ This feature is only available with the Business [service plan](../pricing.md#service-plans).


{% note info %}

You cannot duplicate (copy) a folder and a connection with any permissions.

{% endnote %}


## Object access audit {#audit-access}

The Business [service plan users](../../datalens/pricing.md#service-plans) can get access logs to {{ datalens-short-name }} objects (view, edit, delete). To get the logs, [contact support]({{ link-console-support }}).




#### What's next {#what-is-next}

* [{#T}](../operations/permission/grant.md)
* [{#T}](../operations/permission/revoke.md)
* [{#T}](../operations/permission/request.md)

