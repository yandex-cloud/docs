---
title: Getting information about subjects in the {{ yandex-cloud }} access management system
description: This section describes the feature for getting information about subjects in the {{ yandex-cloud }} access control system, including users, service accounts, user groups, system groups, and public groups. You can use it to search for subjects and retrieve subject attributes.
---

# Getting information about subjects in the {{ yandex-cloud }} access management system

{{ iam-full-name }} provides a feature for [getting information about subjects](../operations/subject-details.md) to simultaneously search for and retrieve attributes of different [types of subjects](#subject-types) in the {{ yandex-cloud }} access management system.

Additional flexibility when searching for subjects and retrieving subject attributes comes from using filters based on the [Common Expression Language (CEL)](https://cel.dev/).

This feature is available in the {{ yandex-cloud }} [CLI](../../cli/cli-ref/iam/cli-ref/subject-details/index.md) and [API](../api-ref/grpc/SubjectDetails/index.md) interfaces.

## Subject types {#subject-types} 

You can use this feature to search for multiple subject types within an [organization](*organization) at the same time:

Subject type | Description | Minimum [role](./access-control/roles.md) required to get information
--- | --- | ---
`USER_ACCOUNT` | [Yandex account](./users/accounts.md#passport) users, [local](./users/accounts.md#local) users, and [federated](./users/accounts.md#saml-federation) users | [organization-manager.users.viewer](../../organization/security/index.md#organization-manager-users-viewer) or higher for the organization
`SERVICE_ACCOUNT` | [Service accounts](./users/service-accounts.md) | [iam.auditor](../security/index.md#iam-auditor) or higher for the organization
`GROUP` | [User groups](../../organization/concepts/groups.md), [system](./access-control/system-group.md) groups, and [public](./access-control/public-group.md) groups | [organization-manager.groups.viewer](../../organization/security/index.md#organization-manager-groups-viewer) or higher for the organization
`INVITEE` | Yandex account users who have been [invited](../../organization/operations/add-account.md#send-invitation) to the organization but have not yet accepted the invitation | [organization-manager.users.viewer](../../organization/security/index.md#organization-manager-users-viewer) or higher for the organization

## Available methods {#methods}

{{ iam-name }} supports two methods for getting information about subjects: [List](#list) and [BatchGet](#batch-get). 

When calling either method, you can provide a subject mask (`field-mask`) that specifies which subject attributes to retrieve. If you do not specify a subject mask, the method only returns `sub` and `type` by default. The available attributes depend on the [subject type](#subject-types). For more information, see [{#T}](#attributes).

You can also use a flexible [CEL filter](#filter) when calling either method to narrow down the list of subjects you want to get information about.

For more info on using methods for getting subject details, see [{#T}](../operations/subject-details.md).

### List {#list}

The `List` method returns a list of organization subjects and their details based on the organization ID. You can use the [REST API](../api-ref/SubjectDetails/list.md), [gRPC API](../api-ref/grpc/SubjectDetails/list.md), or `yc iam subject-details list` [CLI command](../../cli/cli-ref/iam/cli-ref/subject-details/list.md) to call `List`.

When calling the `List` method, make sure to provide the [ID of the organization](../../organization/operations/organization-get-id.md) to search for subjects in.

### BatchGet {#batch-get}

The `BatchGet` method returns information about specified organization subjects based on their IDs. You can use the [REST API](../api-ref/SubjectDetails/batchGet.md), [gRPC API](../api-ref/grpc/SubjectDetails/batchGet.md), or `yc iam subject-details get` [CLI command](../../cli/cli-ref/iam/cli-ref/subject-details/get.md) to call `BatchGet`.

When calling the `BatchGet` method, you must specify at least one subject ID you want to get information about.

To get a list of groups that include a Yandex account user, make sure to provide the [organization ID](../../organization/operations/organization-get-id.md) when calling `BatchGet`.

## Subject attributes {#attributes}

You can use the `List` and `BatchGet` methods to retrieve the values of the following subject attributes:

{% note info %}

The subject mask (`field-mask`) you provide in the `List` and `BatchGet` methods should contain field names without the name of the `subject` main container. e.g., `sub`, `user_account`, or `service_account.service_agent.microservice_id`.

{% endnote %}

#|
|| **Field** | **Data type** | **Attribute** ||
|| **subject**: Main container that includes all subject attributes. | > | > ||
|| `subject.sub` | `string` | [ID](../../api-design-guide/concepts/resources-identification.md) of the subject ||
|| `subject.type` | `enum` ^1^ |
[Subject type](#subject-types) in the access management system:
* `1`: User account; matches the `USER_ACCOUNT` value in the response.
* `2`: Service account; matches the `SERVICE_ACCOUNT` value in the response.
* `3`: Group; matches the `GROUP` value in the response.
* `4`: Invited user; matches the `INVITEE` value in the response.
||
|| `subject.created_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Subject creation date and time ||
|| `subject.status` | `enum` ^1^ |
Subject status (for federated and local users only):
* `1`: Active status; matches the `ACTIVE` value in the response.
* `2`: Inactive status; matches the `SUSPENDED` value in the response.
||
|| `subject.name` | `string` | Subject name. ||
|| `subject.last_authenticated_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Last authentication date and time ||
|| `subject.external_id` | `string` | Subject ID in the external system ||
|| **subject.groups**: Fields with attributes of groups that include a user or service account. ^2^ | > | > ||
|| `subject.groups.type` | `enum` ^1^ |
Group type:
* `1`: [Public group](./access-control/public-group.md); matches the `PUBLIC_ACCESS` value in the response.
* `2`: [User group](../../organization/concepts/groups.md); matches the `EXPLICIT` value in the response.
* `3`: [System group](./access-control/system-group.md); matches the `META` value in the response.
||
|| `subject.groups.id` | `string` | User group, system group, or public group ID ||
|| `subject.groups.name` | `string` | User group, system group, or public group name ||
|| **subject.user_account**: Fields with user-specific attributes. | > | > ||
|| `subject.user_account.given_name` | `string` | Name ||
|| `subject.user_account.family_name` | `string` | Last name ||
|| `subject.user_account.preferred_username` | `string` | User's login. ||
|| `subject.user_account.email` | `string` | User's email address. ||
|| `subject.user_account.phone_number` | `string` | Phone number. ||
|| `subject.user_account.expires_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Scheduled user deactivation date and time, if set. Only for federated and local users. ||
|| `subject.user_account.modified_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Date and time of the most recent update to the user attributes ||
|| `subject.user_account.last_id_proof_at` | [timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp) | Date and time of the user’s last verification ||
|| `subject.user_account.suspend_reason` | `string` | Reason for deactivation (for federated and local users only) ||
|| **subject.user_account.subject_container**: Fields with attributes specific to different user types. | > | > ||
||
`subject.user_account.subject_container.container_type`
| `enum` ^1^ |
Depending on the user type:
* `1`: User of a SAML-compatible identity federation; matches the `SAML` value in the response.
* `3`: Yandex account user; matches the `PASSPORT` value in the response.
* `4`: Local user; matches the `USERPOOL` value in the response.
||
|| `subject.user_account.subject_container.id` | `string` |
Depending on the user type:
* For local users: [User pool](../../organization/concepts/user-pools.md) ID.
* For federated users: [Identity federation](../../organization/concepts/add-federation.md) ID.
* For Yandex account users: `yandex` value.
||
||
`subject.user_account.subject_container.name`
| `string` |
Depending on the user type:
* For local users: User pool name.
* For federated users: Identity federation name.
* For Yandex account users: `yandex` value.
||
|| **subject.user_account.job_info**: Fields with attributes that describe the user’s company and job title. | > | > ||
|| `subject.user_account.job_info.company_name` | `string` | Company name ||
|| `subject.user_account.job_info.department` | `string` | Department ||
|| `subject.user_account.job_info.job_title` | `string` | Job title ||
|| `subject.user_account.job_info.employee_id` | `string` | Employee ID ||
|| **subject.invitee**: Fields with attributes specific to Yandex account users who have been invited to the organization but have not yet accepted the invitation. | > | > ||
|| `subject.invitee.email` | `string` | User's email address. ||
|| `subject.invitee.preferred_username` | `string` | User's login. ||
|| **subject.service_account**: Fields with attributes specific to service accounts. | > | > ||
|| **subject.service_account.cloud**: Fields with attributes that describe the cloud associated with the service account. | > | > ||
|| `subject.service_account.cloud.id` | `string` | Cloud ID. ||
|| `subject.service_account.cloud.name` | `string` | Name of the cloud. ||
|| **subject.service_account.folder**: Fields with attributes that describe the folder associated with the service account. | > | > ||
|| `subject.service_account.folder.id` | `string` | Folder ID. ||
|| `subject.service_account.folder.name` | `string` | Name of the folder. ||
|| **subject.service_account.service_agent**: Fields with attributes specific to service accounts acting as [service agents](./service-control.md#service-agent). | > | > ||
||
`subject.service_account.service_agent.service_id`
| `string` | ID of the service on whose behalf the service agent acts. ||
||
`subject.service_account.service_agent.microservice_id`
| `string` | ID of the microservice on whose behalf the service agent acts. ||
|| **subject.group**: Fields with attributes specific to user groups, system groups, and public groups. | > | > ||
|| `subject.group.type` | `enum` ^1^ |
Group type:
* `1`: [Public group](./access-control/public-group.md); matches the `PUBLIC_ACCESS` value in the response.
* `2`: [User group](../../organization/concepts/groups.md); matches the `EXPLICIT` value in the response.
* `3`: [System group](./access-control/system-group.md); matches the `META` value in the response.
||
|| `subject.group.id` | `string` | User group, system group, or public group ID ||
|| `subject.group.name` | `string` | User group, system group, or public group name ||
|#

{sticky-header}

^1^ Values of `enum`-type fields provided in the request `filter` should use numeric format.
^2^ When using the [BatchGet](#batch-get) method to get a list of groups that include a Yandex account user, make sure to provide the [organization ID](../../organization/operations/organization-get-id.md) in the request.

## Subject filter {#filter}

When getting a list of subjects and their details, you can apply a filter to narrow down the search results and include only the relevant information.

Filters are based on the [Common Expression Language (CEL)](https://cel.dev/) and set in the `filter` field.

For more on available CEL features, see [this official reference](https://cel.dev/reference/api-reference).

In addition to standard CEL features, {{ iam-name }} also supports `icontains` to perform _case-insensitive_ substring matching. Here is an example:

```text
"ABcdEf".icontains("abc") // true
```

For more info on using filters when getting subject details, see [{#T}](../operations/subject-details.md).

#### Useful links {#see-also}

* [{#T}](../operations/subject-details.md)

[*organization]: {% include [organization-definition](../../_popups/identity-hub/organization-definition.md) %}