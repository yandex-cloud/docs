# Secure storage of {{ GL }} CI passwords as {{ lockbox-full-name }} secrets

You can securely store passwords as [{{ lockbox-full-name }} secrets](../../lockbox/concepts/secret.md) and use them in your CI pipelines in {{ mgl-full-name }}. Thus you can protect and hide passwords in CI script from {{ GL }} users, including administrators.

Below is how the integration with {{ lockbox-name }} works. First, you need to create a {{ lockbox-name }} secret and a {{ GL }} environment variable that points to this secret. You also need to install {{ GLR }} on a VM and assign a service account to it. Then, create the CI script provided below. It contains a special command that requests the service account's IAM token. The script uses the IAM token and the environment variable to retrieve the password from the secret. This way, the password is used in the CI script but kept in an external storage.

To enable a {{ mgl-name }} instance to access {{ lockbox-name }} secrets:

1. [Set up your infrastructure](#infra).
1. [Configure the CI pipeline](#ci).
1. [Check the result](#check-result).
1. [Fix potential vulnerabilities](#eliminate-vulnerabilities).

If you no longer need the resources you created, [delete them](#clear-out).

## Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for [disks](../../compute/concepts/disk.md) and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing the secret and requests to the secret (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).
* Fee for a [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Set up your infrastructure {#infra}

1. [Create and activate](../../managed-gitlab/operations/instance/instance-create.md) a {{ mgl-name }} instance.
1. [Create a {{ GL }} project]({{ gl.docs }}/ee/user/project/).
1. [Create](../../lockbox/operations/secret-create.md) a {{ lockbox-name }} secret named `MY_SECRET`.
1. [Create a service account](../../iam/operations/sa/create.md) with the `{{ roles-lockbox-payloadviewer }}` role.

   This role has no permissions to get the list of secrets; therefore, without the secret ID, an attacker cannot retrieve the password from the secret.

1. [Create]({{ gl.docs }}/ee/ci/variables/#for-a-project) a {{ GL }} environment variable for your project. Configure it as follows:

   * **Key**: `MY_SECRET`.
   * **Value**: ID of the {{ lockbox-name }} secret you created.
   * **Mask variable**: Enabled.

      To protect your passwords from attackers, mask the variable. This way, only users with the `Maintainer` or `Owner` roles in your {{ GL }} project will be able to see the variable value, i.e., the {{ lockbox-name }} secret ID . If connected to a virtual machine with {{ GLR }}, an attacker will not be able to retrieve the password from a secret without knowing the secret ID.

1. [Install {{ GLR }}](../../managed-gitlab/tutorials/install-gitlab-runner.md) on a separate {{ compute-full-name }} VM. When creating a VM, specify the service account you previously created.

   In {{ GLR }} settings, make it only available for [protected branches]({{ gl.docs }}/ee/user/project/protected_branches.html) and specific projects (**Protected** and **Lock to current projects**). If you do not provide these settings, CI scripts with passwords can be run in projects that are not monitored by the information security team. Thus, your passwords could be compromised.

   {% cut "Configuring {{ GLR }}" %}

   1. Open the {{ GL }} project in your browser.
   1. In the left-hand menu, go to **Settings** → **CI/CD**.
   1. Under **Runners**, click **Expand**.
   1. Next to the {{ GLR }} you need, click ![icon](../../_assets/console-icons/pencil.svg) and enable the following options:

      * **Protected**: {{ GLR }} will only work with the protected branches.
      * **Lock to current projects**: {{ GLR }} will only work with the current projects.

   1. Click **Save changes**.

   You can learn more about {{ GLR }} settings in [this {{ GL }} guide]({{ gl.docs }}/ee/ci/runners/configure_runners.html).

   {% endcut %}

## Configure the CI pipeline {#ci}

1. Create a branch for the CI pipeline. [Enable its protection]({{ gl.docs }}/ee/user/project/protected_branches.html#for-one-project) at the project level.
1. Switch locally to the branch you created.
1. In the repository root, create a file named `.gitlab-ci.yml` with the following CI script to output the {{ lockbox-name }} secret value:

   ```yaml
   stages:
     - build
   build:
     stage: build
     script:
       - >
         export IAM_TOKEN_JSON=`curl --silent --header "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token`
       - export TOKEN=`echo $IAM_TOKEN_JSON | jq -rMc '.access_token'`
       - >
         curl --silent -header "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload
       - >
         export SECRET_JSON=`curl --silent --header "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload`
       - export VALUE_OF_MY_SECRET=`echo $SECRET_JSON | jq -rMc '.entries[] | select(.key | contains("MY_SECRET")) | .textValue'`
       - echo $VALUE_OF_MY_SECRET
   ```

1. Create a commit and push it to the remote repository named `origin`:

   ```bash
   git add . && git commit -m "Added .gitlab-ci.yml" && git push
   ```

This will run a build that will write the {{ lockbox-name }} secret value to the `VALUE_OF_MY_SECRET` environment variable.

## Check the result {#check-result}

1. In {{ GL }} left-hand menu, navigate to **Build** → **Pipelines**.
1. Make sure the build status is **Passed**. This means that the build was successful.

## Fix potential vulnerabilities {#eliminate-vulnerabilities}

1. [Enable and configure](../../managed-gitlab/operations/approval-rules.md) approval rules for the CI pipeline branch.

   This will prevent attackers from getting the variable value using such commands as `env`, `printenv`, or `echo`. The information security team will be able to track changes in the branch.

1. [Set up a security group](../../vpc/operations/security-group-add-rule.md) for your VM with {{ GLR }}. In this security group, disable incoming traffic that allows external access to the VM.

   
   If an attacker connects to a VM with {{ GLR }} and knows the {{ lockbox-name }} secret ID, they can access the secret.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [{{ GL }} instance](../../managed-gitlab/operations/instance/instance-delete.md)
* [{{ lockbox-name }} secret](../../lockbox/operations/secret-delete.md)
* [VM with {{ GLR }}](../../compute/operations/vm-control/vm-delete.md)
* [Service account](../../iam/operations/sa/delete.md)
