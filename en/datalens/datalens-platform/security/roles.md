---
title: Role reference {{ datalens-platform-full-name }}
description: This reference describes the {{ datalens-platform-short-name }} roles for accessing the service, data, and individual objects.
alternate:
  - href: en/datalens/datalens-platform/security/roles.md
    type: text/markdown
    title: Markdown version
---

# Access permissions reference

The following access permissions are used in {{ datalens-platform-short-name }}:

* [For service access](#service-roles): Determine who has access to the {{ datalens-platform-short-name }} interface and which metadata operations will be available to users.
* [For access to individual objects](#object-roles): Determine the access level for a specific object, such as a collection, workbook, or REST catalog.

Read about how to assign roles in [this section](manage-access.md).

## Service access permissions {#service-roles}

### Visitor {#service-visitor}

The `Visitor` permission grants minimal access to {{ datalens-platform-short-name }}. You can view or edit objects if you have the appropriate access permissions to them.

You can grant the `Visitor` access permission using the following roles:
* `datalens.tenants.visitor` at the instance level.
* `datalens.visitor` at the organizational level.

### Admin {#service-admin}

The `Admin` (`datalens.tenants.admin`) permission grants full access to {{ datalens-platform-short-name }} and all objects within it, as well as full access to metadata administration.

Includes permissions granted by the [`Visitor`](#service-visitor) and [`Metadata administration`](#data-catalog-admin) access permissions.

You can grant the `Admin` access permission using the following roles:
* `datalens.tenants.admin` at the instance level.
* `datalens.admin` at the organizational level.
* `datalens.instances.admin` at the organization level (role is deprecated; use is not recommended).

### Viewing metadata {#data-catalog-viewer}

Users with the `Viewing metadata` permission can:

* View information about data deliveries.
* View information about domains and access permissions to them.
* View information about data.
* View information about data links.
* View glossary information.
* View term information.
* View classification information.
* View tag information.
* View quota information.

You can grant the `Viewing metadata` access permission using the `data-catalog.viewer` role at the organization level.

### Using metadata {#data-catalog-data-consumer}

Users with the `Using metadata` permission can:

* Use and modify domains.
* Modify data and data links.
* Modify glossaries.
* Use and modify terms.
* Modify classifications.
* Use and modify tags.

Includes permissions granted by the [`Viewing metadata`](#data-catalog-viewer) access permission.

You can grant the `Using metadata` access permission using the `data-catalog.dataConsumer` role at the organization level.

### Managing metadata markup {#data-catalog-data-steward}

Users with the `Managing metadata markup` permission can create, start, stop, modify, and delete data deliveries.

Includes permissions granted by the [`Using metadata`](#data-catalog-data-consumer) access permission.

You can grant the `Managing metadata markup` access permission using the `data-catalog.dataSteward` role at the organization level.

### Editing metadata {#data-catalog-editor}

Users with the `Editing metadata` permission can:

* Create, modify, and delete data deliveries.
* Create and delete domains.
* Create and delete data and data links.
* Create and delete glossaries, terms, classifications, and tags.

Includes permissions granted by the [`Using metadata`](#data-catalog-data-consumer) access permission.

You can grant the `Editing metadata` access permission using the `data-catalog.editor` role at the organization level.

### Metadata administration {#data-catalog-admin}

Users with the `Metadata administration` permission can:

* View information regarding access permissions for metadata and modify such access permissions.
* Modify access permissions for domains.

Includes permissions granted by the [`Editing metadata`](#data-catalog-editor) and [`Managing metadata markup`](#data-catalog-data-steward) access permissions.

You can grant the `Metadata administration` access permission using the `data-catalog.admin` role at the organization level.

## Access permissions for objects {#object-roles}

In {{ datalens-platform-short-name }}, you can grant access for the following objects, considering nesting:

* **Collection**
   * Collection.
   * Workbook (access extends to nested connections, datasets, charts, dashboards, reports, HTML pages and SQL queries).
   * Common objects: connections or datasets.
   * Workspace.
   * Data delivery.
   * {{ AF }} cluster.
   * {{ SPRK }} cluster.
   * {{ TR }} cluster.

* **REST catalog**
   * Namespace.
   * Table
   * Visualization.

### Main access permissions {#object-main-roles}

For each object, four levels of access are available: `Limited viewer`, `Viewer`, `Editor`, and `Admin`. Each subsequent access level includes the permissions granted by the preceding one. The set of permissions depends on the type of object.

When you create an object, you are automatically granted the `Admin` access permission for it as its creator.

#### Limited viewer {#limited-viewer}

The `Limited viewer` access permission allows you to see limited information about an object:

* For a workbook: Viewing the charts and dashboards contained within it, as well as information about the access permissions assigned for the workbook.
* For a collection: Viewing information about a collection, the collections and workbooks nested within it, including viewing charts and dashboards contained in those nested workbooks.
* For a common object: Viewing charts and dashboards that use the common object, without having direct access to the object itself.
* For a REST catalog, namespace, table, or view: Viewing an object's metadata without reading the data.
* For a workspace: Viewing information about the workspace without the permission to use it.
* For a cluster: Viewing information about the cluster without the permission to perform operations.

#### Viewer {#viewer}

The `Viewer` access permission allows you to view an object and use it, without the permission to edit:

* For a workbook: Viewing all objects contained within it, as well as information about the access permissions assigned for the workbook.
* For a collection: Viewing information about a collection and the collections and workbooks nested within it, as well as all objects within those nested workbooks.
* For a common object: Viewing the object and the access permissions for it.
* For a REST catalog, namespace, table, or view: Viewing an object's metadata and reading data.
* For a workspace: Viewing information about the workspace and using it.
* For a cluster: Viewing information about the cluster and performing basic operations.

#### Editor {#editor}

The `Editor` access permission allows you to modify an object without the permission to configure access to it:

* For a workbook: Editing the workbook and all objects nested within it, as well as creating copies of the workbook.
* For a collection: Editing a collection and all collections and workbooks nested within it, creating copies of them, and also creating new collections and workbooks inside.
* For a common object: Editing this object.
* For a REST catalog, namespace, table, or view: Managing the object without configuring access permissions.
* For a workspace: Managing the workspace without editing access permissions.
* For a cluster: Managing the cluster without editing access permissions.

#### Admin {#admin}

The `Admin` access permission allows for full management of an object, including the configuration of access permissions for it:

* For a workbook: Editing, moving, and deleting the workbook and all objects nested within it, creating copies of the workbook, and modifying access permissions for it.
* For a collection: Editing, moving, and deleting a collection and all collections and workbooks nested within it, creating new objects inside it, and modifying access permissions.
* For a common object: Editing, moving, and deleting this object, as well as configure access permissions for it.
* For a REST catalog, namespace, table, or view: Managing the object and configuring access permissions for it.
* For a workspace: Managing the workspace and configuring access permissions for it.
* For a cluster: Managing the cluster and configuring access permissions for it.

### Additional access permissions for collections {#collection-roles}

#### Collection visitor {#collections-visitor}

`Collection visitor`: Enables you to view information about the collection without accessing its nested objects.

#### Creator in collection {#collections-creator}

`Creator in collection`: Enables you to view a collection and create objects inside it without accessing the existing ones.

Users with this access permission can:

* View info on the relevant collection and its nested workbooks and collections.
* Create workbooks and collections inside the collection.

Includes permissions granted by the `Collection visitor` access.

### Roles for binding common objects {#binding-roles}

_Common objects_ are connections and datasets you can reuse and link to several workbooks for different teams. You can assign binding roles either for the common object itself or for the collection that contains such common objects.

When binding with delegation, access permissions to a common object within a workbook are not checked: the object is accessible to anyone who has access to the workbook. When binding without delegation, users must be granted access to the original, i.e., the common object.

#### Links without delegation {#limited-entry-binding-creator}

`Bindings without delegation`: Enables you to bind a common object to workbooks without delegating access permissions.

#### Bindings with delegations {#entry-binding-creator}

`Bindings with delegations`: Enables you to bind a common object to workbooks, either with or without delegating access permissions.

#### Useful links {#see-also}

* [{#T}](index.md)
* [{#T}](manage-access.md)
