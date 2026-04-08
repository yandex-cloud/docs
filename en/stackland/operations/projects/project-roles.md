# Configuring project roles

Use project roles to manage user and group access to all namespaces within a project. A role assigned at the project level automatically applies to all nested namespaces.

## Getting started {#before-you-begin}

Make sure that:

* You have the project administrator or cluster administrator role.
* The project already exists. If not, [create one](create-project.md).

## Special roles {#special-roles}

{{ stackland-name }} features two dedicated roles for managing projects:

* `stackland:admin`: Project administrator role. It grants full access to all resources in the project, including management of namespaces and roles.
* `stackland:project-member`: Project member role. It grant view-only access to the project and its namespaces in the management console and tools.

## Appointing a project administrator {#assign-admin}

Project administrators are appointed by the cluster administrator via the `ProjectRoleBinding` resource.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. On the project side panel, click **Access management**.
  1. In the **Members** tab, click **+ Add member**.
  1. In the **Add member** dialog box, specify the following:

      * **Subject**: Select the user or group from the drop-down list.
      * **Role**: Select **Administrator**.

  1. Click **Add**.


- CLI {#cli}

  Create the `ProjectRoleBinding` resource in your project's service namespace:

  ```yaml
  apiVersion: stackland.yandex.cloud/v1alpha1
  kind: ProjectRoleBinding
  metadata:
    name: stackland-projects-team-alpha-admins
    namespace: project-team-alpha
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: stackland:admin
  subjects:
    - kind: User
      name: alice@stackland
    - kind: Group
      name: team-alpha-admins
  ```

  Where:

  * `metadata.name`: Role binding name. It must be prefixed with `stackland-projects-`. This is a required field.
  * `metadata.namespace`: Project's service namespace in `project-<project_name>` format. This is a required field.
  * `roleRef.name`: Role name. Set to `stackland:admin` for the project administrator. This is a required field.
  * `subjects`: List of subjects to assign the role to. The supported types are `User`, `Group`, and `ServiceAccount`. This is a required field.

  Apply the manifest:

  ```bash
  kubectl apply -f project-role-binding.yaml
  ```

{% endlist %}

The project administrator role grants the following privileges:

* Full access to all namespaces within the project.
* Permission to create and delete namespaces.
* Permission to assign roles to other users within the project.

## Adding a project member {#assign-member}

Project members have view access to the project and its namespaces via the UI and tools. To manage resources, a member requires additional roles with the appropriate permissions.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. On the project side panel, click **Access management**.
  1. In the **Members** tab, click **+ Add member**.
  1. In the **Add member** dialog box, specify the following:

      * **Subject**: Select the user or group from the drop-down list.
      * **Role**: Select **Member**.

  1. Click **Add**.


- CLI {#cli}

  ```yaml
  apiVersion: stackland.yandex.cloud/v1alpha1
  kind: ProjectRoleBinding
  metadata:
    name: stackland-projects-team-alpha-members
    namespace: project-team-alpha
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: stackland:project-member
  subjects:
    - kind: User
      name: bob@stackland
    - kind: Group
      name: team-alpha-members
  ```

{% endlist %}

## Assigning a role across all project namespaces {#assign-project-wide-role}

A project administrator can apply an existing `ClusterRole` to all namespaces within the project.

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ProjectRoleBinding
metadata:
  name: stackland-projects-kafka-admins
  namespace: project-team-alpha
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: stackland:editor
subjects:
  - kind: Group
    name: team-alpha-developers
```

{{ stackland-name }} will automatically propagate the `RoleBinding` into each project namespace.

## Creating a custom project role {#create-custom-role}

A project administrator can create a custom role available in all project namespaces.

1. Create the `ProjectRole` resource:

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: ProjectRole
    metadata:
      name: stackland-projects-pg-admin
      namespace: project-team-alpha
    rules:
      - apiGroups:
          - postgresql.stackland.yandex.cloud
        resources:
          - postgresqlclusters
        verbs:
          - create
          - delete
          - patch
          - update
          - get
          - list
    ```

    Where:

    * `metadata.name`: Role name. It must be prefixed with `stackland-projects-`. This is a required field.
    * `metadata.namespace`: Project's service namespace. This is a required field.
    * `rules`: List of access permissions in Kubernetes RBAC format. This is a required field.

1. Assign the role using `ProjectRoleBinding`:

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: ProjectRoleBinding
    metadata:
      name: stackland-projects-pg-admins
      namespace: project-team-alpha
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ProjectRole
      name: stackland-projects-pg-admin
    subjects:
      - kind: Group
        name: team-alpha-pg-admins
    ```

{{ stackland-name }} will automatically create the relevant `Role` and `RoleBinding` in each project namespace.

## Viewing assigned roles {#list-roles}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. On the project side panel, click **Access management**.

  The page displays three tabs:

  * **Members**: List of users and groups with **Member** or **Administrator** roles.
  * **Project roles**: List of custom roles in the project.
  * **Project role bindings**: Table of bindings with the following columns: **Name**, **Role**, **Subjects**, and **Creation date**.


- CLI {#cli}

  To get a list of project role bindings, run this command:

  ```bash
  kubectl get projectrolebindings -n project-team-alpha
  ```

  To get a list of custom roles in the project, run this command:

  ```bash
  kubectl get projectroles -n project-team-alpha
  ```

{% endlist %}

## Revoking a role {#revoke-role}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **Projects**.
  1. Select the project from the list.
  1. On the project side panel, click **Access management**.
  1. In the **Members** tab, find the member.
  1. In the member row, click **⋯** and select **Delete**.
  1. Confirm the deletion.


- CLI {#cli}

  Delete the corresponding `ProjectRoleBinding` resource.

  ```bash
  kubectl delete projectrolebinding stackland-projects-kafka-admins -n project-team-alpha
  ```

{% endlist %}

## What's next {#what-is-next}

* [Setting project quotas](namespace-quotas.md)
* [Managing namespaces in a project](manage-namespaces.md)
