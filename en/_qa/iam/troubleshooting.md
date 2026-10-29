# Troubleshooting {{ iam-full-name }}

#### Why do I get the `403 Forbidden` or `Permission Denied` error when working under the service account? {#service-account-forbidden}

Make sure the service account has roles for the resource it works with or for the parent folder or cloud. A role for the service account itself as a resource does not grant access to virtual machines, buckets, or other resources.

Assign the necessary roles to the service account as detailed in [{#T}](../../iam/operations/sa/assign-role-for-sa.md).

#### What should I do if I get the `Service account is not available` error?

You may encounter this error when working through the console, CLI, API, or other tools if the requesting account has no permissions to use the selected service account.

Assign to that account the `iam.serviceAccounts.user` role for the **service account** in question by following [this guide](../../iam/operations/sa/set-access-bindings.md#assign-role-to-sa). You can also assign the role for the parent folder or cloud.

If you are sending the request using the same service account you are associating with the resource, that service account also needs permissions to use itself. For example, these permissions are checked when creating a container revision in {{ serverless-containers-name }}.

#### Why cannot I assign the cloud owner role? {#cloud-owner-role}

The `Role 'resource-manager.clouds.owner' is only applicable to resources of type 'resource-manager.cloud'` error means that you are assigning the role for a resource of a different type, e.g., a folder or organization.

You can assign the `{{ roles-cloud-owner }}` role only for a cloud. In the access permission section, select the cloud and assign the role by following [this guide](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-user). Only the [cloud owner](../../resource-manager/concepts/resources-hierarchy.md#owner) can assign this role.

#### What should I do if I get an error when sending or accepting an invitation to an organization? {#organization-invitation}

Your actions depend on the error message:

* `No valid emails. Or all specified emails have been invited before`: Check the email addresses and whether the users are already in the organization or the list of invitees.
* `Invitation ... has 'ACCEPTED' status. Expected status 'PENDING'`: Invitation has already been accepted. Log in to the organization using the account that was selected when accepting the invitation. It does not have to be accepted again.
* `Invitation ... has been expired after ...`: Invitation has expired. Ask the administrator to resend the invitation.
* `Permission denied`: Check which account is used to perform the action. To send invitations, the user needs the [necessary roles](../../organization/operations/add-account.md#useraccount). If the error occurs when accepting the invitation, report its details to the organization administrator or support.

If you see `Contact the organization administrator for a new invitation`, open the error details and check the invitation status. The administrator can [delete the invitation](../../organization/operations/add-account.md#delete-invitation) or [resend it](../../organization/operations/add-account.md#resend-invitation).

If the issue persists, [contact support]({{ link-console-support }}). Attach the full error message and the [HAR file](../../support/create-har.md) captured when reproducing the error.

#### Why is the federated user missing from the organization? {#federated-user-missing}

If a user is on the list of federated users but not on the [list of organization users](https://center.yandex.cloud/organization/users), they may have been deleted from the organization.

[Add the user to the federation again](../../organization/operations/add-account.md#add-user-sso). Use their Name ID on the identity provider's side: this ID may not be matching their email address.

After you add the user again, their user ID in the organization will change. Check the new account’s access permissions and reassign the necessary roles.

#### Why are the user’s name and email address not shown in the organization? {#unknown-user}

The original account may have been deleted on the {{ yandex-360 }} or identity provider's side. Check this with the administrator and, if the account is no longer used, [delete the user from the organization](../../organization/operations/edit-account.md).

#### How to fix the `The signature of response or assertion was invalid` error? {#saml-signature}

Check the certificate your identity provider uses to sign SAML responses. If the certificate was updated on the provider's side, [add the current certificate to the federation](../../organization/operations/setup-federation.md#add-certificate-fed).

For automated updates, use the CLI or API as per this guide. Make sure you use a SAML federation certificate, not an authorization key of the service account.

#### How to fix the `Response is invalid in a general way` error? {#saml-response}

The `Response is invalid in a general way` or `The assertion was not valid` error means that the identity provider’s SAML response failed validation.

1. Make sure the provider's settings specify [your federation’s ACS URL](../../organization/operations/setup-federation.md#configure-sso).
1. Check the SAML response signing settings and certificate as per the [recommendations for signature errors](#saml-signature).
1. Check the settings against the [guide for your identity provider](../../organization/tutorials/federations/index.md).
1. After you update the settings, try logging in again.

If the error persists, [contact support]({{ link-console-support }}). Attach the full error message, name and version of your identity provider, screenshots of the SAML settings, and the [HAR file](../../support/create-har.md) captured when reproducing the error. Remove cookies, tokens, and personal data from the HAR file before you send it.
