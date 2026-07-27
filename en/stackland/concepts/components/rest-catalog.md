# {{ rest-catalog-name }} {#rest-catalog}

{{ rest-catalog-name }} is a REST catalog for {{ IBRG }} tables compatible with the Iceberg REST Catalog API. This component allows you to manage catalogs, table namespaces, and data access by leveraging the following custom resources:

* `RestCatalog` to create an Iceberg REST catalog.
* `RestCatalogPrincipal` to create principals for access to the Iceberg REST Catalog API.

## Catalog {#catalog}

A catalog is described by the `RestCatalog` resource and defines where to store table data and which access model to apply. The operator configures the actual catalog state to match the one described in the resource specification.

Each catalog is associated with an [{{ objstorage-name }} bucket](storage.md): the `spec.stacklandStorage.bucketRef` property refers to an existing `Bucket` resource. All allowed storage paths defined in `spec.allowedLocations` must reside within that bucket.

Main specification properties:

* `allowedLocations`: List of S3 paths allowed for table data storage. Specify at least one path.
* `stacklandStorage.bucketRef`: Name of the bucket where catalog data is stored.
* `defaultBaseLocation`: Default base path for table data. It must be included in `allowedLocations`. If not set, the first item from `allowedLocations` is used.
* `defaultNamespace`: Default namespace for tables (array of path segments).
* `properties`: Additional catalog properties in `key – value` format.
* `deletionProtection`: Optional catalog deletion protection. The default value is `false`. If `true`, the catalog cannot be deleted until this flag is removed.

The folder name matches the `metadata.name` property of the `RestCatalog` resource. A cluster may only have one catalog with the specified name.

## User groups and catalog roles {#roles}

The catalog access model uses a dual structure comprising user groups and catalog roles.

User groups are defined in the `spec.declaredPrincipalRoles` property. Each group is a name of a role managed by the operator. Groups are used in catalog roles and when granting access to principals.

Catalog roles are specified in the `spec.catalogRoles` property. Each role defines a scope and its associated privileges. Four scope types are supported:

* `catalog`: Privileges at the catalog level.
* `namespace`: Privileges at the namespace level.
* `table`: Privileges at the table level.
* `view`: Privileges at the view level.

You can associate a catalog role with one or more user groups via the `principalRoles` parameter. The names you specify in that property must match the names in `declaredPrincipalRoles`.

## Catalog users {#principals}

A catalog user is described by the `RestCatalogPrincipal` resource and represents a principal for access to the Iceberg REST Catalog API via OAuth2.

Main specification properties:

* `catalog`: Name of the catalog the user is associated with. The value must match the `metadata.name` property of the `RestCatalog` resource in the same project.
* `principalRoles`: List of user groups from the catalog’s `declaredPrincipalRoles` property. Specify at least one group.
* `credentialsSecretRef`: Optional reference to a Kubernetes Secret with OAuth2 credentials. It not set, the secret will be created automatically and its name will be specified in `status.credentialsSecretName`.

Kubernetes Secrets use these two fields to store credentials: `clientId` and `clientSecret`. The `clientId` value matches the principal name. The `clientSecret` property is used to obtain an OAuth2 token for access to the Iceberg REST Catalog API.

## Statuses {#status}

The `status.phase` field of the `RestCatalog` resource indicates the current catalog status:

* `pending`: Catalog is being created or waiting for dependencies.
* `ready`: Catalog is ready for use.
* `failed`: There is an error. Fix the configuration or external conditions.
* `deleting`: Catalog is being deleted.
* `pendingResources`: Catalog is available, but the required namespaces, tables, or views do not exist in Iceberg yet, so granting privileges to roles is deferred.

The `status.phase` field of the `RestCatalogPrincipal` resource indicates the current status of the catalog user:

* `pending`: Principal is being created or waiting for dependencies.
* `ready`: Principal is synchronized with the catalog.
* `failed`: There is an error. Fix the configuration or external conditions.
* `deleting`: Principal is being deleted.
* `pendingResources`: Principal is awaiting a role not declared in the catalog.

## Connection endpoints {#endpoints}

The `RestCatalog` resource status sets endpoints for client connections.

Internal endpoints:

* `endpoint`: Internal URI of the Iceberg REST Catalog API.
* `oauth2TokenEndpoint`: Endpoint for obtaining an OAuth2 token internally.

External endpoints appear only if public access is configured for the component:

* `externalEndpoint`: Catalog public URI.
* `externalOAuth2TokenEndpoint`: Endpoint for obtaining an OAuth2 token externally.

To enable public access, set `spec.settings.rest-catalog.ingress.enabled: true` in the `IcebergRestCatalogConfig` resource.
