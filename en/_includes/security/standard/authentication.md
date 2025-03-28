# Authentication and access management requirements

## 1. Authentication and access management {#authentication}


In {{ yandex-cloud }}, identification, authentication, and access control is performed by [{{ iam-full-name }} ({{ iam-short-name }})](../../../iam/) and [{{ org-full-name }}](../../../organization/).

The platform works with three categories of users:

* [Yandex accounts](../../../iam/concepts/users/accounts.md#passport): Accounts in Yandex ID.
* [Federated accounts](../../../iam/concepts/#saml-federation): Accounts in a corporate [SAML-compatible identity federation](../../../organization/concepts/add-federation.md), such as Active Directory.
* [Service accounts](../../../iam/concepts/#sa): Accounts that can be used by programs to manage resources.

Yandex ID and federated accounts are authenticated in their own systems. {{ yandex-cloud }} has no access to the passwords of these account users and only authenticates service accounts using {{ iam-short-name }}.

User access to cloud resources is regulated by [roles](../../../iam/concepts/access-control/roles.md). {{ yandex-cloud }} services may provide different levels of granularity while granting permissions: in some cases, a role can be assigned directly to a service resource, in other cases, permissions are only granted at the level of the folder or cloud where the service resource is located.

This ensures interaction of different categories of resources, roles, and users in the {{ yandex-cloud }} infrastructure. Access to resources is managed by {{ iam-short-name }}. {{ iam-short-name }} controls each request and makes sure that all operations with resources are only run by users who have the appropriate permissions.

### Identity federations {#federations}

#### 1.1 An identity federation (single sign-on, SSO) is configured {#saml-federation}

[{{ org-full-name }}](../../../organization/) is a single service for managing the organizational structure, setting up integration with the employee catalog, and differentiating user access to the organization's cloud resources.

For the purpose of centralized account management, use [SAML-compatible identity federations](../../../organization/concepts/add-federation.md). By using identity federations, a company can set up Single Sign-On, which is authentication in {{ yandex-cloud }} via their IdP server. With this approach, employees can use their corporate accounts that are subject to the company's security policies, such as:

* Revoking and blocking accounts.
* Password policies.
* Limiting the number of unsuccessful login attempts.
* Blocking access sessions upon expiry of a preset user's idle time.
* Two-factor authentication.

{% note tip %}

Use federated accounts instead of Yandex ID accounts whenever possible. Keep in mind that there is a separate role, `organization-manager.federations.admin`, you can use to manage a federation.

{% endnote %}

To make sure all authentication requests from {{ yandex-cloud }} contain a digital signature, enable the **Sign authentication requests** option. To complete the configuration, download and install a {{ yandex-cloud }} certificate. You can download the certificate in the **Sign authentication requests** field immediately after creating a federation.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to **All services** → **{{ org-full-name }}** → **Federations**.
  1. Make sure the list contains at least one identity federation configured. Otherwise, proceed to <q>Guides and solutions to use</q>.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. View information about the federations configured:

      ```bash
      yc organization-manager federation saml list \
        --organization-id=<organization ID>
      ```

  1. Make sure the list contains at least one identity federation configured. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

* [Guide on setting up SAML-based identity federations](../../../organization/concepts/add-federation.md#federation-usage).
* [Guide on configuring a SAML-based federation with KeyCloak](https://www.youtube.com/watch?v=m-oe7V9PvC4).

##### 1.1.1 User group mapping is set up in an identity federation {#group-mapping}

In organizations with a lot of users, you may need to grant the same access permissions for {{ yandex-cloud }} resources to multiple users at once. In this case, it is more efficient to grant roles and permissions to a group rather than individually.

If you have configured user groups in your identity provider or plan to do so, [set up user group mapping](../../../organization/operations/federation-group-mapping.md) between the identity provider and {{ org-name }}. Users in the identity provider's groups will be granted the same access permissions to {{ yandex-cloud }} resources as their respective groups in {{ org-name }}.

#### 1.2 Yandex ID accounts are only used in exceptional cases {#yandex-id-accounts}

The best approach to account management, in terms of security, is using identity federations (for more information, see recommendation 1.1). Therefore, you should do your best to ensure that your organization's list of users only contains federated users (those with the <q>FEDERATION ID</q> attribute) and there are as few Yandex ID accounts on the list as possible. The following exceptions are allowed:

* Account with the `billing.accounts.owner` permissions (technically, only a Yandex ID account can have this role at the moment).
* Account with the `organization-manager.organizations.owner` and `{{ roles-cloud-owner }}` permissions, if used in emergencies only, e.g., when configuration of your federation fails. If you need to, you can [delete](../../../security/operations/account-deletion.md) a privileged [Yandex account](../../../iam/concepts/users/accounts.md#passport) with the `organization-manager.organizations.owner` role from an organization.
* External accounts, such as those of your contract partners or contractors, which, for some reason, you cannot register in your IdP.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to **All services** → **{{ org-full-name }}** → **Users**.
  1. If the **Federation** column is set to **federation** for all the accounts (but for those on the above list of exceptions allowed), the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to search for non-federated accounts in your organization, but for the ID of the account included in the list of valid exceptions:

      ```bash
      yc organization-manager user list --organization-id=<organization ID> \
        --format=json | jq -r '.[] | select(.subject_claims.sub!="<ID of account from list of allowed exceptions>")' | jq -r 'select(.subject_claims.federation | not)'
      ```

  1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Remove all the accounts that have a Yandex ID from your organization, except those on the list of allowed exceptions.

#### 1.3 The cookie lifetime in a federation is less than 6 hours {#cookie-timeout}

In the [identity federation](../../../organization/concepts/add-federation.md) settings, make sure the **Cookie lifetime** parameter value is less than or equal to 6 hours. Thus you minimize the risk of compromising cloud users' workstations.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Go to the **Organizations** tab.
  1. Next, open the **Federations** tab and select your federation.
  1. Find the **Cookie lifetime** parameter.
  1. Make sure its value is less than or equal to 6 hours. Otherwise, proceed to <q>Guides and solutions to use</q>.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to search for accounts with primitive roles assigned at the organization level:

      ```bash
      export ORG_ID=<organization ID>
      for FED in $(yc organization-manager federation saml list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc organization-manager federation saml get --id bpfdshe1skaqcjp6uc50 --format=json | jq -r '. | select(.cookie_max_age>"21600s")'
      done
      ```

  1. The output should return an empty string. If the output returns the current federation's settings where `cookie_max_age` > 21600s, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Set the **Cookie lifetime** to 6 hours (21600 seconds) or less.

### Access management {#access-control}

#### 1.4 Only appropriate administrators can manage {{ iam-short-name }} group membership {#iam-admins}

You can conveniently control access to resources via [user groups](../../../iam/operations/groups/create.md). Make sure to control access to a group as a resource. Users with access permissions for a group can manage other users' membership in that group. Users get these permissions in the following cases:

* User has the `organization-manager.groups.memberAdmin` role for the organization.
* User has the `organization-manager.groups.memberAdmin` role for a specific group as a resource.
* User has the `organization-manager.organizations.owner` or `{{ roles-admin }}` role or another privileged role for the whole organization.
* User has the `{{ roles-admin }}` or `{{ roles-editor }}` role for a specific group as a resource (this is not recommended).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to **All services** → **{{ org-full-name }}** → **Groups** → **Select a group** → **Group access permissions**.
  1. Toggle the **Inherited roles** switch.
  1. If the list does not contain any accounts that must have no permission to manage group membership, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Remove the group access permissions from the accounts that do not require them.

#### 1.5 Service roles are used instead of primitive roles: {{ roles-admin }}, {{ roles-editor }}, {{ roles-viewer }}, {{ roles-auditor }} {#min-privileges}

The [principle of least privilege](../../../iam/best-practices/using-iam-securely.md#restrict-access) requires assigning users the minimum required roles. We do not recommend using primitive roles, such as `{{ roles-admin }}`, `{{ roles-editor }}`, `{{ roles-viewer }}`, and `{{ roles-auditor }}` that are valid for all services, because this contradicts the principle of least privilege. To ensure more selective access control and implementation of the principle of least privilege, use service roles that only contain permissions for a certain type of resources in a given service. You can see the list of all service roles in the [{{ yandex-cloud }} roles reference](../../../iam/roles-reference.md).

Use the [{{ roles-auditor }}](../../../iam/roles-reference.md#auditor) role without data access wherever possible.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to **All services** → **{{ org-full-name }}** → **Users**.
  1. Make sure no accounts in the **Access permissions** column have these primitive roles: `{{ roles-admin }}`, `{{ roles-editor }}`, or `{{ roles-viewer }}`. Otherwise, proceed to <q>Guides and solutions to use</q>.
  1. Next, go to the global cloud menu (click the cloud in the initial cloud menu). Select the **Access permissions** tab.
  1. Make sure no accounts in the **Roles** column have these primitive roles: `{{ roles-admin }}`, `{{ roles-editor }}`, or `{{ roles-viewer }}`. Otherwise, proceed to <q>Guides and solutions to use</q>.
  1. Next, go to each folder of each cloud and, similarly, navigate to the **Access permissions** tab.
  1. Make sure no accounts in the **Roles** column have these primitive roles: `{{ roles-admin }}`, `{{ roles-editor }}`, or `{{ roles-viewer }}`. Otherwise, proceed to <q>Guides and solutions to use</q>.
 
- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to search for accounts with primitive roles assigned at the organization level:

      ```bash
      export ORG_ID=<organization ID>
      yc organization-manager organization list-access-bindings \
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      ```

  1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.
  1. Run the command below to search for accounts with primitive roles assigned at the cloud level:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      done
      ```

  1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.
  1. Run the command below to search for accounts with primitive roles assigned at the level of all folders in your clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      done;
      done
      ```

  1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Analyze the accounts found with the `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-viewer }}` primitive roles assigned and replace them with [service granular roles](../../../iam/roles-reference.md) based on your role matrix.

Follow [this guide](../../../security-deck/operations/ciem/view-permissions.md) to view the full list of a subject's access permissions.

#### 1.6 The {{ roles-auditor }} role is used to prevent access to user data {#roles-auditor}

Assign the `{{ roles-auditor }}` role to users who do not need access to data, e.g., external contractors or auditors.
`{{ roles-auditor }}` is a role with least privilege without access to service data. It grants permission to read service configurations and metadata.
The `{{ roles-auditor }}` role allows you to perform the following operations:

* View information about a resource.
* View resource metadata.
* View a list of operations with the resource.

To control access more selectively and implement the principle of least privilege, use the `{{ roles-auditor }}` role by default.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. Click the **Access permissions** tab.
  1. Click **Assign roles**.
  1. In the **Configure access bindings** window, click **Select user**.
  1. Select a user from the list or use the user search option.
  1. Click **Add role**.
  1. Select the `{{ roles-auditor }}` role in the folder.
  1. Click **Save**.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for accounts with the `{{ roles-auditor }}` role assigned at the organization level:

     ```bash
     export ORG_ID=<organization_ID>
     yc organization-manager organization list-access-bindings \
     --id=${ORG_ID} \
     --format=json | jq -r '.[] | select(.role_id=="auditor")'
     ```

     If the list of accounts is empty, proceed to <q>Guides and solutions to use</q>.

  1. Run the command below to search for accounts with the `{{ roles-auditor }}` role assigned at the cloud level:

     ```bash
     export ORG_ID=<organization_ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="auditor")'
     done
     ```

     If the list of accounts is empty, proceed to <q>Guides and solutions to use</q>.

  1. Run the command below to search for accounts with the `{{ roles-auditor }}` role assigned at the level of all folders in your clouds:

     ```bash
     export ORG_ID=<organization_ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="auditor")'
     done;
     done
     ```

     If the list of accounts is empty, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

1. [Assign](../../../iam/operations/roles/grant.md) the `{{ roles-auditor }}` role to users requiring no data access.
1. Remove the excessive account permissions using {{ iam-short-name }}.

### Service accounts {#service-accounts}

#### 1.7 Cloud entities with service accounts are registered and limited {#sa}

A [service account](../../../iam/concepts/users/service-accounts.md) is an account that can be used by a program to manage resources in {{ yandex-cloud }}. A service account is used to make requests as an application.

* Do not use employee accounts instead of service accounts. If, for example, an employee quits or moves to a different department, their account permissions are disabled, which may lead to an application failure.
* Do not write service account keys directly to your application's code, configuration files, or environment variables.

**When using service accounts**:

* [Assign the service account](../../../compute/operations/vm-connect/auth-inside-vm.md) to the VM and get the token via the metadata service.
* Additionally, set up the local firewall on the VM to allow access to the metadata service (IP address: `169.254.169.254`) only to the appropriate processes and system users.

  Example of denying access to all users except the specified one (in this case, `root`):

  ```bash
  sudo iptables --append OUTPUT --proto tcp \
  --destination 169.254.169.254 --match owner ! --uid-owner root \
  --jump REJECT
  ```

The cloud entities with service accounts assigned must be registered and limited because, for example, if a service account is assigned to a VM, a hacker may get the service account's token from the metadata service from within the VM.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to the appropriate folder and open the settings of the VM you need.
  1. Click **Edit**. 
  1. The service account data is displayed.
  1. Repeat the steps for all VMs in all folders.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to search for VMs with assigned service accounts in your organization:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc compute instance get --id=$VM_ID --format=json | jq -r '. | select(.service_account_id)' | jq -r '.id' 
      done;
      done;
      done
      ```

  1. If there are no lines in the list or only accounted entities are output, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Remove the service accounts from the cloud entities that do not require them.

#### 1.8 Service accounts have minimum privileges granted {#sa-privileges}

Follow the principle of least privilege and [assign to the service account](../../../iam/operations/roles/grant.md) only the roles necessary to run the application.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Check the list of service accounts.
  1. Repeat the steps for other folders.
  1. Go to the **Access permissions** tab at the cloud and folder levels.

  To view organization-level access permissions, you need to use the YC CLI.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to output all the service accounts of the organization in `<service_account_ID>:<service_account_name>` format:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc iam service-account list --folder-id=$FOLDER_ID --format=json  | jq -r '.[].id + ":" + .[].name' 
      done;
      done;
      done
      ```

  1. Run the command below to output all the access permissions of a given service account assigned for the organization:

      ```bash
      export ORG_ID=<organization ID>
      yc organization-manager organization list-access-bindings \
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")'
      ```

  1. View the service account's access permissions in all clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID  --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $CLOUD_ID
      done;
      ```

  1. View the service account's access permissions in all folders:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID  --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $FOLDER_ID
      done;
      done
      ```

  1. Make sure the lists indicate no excessive permissions. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

* Use {{ sd-full-name }} to [view](../../../security-deck/operations/ciem/view-permissions.md) the full list of a service account's access permissions.
* Use {{ sd-name }} to [revoke](../../../security-deck/operations/ciem/revoke-permissions.md) the service account’s excessive access permissions.
* [Remove](../../../iam/operations/roles/revoke.md) the excessive permissions from the service account using {{ iam-short-name }}.

#### 1.9 Only trusted administrators have access to service accounts {#sa-admins}

You can grant permissions to use a service account under another user or service account.
Follow the principle of least privilege when granting access to a service account as a resource: if the user has service account permissions, they also have access to all of its permissions. [Assign](../../../iam/operations/sa/set-access-bindings.md) roles that allow using and managing service accounts to a minimum number of users.
Each service account with extended permissions should be placed as a resource in a separate folder. It prevents accidental granting of permissions for this account along with the permissions for the folder with the respective service component.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Click the service account you need and go to the **Access permissions** tab.
  1. Check the access permissions assigned to the service account.
  1. Make sure the list only contains valid administrators. Otherwise, proceed to <q>Guides and solutions to use</q>.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to output all the service accounts in the clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID  --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $CLOUD_ID
      done;
      ```

  1. Run the command below to output all the access permissions for a specific service account as a resource:

      ```bash
      yc iam service-account list-access-bindings \
        --id <service_account_ID>
      ```
 
  1. Make sure the list only contains valid administrators. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

[Remove](../../../iam/operations/roles/revoke.md) the unnecessary service account permissions using {{ iam-short-name }}.

#### 1.10 Service account keys are rotated on a regular basis {#sa-key-rotation}

{{ yandex-cloud }} allows you to create the following access keys for service accounts:

* [IAM tokens](../../../iam/concepts/authorization/iam-token.md) that are valid for 12 hours. 
* [API keys](../../../iam/concepts/authorization/api-key.md): You can choose any validity period.
* [Authorized keys](../../../iam/concepts/authorization/key.md) with unlimited validity.
* [AWS API-compatible static access keys](../../../iam/concepts/authorization/access-key.md) with unlimited validity.

You need to rotate keys with unlimited validity yourself: delete and generate new ones. You can check out the date when a key was created in its properties. Perform key rotation at least once in 90 days as recommended in the information security standards, such as PCI DSS.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to the appropriate folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Click the service account you need and see the date of each key's generation under **Access key properties**.
  1. Repeat the steps for each of your folders.
  1. Make sure the keys were created less than 90 days ago. Otherwise, proceed to <q>Guides and solutions to use</q>.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Check when static access keys were created:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc iam access-key list --service-account-id=$SA --format=json | jq -r '.[] | "key_id" + ":" + .id + "," + "sa_id" + ":" + .service_account_id + "," + "created_at" + ":" + .created_at '
      done;
      done;
      done
      ```

  1. Check when authorized keys were created:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc iam key list --service-account-id=$SA --format=json | jq -r '.[] | "key_id" + ":" + .id + "," + "sa_id" + ":" + .service_account_id + "," + "created_at" + ":" + .created_at '
      done;
      done;
      done
      ```

  1. Check when API access keys were created:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for SA in $(yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc iam api-key list --service-account-id=$SA --format=json | jq -r '.[] | "key_id" + ":" + .id + "," + "sa_id" + ":" + .service_account_id + "," + "created_at" + ":" + .created_at '
      done;
      done;
      done
      ```

  1. Make sure no list of keys of any type contains keys with the `created_at` value older than 90 days. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Follow the [guide](../../../iam/operations/compromised-credentials.md#key-reissue) for rotating keys depending on their type.

#### 1.11 Service account API keys have specified scopes {#api-key-scopes}

{% include [scoped-api-keys](../../../_includes/iam/scoped-api-keys.md) %}

The scope limits the use of [API keys](../../../iam/concepts/authorization/api-key.md) in addition to the user's personal access permissions. Configuring scope limits and expiration dates will reduce the risk of unauthorized use of your keys.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the service account.
  1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_api_keys }}**, check the **{{ ui-key.yacloud.iam.folder.service-account.overview.column_key_scope }}** field in the table with your API keys’ details.
  1. If all API keys have their scopes specified, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  Run the command below and specify the name of the service account your API keys belong to:

  ```bash
  yc iam api-key list --service-account-name <service_account_name>
  ```

  If all API keys listed in the `SCOPE` filed of the command output have their scopes set, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

[Create](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key with a specified scope.

#### 1.12 Tokens for cloud functions and VMs are issued by a service account {#func-token}

To get an IAM token when executing a function, [assign](../../../functions/operations/function-sa.md) a service account to the function. In this case, the function will get an {{ iam-short-name }} token by means of built-in {{ yandex-cloud }} tools so that you do not have to provide any secrets to the function externally. Do the same [for your VMs](../../../compute/operations/vm-info/get-info.md#inside-instance). For more information about getting an IAM token in a function, see [{#T}](../../../functions/operations/function-sa.md).

{% list tabs group=instructions %}

- Manual check {#manual}

  Analyze all of your VMs and cloud functions in terms of manually created service account tokens. Tokens are used properly if you assign a service account to an entity and use the account's token from within via the metadata service.

{% endlist %}

#### 1.13 Impersonation is used wherever possible {#impersonation}

[Impersonation](../../../iam/operations/sa/set-access-bindings.md#impersonation) allows a user to perform actions under a service account and to temporarily extend user permissions without generating static credentials for the user. It may be useful for use cases such as duty, local development, or permission verification.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), click the name of the cloud you need in the left-hand panel.
  1. Go to the **Access permissions** tab and check if the `{{ roles-iam-sa-tokencreator }}` role is there.

{% endlist %}

**Guides and solutions to use:**

If the `{{ roles-iam-sa-tokencreator }}` role is missing, set up impersonation for service accounts to provide temporary access to critical data by following this [guide](../../../iam/operations/sa/set-access-bindings.md#impersonation).


### VM metadata {#vm-metadata}

#### 1.14 There are no cloud keys represented as plain text in the VM metadata service {#cloud-keys}

Do not write service account keys and other keys to the [VM metadata](../../../compute/concepts/vm-metadata.md) directly. [Assign a service account](../../../compute/operations/vm-connect/auth-inside-vm.md) to a VM instance and get a token using the metadata service. You can store sensitive data in any metadata field. However, the most common one is `user-data` (due to its use in the cloud-init utility).

See the list of all regular expressions used to search for cloud accounts' credential secrets:

* **yandex_cloud_iam_cookie_v1** : c1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
  Yandex.Cloud Session Cookie
* **yandex_cloud_iam_token_v1** : t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
  Yandex.Cloud IAM token
* **yandex_cloud_iam_api_key_v1** : AQVN[A-Za-z0-9_\-]{35,38}
  Yandex.Cloud API Keys (Speechkit, Vision, Translate)
* **yandex_passport_oauth_token** : y[0-6]_[-_A-Za-z0-9]{55} 
  Yandex Passport OAuth token
* **yandex_cloud_iam_access_secret** : YC[a-zA-Z0-9_\-]{38}
  Yandex.Cloud AWS API compatible Access Secret

{% list tabs group=instructions %}

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to search for cloud keys in the metadata service represented as plaintext, using the example of {{ yandex-cloud }} AWS API Compatible Access Secret:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc compute instance get --id=$VM_ID --full --format=json | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("YC[a-zA-Z0-9_\\-]{38}") | .string' && echo $VM_ID
      done;
      done;
      done
      ```

  1. If there are no lines in the list, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.
  1. Run the command below to search for plaintext cloud keys in the metadata service. Here we use a {{ yandex-cloud }} {{ iam-short-name }} token as an example:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc compute instance get --id fhm2i4a72v44kdqaqhid --full --format=json | jq -r '. | select(.metadata."user-data")| .metadata."user-data" | match("t1\\.[A-Z0-9a-z_-]+[=]{0,2}\\.[A-Z0-9a-z_-]{86}[=]{0,2}") | .string'
      done;
      done;
      done
      ```

  1. If there are no lines in the list, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Remove the keys from the metadata of the VMs with deviations found:

{% include [delete-keys-from-metadata](../../../_includes/compute/delete-keys-from-metadata.md) %}

#### 1.15 Getting a token via AWS IMDSv1 is disabled on the VM {#aws-token}

The cloud has a [metadata service](../../../compute/concepts/vm-metadata.md) that provides information about VM performance.

From inside a VM, metadata is available in the following formats:

* Google Compute Engine (some fields are not supported).
* Amazon EC2 (some fields are not supported).

Amazon EC2 Instance Metadata Service version 1 (IMDSv1) has a number of drawbacks. The most critical of them is that there is a risk of compromising a service account token via the metadata service using a Server-Side Request Forgery (SSRF) attack. For more information, see the [official AWS blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). Therefore, AWS has released IMDSv2, the second version of the metadata service.

So far, {{ yandex-cloud }} does not support version 2, so it is strongly recommended to technically disable getting a service account token via the Amazon EC2 metadata service.

The Google Compute Engine metadata service uses an additional header to protect against SSRF and enhance security.

You can disable getting a service account token via Amazon EC2 using the [aws_v1_http_token:DISABLED](../../../compute/api-ref/grpc/Instance/create.md#yandex.cloud.compute.v1.MetadataOptions) VM parameter.

{% list tabs group=instructions %}

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to search for VMs with IMDSv1 enabled for getting a token:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute instance get --id=$VM_ID --format=json | jq -r '. | select(.metadata_options.aws_v1_http_token=="ENABLED")' | jq -r '.id' 
      done;
      done;
      done
      ```

  1. If there are no lines in the list, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Under metadata_options, set the [aws_v1_http_token](../../../compute/api-ref/grpc/Instance/create.md#yandex.cloud.compute.v1.MetadataOptions) parameter to `DISABLED` for the found VMs:

```bash
yc compute instance update <VM_ID> \
  --metadata-options aws-v1-http-token=DISABLED
```

### Privileged accounts {#privileged-accounts}

#### 1.16 Two-factor authentication is set up for privileged accounts {#twofa}

We recommend using two-factor authentication (2FA) for cloud infrastructure access control to avoid the risk of compromising user accounts. Access to the {{ yandex-cloud }} management console can be based on 2FA.

To enable two-factor authentication, contact an identity provider that supports 2FA and set up a SAML-compliant identity federation. {{ yandex-cloud }} has no IdP of its own and user identification is done using external services, such as Yandex ID or corporate systems integrated via identity federations. For example, if you are using an IdP of Active Directory or Keycloak, set up 2FA in these systems. Make sure to set up 2FA at least for privileged cloud accounts.

For a Yandex ID, set up 2FA using [this guide](https://yandex.com/support/id/authorization/twofa.html).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the Yandex ID UI in your browser.
  1. Go to the [Security](https://id.yandex.ru/security) tab.
  1. Make sure login with an additional key is selected as the login option.
  1. If the key-based login is configured, the recommendation is fulfilled. Otherwise, proceed to <q>Guides and solutions to use</q>.
  1. If you are using external IdPs, follow the guides to check the settings.

{% endlist %}

**Guides and solutions to use:**

* [Two-factor authentication: Yandex ID](https://yandex.com/support/id/authorization/twofa.html)
* [KeyCloak: Creating other credentials](https://www.keycloak.org/docs/latest/server_admin/#creating-other-credentials)
* [Configure Additional Authentication Methods for AD FS](https://learn.microsoft.com/en-us/windows-server/identity/ad-fs/operations/configure-additional-authentication-methods-for-ad-fs).

#### 1.17 Only trusted administrators have privileged roles {#privileged-users}

{{ yandex-cloud }} privileged users include accounts with the following roles:

* `billing.accounts.owner`
* `{{ roles-admin }}` assigned for a billing account
* `organization-manager.organizations.owner`
* `organization-manager.admin`
* `{{ roles-cloud-owner }}`
* `{{ roles-admin }}` and `{{ roles-editor }}` assigned for an organization
* `{{ roles-admin }}` and `{{ roles-editor }}` assigned for a cloud
* `{{ roles-admin }}` and `{{ roles-editor }}` assigned for a folder

The `billing.accounts.owner` role is granted automatically when creating a billing account and cannot be reassigned to another user. The role allows you to perform any action with the billing account.

The `billing.accounts.owner` role can only be assigned to a Yandex ID account. An account with the `billing.accounts.owner` role is used when setting up payment methods and adding clouds.

Make sure to properly secure this account: it offers significant privileges and cannot be federated with a corporate account.

The most appropriate approach would be to not use this account on a regular basis:

* Only use it for initial setup and updates.
* When actively using this account, enable two-factor authentication (2FA) in Yandex ID.
* After that, if you do not use the bank card payment method (only available for this role), set a strong password for this account (generated using specialized software), disable 2FA, and refrain from using this account unnecessarily.
* Change the password to a newly generated one each time you use the account.

We recommend disabling 2FA only for this account and if it is not assigned to a specific employee.<q></q> Thus you can avoid linking this critical account to a personal device.

To manage a billing account, assign the `{{ roles-admin }}` or `{{ roles-editor }}` role for the billing account to a dedicated employee with a federated account.

To view billing data, assign the `{{ roles-viewer }}` role for the billing account to a dedicated employee with a federated account.

By default, the `organization-manager.organizations.owner` role is granted to the user who creates an organization: the organization owner. The role allows you to appoint organization owners and use all the administrator privileges.

The `{{ roles-cloud-owner }}` role is assigned automatically when you create your first cloud in the organization. A user with this role can perform any operation with the cloud or its resources and grant cloud access to other users: assign roles and revoke them.

Assign the `{{ roles-cloud-owner }}` and `organization-manager.organizations.owner` roles to one or more employees with a federated account. Set a strong password for the Yandex ID account that was used to create the cloud, and use it only when absolutely necessary (for example, if the federated access fails).

Make sure to fully protect your federated account that is granted one of the privileged roles listed above:

* Enable two-factor authentication.
* Disable authentication from devices beyond the company's control.
* Configure login attempt monitoring and set alert thresholds.

Assign federated accounts the `{{ roles-admin }}` roles for clouds, folders, and billing accounts. Minimize the number of accounts with these roles and regularly review the expedience of these roles for the accounts they are assigned to.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  Checking roles for the {{ billing-name }} service:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Go to [{{ billing-name }}]({{ link-console-billing }}).
  1. Check who is granted the roles: `billing.accounts.owner` and `{{ roles-admin }}`.

  Checking roles for an organization:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Go to **All services** → **{{ org-full-name }}** → **Users**.
  1. Check which users have the `{{ roles-admin }}`, `organization-manager.organizations.owner`, `organization-manager.admin`, and `{{ roles-cloud-owner }}` roles.

  Checking roles for a cloud:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Go to the global cloud menu: click the cloud in the initial cloud menu. Select the **Access permissions** tab.
  1. Check which users have the `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-cloud-owner }}` roles.

  To check roles for a folder:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Next, go to each folder of each cloud and, similarly, select the **Access permissions** tab.
  1. Check to whom the `{{ roles-admin }}` role is granted.
  1. Make sure all the privileged roles are granted to trusted administrators. Otherwise, proceed to <q>Guides and solutions to use</q>.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Find organization-level privileged permissions:

      ```bash
      export ORG_ID=<organization ID>
      yc organization-manager organization list-access-bindings
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="organization-manager.organizations.owner" or .role_id=="organization-manager.admin" or .role_id=="resource-manager.clouds.owner" or role_id=="resource-manager.clouds.editor")'
      ```

  1. Find cloud-level privileged permissions:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="resource-manager.clouds.owner" or role_id=="resource-manager.clouds.editor")' && echo $CLOUD_ID
      done
      ```

  1. Run the command below to search for privileged permissions at the level of all folders in your clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin")' && echo $FOLDER_ID
      done;
      done
      ```

  1. Make sure all the privileged roles are granted to trusted administrators. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

If any roles granted to untrusted administrators are found, investigate why and remove the respective permissions.

### Local users of managed databases {#mdb-users} 

#### 1.18 Strong passwords are set for local users of managed databases {#mdb-auth}

To use a database at the application level, in addition to {{ iam-short-name }} service roles, a separate local user is created: the database owner. The following password policy applies to this user:

* The password must contain numbers, uppercase letters, lowercase letters, and special characters. 
* It must be at least 8 characters long.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure the password is regularly rotated in manual mode and meets your company password policies. The password is stored on the client side and cannot be viewed in the management console, CLI, and API.

{% endlist %}

### Third party access {#outstaff-access}

#### 1.19 Contractor and third-party access control is enabled {#contractors}

If you grant third-party contractors access to your clouds, make sure to follow these security measures:

* Assign permissions to contractor employees based on the principle of least privilege.
* Where possible, create a separate account for third-party employees in your corporate IdP and assign the relevant policies to this account.
* Require them to handle their account secrets with care.
* Review the relevance of external user access to your cloud infrastructure.
* Use the [{{ roles-auditor }}](../../../iam/roles-reference.md#auditor) role without data access wherever possible. 

{% list tabs group=instructions %}

- Manual check {#manual}

  Check all accounts in your organization and make sure you are aware of all contractor and third-party accounts and follow the recommendations above.

{% endlist %}

### Resource model {#resource-framework}

#### 1.20 The proper resource model is used {#resourses}

When developing an access model for your infrastructure, we recommend the following approach:

* At least one organization per company.
* Group resources by purpose and store them in separate folders. To ensure the strictest isolation, place them in a separate cloud.
* Place any critical resources in a separate folder or cloud. These include resources related to the processing of payment data, personal data, and trade secret data.
* Host the resource groups that require different administrative permissions in different folders or clouds (DMZ, CDE, security, backoffice, and so on).
* When developing apps, make sure to isolate test and production environments.
* Put shared resources (e.g., network and security groups) into a separate shared resource folder (if you separate components into folders).

{% list tabs group=instructions %}

- Manual check {#manual}

  Analyze your resource model and make sure it follows the recommendations given above.

{% endlist %}

#### 1.21 There is no <q>public access</q> to your organization's resources {#public-access}

{{ yandex-cloud }} allows you to grant public access to your resources. You can grant public access by assigning access permissions to [public groups](../../../iam/concepts/access-control/public-group.md) (`All authenticated users`, `All users`). 

Public group details:

* `All authenticated users`: All authenticated users. This means all registered {{ yandex-cloud }} users or service accounts, both from your clouds and other users' clouds.
* `All users`: Any user. No authentication is required.

{% note warning %}

Now `All users` is only supported in the following services: {{ objstorage-short-name }} (if ACL-based access management is used), {{ container-registry-name }}, and {{ sf-name }}. For other services, assigning a role to the `All users` group is equivalent to assigning a role to `All authenticated users`.

{% endnote %}

Make sure that these groups have no public access to your resources: clouds, folder, buckets, and more.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  Checking roles in a cloud:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Next, go to the global cloud menu (click the cloud in the initial cloud menu). Select the **Access permissions** tab.
  1. Check whether there are `All users` and `All authenticated users` among users.

  Checking roles in a folder:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Go to the appropriate folder of the cloud you need and open the **Access permissions** tab.
  1. Check whether there are `All users` and `All authenticated users` among users.
  1. Repeat the steps for all folders in all your clouds.

  Checking roles in {{ objstorage-short-name }}:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Go to the desired cloud and find **{{ objstorage-short-name }}**.
  1. Click the three dots next to the bucket and check its ACL for `allUsers`, `allAuthenticatedUsers`.
  1. Open the bucket and check the ACLs of each of its objects for `allUsers`, `allAuthenticatedUsers`.
  1. Open the bucket's global settings, select **Object read access**, and make sure the **Public** parameter is disabled.
  1. Repeat the steps for all the buckets and objects in all of your clouds.

  Checking roles in {{ container-registry-name }}:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Next, go to each cloud and find **{{ container-registry-name }}**.
  1. Open the appropriate registry and click **Access permissions** on the left.
  1. Check whether there are `All users` and `All authenticated users` among users.
  1. Repeat the steps for all your clouds.

  Checking roles in {{ sf-name }}:

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Next, go to each cloud and find **{{ sf-name }}**.
  1. Open all cloud functions and make sure the **Public access** parameter is disabled.
  1. Make sure none of the specified resources contain `All users` or `All authenticated users`. Otherwise, proceed to <q>Guides and solutions to use</q>.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run the command below to search for accounts with primitive roles assigned at the organization level:

      ```bash
      export ORG_ID=<organization ID>
      yc organization-manager organization list-access-bindings \
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="organization-manager.organizations.owner" or .role_id=="organization-manager.admin" or .role_id=="resource-manager.clouds.owner")'
      ```

  1. Run the command below to search for cloud-level access permissions such as `allUsers` and `allAuthenticatedUsers`:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $CLOUD_ID
      done
      ```

  1. Run the command below to search for folder-level access permissions such as `allUsers` and `allAuthenticatedUsers`:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $FOLDER_ID
      done;
      done
      ```

  1. Run the command below to search for the `allUsers` and `allAuthenticatedUsers` access permissions at the {{ container-registry-name }} level in all folders:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for CR in $(yc container registry list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id');
      do yc container registry list-access-bindings --id $CR --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $CR
      done;
      done;
      done
      ```

  1. Run the command below to search for the `allUsers` and `allAuthenticatedUsers` access permissions at the {{ sf-name }} level in all folders:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for FUN in $(yc serverless function list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc serverless function  list-access-bindings --id $FUN --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $FUN
      done;
      done;
      done
      ```

  1. Make sure none of the specified resources contain `allUsers` or `allAuthenticatedUsers`. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

If you detect that `All users` and `All authenticated users` have the access permissions that they should not have, remove these permissions.

#### 1.22 Contact information of the person in charge of your organization is valid {#org-contacts}

When registering a cloud in {{ yandex-cloud }}, customers enter their contact information. For example, an email address is used for notifications about incidents, scheduled maintenance activities, and so on.

For instance, if abnormal activities in the customer's organization are detected on the cloud side or the {{ iam-short-name }} cloud keys get available in external GitHub repositories, the customer receives a notification. This feature is implemented thanks to {{ yandex-cloud }} participating in the [Github Secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program) and analyzing secrets in Yandex search. If any keys are compromised in a public repository, delete the secret from the repository and its [history](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository), as well as revoke the [keys](../../../iam/operations/compromised-credentials.md).

Make sure the contact information is valid and messages are sent to multiple persons in charge from the specified email address.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} management console in your browser.
  1. Go to [{{ billing-name }}]({{ link-console-billing }}).
  1. Go to the **Account data** tab.
  1. At the bottom, click **Edit data in Yandex Balance**.
  1. Verify the specified contact information.
  1. Make sure the contact details are valid. Otherwise, proceed to <q>Guides and solutions to use</q>.

{% endlist %}

**Guides and solutions to use:**

Specify up-to-date contact information using the [guide](../../../billing/operations/change-data.md#change-address).

#### 1.23 Resource labels are used {#labels}

[Labels](../../../resource-manager/concepts/labels.md) are required to monitor data streams and tag critical resources for privilege management.
For example, to tag resources which handle personal data under Federal Law No. FZ-152 of the Russian Federation on Personal Data, select the `152-fz:true` label for:

* Folder
* {{ objstorage-full-name }} [bucket](../../../storage/concepts/bucket.md)
* {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md)
* Managed DB clusters

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  The example below shows how to check if there is a label to a [{{ vpc-full-name }}](../../../vpc/) cloud network. You can perform similar checks for other resource labels.

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Check it for labels.

{% endlist %}

**Guides and solutions to use:**

[Guide on managing labels](../../../resource-manager/operations/manage-labels.md)

### Notifications and audit {#notifications-and-audit}

#### 1.24 {{ yandex-cloud }} security notifications are enabled {#security-notifications}

To get notifications of security-related events, such as vulnerability detection and elimination, we recommend selecting security notifications in the management console.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), click [**Settings**]({{ link-console-settings }}).
  1. Go to the **Notifications** section.
  1. In the notification settings, enable the **Security** option.

{% endlist %}

**Guides and solutions to use:**

1. [Make sure](../../../resource-manager/concepts/notify.md) that notifications are set up.
1. Enable the **Security** option in the notification settings in the management console.

#### 1.25 Tracking the date of last service account authentication and last access key use in {{ iam-full-name }} {#key-usage-control}

{% include [sa-last-used-data](../../iam/sa-last-used-data.md) %}

{% include [key-has-last-used-data](../../iam/key-has-last-used-data.md) %}

For more information, see [{#T}](../../../iam/concepts/users/service-accounts.md#sa-key).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder the service account with access keys belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the service account you need.
  1. You can see the time of the last key use in the table with key info under **{{ ui-key.yacloud.iam.folder.service-account.overview.column_key_last-used-at }}**.

{% endlist %}

#### 1.26 Access permissions of users and service accounts are regularly audited using the {{ sd-full-name }} {{ ciem-name }} {#ciem-access-control}

To ensure data and cloud infrastructure security, you need to regularly audit the access permissions of users and service accounts.

[Cloud Infrastructure Entitlement Management]({{ link-sd-main }}iam-diagnostics/) or {{ ciem-name }} is a tool that provides a centralized view of the full list of access permissions for the organization's [resources](../../../iam/concepts/access-control/resources-with-access-control.md), granted to [subjects](../../../iam/concepts/access-control/index.md#subject): users, service accounts, [user groups](../../../organization/concepts/groups.md), [system groups](../../../iam/concepts/access-control/system-group.md), and [public groups](../../../iam/concepts/access-control/public-group.md). The tool also makes it easy to revoke accesses from subjects.

To learn more, see [{#T}](../../../security-deck/concepts/ciem.md).

**Guides and solutions to use:**

[{#T}](../../../security-deck/operations/ciem/view-permissions.md).
[{#T}](../../../security-deck/operations/ciem/revoke-permissions.md).