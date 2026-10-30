# Assigning permissions for a catalog

To grant access to [{{ rest-catalog-name }}](../../concepts/components/rest-catalog.md), assign a role to an existing user, group, or service account. There is no need to create a separate catalog account.

If the user or group has not yet been created, follow the [Create user](../iam/create-user.md) or [Create group](../iam/create-group.md) instructions. You can create a Kubernetes service account using the `kubectl create service account <service_account_name> -n <namespace>` command.

## Using the CLI {#cli}

1. Create a file named `stacklandrestcatalogaccessbinding.yaml` with the `StacklandRestCatalogAccessBinding` resource configuration. Select one manifest option based on required access scope:

    {% include notitle [YAML-file-restcatalogprincipal](../../_includes/yamls/operations/rest-catalog/restcatalogprincipal.md) %}

    In all examples, the user named `analytics-user` gets the `reader` role for the selected `analytics` catalog object. Replace the username and object details with the right ones. The Iceberg namespace in the examples consists of two segments: `sales` and `reports`.

    Parameters:

    * `spec.catalogRef`: `StacklandRestCatalog` resource name in the same namespace where the permission assignment is being created.
    * `spec.subject.kind`: Role recipient type: `User`, `Group`, or `ServiceAccount`.
    * `spec.subject.name`: User, group, or service account name. For `User`, you can specify an ID in `spec.subject.id` instead of a name.
    * `spec.subject.namespace`: Service account namespace. Required if `kind: ServiceAccount`.
    * `role` under `spec.catalog`, `spec.namespace`, `spec.table`, or `spec.view`: Role for the selected object, `auditor`, `viewer`, `reader`, `writer`, `editor`, or `admin`.

    To assign a role for a specific Iceberg namespace, table, or view, specify the appropriate [scope](../../concepts/components/rest-catalog.md#roles) instead of `spec.catalog`. You can specify only one area and one role in a single resource.

1. Apply the manifest:

    ```bash
    kubectl apply -f stacklandrestcatalogaccessbinding.yaml -n <namespace>
    ```

1. Check the permission assignment status:

    ```bash
    kubectl get stacklandrestcatalogaccessbinding analytics-reader -n <namespace>
    ```

    Wait for the `ready` status in the `Phase` column. If the required Iceberg namespace, table, or view has not yet been created, the assignment remains in the `pendingResources` status. If unable to determine the role recipient, the assignment remains in the `pending` status.

To assign another role or grant access to another recipient, create a separate `StacklandRestCatalogAccessBinding` resource.

## Using the management console {#console}

You can assign a role to a user or group via the management console. For a service account, use the [CLI](#cli).

1. Open the project and select the catalog’s namespace.
1. In the left-hand menu, select **REST Catalog** → **Catalogs**.
1. Open the catalog and go to the **Access** tab.
1. Click **Grant access**.
1. Fill out the fields as follows:

    * **Name**: Name of the permission assignment, unique within the namespace.
    * **Subject**: User or group you need to grant access to.
    * **Target**: **Catalog**, **Namespace**, **Table**, or **View**.
    * **Catalog namespace**: Path to the Iceberg namespace. Mandatory for all targets except a catalog. Enter non-empty segments separated by `/`, e.g., `sales/reports`. No points are permitted inside segments.
    * **Table name** or **View name**: Name of the object for the relevant target.
    * **Access level**: `auditor`, `viewer`, `reader`, `writer`, `editor`, or `admin` role.

1. Click **Grant access**. The new assignment will appear on the **Access** tab.

One assignment grants one role for one object. Create a separate assignment for a different role or object.

## Editing a permission assignment {#edit}

You can change the role or scope of access for an existing assignment. To select a different catalog, user, or group, [revoke the assignment](delete-principal.md) and create a new one.

### Using the CLI {#edit-cli}

1. Open the resource for editing:

    ```bash
    kubectl edit stacklandrestcatalogaccessbinding <assignment_name> -n <namespace>
    ```

1. Change the role or access scope section. Exactly one section must remain in `spec`: `catalog`, `namespace`, `table`, or `view`.
1. Save the changes and wait for the `ready` status.

### Using the management console {#edit-console}

1. On the catalog's **Access** tab, open the assignment and click **Edit**.
1. Change the **Target**, Iceberg namespace path, object name, or **Access level**. The **Name** and **Subject** fields are read-only.
1. Click **Save** and wait for the changes to be applied.
