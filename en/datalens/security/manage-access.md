# Object permissions

{{ datalens-short-name }} access control is implemented at the object and the folder level.
You can grant users permission to each object and directory. They determine which operations are allowed. If you created or copied a directory or object, they will have the same permissions as their new parent folder.

You can grant users access to a directory or any service object:

* [Connection](../concepts/connection.md)
* [Datasets](../concepts/dataset/index.md)
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

A user with the `{{ permission-execute }}` permission for a connection can make requests to it, but can't create datasets. Regardless of dataset permissions, the user can't access a list of tables in a dataset or view the SQL subquery that the dataset is based on.

A user with `{{ permission-execute }}` access to a dataset can run queries against the dataset but is unable to create or edit charts or view the dataset.

{% note warning %}

You can only grant the `{{ permission-execute }}` permission for connections and datasets.

{% endnote %}

Granting users the `{{ permission-execute }}` permission lets you:

* Reduce the number of requests to the source, thereby reducing the load on the connection source.

* Better control what data can be shown from a dataset. You can hide some source fields so that users can't view all fields.

* Restrict the creation of subqueries to the source database. A user with the `{{ permission-execute }}` permission can't write subqueries.

### {{ permission-read }} {#permission-read}

A user with the `{{ permission-read }}` permission can view dashboards, widgets, datasets, and directories.

{% note warning %}

The `{{ permission-read }}` permission doesn't allow copying datasets, because they contain [RLS](row-level-security.md) settings. A user can only copy datasets if granted the `{{ permission-write }}` or `{{ permission-admin }}` permission.

{% endnote %}

### {{ permission-write }} {#permission-write}

A user with the `{{ permission-write }}` permission can edit dashboards, widgets, connections, datasets, and directories.

The `{{ permission-write }}` permission includes everything included in the `{{ permission-read }}` permission.

### {{ permission-admin }} {#permission-admin}

A user with the `{{ permission-admin }}` permission can edit available objects and directories, as well as change permissions.

The `{{ permission-admin }}` permission includes everything included in the `{{ permission-write }}` permission.


## Table of permissions {#permission-table}

| Access object<br/>Action | {{ permission-execute }} | {{ permission-read }} | {{ permission-write }} | {{ permission-admin }} |
----|----|----|----|----
| **Directory** |
| View directories | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit a directory | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete directories | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Connection** |
| Make requests<br/>to a connection | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Create a dataset<br/>over a connection | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| View<br/>connection parameters | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit connections | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete connections | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Datasets** |
| Make requests<br/>to a dataset | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Create a chart<br/>on a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| View a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Copy a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete datasets | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Chart** |
| View charts | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit charts | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Copy a chart | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete charts | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Grant public access | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Dashboard** |
| View dashboards | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit dashboards | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Copy dashboards | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete dashboards | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Grant public access | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |

{% note info %}

You cannot duplicate (copy) a folder and a connection with any permissions.

{% endnote %}


## Object access audit {#audit-access}

A {{ datalens-short-name }} user can get access logs for {{ datalens-short-name }} objects (view, edit, delete).
To retrieve logs, [please contact technical support]({{ link-console-support }}).




#### What's next {#what-is-next}

* [{#T}](../operations/permission/grant.md)
* [{#T}](../operations/permission/revoke.md)
* [{#T}](../operations/permission/request.md)

