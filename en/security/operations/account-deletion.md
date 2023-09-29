# Deleting a passport account from an organization

These instructions describe how to delete a privileged passport account with the `organization-manager.organizations.owner` role from an [organization](../../organization/).

This may be necessary if you require full control of a privileged account's authentication. In this case, a privileged account that has full privileges with respect to an organization and an organization's resources.

You can delete a privileged account if you have previously granted the `organization-manager.organizations.owner` role to a federated account. However, this creates the risk that if the federation breaks (on the cloud or the client side), it will not be possible to manage the organization using any federated account.

The instructions provide actions for mitigating risks related a federation failure.

## Primary actions {#main-steps}

1. Create a [federation](../../organization/concepts/add-federation.md).
1. Verify federation functionality by logging in as a federated user.
1. Assign the `organization-manager.organizations.owner` role to a federated user:

   {% list tabs %}

   - CLI

      ```yc
      yc organization-manager organization add-access-binding \
          --id= <organization_ID> \
          --subject= federatedUser:<federated_user_ID> \
          --role=organization-manager.organizations.owner
      ```

   {% endlist %}

1. Create a service cloud called `security`.
1. Assign the `admin` role for the `security` cloud to security officers that will be able to restore access to the cloud if your federation breaks.
1. [Create a service account](../../iam/operations/sa/create.md) in the `security` cloud as a way to recover access to the organization in an emergency.

   If you are using an existing service account, make sure it does not have [static](../../iam/concepts/authorization/access-key.md) or [API keys](../../iam/concepts/authorization/api-key.md).

   {% list tabs %}

   - CLI

      ```yc
      yc iam api-key list --service-account-id=<service_account_ID>
      yc iam access-key list --service-account-id=<service_account_ID>
      ```

   {% endlist %}

   {% note warning %}

   A security officer can upgrade their role up to `organization-manager.organizations.owner` by being in control of the service account assigned this role. Make sure that only security officers have administrator access to the `security` cloud and the service account by running the command below:

   {% list tabs %}

   - CLI

      ```yc
      yc iam service-account list-access-bindings --id <service_account_ID>
      ```

   {% endlist %}

   Keep in mind that any user with the `admin` role to the folder, the cloud, or the organization hosting the service account will be able to manage this service account. Therefore, these users will also be able to upgrade their roles up to `organization-manager.organizations.owner`. Make sure that only trusted users have the `admin` role to the service account as well as to the folder, the cloud, and the organization hosting this account.

   {% endnote %}

1. Granting the `organization-manager.organizations.owner` role to a service account:

   {% list tabs %}

   - CLI

      ```yc
      yc organization-manager organization add-access-binding \
          --id= <organization_ID> \
          --service-account-id=<service_account_ID> \
          --role=organization-manager.organizations.owner
      ```

   {% endlist %}

1. [Create an authorized key](../../iam/operations/iam-token/create-for-sa.md#via-cli) for a service account.
1. Save the key file in trusted storage.
1. Delete the `organization-manager.organizations.owner` role for the passport account using the console or the command-line interface:

   {% list tabs %}

   - CLI

      ```yc
      yc organization-manager organization remove-access-binding \
          --id=<organization_ID> \
          --user-account-id=<passport_account_ID> \
          --role=organization-manager.organizations.owner
      ```

   {% endlist %}

## Additional measures {#additional-measures}

Configure {{ at-name }} to process the service and the federated accounts with the `organization-manager.organizations.owner` role:

1. [Configure the collection of audit logs at the organization level](../../audit-trails/quickstart.md) in {{ at-full-name }}.

1. At least track the following events (in [Object Storage](../../audit-trails/tutorials/search-bucket.md), a [log group](../../audit-trails/tutorials/search-cloud-logging.md), [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main), and [your SIEM](../../audit-trails/concepts/export-siem.md)):

   * Creating service account keys (events: `{{ at-event-prefix }}.audit.iam.CreateAccessKey`, `{{ at-event-prefix }}.audit.iam.CreateKey`, `{{ at-event-prefix }}.audit.iam.CreateApiKey`, and `authentication.subject_id = <service_account_ID>`).
   * Assigning access rights to the service account (event: `UpdateServiceAccountAccessBindings` and `details.service_account_id = <service_account_ID>`).
   * Any action using the `organization-manager.organizations.owner` privilege (`.authentication.subject_id == <ID_of_user_with_this_privilege>`).

You can use [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main) to analyze and respond to events in {{ at-name }}.

## Response to federation failure {#federation-repair}

1. Access the authorized key saved in trusted storage.
1. [Authenticate](../../cli/operations/authentication/service-account.md#auth-as-sa) as a service account.
1. Next:

   * Either grant the `organization-manager.organizations.owner` role to the passport account and use this account to restore the federation.
   * Or restore the federation from the command-line interface (CLI).

1. Verify access as a federated user.

## Actions following federation recovery {#after-federation-repairation}

1. If the passport account was granted the `organization-manager.organizations.owner` role, [revoke this role](../../iam/operations/roles/revoke.md).
1. Create a new authorized key for the service account and save it to trusted storage.
