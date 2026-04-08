# Assigning access permissions

You can assign roles to users, groups, and service accounts. Access permissions can be assigned at two levels:

* At the cluster level, using the `ClusterAccessBinding` resource. Such a role applies to the entire organization.
* At the project level, using the `AccessBinding` resource. Such a role applies to a specific namespace.

{% note info %}

To assign cluster-level permissions, you need the organization admin privileges.

{% endnote %}

## Assigning a cluster-level role {#cluster-level}

Use the `ClusterAccessBinding` resource to assign roles at the organization level.

### Assigning a role to a user {#assign-to-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, navigate to **Access management**.
  1. On the **Access permissions** page, click **Assign role**.
  1. In the **Subject** field, select **User**.
  1. Select a user from the list.
  1. In the **Role** field, select a role.
  1. Click **Save**.

- CLI {#cli}

  1. Create a file named `user-role-binding.yaml`:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: ClusterAccessBinding
      metadata:
        name: user-admin-role
      spec:
        roleID: admin
        subject:
          kind: User
          name: username
      ```

      Where:

      * `metadata.name`: Unique role binding name.
      * `roleID`: Role ID, such as `admin`, `editor`, or `viewer`.
      * `kind`: Subject type. To set a user, specify `User`.
      * `name`: Name of the user (`username` for local users and `name_id` for SAML federation users).

  1. Apply the configuration:

      ```bash
      kubectl apply -f user-role-binding.yaml
      ```

  1. Check the binding you created:

      ```bash
      kubectl get clusteraccessbinding user-admin-role
      ```

{% endlist %}

### Assigning a role to a group {#assign-to-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, navigate to **Access management**.
  1. On the **Access permissions** page, click **Assign role**.
  1. In the **Subject** field, select **Group**.
  1. Select a group from the list.
  1. In the **Role** field, select a role.
  1. Click **Save**.

- CLI {#cli}

  1. Create a file named `group-role-binding.yaml`:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: ClusterAccessBinding
      metadata:
        name: stackland-cluster-admins
      spec:
        roleID: admin
        subject:
          kind: Group
          name: stackland-cluster-admins
      ```

      Where:

      * `metadata.name`: Unique role binding name.
      * `roleID`: Role ID.
      * `kind`: Subject type. To set a group, specify `Group`.
      * `name`: Group name.

  1. Apply the configuration:

      ```bash
      kubectl apply -f group-role-binding.yaml
      ```

  1. Check the binding you created:

      ```bash
      kubectl get clusteraccessbinding stackland-cluster-admins
      ```

{% endlist %}

## Assigning a project-level role {#project-level}

Use the `AccessBinding` resource to assign roles within a specific namespace.

### Assigning a project-level role to a user {#assign-to-user-project}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a file named `user-project-role-binding.yaml`:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: AccessBinding
      metadata:
        name: bob-is-storage-admin
        namespace: warehouse
      spec:
        roleID: storage.admin
        subject:
          kind: User
          name: bob@stackland
      ```

      Where:

      * `metadata.name`: Unique role binding name.
      * `metadata.namespace`: Namespace to assign the role in.
      * `roleID`: Role ID.
      * `kind`: Subject type. To set a user, specify `User`.
      * `name`: Username.

  1. Apply the configuration:

      ```bash
      kubectl apply -f user-project-role-binding.yaml
      ```

  1. Check the binding you created:

      ```bash
      kubectl get accessbinding bob-is-storage-admin -n warehouse
      ```

{% endlist %}

### Assigning a project-level role to a service account {#assign-to-sa}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a file named `sa-role-binding.yaml`:

      ```yaml
      apiVersion: iam.stackland.yandex.cloud/v1alpha1
      kind: AccessBinding
      metadata:
        namespace: warehouse
        name: app-sa-is-storage-viewer
      spec:
        roleID: storage.viewer
        subject:
          kind: ServiceAccount
          name: app-sa
          namespace: warehouse
      ```

      Where:

      * `metadata.name`: Unique role binding name.
      * `metadata.namespace`: Namespace to assign the role in.
      * `roleID`: Role ID.
      * `kind`: Subject type. To set a service account, specify `ServiceAccount`.
      * `name`: Service account name.
      * `namespace`: Namespace of the service account.

  1. Apply the configuration:

      ```bash
      kubectl apply -f sa-role-binding.yaml
      ```

  1. Check the binding you created:

      ```bash
      kubectl get accessbinding app-sa-is-storage-viewer -n warehouse
      ```

{% endlist %}

## Available roles {#available-roles}

The basic roles in the system include:

* `admin`: Full access to all resources in the organization.
* `editor`: Permissions to create and modify resources.
* `viewer`: View-only permissions for resources.

To view all available roles, refer to [Access management](../../access-management.md).

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, navigate to **Access management**.
  1. On the **Access permissions** page, find the role binding in question.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **Delete**.
  1. Confirm the deletion.

- CLI {#cli}

  To revoke a cluster-level role, delete the `ClusterAccessBinding` resource:

  ```bash
  kubectl delete clusteraccessbinding <binding_name>
  ```

  To revoke a project-level role, delete the `AccessBinding` resource:

  ```bash
  kubectl delete accessbinding <binding_name> -n <namespace>
  ```

{% endlist %}

## What's next {#what-is-next}

* [Creating a user](create-user.md)
* [Creating a user group](create-group.md)
* [Connecting a SAML federation](connect-saml-federation.md)
