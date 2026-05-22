# Creating a user

Create a local user in {{ iam-name }} and assign them the required [role](../../access-management.md).

{% note info %}

To create a user, you need the organization admin privileges.

{% endnote %}

## Creating a local user {#create-local-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, navigate to **Access management**.
  1. On the **Users** page, click **Create user**.
  1. Specify a username.
  1. Set a temporary password for the user.
  1. Click **Create**.

  On first login, the user will need to change their temporary password.


- CLI {#cli}

  You can only create a local user via the management console. After the user is created, you can use the `ClusterAccessBinding` or `AccessBinding` resource to assign them a role.

  To check the new user, run this command:

  ```bash
  kubectl get clusteraccessbindings -o wide
  ```

  To assign a role to your new user, create a file named `user-role-binding.yaml`:

  ```yaml
  apiVersion: iam.stackland.yandex.cloud/v1alpha1
  kind: ClusterAccessBinding
  metadata:
    name: <username>-role
  spec:
    roleID: <role_ID>
    subject:
      kind: User
      name: <username>
  ```

  Where:

  * `metadata.name`: Unique role binding name.
  * `roleID`: Role ID, such as `viewer`, `editor`, or `admin`.
  * `name`: Name of the user you created in the management console.

  Apply the manifest:

  ```bash
  kubectl apply -f user-role-binding.yaml
  ```

{% endlist %}

## Creating a federated user {#create-federated-user}

External IdP users are automatically created upon their first login via the [SAML federation](connect-saml-federation.md).

For a federated user to appear in the system:

1. [Configure the SAML federation](connect-saml-federation.md).
1. Ask the user to log in via the federation.
1. After successful authentication, the user will automatically appear in the {{ iam-name }} user list.

## What's next {#what-is-next}

* [Creating a user group](create-group.md)
* [Assigning access permissions](assign-role.md)
* [Connecting a SAML federation](connect-saml-federation.md)
