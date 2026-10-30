# {{ rest-catalog-name }} {#rest-catalog}

{{ rest-catalog-name }} is a REST catalog for {{ IBRG }} tables compatible with the Iceberg REST Catalog API. This component allows you to create catalogs and manage access to data through custom resources:

* `StacklandRestCatalog`: For creating a catalog.
* `StacklandRestCatalogAccessBinding`: For granting access permissions to users, groups, and service accounts.

You can [connect your catalog to {{ mtr-name }}](../../operations/trino/create-catalog.md) by specifying its name. The connection and storage access settings are configured automatically.

## Catalog {#catalog}

A `StacklandRestCatalog` resource describes a catalog. For storing table data, a separate bucket in [{{ objstorage-name }}](storage.md) and an access key for it are created automatically. No need to select a bucket and configure access to it.

Main specification properties:

* `description`: Description of the catalog up to 256 characters long. This is an optional parameter.
* `labels`: Catalog labels in `key – value` format. These are set when the catalog is created and cannot be changed.
* `deletionProtection`: Catalog deletion protection. The default value is `false`. If `true`, the catalog cannot be deleted until this protection is disabled.

The catalog name is specified in `metadata.name` and must be unique within the namespace. The name must begin with a Latin letter, contain only lowercase Latin letters, digits, and hyphens, end with a letter or digit, and be maximum 63 characters long.

## Catalog roles {#roles}

Permissions are assigned using the `StacklandRestCatalogAccessBinding` resource. A single assignment links a single user, group, or service account with a single role in the selected resource.

The `spec.catalogRef` setting refers to `StacklandRestCatalog` in the same namespace. The role scope is specified by one of the following settings:

* `catalog`: Entire catalog.
* `namespace`: Iceberg table namespace. The path is specified as an array of `namespacePath` segments.
* `table`: Table. The `namespacePath` and table `name` are specified.
* `view`: View. The `namespacePath` and view `name` are specified.

For the scope selected in the `role` setting, specify one of these roles:

#|
|| **Role** | **Permissions** ||
|| `auditor`, `viewer` | Viewing information about resources and assigned permissions. ||
|| `reader` | Permissions of the `viewer` role; reading table and view data. ||
|| `writer` | Permissions of the `reader` role; writing data into existing tables and replacing existing views. ||
|| `editor` | Permissions of the `writer` role; creating, updating, and deleting objects in the selected scope. ||
|| `admin` | Permissions of the `editor` role; assigning and revoking access permissions in the selected scope. ||
|#

For an additional role or another scope, select a separate designation.

Related guides: [Assigning permissions for a catalog](../../operations/rest-catalog/create-principal.md), [Editing permission assignment](../../operations/rest-catalog/create-principal.md#edit), [Revoking permissions for a catalog](../../operations/rest-catalog/delete-principal.md).

## Catalog users {#principals}

Access for the catalog is provided to existing {{ iam-name }} users, groups, and service accounts. No need to create separate catalog accounts and OAuth2 secrets.

The role subject is specified in `spec.subject` of the `StacklandRestCatalogAccessBinding` resource:

* `kind: User`: User. Specify their `name` or `id`.
* `kind: Group`: User group. Specify its `name`.
* `kind: ServiceAccount`: Kubernetes service account. Specify its `name` and `namespace`.

In the management console, you can assign permissions to users and groups. To assign permissions to a service account, use the [CLI](../../operations/rest-catalog/create-principal.md#cli).

When running queries via {{ TR }}, the permissions of the user or service account that logged in to {{ TR }} are used. [{{ TR }} access rules](trino.md#access-control) are also accounted for.

## Statuses {#status}

The `status.phase` field of the `StacklandRestCatalog` resource indicates the current catalog status:

* `pending`: Catalog is being created or awaiting the required resources to be ready.
* `ready`: Catalog is ready for use.
* `failed`: Error. See `status.conditions` for details.
* `deleting`: Catalog is being deleted.

See the `status.phase` field of the `StacklandRestCatalogAccessBinding` resource for the permission assignment status. In addition to these statuses, it can take the `pendingResources` value, which means the assignment is awaiting the required Iceberg namespace, table, or view to appear.

In the management console, the catalog status is displayed in the catalog list and in the catalog card. You can view permission assignments on the **Access** tab. If the catalog or assignment are not ready, open their **Statuses** tab to view the reason and error description.

## Connection endpoints {#endpoints}

You can view addresses for client connections in the `StacklandRestCatalog` resource status:

* `status.endpoint`: Internal address of the Iceberg REST Catalog API.
* `status.externalEndpoint`: External address available when public access is enabled.

In the management console, you can see addresses on the **General** tab. The **Connect** button opens instructions for clients and becomes available when the catalog is ready and has a connection address.

To enable public access, set `spec.settings.restCatalog.publicAccess.enabled: true` in the `StacklandRestCatalogConfig` resource.

When connecting to {{ TR }}, the internal address is used by default. To select an external address, set `spec.stacklandRestCatalog.useExternalEndpoint: true` in the `TrinoCatalog` resource.
