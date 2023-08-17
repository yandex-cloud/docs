# 1. Authentication and access control

In {{ yandex-cloud }}, identification, authentication, and access control is performed by [{{ iam-full-name }} ({{ iam-short-name }})](../../../iam/) and [{{ org-full-name }}](../../../organization/).

The platform works with three categories of users:

* [Yandex accounts](../../../iam/concepts/index.md#passport): Accounts in Yandex ID.
* [Federated accounts](../../../iam/concepts/#saml-federation): Accounts in a corporate [SAML-compatible identity federation](../../../organization/add-federation.md), such as Active Directory.
* [Service accounts](../../../iam/concepts/#sa): Accounts that can be used by a program to manage resources.

Yandex ID accounts and federated accounts are authenticated in their own systems. {{ yandex-cloud }} has no access to these users' passwords and only authenticates service accounts via {{ iam-short-name }}.

User access to cloud resources is regulated by [roles](../../../iam/concepts/access-control/roles.md). {{ yandex-cloud }} services may provide different levels of granularity while granting permissions: in some cases, a role can be assigned directly to a service resource, in other cases, permissions are only granted at the level of the folder or cloud where the service resource is located.

This ensures interaction of different categories of resources, roles, and users in the {{ yandex-cloud }} infrastructure. Access to resources is managed by {{ iam-short-name }}. {{ iam-short-name }} controls each request and makes sure that all operations with resources are only run by users who have the appropriate permissions.

#### 1.1 An identity federation (Single Sign-On, SSO) is configured {#saml-federation}

[{{ org-full-name }}](../../../organization/) is a single service for managing the organizational structure, setting up integration with the employee catalog, and differentiating user access to the organization's cloud resources.

For the purpose of centralized account management, use [SAML-compatible identity federations](../../../organization/add-federation.md). By using identity federations, a company can set up Single Sign-On, which is authentication in {{ yandex-cloud }} via their IdP server. With this approach, employees can use their corporate accounts that are subject to the company's security policies, such as:

* Revoking and blocking accounts.
* Password policies.
* Limiting the number of unsuccessful login attempts.
* Blocking access sessions upon expiry of a preset user's idle time.
* Two-factor authentication.

{% note tip %}

Use federated accounts instead of Yandex  ID accounts whenever possible. Keep in mind that there is a separate role, `organization-manager.federations.admin`, that is used for federation management.

{% endnote %}

To make sure that all authentication requests from {{ yandex-cloud }} contain a digital signature, enable the **Sign authentication requests** option. To complete the configuration, download and install a {{ yandex-cloud }} certificate. You can download the certificate in the **Sign authentication requests** field immediately after creating a federation.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to **All services** → **{{ org-full-name }}** → **Federations**.
   1. If the list contains at least one identity federation configured, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. View information about the federations configured:

      ```bash
      yc organization-manager federation saml list \
        --organization-id=<organization ID>
      ```

   1. If the list contains at least one identity federation configured, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

* [Instructions for setting up SAML-based identity federations](../../../organization/add-federation.md#federation-usage).
* [Instructions for setting up SAML-based federations with KeyCloak](https://www.youtube.com/watch?v=m-oe7V9PvC4).

#### 1.2 Yandex ID accounts are only used in exceptional cases {#yandex-id-accounts}

The best approach to account management, in terms of security, is using identity federations (for more information, see recommendation 1.1). Therefore, you should do your best to ensure that your organization's list of users only contains federated users (those with the <q>FEDERATION ID</q> attribute) and there are as few Yandex ID accounts on the list as possible. Exceptions allowed:

* An account with the `billing.accounts.owner` permissions (technically, this role can now be granted to a Yandex ID account only).
* An account with the `organization-manager.organizations.owner` and `{{ roles-cloud-owner }}` permissions only if you use it in case of emergency, such as when a federation's setup failed. If necessary, you can [delete](../../../security/operations/account-deletion.md) a privileged passport account with the `organization-manager.organizations.owner` role from an organization.
* External accounts, such as those of your contract partners or contractors, which, for some reason, you can't register in your IdP.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to **All services** → **{{ org-full-name }}** → **Users**.
   1. If the **Federation** column is set to **federation** for all the accounts (but for those on the above list of exceptions allowed), the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for non-federated accounts in your organization, but for the ID of the account included in the list of valid exceptions:

      ```bash
      yc organization-manager user list --organization-id=<organization ID> \
        --format=json | jq -r '.[] | select(.subject_claims.sub!="<ID of the account on the list of valid exceptions>")' | jq -r 'select(.subject_claims.federation | not)'
      ```

   1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Remove all the accounts that have a Yandex ID from your organization, but for those on the list of allowed exceptions.

#### 1.3 Only appropriate administrators can manage {{ iam-short-name }} group membership {#iam-admins}

It's convenient to control access to resources via [user groups](../../../iam/operations/groups/create.md). Be sure to control access rights to a group as a resource. Users with access rights to the group can manage other users' membership in the group. When users are granted these rights:

* The user is assigned the `organization-manager.groups.memberAdmin` role for an organization.
* The user is assigned the `organization-manager.groups.memberAdmin` role for a specific group as a resource.
* The user is assigned the `organization-manager.organizations.owner` or `{{ roles-admin }}` role or another privileged role for the entire organization.
* The user is assigned the `{{ roles-admin }}` or `{{ roles-editor }}` role for a specific group as a resource (this is not recommended).

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to **All services** → **{{ org-full-name }}** → **Groups** → **Select the desired group** → **Group access rights**.
   1. Toggle the **Inherited roles** switch.
   1. If the list doesn't contain any accounts that must have no permission to manage group membership, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Remove the group access rights from the accounts that don't require them.

#### 1.4 Service roles are used instead of primitive roles: {{ roles-admin }}, {{ roles-editor }}, and {{ roles-viewer }} {#min-privileges}

The [principle of minimum privileges](../../../iam/best-practices/using-iam-securely.md#restrict-access) requires assigning users the minimum required roles.
 We don't recommend using primitive roles like `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-viewer }}` that are valid in all services, because this contradicts the principle of minimum privileges. To ensure more selective access control and implementation of the principle of minimum privileges, use service roles that only contain permissions for a certain type of resources in the specified service. For the list of all service roles, go to the [{#T}](../../../iam/concepts/access-control/roles.md) page of {{ iam-short-name }}.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to **All services** → **{{ org-full-name }}** → **Users**.
   1. If no accounts in the **Access rights** column have primitive roles, such as `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-viewer }}`, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.
   1. Next, go to the global cloud menu (click on the cloud in the initial cloud menu). Select the **Access rights** tab.
   1. If no accounts in the **Roles** column have primitive roles, such as `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-viewer }}`, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.
   1. Next, go to each folder of each cloud and, similarly, select the **Access rights** tab.
   1. If no accounts in the Roles column have primitive roles, such as `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-viewer }}`, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.
       
- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.
   1. Run the command below to search for accounts with primitive roles assigned at the cloud level:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      done
      ```

   1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.
   1. Run the command below to search for accounts with primitive roles assigned at the level of all folders in your clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="viewer")'
      done;
      done
      ```

   1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Analyze the accounts found with the `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-viewer }}` primitive roles assigned and replace them with [service granular roles](../../../iam/concepts/access-control/roles.md) based on your role matrix.

#### 1.5 Cloud entities with service accounts are registered and limited {#sa}

A [service account](../../../iam/concepts/users/service-accounts.md) is an account that can be used by a program to manage resources in {{ yandex-cloud }}. A service account is used to make requests as an application.

* Do not use employee accounts instead of service accounts. If, for example, an employee quits or moves to a different department, their account permissions are disabled, which may lead to an application failure.
* Don't write service account keys directly to your application's code, configuration files, or environment variables.

**When using service accounts**:

* [Assign a service account](../../../compute/operations/vm-connect/auth-inside-vm.md) to a VM instance and get a token using the metadata service.
* In addition, set up a local firewall on the VM instance so that only the necessary processes and system users have access to the metadata service (IP address: `169.254.169.254`).

   Example of blocking access for all users except the specified one (in this case, `root`):

   ```bash
   sudo iptables --append OUTPUT --proto tcp \
   --destination 169.254.169.254 --match owner ! --uid-owner root \
   --jump REJECT
   ```

The cloud entities with service accounts assigned must be registered and limited, because, for example, if a service account is assigned to a VM, a hacker may get the service account's token from the metadata service from within the VM.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to the desired folder and open the settings of the appropriate VM.
   1. Click **Edit**.
   1. The service account data is displayed.
   1. Repeat the steps for all VMs in all folders.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If there are no lines in the list or only accounted entities are output, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Remove the service accounts from the cloud entities that don't require them.

#### 1.6 There are no cloud keys represented as plaintext in the VM metadata service {#cloud-keys}

Don't write service account keys and other keys to the [VM metadata](../../../compute/concepts/vm-metadata.md) directly. [Assign a service account](../../../compute/operations/vm-connect/auth-inside-vm.md) to a VM instance and get a token using the metadata service. Sensitive data may be stored in any metadata field. However, the most common one is `user-data` (due to its use in the cloud-init utility).

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

{% list tabs %}

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If there are no lines in the list, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.
   1. Run the command below to search for cloud keys in the metadata service represented as plaintext, using the example of a {{ yandex-cloud }} {{ iam-short-name }} token:

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

   1. If there are no lines in the list, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Remove the keys from the metadata of the VMs with deviations found.

#### 1.7 Getting a token via AWS IMDSv1 is disabled on the VM {#aws-token}

The cloud has a [metadata service](../../../compute/concepts/vm-metadata.md) that provides information about VM performance.

From inside a VM, metadata is available in the following formats:

* Google Compute Engine (some fields are not supported).
* Amazon EC2 (some fields are not supported).

Amazon EC2 Instance Metadata Service version 1 (IMDSv1) has a number of drawbacks. The most critical of them is that there is a risk of compromising a service account token via the metadata service using a Server-Side Request Forgery (SSRF) attack. For more information, see the [official AWS blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). Therefore, AWS has released IMDSv2, the second version of the metadata service.

So far, {{ yandex-cloud }} doesn't support version 2, so it's strongly recommended to technically disable getting a service account token via the Amazon EC2 metadata service.

The Google Compute Engine metadata service uses an additional header to protect against SSRF and enhance security.

You can disable getting a service account token via Amazon EC2 using the [aws_v1_http_token:DISABLED](../../../compute/api-ref/grpc/instance_service.md#MetadataOptions) VM parameter.

{% list tabs %}

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If there are no lines in the list, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Under metadata_options, set the [aws_v1_http_token](../../../compute/api-ref/grpc/instance_service.md#MetadataOptions) parameter to `DISABLED` for the VMs found:

```bash
yc compute instance update <VM_instance_ID> \ 
  --metadata-options aws-v1-http-token=DISABLED
```

#### 1.8 Service accounts have minimum privileges granted {#sa-privileges}

Follow the principle of minimum privileges and [assign to the service account](../../../iam/operations/roles/grant.md) only those roles that are needed to run the application.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to the appropriate folder.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Check the list of service accounts.
   1. Repeat the steps for other folders.
   1. Go to the **Access rights** tab at the cloud and folder levels.

   You can only view the organization-level access rights in the YC CLI.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to output all the service accounts of the organization in `<service_account_ID>:<service_account_name>` format:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for SA in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc iam service-account list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id + ":" + .[].name'
      done;
      done;
      done
      ```

   1. Run the command below to output all the access rights of a specific service account to the organization:

      ```bash
      export ORG_ID=<organization ID>
      yc organization-manager organization list-access-bindings \
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")'
      ```

   1. View the service account's access rights in all clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $CLOUD_ID
      done;
      ```

   1. View the service account's access rights in all folders:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $FOLDER_ID
      done;
      done
      ```

   1. If the list doesn't contain any rights that are not required, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

[Remove](../../../iam/operations/roles/revoke.md) the unnecessary rights from the service account using {{ iam-short-name }}.

#### 1.9 Only trusted administrators have access to service accounts {#sa-admins}

You can grant permissions to use a service account under another user or service account.
Follow the principle of minimum privileges when granting access to a service account as a resource: if the user has service account permissions, they also have access to all of its permissions. [Assign](../../../iam/operations/sa/set-access-bindings.md) roles that allow using and managing service accounts to a minimum number of users.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to the appropriate folder.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Click on the desired service account and go to the **Access rights** tab.
   1. Check the access rights assigned to the service account.
   1. If the list only contains valid administrators, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to output all the service accounts in the clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.subject.type=="serviceAccount")' && echo $CLOUD_ID
      done;
      ```

   1. Run the command below to output all the access rights to a specific service account as a resource:

      ```bash
      yc iam service-account list-access-bindings \
        --id <service_account_ID>
      ```

   1. If the list only contains valid administrators, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

[Remove](../../../iam/operations/roles/revoke.md) the unnecessary service account rights using {{ iam-short-name }}.

#### 1.10 Service account keys are rotated on a regular basis {#sa-key-rotation}

{{ yandex-cloud }} lets you create the following access keys for service accounts:

* [IAM tokens](../../../iam/concepts/authorization/iam-token.md) that are valid for 12 hours.
* [API keys](../../../iam/concepts/authorization/api-key.md) with unlimited validity.
* [Authorized keys](../../../iam/concepts/authorization/key.md) with unlimited validity.
* [AWS API-compatible static access keys](../../../iam/concepts/authorization/access-key.md) with unlimited validity.

You need to rotate keys with unlimited validity yourself: delete and generate new ones. You can check out the date when a key was created in its properties. Perform key rotation at least once in 90 days as recommended in the information security standards, such as PCI DSS.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to the appropriate folder.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Click on the desired service account and see the date of each key's generation under **Access key properties**.
   1. Repeat the steps for each of your folders.
   1. If the keys were created less than 90 keys ago, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If the list of keys of any type contains no keys with the date in the `created_at` field greater than 90 days, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Follow the [instructions](../../../iam/operations/compromised-credentials.md#key-reissue) for rotating keys depending on their type.

#### 1.11 Two-factor authentication is set up for privileged accounts {#twofa}

We recommend using two-factor authentication (2FA) for cloud infrastructure access control to avoid the risk of compromising user accounts. Access to the {{ yandex-cloud }} management console can be based on 2FA.

To enable two-factor authentication, contact an identity provider that supports 2FA and set up a SAML-compliant identity federation. {{ yandex-cloud }} has no IdP of its own and user identification is done using external services, such as Yandex ID or corporate systems integrated via identity federations. For example, if you're using an IdP of Active Directory or Keycloak, set up 2FA in these systems. Make sure to set up 2FA at least for privileged cloud accounts.

For a Yandex ID account, set up 2FA using these [instructions](https://yandex.com/support/id/authorization/twofa.html).

{% list tabs %}

- Performing a check in the management console

   1. Open the Yandex ID UI in your browser.
   1. Go to the [Security](https://id.yandex.ru/security) tab.
   1. Make sure that the login method using an additional key is specified.
   1. If this method is set up, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.
   1. If you are using external IdPs, follow the instructions to check the settings.

{% endlist %}

**Instructions and solutions to use:**

* [Two-factor authentication: Yandex ID](https://yandex.com/support/id/authorization/twofa.html).
* [KeyCloak: Creating other credentials](https://www.keycloak.org/docs/12.0/server_admin/#creating-other-credentials).
* [Configure Additional Authentication Methods for AD FS](https://learn.microsoft.com/en-us/windows-server/identity/ad-fs/operations/configure-additional-authentication-methods-for-ad-fs).

#### 1.12 Privileged roles are only granted to trusted administrators {#privileged-users}

{{ yandex-cloud }} privileged users include accounts with the following roles:

* `billing.accounts.owner`.
* `{{ roles-admin }}` assigned for a billing account.
* `organization-manager.organizations.owner`.
* `organization-manager.admin`.
* `{{ roles-cloud-owner }}`.
* `{{ roles-admin }}` assigned for an organization.
* `{{ roles-admin }}` assigned for a cloud.
* `{{ roles-admin }}` assigned for a folder.

The `billing.accounts.owner` role is granted automatically when creating a billing account and can't be reassigned to another user. The role lets you perform any action with the billing account.

The `billing.accounts.owner` role can only be assigned to a Yandex ID account. An account with the `billing.accounts.owner` role is used when setting up payment methods and adding clouds.

Make sure to properly secure this account, since it has significant privileges and can't be federated with a corporate account.


The most appropriate approach would be to not use this account on a regular basis:

* Only use it for initial setup and updates.
* For the duration that this account is actively used, be sure to enable two-factor authentication (2FA) in Yandex ID.
* After that, if you don't use the bank card payment method (only available for this role), set a strong password for this account (generated using specialized software), disable 2FA, and refrain from using this account unnecessarily.
* Change the password to a newly generated one each time you use the account.

We recommend disabling 2FA only for this account and if it is not <q>assigned</q> to a specific employee. This lets you avoid linking this critical account to a personal device.

To manage a billing account, assign the `{{ roles-admin }}` or `{{ roles-editor }}` role for the billing account to a dedicated employee with a federated account.

To view billing data, assign the `{{ roles-viewer }}` role for the billing account to a dedicated employee with a federated account.

By default, the `organization-manager.organizations.owner` role is granted to the user who creates an organization: the organization owner. The role lets you to appoint organization owners as well as use all the administrator privileges.

The `{{ roles-cloud-owner }}` role is assigned automatically when you create your first cloud in the organization. A user with this role can perform any operation with the cloud or its resources and grant cloud access to other users: assign roles and revoke them.

Assign the `{{ roles-cloud-owner }}` and `organization-manager.organizations.owner` roles to one or more employees with a federated account. Set a strong password for the Yandex ID account that was used to create the cloud, and use it only when absolutely necessary (for example, if the federated access fails).


Be sure to fully protect your federated account that is granted one of the privileged roles listed above:

* Enable two-factor authentication.
* Disable authentication from devices beyond the company's control.
* Configure login attempt monitoring and set alert thresholds.

Assign federated accounts the `{{ roles-admin }}` roles for clouds, folders, and billing accounts. Minimize the number of accounts with these roles and regularly review the expedience of these roles for the accounts they are assigned to.

{% list tabs %}

- Performing a check in the management console

   Checking roles for the {{ billing-name }} service:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to the **Billing** tab.
   1. Check who is granted the roles: `billing.accounts.owner` and `{{ roles-admin }}`.

   Checking roles for an organization:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to **All services** → **{{ org-full-name }}** → **Users**.
   1. Check who is granted the roles: `{{ roles-admin }}`, `organization-manager.organizations.owner`, `organization-manager.admin`, and `{{ roles-cloud-owner }}`.

   Checking roles for a cloud:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to the global cloud menu: click on the cloud in the initial cloud menu. Select the **Access rights** tab.
   1. Check who is granted the roles: `{{ roles-admin }}` and `{{ roles-cloud-owner }}`.

   Checking roles for a folder:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Next, go to each folder of each cloud and, similarly, select the **Access rights** tab.
   1. Check who is granted the `{{ roles-admin }}` role.
   1. If all the privileged roles are granted to trusted administrators, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Find organization-level privileged rights:

      ```bash
      export ORG_ID=<organization ID>
      yc organization-manager organization list-access-bindings
        --id=${ORG_ID} \
        --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="organization-manager.organizations.owner" or .role_id=="organization-manager.admin" or .role_id=="resource-manager.clouds.owner")'
      ```

   1. Find cloud-level privileged rights:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="resource-manager.clouds.owner")' && echo $CLOUD_ID
      done
      ```

   1. Run the command below to search for privileged rights at the level of all folders in your clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin")' && echo $FOLDER_ID
      done;
      done
      ```

   1. If all the privileged roles are granted to trusted administrators, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

If any roles granted to untrusted administrators are found, investigate why and remove the respective rights.

#### 1.13 Strong passwords are set for local users of managed DBs {#mdb-auth}

To use a database at the application level, in addition to {{ iam-short-name }} service roles, a separate local user is created: the database owner. The following password policy applies to this user:

* The password must include numbers, uppercase letters, lowercase letters, and special characters.
* It must be at least 8 characters long.

{% list tabs %}

- Manual check

   Make sure the password is regularly rotated in manual mode and meets your company's password policies. The password is stored on the client side and can't be viewed in the management console, CLI, and API.

{% endlist %}

#### 1.14 Contractor and third-party access control is enabled {#contractors}

If you grant third-party contractors access to your clouds, make sure to follow these security measures:

* Assign permissions to contractor employees based on the principle of minimum privileges.
* If possible, create a separate account for third-party employees in your corporate IdP and assign the necessary policies to this account.
* Make sure they handle their account secrets carefully.
* Review the expedience of granting external users access to your cloud infrastructure.

{% list tabs %}

- Manual check

   Check all accounts in your organization and make sure you are aware of all contractor and third-party accounts and follow the recommendations above.

{% endlist %}

#### 1.15 The proper resource model is used {#resourses}

When developing an access model for your infrastructure, we recommend the following approach:

* At least one organization per company.
* Group resources by purpose and store them in separate folders. To ensure the strictest isolation, place them in a separate cloud.
* Place any critical resources in a separate folder or cloud. These include resources related to the processing of payment data, personal data, and trade secret data.
* Host the resource groups that require different administrative permissions in different folders or clouds (DMZ, CDE, security, backoffice, and so on).
* When developing apps, make sure to isolate test and production environments.
* Host shared resources (such as network and security groups) in a separate shared resource folder (if components are grouped by folder).

{% list tabs %}

- Manual check

   Analyze your resource model and make sure it follows the recommendations given above.

{% endlist %}

#### 1.16 There is no <q>public access</q> to your organization resources {#public-access}

{{ yandex-cloud }} lets you grant public access to your resources. This is done by granting access rights to [system groups](../../../iam/concepts/access-control/system-group.md) (`{{ subjects-allAuthenticatedUsers }}` and `{{ subjects-allUsers }}`).

System group description:

* `{{ subjects-allAuthenticatedUsers }}`: All authenticated users. These are all registered users or service accounts in {{ yandex-cloud }}: both from your clouds and other users'.
* `{{ subjects-allUsers }}`: Any user. No authentication is required.

{% note warning %}

Now `{{ subjects-allUsers }}` is only supported in the following services: {{ objstorage-short-name }} (if ACL-based access management is used), {{ container-registry-name }}, and {{ sf-name }}. For other services, assigning a role to the `{{ subjects-allUsers }}` group is equivalent to assigning the role to `{{ subjects-allAuthenticatedUsers }}`.

{% endnote %}

Make sure that these groups have no public access to your resources: clouds, folder, buckets, and more.

{% list tabs %}

- Performing a check in the management console

   Checking roles in a cloud:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Next, go to the global cloud menu (click on the cloud in the initial cloud menu). Select the **Access rights** tab.
   1. Check whether there are `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}` among users.

   Checking roles in a folder:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to the appropriate folder of the appropriate cloud and open the **Access rights** tab.
   1. Check whether there are `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}` among users.
   1. Repeat the steps for all folders in all your clouds.

   Checking roles in {{ objstorage-short-name }}:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to the desired cloud and find **{{ objstorage-short-name }}**.
   1. Click the three dots next to the desired bucket and check its ACL for `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}`.
   1. Open the bucket and check the ACL of each of its objects for `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}`.
   1. Open the bucket's global settings, select **Object read access**, and make sure the **Public** parameter is disabled.
   1. Repeat the steps for all the buckets and objects in all of your clouds.

   Checking roles in {{ container-registry-name }}:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Next, go to each cloud and find **{{ container-registry-name }}**.
   1. Open the appropriate registry and click **Access rights** on the left.
   1. Check whether there are `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}` among users.
   1. Repeat the steps for all your clouds.

   Checking roles in {{ sf-name }}:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Next, go to each cloud and find **{{ sf-name }}**.
   1. Open all cloud functions and make sure the **Public access** parameter is disabled.
   1. If none of the specified resources contain `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}`, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. Run the command below to search for cloud-level access rights such as `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}`:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $CLOUD_ID
      done
      ```

   1. Run the command below to search for folder-level access rights such as `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}`:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $FOLDER_ID
      done;
      done
      ```

   1. Run the command below to search for the `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}` access rights at the {{ container-registry-name }} level in all folders:

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

   1. Run the command below to search for the `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}` access rights at the {{ sf-name }} level in all folders:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for FUN in $(yc serverless function list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc serverless function list-access-bindings --id $FUN --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $FUN
      done;
      done;
      done
      ```

   1. If none of the specified resources contain `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}`, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

If you detect that `{{ subjects-allUsers }}` and `{{ subjects-allAuthenticatedUsers }}` have the access rights that they shouldn't, remove these rights.

#### 1.17 Contact information of the person in charge of an organization is valid {#org-contacts}

When registering a cloud in {{ yandex-cloud }}, customers enter their contact information. For example, an email address is used for notifications about incidents, scheduled maintenance activities, and so on.

For instance, if abnormal activities in the customer's organization are detected on the cloud side or the {{ iam-short-name }} cloud keys get available in external GitHub repositories, the customer receives a notification. This feature is implemented thanks to {{ yandex-cloud }} participating in the [Github Secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program) and analyzing secrets in Yandex search. If any keys are compromised in a public repository, delete the secret from the repository and its [history](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository), as well as revoke the [keys](../../../iam/operations/compromised-credentials.md).

Make sure the contact information is valid and messages are sent to multiple persons in charge from the specified email address.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to the **Billing** tab.
   1. Go to the **Account data** tab.
   1. At the bottom, click **Edit data in Yandex Balance**.
   1. Verify the specified contact information.
   1. If it's valid, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Specify up-to-date contact information using the [instructions](../../../billing/operations/change-data.md#change-address).

#### 1.18 The cookie lifetime in a federation is less than 6 hours {#cookie-timeout}

In the [identity federation](../../../organization/add-federation.md) settings, make sure the **Cookie lifetime** parameter value is less than or equal to 6 hours. This is necessary to minimize the risk of compromising cloud users' workstations.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to the **Organizations** tab.
   1. Next, open the **Federations** tab and select your federation.
   1. Find the **Cookie lifetime** parameter.
   1. If its value is less than or equal to 6 hours, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If an empty string is output, the recommendation is fulfilled. If the result with the current federation's settings is output, where `cookie_max_age` > 21600s, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Set the **Cookie lifetime** to 6 hours (21600 seconds) or less.

#### 1.19 Tokens for cloud functions and VMs are issued via service accounts {#func-token}

To get an IAM token when executing a function, [assign](../../../functions/operations/function-sa.md) a service account to the function. In this case, the function receives an {{ iam-short-name }} token using built-in {{ yandex-cloud }} mechanisms without having to transfer any secrets to the function from outside. Do the same [for your VMs](../../../compute/operations/vm-info/get-info.md#inside-instance).

{% list tabs %}

- Manual check

   Analyze all of your VMs and cloud functions in terms of manually created service account tokens. Tokens are used properly if you assign a service account to an entity and use the account's token from within via the metadata service.

{% endlist %}
