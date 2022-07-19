# Updating a lifecycle policy

Once you create a [lifecycle policy](../../concepts/lifecycle-policy.md), you can modify its rules as well as its status, name, or description.

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

- API

   To edit a lifecycle policy, use the [Update](../../api-ref/grpc/lifecycle_policy_service.md#Update) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource. Specify the policy ID in the `lifecycle_policy_id` property.

   You can retrieve a list of policies using the [List](../../api-ref/grpc/lifecycle_policy_service.md#List) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}

{% include [lifecycle restrictions](../../../_includes/container-registry/lifecycle-restrictions.md) %}

## Examples {#examples}

### Updating lifecycle policy rules {#update-rules}

{% list tabs %}

- CLI

   1. Prepare new [policy rules](../../concepts/lifecycle-policy.md#lifecycle-rules) and save them to a file named `new-rules.json`.

      {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

   1. Change the policy rules by running the command with the following parameter:
      * `new-rules`: Path to the file with the new policy description.

      {% note alert %}

      Updating the policy completely overwrites all current rules by destroying them.

      {% endnote %}

      ```bash
      yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-rules ./new-rules.json
      ```

      Result:

      ```bash
      WARN: All current lifecycle rules will be overwritten. Are you sure?[y/N] y
      id: crp6lg1868p3i0emkv1b
      name: test-policy
      ...
        expire_period: 172800s
        tag_regexp: test.*
        untagged: true
      ```

{% endlist %}

### Updating a lifecycle policy status {#update-status}

#### Activate a lifecycle policy {#activate}

{% list tabs %}

- CLI

   Activate a deactivated lifecycle policy by running the command below with the `--activate` flag:

   ```bash
   yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --activate
   ```

   Result:

   ```bash
   id: crp6lg1868p3i0emkv1b
   name: test-policy
   repository_id: crp3cpm16edqql0t30s2
   ...
     expire_period: 172800s
     tag_regexp: test.*
     untagged: true
   ```

{% endlist %}

#### Disable a lifecycle policy {#disabled}

{% list tabs %}

- CLI

   Deactivate an active policy by running the command below with the `--disable` flag:

   ```bash
   yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --disable
   ```

   Result:

   ```bash
   id: crp6lg1868p3i0emkv1b
   name: test-policy
   repository_id: crp3cpm16edqql0t30s2
   ...
     expire_period: 172800s
     tag_regexp: test.*
     untagged: true
   ```

{% endlist %}

### Updating a lifecycle policy name {#update-name}

{% list tabs %}

- CLI

   Change the policy name by running the command:

   ```bash
   yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-name new-policy
   ```

   Where `new-name` is the new policy name.

      {% include [name-format](../../../_includes/name-format.md) %}

   Result:

   ```bash
   id: crp6lg1868p3i0emkv1b
   name: new-policy
   repository_id: crp3cpm16edqql0t30s2
   ...
     expire_period: 172800s
     tag_regexp: test.*
     untagged: true
   ```

{% endlist %}

### Updating a lifecycle policy description {#update-description}

{% list tabs %}

- CLI

   Change the policy description by running the command:

   ```bash
   yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-description "new description"
   ```

   Where `new-description` is the new policy description.

   Result:

   ```bash
   id: crp6lg1868p3i0emkv1b
   name: test-policy
   repository_id: crp3cpm16edqql0t30s2
   ...
     expire_period: 172800s
     tag_regexp: test.*
     untagged: true
   ```

{% endlist %}