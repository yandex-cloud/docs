# Installing {{ GLR }} on a {{ compute-full-name }} VM

You can install {{ GLR }} on a {{ compute-name }} [VM](../../compute/concepts/vm.md). As a result, you will not need a more expensive and hard to configure [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) to install {{ GLR }}.

To install {{ GLR }} on a {{ compute-name }} VM:

1. [{#T}](#infra).
1. [{#T}](#gitlab-token).
1. [{#T}](#install).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#infra}

1. [Create and activate](../../managed-gitlab/operations/instance/instance-create.md) a {{ mgl-name }} instance.
1. [Create a {{ GL }} project]({{ gl.docs }}/ee/user/project/).
1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a public Ubuntu 22.04 LTS image.

## Get a {{ GLR }} token {#gitlab-token}

1. Open the {{ GL }} project in your browser.
1. In the left-hand menu, go **Settings** → **CI/CD**.
1. Under **Runners**, click **Expand**.
1. Next to **New Project Runner**, click ![icon](../../_assets/dots.svg) and copy the contents of the **Registration token** field.

## Install {{ GLR }} {#install}

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
   Runner registered successfully. Feel free to start it, but if it is running already the config should be automatically reloaded!

   Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [{{ GL }} instance](../../managed-gitlab/operations/instance/instance-delete.md)
* [VM with {{ GLR }}](../../compute/operations/vm-control/vm-delete.md)
* [Service account](../../iam/operations/sa/delete.md)
