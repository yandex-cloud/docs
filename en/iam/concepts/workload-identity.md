---
title: Workload identity federation in {{ iam-full-name }}
description: This section describes workload identity federations, an {{ iam-name }} tool that enables you to configure exchange of tokens from any OpenID Connect-compatible systems for IAM tokens to access the {{ yandex-cloud }} API.
---

# Workload identity federations

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

A workload identity federation is a {{ iam-full-name }} tool that enables you to configure exchange of tokens from any [OpenID Connect](https://openid.net/developers/how-connect-works/)-compatible systems for [IAM tokens](./authorization/iam-token.md) that can be used to access the [{{ yandex-cloud }} API](../../api-design-guide/index.yaml).

Popular use cases:

* {{ k8s }} pod request to the {{ yandex-cloud }} API to get the {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md) contents.
* Request to the {{ yandex-cloud }} API from a [CI/CD](https://en.wikipedia.org/wiki/CI/CD) system, such as {{ GL }}, to deploy cloud services using [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).

Such a process does not involve creation of long-lived keys, thus improving both user convenience and security.

For more information about OpenID Connect, see the [OIDC specification](https://openid.net/specs/openid-connect-core-1_0.html).

You can use the [YC CLI](../../cli/quickstart.md) to configure a workload identity federation.

To create a workload identity federation, you need the `iam.workloadIdentityFederations.editor` [role](../security/index.md#iam-workloadIdentityFederations-editor) or higher.

## How a federation works {#work-scheme}

A workload identity federation is created in a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and requires configuration of required parameters of an OpenID Connect-compatible provider (OIDC provider).

* `audience`: Resource for which the IAM token will be issued. Provided in `StringOrURI` format.

    A federation can have a single one or a whole array of the `audience` values specified.
* `issuer`: URL of the OIDC provider server.
* `jwks-url`: URL for retrieving the current public key issued by the OIDC provider and used for [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token) signature verification.

You can create multiple workload identity federations in a single folder.

A workload identity federation consists of [_federated credentials_](#federated-credentials), each containing details about the link between a specific [service account](./users/service-accounts.md) and a specific _external subject_.

An external subject is a subject authorized by a third-party OIDC provider and belonging to a service external to {{ yandex-cloud }} and therefore requiring a {{ yandex-cloud }} IAM token. For example, this could be a [{{ k8s }} service account](../../managed-kubernetes/concepts/index.md#service-accounts) or a [{{ GL }}](../../managed-gitlab/index.yaml) job.

Steps to obtain an IAM token using a service account linked to a federation:

1. To get a {{ yandex-cloud }} IAM token, an external subject contacts the OIDC provider which issues a JWT token for it.
1. The external subject submits the obtained JWT token to the {{ iam-full-name }} workload identity federation.
1. {{ iam-name }} verifies the external subject's permissions (by checking for the appropriate [federated credentials](#federated-credentials)) and the validity of the submitted JWT token (using a public key).
1. Upon successful verification of permissions and the JWT token, {{ iam-name }} exchanges the JWT token for an IAM token of the {{ yandex-cloud }} service account linked to this external subject through the relevant federated credentials.
1. The external subject uses the obtained IAM token to make the required {{ yandex-cloud }} API requests on behalf of the service account specified in the federated credentials.

## Federated credentials {#federated-credentials}

_Federated credentials_ refer to the link established between a workload identity federation, a {{ yandex-cloud }} service account, and an external subject.

Federated credentials are created within an identity federation and require configuration of required parameters.

* `Service account ID or name`: Data of the service account that will get an IAM token upon request from an external subject.

    The service account can reside in a folder other than the one containing the workload identity federation.

    The service account must get [roles](./access-control/roles.md) permitting the required actions with resources or data in {{ yandex-cloud }}.
* `Workload identity federation ID`: Data of the workload identity federation for which federated credentials are being added.
* `subject`: ID assigned by the OIDC provider to the external subject submitting a request to the {{ yandex-cloud }} API.

You can use the [YC CLI](../../cli/quickstart.md) to create federated credentials.

To create federated credentials, the user needs the following:
* The `iam.serviceAccounts.federatedCredentialEditor` [role](../security/index.md#iam-serviceAccounts-federatedCredentialEditor) or higher for the service account that will be used in the federated credentials.
* The `iam.workloadIdentityFederations.user` [role](../security/index.md#iam-workloadIdentityFederations-user) or higher for the folder containing the relevant workload identity federation.