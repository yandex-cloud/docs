# Creating a user group

You can create a user group in {{ iam-name }} to simplify access permission management.

{% note info %}

You need the organization administrator permissions to create such a group.

{% endnote %}

## Creating a group {#create-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, navigate to **Access management**.
  1. On the **Groups** page, click **Create group**.
  1. Specify the group's name.
  1. Optionally, add the group's description.
  1. Click **Create**.


- CLI {#cli}

  You can only create a group using the management console. After the group is created, you can use the `ClusterAccessBinding` resource to assign it a role.

  To assign a role to your group, create a file named `group-role-binding.yaml`:

  ```yaml
  apiVersion: iam.stackland.yandex.cloud/v1alpha1
  kind: ClusterAccessBinding
  metadata:
    name: <group_name>-role
  spec:
    roleID: <role_ID>
    subject:
      kind: Group
      name: <group_name>
  ```

  Where:

  * `metadata.name`: Unique role binding name.
  * `roleID`: Role ID, such as `viewer`, `editor`, or `admin`.
  * `name`: Name of the group you created in the management console.

  Apply the manifest:

  ```bash
  kubectl apply -f group-role-binding.yaml
  ```

  Check the binding you created:

  ```bash
  kubectl get clusteraccessbinding <group_name>-role
  ```

{% endlist %}

## Adding users to a group {#add-members}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, navigate to **Access management**.
  1. On the **Groups** page, select a group.
  1. Go to the **Members** tab.
  1. Click **Add member**.
  1. Select the users you want to add to the group.
  1. Click **Add**.


- CLI {#cli}

  You can only manage group membership via the management console.

  To check role assignments for groups, run this command:

  ```bash
  kubectl get clusteraccessbindings -o wide
  ```

{% endlist %}

## System groups {#system-groups}

Groups prefixed with `stackland-` are system groups. You cannot delete or create such groups, but you can manage their membership.

System group examples:

* `stackland-cluster-admins`: Cluster administrators with full permissions.
* `stackland-cluster-editors`: Editors with permissions to edit resources.
* `stackland-cluster-viewers`: Users with view-only permissions.

## What's next {#what-is-next}

* [Assign access permissions for the group](assign-role.md)
* [Configure federation group mapping](connect-saml-federation.md#group-mapping)
