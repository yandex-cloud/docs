# Updating a lifecycle policy

After creating a [lifecycle policy](../../concepts/lifecycle-policy.md), you can update its rules, status, name, and description.

To access the policy, use its ID. For information about getting a policy ID, see [{#T}](lifecycle-policy-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. See the description of the CLI command for updating policy parameters:

     ```bash
     yc container repository lifecycle-policy update --help
     ```

  1. Change the policy parameters, such as by renaming it:

     ```bash
     yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-name new-policy
     ```

{% endlist %}

{% include [lifecycle restrictions](../../../_includes/container-registry/lifecycle-restrictions.md) %}

## Examples {#examples}

### Updating lifecycle policy rules {#update-rules}

{% list tabs %}

- CLI

  1. Set new [policy rules](../../concepts/lifecycle-policy.md#lifecycle-rules) and save them to a file named `new-rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Change the policy rules by running the command with the following parameter:

     * `new-rules`: Path to the file with the new policy description.

       {% note alert %}

       Updating the policy completely overwrites all current rules by destroying them.

       {% endnote %}

       ```bash
       yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-rules ./new-rules.json
       WARN: All current lifecycle rules will be overwritten. Are you sure?[y/N] y
       id: crp6lg1868p3i0emkv1b
       name: test-policy
       repository_id: crp3cpm16edqql0t30s2
       description: disabled lifecycle-policy for tests
       status: DISABLED
       created_at: "2020-05-28T15:05:58.143719Z"
       rules:
       - description: remove prod images older than 60 days except 20 last ones
         expire_period: 5184000s
         tag_regexp: prod
         retained_top: "20"
       - description: remove all test and untagged images older than 48 hours
         expire_period: 172800s
         tag_regexp: test.*
         untagged: true
       ```

{% endlist %}

### Updating a lifecycle policy status {#update-status}

#### Activate a lifecycle policy {#activate}

{% list tabs %}

- CLI

  Activate the disabled policy by running the command with the `--activate` flag:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --activate
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  description: disabled lifecycle-policy for tests
  status: ACTIVE
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

#### Disable a lifecycle policy {#disabled}

{% list tabs %}

- CLI

  Disable the active policy by running the command with the `--disable` flag:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --disable
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  description: disabled lifecycle-policy for tests
  status: DISABLED
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Updating a lifecycle policy name {#update-name}

{% list tabs %}

- CLI

  Change the policy name by running the command with the following parameter:
  * `new-name`: New policy name.

    {% include [name-format](../../../_includes/name-format.md) %}

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-name new-policy
  id: crp6lg1868p3i0emkv1b
  name: new-policy
  repository_id: crp3cpm16edqql0t30s2
  description: disabled lifecycle-policy for tests
  status: DISABLED
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Updating a lifecycle policy description {#update-description}

{% list tabs %}

- CLI

  Change the policy description by running the command with the following parameter:
  * `new-description`: New policy description.

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-description "new description"
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  description: new description
  status: DISABLED
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}