# Secure storage of {{ GL }} CI passwords as {{ lockbox-full-name }} secrets

You can securely store passwords as [{{ lockbox-full-name }} secrets](../../lockbox/concepts/secret.md) and use them in your CI scripts in {{ mgl-full-name }}. Thus you can protect and hide passwords in CI scripts from {{ GL }} users, including administrators.

Below is how the integration with {{ lockbox-name }} works. First you prepare a {{ lockbox-name }} secret and a {{ GL }} environment variable referring to this secret. You also install {{ GLR }} on a VM and link a service account to it. Then you create the CI script provided below. It contains a special command that requests the service account's IAM token. The script uses the IAM token and the environment variable to retrieve the password from the secret. As a result, the password is used by the CI script but stored in an external storage.

To enable a {{ mgl-name }} instance to access {{ lockbox-name }} secrets:

1. [Prepare your infrastructure](#infra).
1. [Configure the CI script](#ci).
1. [Check the result](#check-result).
1. [Fix potential vulnerabilities](#eliminate-vulnerabilities).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#infra}

1. [Create and activate](../../managed-gitlab/operations/instance/instance-create.md) a {{ mgl-name }} instance.
1. [Create a {{ GL }} project]({{ gl.docs }}/ee/user/project/).
1. [Create](../../lockbox/operations/secret-create.md) a {{ lockbox-name }} secret named `MY_SECRET`.
1. [Create a service account](../../iam/operations/sa/create.md) with the `{{ roles-lockbox-payloadviewer }}` role.

   This role has no permissions to acquire the secrets list; therefore, lacking the secret ID, the attacker will not be able to retrieve the password from the secret.

1. [Create a {{ GL }} environment variable]({{ gl.docs }}/ee/ci/variables/#for-a-project) for the project. Configure it as follows:

   * **Key**: `MY_SECRET`.
   * **Value**: ID of the {{ lockbox-name }} secret you created.
   * **Mask variable**: Enabled.

      Mask the variable to protects your passwords from theft. This way, only users with the `Maintainer` or `Owner` roles in your {{ GL }} project will be able to see the value of the {{ lockbox-name }} secret ID variable. If connected to a virtual machine with {{ GLR }}, the attacker will not be able to retrieve the password from a secret without knowing the secret ID.

1. [Install {{ GLR }}](../../managed-gitlab/tutorials/install-gitlab-runner.md) on a separate {{ compute-full-name }} VM. When creating a VM, specify the service account you previously created.

   In {{ GLR }} settings, make it only available for [protected branches]({{ gl.docs }}/ee/user/project/protected_branches.html) and specific projects (**Protected** and **Lock to current projects**). If you do not provide these settings, CI scripts with passwords will be runnable in projects not monitored by the information security team. Thus your passwords may become compromised.

   {% cut "Configuring {{ GLR }}" %}

   1. Open the {{ GL }} project in your browser.
   1. In the left-hand menu, go **Settings** → **CI/CD**.
   1. Under **Runners**, click **Expand**.
   1. In the row with the {{ GLR }} you need, click ![icon](../../_assets/console-icons/pencil.svg) and enable the following options:

      * **Protected**: {{ GLR }} will only work with the protected branches.
      * **Lock to current projects**: {{ GLR }} will only work with the current projects.

   1. Click **Save changes**.

   For more information about {{ GLR }} settings, see the [{{ GL }} documentation]({{ gl.docs }}/ee/ci/runners/configure_runners.html).

   {% endcut %}

## Configure the CI script {#ci}

1. Create a branch for the CI script. [Enable its protection]({{ gl.docs }}/ee/user/project/protected_branches.html#for-one-project) at the project level.
1. Switch locally to the branch you created.
1. In the repository root, create a file named `.gitlab-ci.yml` and paste to it the CI script to output the {{ lockbox-name }} secret value:

   ```yaml
   stages:
     - build
   build:
     stage: build
     script:
       - >
         export IAM_TOKEN_JSON=`curl -s -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token`
       - export TOKEN=`echo $IAM_TOKEN_JSON | jq -rMc '.access_token'`
       - >
         curl -s -H "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload
       - >
         export SECRET_JSON=`curl -s -H "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload`
       - export VALUE_OF_MY_SECRET=`echo $SECRET_JSON | jq -rMc '.entries[] | select(.key | contains("MY_SECRET")) | .textValue'`
       - echo $VALUE_OF_MY_SECRET
   ```

1. Create a commit and send it to the remote repository named `origin`:

   ```bash
   git add . && git commit -m "Added .gitlab-ci.yml" && git push
   ```

This will run a build that will write the {{ lockbox-name }} secret value to the `VALUE_OF_MY_SECRET` environment variable.

## Check the result {#check-result}

1. In {{ GL }} left-hand menu, navigate to **Build** → **Pipelines**.
1. Make sure the build's status is **Passed**. This means that the build was successful.

## Fix potential vulnerabilities {#eliminate-vulnerabilities}

1. [Enable and configure](../../managed-gitlab/operations/approval-rules.md) code review rules in the branch for the CI script.

   Thus attackers will not be able to learn the variable using such commands as `env`, `printenv`, or `echo`. The information security will be able to track changes in the branch.

1. [Configure a security group](../../vpc/operations/security-group-add-rule.md) for a VM with {{ GLR }}. In this security group, ban the incoming traffic allowing connections to the VM from outside.


   If the attacker connects to a VM with {{ GLR }} and knows the {{ lockbox-name }} secret ID, they will be able to access the secret.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [ {{ GL }} instance](../../managed-gitlab/operations/instance/instance-delete.md)
* [{{ lockbox-name }} secret](../../lockbox/operations/secret-delete.md)
* [VM with {{ GLR }}](../../compute/operations/vm-control/vm-delete.md)
* [Service account](../../iam/operations/sa/delete.md)
