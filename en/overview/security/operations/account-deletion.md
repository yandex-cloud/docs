# Deleting a passport account from an organization

These instructions describe how to delete a privileged passport account with the `organization-manager.organizations.owner` role from an [organization](../../../organization/).

This may be necessary if you require full control of a privileged account's authentication. In this case, a privileged account that has full privileges with respect to an organization and an organization's resources.

You can delete a privileged account if you have previously granted the `organization-manager.organizations.owner` role to a federated account. However, this creates the risk that if the federation breaks (on the cloud or the client side), it will not be possible to manage the organization using any federated account.

The instructions provide actions for mitigating risks related a federation failure.

## Primary actions {#main-steps}

1. Create a [federation](../../../organization/add-federation.md).
1. Verify federation functionality by logging in as a federated user.
1. Assign the `organization-manager.organizations.owner` role to a federated user:

   {% list tabs %}

   - CLI

      ```yc
      yc organization-manager organization add-access-binding \
          --id= <organization ID> \
          --subject= federatedUser:<federated user ID> \
          --role=organization-manager.organizations.owner
      ```

   {% endlist %}

1. Create a service cloud called `security`.
1. Assign the `admin` role for the `security` cloud to security officers that will be able to restore access to the cloud if your federation breaks.
1. [Create a service account](../../../iam/operations/sa/create.md) in the `security` cloud as a way to recover access to the organization in an emergency.

   If you are using an existing service account, make sure it does not have [static](../../../iam/concepts/authorization/access-key.md) or [API keys](../../../iam/concepts/authorization/api-key.md).

   {% list tabs %}

   - CLI

      ```yc
      yc iam api-key list --service-account-id=<service account ID>
      yc iam access-key list --service-account-id=<service account ID>
      ```

   {% endlist %}

   {% note warning %}

   A security officer can upgrade their role up to `organization-manager.organizations.owner` by being in control of the service account assigned this role. Make sure that only security officers have administrator access to the `security` cloud and the service account by running the command below:

   {% list tabs %}

   - CLI

      ```yc
      yc iam service-account list-access-bindings --id <service account ID>
      ```

   {% endlist %}

   Keep in mind that any user with the `admin` role to the folder, the cloud, or the organization hosting the service account will be able to manage this service account. Therefore, these users will also be able to upgrade their roles up to `organization-manager.organizations.owner`. Make sure that only trusted users have the `admin` role to the service account as well as to the folder, the cloud, and the organization hosting this account.

   {% endnote %}

1. Granting the `resource-manager.organization.owner` role to a service account:

   {% list tabs %}

   - CLI

      ```yc
      yc organization-manager organization add-access-binding \
          --id= <organization ID> \
          --service-account-id=<service account ID> \
          --role=organization-manager.organizations.owner
      ```

   {% endlist %}

1. [Create an authorized key](../../../iam/operations/iam-token/create-for-sa.md#via-cli) for a service account.
1. Save the key file in trusted storage.
1. Delete the `resource-manager.organization.owner` role for the passport account using the console or the command-line interface:

   {% list tabs %}

   - CLI

      ```yc
      yc organization-manager organization remove-access-binding \
          --id=<organization ID> \
          --user-account-id=<passport account ID> \
          --role=organization-manager.organizations.owner
      ```

   {% endlist %}

## Additional measures {#additional-measures}

Configure Audit trails to process the service and the federated accounts with the `resource-manager.organization.owner` role:

1. [Configure the recording of audit logs at the organization level](../../../audit-trails/quickstart.md) in Audit Trails.
1. At least track the following events (in [Object Storage](../../../audit-trails/tutorials/search-bucket.md), [log group](../../../audit-trails/tutorials/search-cloud-logging.md), [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main), and [your SIEM](../../../audit-trails/concepts/export-siem.md)):

   * Creating service account keys (events: `yandex.cloud.audit.iam.CreateAccessKey`, `yandex.cloud.audit.iam.CreateKey`, `yandex.cloud.audit.iam.CreateApiKey`, and `authentication.subject_id = <service account ID>`).
   * Assigning access rights to the service account (event: `UpdateServiceAccountAccessBindings` and `details.service_account_id = <service account ID>`).
   * Any action using the `resource-manager.organization.owner` privilege (`.authentication.subject_id == <ID of user with this privilege>`).

You can use [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main) to analyze and respond to events in {{ at-name }}.

## Response to federation failure {#federation-repair}

1. Access the authorized key saved in trusted storage.
1. [Authenticate](../../../cli/operations/authentication/service-account.md#auth-as-sa) with the service account.
1. Next:
   * Either grant the `resource-manager.organization.owner` role to the passport account and use this account to restore the federation.
   * Or restore the federation from the command-line interface (CLI).
1. Verify access as a federated user.

## Actions following federation recovery {#after-federation-repairation}

1. If the passport account was granted the `resource-manager.organization.owner` role, [revoke this role](../../../iam/operations/roles/revoke.md).
1. Create a new authorized key for the service account and save it to trusted storage.
