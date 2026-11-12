---
title: Getting information about subjects in the {{ yandex-cloud }} access management system
description: In this guide, you will learn how to employ the feature for getting information about subjects in the {{ yandex-cloud }} access control system, including users, service accounts, user groups, system groups, and public groups. You can use it to search for and retrieve subject attributes.
---

# Getting information about subjects in the {{ yandex-cloud }} access management system

{{ iam-full-name }} provides a feature for [getting information about subjects](../concepts/subject-details.md) to search for and retrieve attributes of different types of subjects in the {{ yandex-cloud }} access management system within your [organization](*organization).

[Roles](../concepts/access-control/roles.md) required to get information about subjects depend on the target [subject type](../concepts/subject-details.md#subject-types):

* Users: `organization-manager.users.viewer` [role](../../organization/security/index.md#organization-manager-users-viewer) or higher for the organization.
* [Service accounts](../concepts/users/service-accounts.md): `iam.auditor` [role](../security/index.md#iam-auditor) or higher for the organization.
* [User groups](../../organization/concepts/groups.md), [system groups](../concepts/access-control/system-group.md), and [public groups](../concepts/access-control/public-group.md): `organization-manager.groups.viewer` [role](../../organization/security/index.md#organization-manager-groups-viewer) or higher for the organization.
* Yandex account users who have been [invited](../../organization/operations/add-account.md#send-invitation) to the organization but have not yet accepted the invitation: `organization-manager.users.viewer` [role](../../organization/security/index.md#organization-manager-users-viewer) or higher for the organization.

## Getting a list of subjects {subject-list}

To get a list of [subjects](../concepts/subject-details.md#subject-types) in an organization:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. See the description of the CLI command for getting a list of subjects in an organization:

      ```bash
      yc iam subject-details list --help
      ```
  1. {% include [get-federation-id-cli](../../_includes/organization/get-federation-id-cli.md) %}
  1. Get your list of subjects:

      ```bash
      yc iam subject-details list \
        --organization-id <organization_ID> \
        --field-mask <attribute_list> \
        --filter '(<filtering_CEL_expression>)' \
        --limit <number_of_subjects> \
        --format yaml
      ```

      Where:
      * `--organization-id`: ID of the organization whose list of [subjects](../concepts/subject-details.md#subject-types) you want to get.
      * `--field-mask`: Mask of subjects, i.e., a list of [attributes](../concepts/subject-details.md#attributes) you want to get. Available attributes are subject type-specific.
      
          For example, to display a list of creation dates, email addresses, and last names of your users, set this parameter to `created_at,user_account.email,user_account.family_name`.

          This is an optional setting. By default, regardless of the `--field-mask` parameter value, the list shows subject IDs and types.
      * `--filter`: [Filtering expression](../concepts/subject-details.md#filter) in [Common Expression Language (CEL)](https://cel.dev/).

          For example, to display only a list of local users whose profiles have the `{{ ui-key.yacloud_org.entity.user.caption.email }}` field filled in and whose email address contains `ivan`, set this parameter to the following:

          ```text
          '(subject.type in [1] && 
          has(subject.user_account.email) && 
          subject.user_account.email.icontains("ivan"))'
          ```

          {% note info %}

          For case-insensitive substring matching, use the `icontains` function.

          {% endnote %}

          This is an optional setting. By default, no filters apply to the results.
      * `--limit`: Limits the number of subjects in the result list. This is an optional setting. The default value is `1000`.
      * `--format`: To get results with attributes other than the default values, use the `json` or `yaml` output format.

      Result:

      ```text
      - sub: ek09f4kjk3mk********
        type: USER_ACCOUNT
        created_at: "2026-09-23T16:54:03.297124Z"
        user_account:
          family_name: Ivanov
          email: Sergey-Ivanov@example.com
      - sub: ek0ogbhh6o3p********
        type: USER_ACCOUNT
        created_at: "2026-09-23T16:55:42.318668Z"
        user_account:
          family_name: Sergeev
          email: IVANsergeev@example.com
      ```

- API {#api}

  Use the [list](../api-ref/SubjectDetails/list.md) REST API method for the [SubjectDetails](../api-ref/SubjectDetails/index.md) resource or the [SubjectDetailsService/List](../api-ref/grpc/SubjectDetails/list.md) gRPC API call.

  {% include [subject-details-short-api-filter-tip](../../_includes/iam/subject-details-short-api-filter-tip.md) %}

{% endlist %}


### Examples {#list-examples}

#### Getting a list of all subjects created after a specific date {#list-creation-date}

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc iam subject-details list \
    --organization-id bpf2c65rqcl8******** \
    --field-mask created_at \
    --filter '(subject.created_at >= timestamp("2026-09-01T00:00:00Z"))' \
    --format yaml
  ```

  {% cut "Result" %}


  ```text
  - sub: aje7gcq7usen********
    type: SERVICE_ACCOUNT
    created_at: "2026-09-24T07:26:05.813707Z"
  - sub: ek09f4kjk3mk********
    type: USER_ACCOUNT
    created_at: "2026-09-23T16:54:03.297124Z"
  - sub: ek0ogbhh6o3p********
    type: USER_ACCOUNT
    created_at: "2026-09-23T16:55:42.318668Z"
  ```

  {% endcut %}

{% endlist %}

#### Getting a list of names of service accounts residing in specific folders {#list-sa-in-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc iam subject-details list \
    --organization-id bpf2c65rqcl8******** \
    --field-mask name,service_account.folder.id \
    --filter '(subject.service_account.folder.id in ["b1gkd6dks6i1********", "b1gfq9pe6rd2********"])' \
    --format yaml
  ```

  {% cut "Result" %}

  ```text
  - sub: aje8ibek25c6********
    type: SERVICE_ACCOUNT
    name: sa-sd
    service_account:
      folder:
        id: b1gkd6dks6i1********
  - sub: ajepodjpcifj********
    type: SERVICE_ACCOUNT
    name: sa-lockbox
    service_account:
      folder:
        id: b1gfq9pe6rd2********
  - sub: ajet9uglmjir********
    type: SERVICE_ACCOUNT
    name: sample-sa
    service_account:
      folder:
        id: b1gkd6dks6i1********
  ```

  {% endcut %}

{% endlist %}

#### Getting a list of statuses for local users without a phone number {#list-users-no-phone}

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc iam subject-details list \
    --organization-id bpf2c65rqcl8******** \
    --field-mask status \
    --filter '(subject.user_account.subject_container.container_type == 4 && 
              !has(subject.user_account.phone_number))' \
    --format yaml
  ```

  {% cut "Result" %}

  ```text
  - sub: aje3i1gq49n3********
    type: USER_ACCOUNT
    status: ACTIVE
  - sub: ajejij9f440p********
    type: USER_ACCOUNT
    status: ACTIVE
  - sub: ajejvne736i3********
    type: USER_ACCOUNT
    status: ACTIVE
  - sub: ek09f4kjk3mk********
    type: USER_ACCOUNT
    status: SUSPENDED
  ```

  {% endcut %}

{% endlist %}


## Getting attributes of individual subjects {subject-details-get}

To get attributes of individual [subjects](../concepts/subject-details.md#subject-types) in an organization:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. See the description of the CLI command for getting attributes of individual subjects in an organization:

      ```bash
      yc iam subject-details get --help
      ```
  1. Get information about your subjects:

      ```bash
      yc iam subject-details get \
        --subject-ids <list_of_IDs> \
        --field-mask <attribute_list> \
        --filter '(<filtering_CEL_expression>)' \
        --format yaml \
        --organization-id <organization_ID>
      ```

      Where:
      * `--subject-ids`: List of IDs of subjects whose attributes you want to get. comma-separated. Here is an example: `ek09f4kjk3mk********,ek0ogbhh6o3p********`.
      * `--field-mask`: Mask of subjects, i.e., a list of [attributes](../concepts/subject-details.md#attributes) you want to get. Available attributes are subject type-specific.
      
          For example, to get email addresses and complete employment information for users, set this parameter to `user_account.email,user_account.job_info`.

          This is an optional setting. By default, regardless of the `--field-mask` parameter value, the list shows subject IDs and types.
      * `--filter`: [Filtering expression](../concepts/subject-details.md#filter) in [Common Expression Language (CEL)](https://cel.dev/).

          For example, to make the command output only those users who have the fields under `{{ ui-key.yacloud_org.my-account.ProfilePage.job_info_subheader }}` filled in, set this parameter to the following:

          ```text
          '(has(subject.user_account.job_info))'
          ```

          This is an optional setting. By default, no filters apply to the results.
      * `--format`: To get results with attributes other than the default values, use the `json` or `yaml` output format.
      * `--organization-id`: [ID of the organization](../../organization/operations/organization-get-id.md) the target subjects belong to.

          This is an optional setting. Specify the organization ID when it is impossible to get the information without it. 

          {% note tip %}

          For example, the organization ID must be specified when trying to get a list of groups that a user with a Yandex account belongs to. You must specify the organization explicitly because such a user can belong to multiple different organizations at once.

          {% endnote %}

      Result:

      ```text
      - sub: ek09f4kjk3mk********
        type: USER_ACCOUNT
        user_account:
          email: Sergey-Ivanov@example.com
          job_info:
            company_name: Top Company
            department: Accounting
            job_title: Senior Accountant
            employee_id: "456"
      - sub: ek0ogbhh6o3p********
        type: USER_ACCOUNT
        user_account:
          email: IVANsergeev@example.com
          job_info:
            company_name: Top Company
            department: IT
            job_title: DevOps engineer
            employee_id: "123"
      ```

- API {#api}

  Use the [batchGet](../api-ref/SubjectDetails/batchGet.md) REST API method for the [SubjectDetails](../api-ref/SubjectDetails/index.md) resource or the [SubjectDetailsService/BatchGet](../api-ref/grpc/SubjectDetails/batchGet.md) gRPC API call.

  {% include [subject-details-short-api-filter-tip](../../_includes/iam/subject-details-short-api-filter-tip.md) %}

{% endlist %}

### Examples {#get-examples}

#### Getting a list of groups the user is a member of {#get-user-groups}

{% list tabs group=instructions %}

- CLI {#cli}

  {% note info %}

  To get a list of groups for a user with a Yandex account, provide the organization ID in the command.

  {% endnote %}

  Run this command:

  ```bash
  yc iam subject-details get \
    --subject-ids ajei280a73vc******** \
    --field-mask groups \
    --organization-id bpf2c65rqcl8******** \
    --format yaml
  ```

  {% cut "Result" %}

  ```text
  sub: ajei280a73vc********
  type: USER_ACCOUNT
  groups:
    - id: ajeql2iqn9d1********
      name: sample-group
      type: EXPLICIT
    - id: allUsers
      name: All users
      type: PUBLIC_ACCESS
    - id: allAuthenticatedUsers
      name: All authenticated users
      type: PUBLIC_ACCESS
    - id: group:organization:bpf2c65rqcl8********:users
      name: All users in organization Test Organization
      type: META
  ```

  {% endcut %}

{% endlist %}

#### Getting all available user attributes {#get-all-user-attributes}

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc iam subject-details get \
    --subject-ids aje3b3juqevc********,ek0ogbhh6o3p********,ajei280a73vc******** \
    --field-mask created_at,status,name,last_authenticated_at,external_id,user_account \
    --format yaml
  ```

  {% cut "Result" %}

  ```text
  - sub: aje3b3juqevc********
    type: USER_ACCOUNT
    created_at: "2025-08-03T18:38:44.195748Z"
    status: ACTIVE
    user_account:
      preferred_username: sample-federated-user
      subject_container:
        id: bpfsuecgv39i********
        name: sample-federation
        container_type: SAML
      last_id_proof_at: "2025-08-03T18:38:44.195748Z"
      modified_at: "2025-08-03T18:38:44.195748Z"
    external_id: sample-federated-user
  - sub: ek0ogbhh6o3p********
    type: USER_ACCOUNT
    created_at: "2026-09-23T16:55:42.318668Z"
    status: ACTIVE
    name: Ivan Sergeev
    user_account:
      given_name: Ivan
      family_name: Sergeev
      preferred_username: ivanserg@example.com
      email: IVANsergeev@example.com
      subject_container:
        id: ek0o6g0irskn********
        name: sample-pool
        container_type: USERPOOL
      job_info:
        company_name: Top Company
        department: IT
        job_title: DevOps engineer
        employee_id: "123"
      modified_at: "2026-09-23T19:48:49.112910Z"
  - sub: ajei280a73vc********
    type: USER_ACCOUNT
    created_at: "2020-01-23T06:21:07Z"
    status: ACTIVE
    name: Aleksey I.
    last_authenticated_at: "2026-09-24T05:40:00Z"
    user_account:
      given_name: Aleksey
      family_name: Ivanov
      preferred_username: aivan********
      email: aivan********@yandex.ru
      phone_number: "+79876******"
      subject_container:
        id: yandex
        name: yandex
        container_type: PASSPORT
      last_id_proof_at: "2026-09-24T05:42:45.551123Z"
      modified_at: "2026-09-22T05:55:45.853516Z"
    external_id: "114*****"
  ```

  {% endcut %}

{% endlist %}

#### Getting the last names of federated and local users who have never authenticated in {{ yandex-cloud }} {#get-never-authenticated}

{% note warning %}

If your filter uses fields with the `enum` data type, provide the numeric values specified in the [subject attributes](../concepts/subject-details.md#attributes) table for such fields.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc iam subject-details get \
    --subject-ids aje3b3juqevc********,ek0ogbhh6o3p********,ajei280a73vc******** \
    --field-mask user_account.family_name \
    --filter 'subject.user_account.subject_container.container_type in [1, 4] && 
              !has(subject.last_authenticated_at)' \
    --format yaml
  ```

  {% cut "Result" %}

  ```text
  sub: ek0ogbhh6o3p********
  type: USER_ACCOUNT
  user_account:
    family_name: Sergeev
  ```

  {% endcut %}

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../concepts/subject-details.md)

[*organization]: {% include [organization-definition](../../_popups/identity-hub/organization-definition.md) %}
