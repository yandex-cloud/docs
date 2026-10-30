# Revoking permissions for a folder

To revoke permissions for [{{ rest-catalog-name }}](../../concepts/components/rest-catalog.md), delete the relevant `StacklandRestCatalogAccessBinding` resource.

Deleting the assignment does not delete a user, user group, or service account. Permissions granted by other assignments remain in place.

## Using the CLI {#cli}

1. Find the assignment in the list. Check the folder, assignee, and role:

    ```bash
    kubectl get stacklandrestcatalogaccessbinding -n <namespace>
    kubectl get stacklandrestcatalogaccessbinding <assignment_name> -n <namespace> -o yaml
    ```

1. Delete the permission assignment:

    ```bash
    kubectl delete stacklandrestcatalogaccessbinding <assignment_name> -n <namespace>
    ```

## Using the management console {#console}

1. Open the project and select the catalog’s namespace.
1. In the left-hand menu, select **REST Catalog** → **Catalogs**.
1. Open the catalog and go to the **Access** tab.
1. Open the assignment in question. Check the assignee, purpose, and access tier.
1. Click **Revoke access** and confirm the action.

The assignment remains in the `deleting` state in the list until the revocation is complete. If the operation cannot complete, check the reason in the **States** tab of the assignment.
