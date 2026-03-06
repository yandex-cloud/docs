# Deploying {{ GLR }} on a {{ compute-full-name }} virtual machine

[{{ GLR }}](https://docs.gitlab.com/runner/) is an open-source application which executes {{ GL }} CI/CD pipeline jobs based on instructions from a special file named `.gitlab-ci.yml`. You can deploy {{ GLR }} not only in a [{{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) cluster but also on a {{ compute-name }} virtual machine, which is an easier and cheaper option.

For a custom (self-managed) {{ GL }} installation, you can manually install {{ GLR }} on a {{ compute-name }} [VM](../../compute/concepts/vm.md).

For {{ mgl-full-name }}, you can also manually install {{ GLR }} or automatically deploy a [runner](../../managed-gitlab/concepts/index.md#runners) in the [management console]({{ link-console-main }}) that will ensure the correct number of workers run in {{ compute-name }}.

{% include [gl-runners-preview](../../_includes/managed-gitlab/gl-runners-preview.md) %}

To get started with {{ GLR }} using {{ compute-name }}:

1. [Set up your infrastructure](#infra).
1. [Get a {{ GLR }} token](#gitlab-token).
1. [Deploy {{ GLR }}](#deploy-glr).
1. [Create a test scenario](#example).

If you no longer need the resources you created, [delete them](#clear-out).

## Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for [disks](../../compute/concepts/disk.md) and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Set up your infrastructure {#infra}

1. [Create and activate](../../managed-gitlab/operations/instance/instance-create.md) a {{ mgl-name }} instance.
1. [Create a {{ GL }}]({{ gl.docs }}/ee/user/project/) project.

## Get a {{ GLR }} token {#gitlab-token}

You can get a token when creating a {{ GLR }} in {{ GL }}. You specify this token when [deploying {{ GLR }}](#deploy-glr) on a {{ compute-name }} VM to have a runner authenticated in {{ GL }}.

{% include [get-token](../../_includes/managed-gitlab/get-token.md) %}

## Deploy {{ GLR }} {#deploy-glr}

You can [install {{ GLR }} manually](#install) or [deploy a runner in the management console automatically](#create-runner).

### Install {{ GLR }} on a VM manually {#install}

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a public Ubuntu 22.04 LTS image.

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH:

   ```bash
   ssh <login>@<VM_public_IP_address>
   ```

1. Install the git and jq utilities:

   ```bash
   sudo apt-get --yes install git jq
   ```

1. Add a repository with {{ GLR }} to the package manager:

   ```bash
   curl --location https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   ```

1. Install {{ GLR }}:

   ```bash
   sudo apt-get -y install gitlab-runner
   ```

1. Register {{ GLR }}:

   ```bash
   sudo gitlab-runner register
   ```

   The command will prompt you for additional data:

   * URL of the {{ GL }} instance in `https://<domain>/` format.
   * [Previously obtained](#gitlab-token) {{ GLR }} token.
   * {{ GLR }} description.
   * Do not specify {{ GLR }} tags and the update settings (`maintenance note`).
   * `executor`: `shell`.

   Result:

   ```text
   Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

   Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
   ```

### Create a runner using the management console {#create-runner}

{% include [gl-runners-preview](../../_includes/managed-gitlab/gl-runners-preview.md) %}

{% include [note-payment](../../_includes/managed-gitlab/note-payment.md) %}

The feature of creating runners from the management console is only available for {{ mgl-name }} instances.

{% include [runner-create](../../_includes/managed-gitlab/runner-create-console.md) %}

#### Test the runner {#view-runner}

{% list tabs %}

- In {{ GL }}

    * If {{ GLR }} was created for the whole {{ GL }} instance:
        1. In the bottom-left corner, click **Admin**.
        1. In the left-hand menu, select **CI/CD** → **Runners**.
        1. Make sure the new runner is now in the list.

    * If {{ GLR }} was created for a project:
        1. Open your project.
        1. In the left-hand menu, select **Settings** → **CI/CD**.
        1. Under **Runners**, click **Expand**.
        1. Make sure the new runner has appeared in the **Assigned project runners** section.

- In {{ compute-name }}

    Make sure the new VMs with the `runner-` name prefix have appeared in the **{{ ui-key.yacloud.compute.instances.label_title }}** section.

{% endlist %}

## Create a test scenario {#example} 

1. Open the {{ GL }} project.

1. Select **Build** → **Pipeline editor** in the left-hand menu. A page will open asking you to add a new file named `.gitlab-ci.yml`, in which you need to describe the scenario in [YAML](https://yaml.org/) format.

1. Add the scenario text:

    ```yaml
    build:
    stage: build
    script:
      - echo "Hello, $GITLAB_USER_LOGIN!"

    test:
    stage: test
    script:
      - echo "This job tests something"

    deploy:
    stage: deploy
    script:
      - echo "This job deploys something from the $CI_COMMIT_BRANCH branch."
    environment: production
    ```

1. Click **Commit changes**.

1. Select **Build** → **Jobs** in the left-hand menu.

1. Make sure that three jobs have the `Passed` status.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [{{ GL }} instance](../../managed-gitlab/operations/instance/instance-delete.md)
* [VM with {{ GLR }}](../../compute/operations/vm-control/vm-delete.md)
* [Service account](../../iam/operations/sa/delete.md)

### See also {#see-also}

* [{#T}](../../managed-gitlab/concepts/index.md#managed-runners)
* [{#T}](../../managed-gitlab/operations/runner.md)