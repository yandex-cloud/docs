# Deploying a self-hosted {{ src-name }} worker on a {{ compute-full-name }} VM

[Self-hosted workers]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#self-hosted-workers) are users’ personal servers, both virtual and physical, on which {{ src-name }} [CI/CD processes]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) run. These processes will have access to the user server environment.

Restrictions on the [amount of computing resources]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#cloud-worker-resources) do not apply to self-hosted workers, and they also do not consume the [total CI/CD runtime quota]({{ link-src-docs }}/sourcecraft/concepts/limits#ci-cd-quotas).

If you have a computer with a suitable configuration, you can [set up a self-hosted worker for {{ src-name }}]({{ link-src-docs }}/sourcecraft/operations/self-hosted-worker) all by yourself. Otherwise, you can create a VM in {{ compute-name }} and install a self-hosted worker on it. Even more, you can automate not only the processes of creating a VM, installing, configuring, and starting a self-hosted worker, but also the process of deleting a VM after the CI/CD [workflow]({{ link-src-docs }}/sourcecraft/ci-cd-ref/workflows) is completed. This way you can optimize the use of your {{ compute-name }} resources.

Here we discuss an example of how to implement such automation with the help of {{ src-name }} CI/CD processes using a [service connection]({{ link-src-docs }}/sourcecraft/operations/service-connections).

Self-hosted worker use cases:
* In the same repository the worker was created from. In cases like this, the VM can be automatically deleted as soon as the workflow is completed.

  {% cut "test-task-and-delete-vm-async workflow example" %}

  ```yaml
  test-task-and-delete-vm-async:
    runs_on: self-hosted
    tasks:
      - test-task
      - name: delete
        uses: delete-vm-async
        needs: [test-task]
  ```

  The `test-task` task performs useful work, such as project compilation.

  The `delete` task gets started only after `test-task` (the `needs: [test-task]` parameter) is executed and asynchronously deletes the VM on which the self-hosted worker was run.

  Before executing the `test-task-and-delete-vm-async` workflow, you need to execute the `create-vm` workflow the self-hosted worker will be created in.

  {% note info %}

  You cannot set a precise workflow sequence, so workflows must be [started manually]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) one by one.

  {% endnote %}

  {% endcut %}

* In any other repository of the [organization]({{ link-src-docs }}/sourcecraft/concepts/#org). In this case, you need to delete the VM with the self-hosted worker [manually](#clear-out).

To deploy a self-hosted {{ src-name }} worker on a {{ compute-name }} VM:
1. [Get ready](#prepare).
1. [Deploy the infrastructure](#infra).
1. [Create a repository with a CI/CD configuration](#clone-repo).
1. [Create secrets](#secrets).
1. [Set up a service connection](#service-connection).
1. [Set up a CI/CD process](#configure-ci-cd).
1. [Test the worker](#check-worker).

If you no longer need the resources you created, [delete them](#clear-out).

## Get ready for work {#prepare}

1. {% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}
1. Authenticate in {{ src-name }} on the service [home page]({{ link-src-main }}) or [sign up]({{ link-src-docs }}/sourcecraft/security/registration.md).

### Required paid resources {#paid-resources}

The cost of supporting a self-hosted worker infrastructure includes:
* Fee for a disk and a running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using an external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Deploy the infrastructure {#infra}

1. If you do not already have a network infrastructure in the {{ yandex-cloud }} folder you want to have your self-hosted worker VM in, create a cloud [network](../../vpc/operations/network-create.md), e.g., `default`, and a [subnet](../../vpc/operations/subnet-create.md), e.g., `default-ru-central1-d`.

    {% note info %}

    The example CI/CD configuration discussed here uses a network named `default` and a subnet named `default-ru-central1-d`.

    {% endnote %}

1. In the given example, the default [security group](../../vpc/concepts/security-groups.md) is used for the VM. [Add](../../vpc/operations/security-group-add-rule.md) the following rules to it:

    <br>

    #|
    || **Traffic**
    **direction**
    | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** 
    | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**
    | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**
    | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** /
    **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**
    | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** ||
    || Inbound
    | `Access to VM from`
    `the internet`
    | `0-65535`
    | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
    | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
    | `0.0.0.0/0` ||
    || Outbound
    | `VM access to`
    `the internet`
    | `0-65535`
    | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
    | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
    | `0.0.0.0/0` ||
    |#

1. In the {{ yandex-cloud }} folder you want to have your self-hosted worker VM in, [create](../../iam/operations/sa/create.md) a service account with the `compute.editor` [role](../../compute/security/index.md#compute-editor) for the folder.

    This service account will be used to create VMs in {{ compute-name }} and establish a {{ src-name }} [service connection]({{ link-src-docs }}/sourcecraft/concepts/service-connections).

## Create a repository with a CI/CD configuration {#clone-repo}

{% note tip %}

This example shows how to create a new repository based on a [self-hosted-worker](https://sourcecraft.dev/examples/self-hosted-worker) repository. 

Instead of creating a new repository, you can also [fork]({{ link-src-docs }}/sourcecraft/operations/fork-work#create-fork) it from the `self-hosted-worker` repository.

{% endnote %}

1. [Create]({{ link-src-docs }}/sourcecraft/operations/repo-create#create-empty) a new empty repository in the [organization](../../organization/concepts/organization.md) whose cloud and folder will be used for the self-hosted worker VM.

    On the page that opens, copy the link for access to the new repository formatted as: `https://git@git.sourcecraft.dev/<organization_slug>/<new_repository_slug>.git`.

    {% note info %}

    In the example below, you work with `git` via [HTTPS]({{ link-src-docs }}/sourcecraft/security/pat). You can also use [SSH]({{ link-src-docs }}/sourcecraft/security/ssh).

    {% endnote %}

1. [Clone]({{ link-src-docs }}/sourcecraft/operations/repo-clone) the [self-hosted-worker](https://sourcecraft.dev/examples/self-hosted-worker) repository with an example of a self-hosted worker deployment:

    ```bash
    git clone https://git@git.sourcecraft.dev/examples/self-hosted-worker.git
    cd self-hosted-worker
    ```

    The `self-hosted-worker` repository contains the following files:

    ```text
    ├── .sourcecraft
    │   └── ci.yaml                      # {{ src-name }} CI/CD configuration
    ├── .gitignore
    ├── compute-instance-create.sh       # script for creating a VM
    ├── compute-instance-delete-async.sh # script for deleting a VM in asynchronous mode
    ├── compute-instance-delete.sh       # script for deleting a VM
    ├── metadata.yaml                    # metadata for a VM
    └── README.md
    ```

1. Use the `self-hosted-worker` repository as the basis for your new repository:

    ```bash
    git remote remove origin
    git remote add origin https://git@git.sourcecraft.dev/<organization_slug>/<new_repository_slug>.git
    git branch -M main
    ```

1. Push your changes to the new repository:

    ```bash
    git push -u origin main
    ```

## Create secrets {#secrets}

1. [Get]({{ link-src-docs }}/sourcecraft/security/pat#create) a personal authentication token (PAT) with the [Repository administrator]({{ link-src-docs }}/sourcecraft/security/#src-repositories-admin) `role` and access to the repository you want to be using the self-hosted CI/CD worker in.

    {% note tip %}

    If you want to use the worker for more than just the repository it was created from, specify the appropriate permissions for the personal token.

    {% endnote %}

    The worker uses this token to get authenticated in {{ src-name }}.

1. [Generate SSH keys](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for access to the worker VM.
1. [Create]({{ link-src-docs }}/sourcecraft/operations/secrets#create-secret) the following {{ src-name }} secrets:
    * With the `PAT` name and the token value.
    * With the `SSH_PUB` name and a public SSH key.

## Set up a service connection {#service-connection}

[Service connections]({{ link-src-docs }}/sourcecraft/operations/service-connections) allow you to securely integrate your {{ src-name }} projects with the {{ yandex-cloud }} resources.

[Create]({{ link-src-docs }}/sourcecraft/operations/service-connections#create-service-connection) a service connection named `default-service-connection`, use the [previously created](#infra) service account with the `compute.editor` [role](../../compute/security/index.md#compute-editor) for the folder.

{% note warning %}

The [{{ src-name }} grant]({{ link-src-docs }}/sourcecraft/concepts/grant) you get when creating a service connection in a {{ src-name }} personal organization, does not apply to {{ compute-full-name }} and {{ vpc-full-name }}.

{% endnote %}

## Set up a CI/CD process {#configure-ci-cd}

Set up a CI/CD process to deploy a self-hosted worker.

### Configure basic CI/CD settings {#base-config}

The CI/CD process is [configured]({{ link-src-docs }}/sourcecraft/operations/ci-cd) in the `.sourcecraft/ci.yaml` file. 

The presented [CI/CD configuration]({{ link-src-docs }}/sourcecraft/ci-cd-ref/) consists of the following [workflows]({{ link-src-docs }}/sourcecraft/ci-cd-ref/workflows):
* `create-vm`: Creates a VM with a self-hosted worker.
* `delete-vm`: Deletes a VM with a self-hosted worker.
* `test-task-and-delete-vm-async`: Runs a test task on a self-hosted worker and deletes the VM asynchronously.

{% note info %}

The `create-vm` and `delete-vm` workflows run on standard [{{ src-name }} cloud workers]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#cloud-workers). The `test-task-and-delete-vm-async` process runs on a self-hosted worker.

{% endnote %}

Adjust the CI/CD configuration for your needs or use an existing one.

### Set your VM parameters {#vm-config}

The VM configuration for a self-hosted worker is specified in the `env` variable section in the `.sourcecraft/ci.yaml` file:
* `COMPUTE_INSTANCE_NAME`: VM name and host name, e.g., `self-hosted-worker`.
* `VPC_SUBNET_NAME`: Name of the subnet created earlier the VM will reside in, e.g., `default-ru-central1-d`.
* `CREATE_BOOT_DISK`: [Disk image](../../compute/concepts/image.md) from which the VM will be created, e.g., `image-folder-id=standard-images,image-family=ubuntu-2204-lts` (Ubuntu 22.04 LTS). See also [{#T}](../../compute/operations/images-with-pre-installed-software/get-list.md).
* `PLATFORM`: VM [platform](../../compute/concepts/vm-platforms.md), e.g., `standard-v3`.
* `MEMORY`: Amount of RAM, e.g., `64GB`.
* `CORES`: Number of vCPU cores, e.g., `8`.
* `CORE_FRACTION`: [Guaranteed share](../../compute/concepts/performance-levels.md) of vCPUs, e.g., `100`.
* `PREEMPTIBLE`: Whether or not to use a [preemptible VM](../../compute/concepts/preemptible-vm.md), e.g., `false`.
* `SSH_PUB`: [Previously created](#secrets) secret with the public part of the SSH key in `${{ secrets.<secret_name> }}` format. Set in case you need to connect to a VM with a self-hosted worker.

A VM user with the `builder` login is created within the `metadata.yaml` file.

```yaml
users:
- name: builder
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  shell: /bin/bash
  ssh_authorized_keys:
  - ${SSH_PUB}
```

Adjust the VM configuration for your needs or use an existing one.

### Create a script to install a self-hosted worker and other software on the VM {#script}

To install an executable of a self-hosted worker or other software, e.g., [Docker](https://www.docker.com/), the `metadata.yaml` file is used:

```yaml
  - path: "/usr/local/etc/startup.sh"
    permissions: "755"
    content: |
      #!/bin/bash

      # install self-hosted-processor
      apt-get update
      apt-get install -y musl
      curl \
        --silent \
        --show-error \
        --location \
        https://{{ s3-storage-host }}/src-processor-downloads/self-hosted-processor-latest/linux/amd64/self-hosted-processor \
        --output self-hosted-processor
      chmod +x self-hosted-processor
      mv self-hosted-processor /home/builder/sourcecraft
      chmod 777 -R /home/builder/sourcecraft

      # install docker
      apt install ca-certificates curl software-properties-common apt-transport-https -y
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      apt update
      apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
      usermod -aG docker builder
```

In a newly deployed VM, the `/usr/local/etc/startup.sh` bash script is created and executed, which installs the self-hosted worker executable and Docker.

Adjust the installation script for your needs or use an existing one.

### Configure a self-hosted worker {#worker-config}

The `config.yaml` [worker configuration file]({{ link-src-docs }}/sourcecraft/operations/self-hosted-worker#config-file) is also configured in the `metadata.yaml` file:

```yaml
write_files:
  - path: "/home/builder/sourcecraft/config.yaml"
    permissions: "644"
    content: |
      executor_type: shell
      self_hosted:
        root_dir: /home/builder/sourcecraft/tmp
        max_slots: 3
      logger_type: json
      logger_level: info
      endpoint:
        host: ci.sourcecraft.tech
        port: 443
        ssl_no_verify: false
      auth:
        pat: ${PAT}
```

## Test the worker {#check-worker}

### Create a VM with a self-hosted worker {#create-vm}

[Manually run]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) the `create-vm` workflow.

You can follow the creation process using the [cube]({{ link-src-docs }}/sourcecraft/ci-cd-ref/cubes) logs. If the workflow completes successfully, you can see the new VM in the {{ yandex-cloud }} [management console]({{ link-console-main }}) using the link from the `create-vm` cube log.

### Run a test workflow {#run-test-workflow}

1. [Manually run]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) the `test-task-and-delete-vm-async` workflow.
1. In `test-task`, check the logs of the `test-worker` and `test-docker` cubes:
    * The `test-worker` cube logs should present the results of the `uname -a` and `free -h` commands run directly on the worker.
    * The `test-docker` cube logs should present the version of the {{ yandex-cloud }} CLI that will be run in the Docker container.

After `test-task` is completed, the `delete` (`delete-vm-async`) task will be started, which will attempt to delete the VM in asynchronous mode. You can see the deletion result in the {{ yandex-cloud }} [management console]({{ link-console-main }}) using the link from the `delete-vm` cube log.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [manually run]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) the `delete-vm` workflow or [delete](../../compute/operations/vm-control/vm-delete.md) the self-hosted worker VM in the {{ yandex-cloud }} interface.

Optionally, delete the [network](../../vpc/operations/network-delete.md) and [subnet](../../vpc/operations/subnet-delete.md).

## See also {#see-also}

* [Setting up a self-hosted worker for {{ src-name }}]({{ link-src-docs }}/sourcecraft/operations/self-hosted-worker)
* [{#T}](../../compute/operations/vm-create/create-with-cloud-init-scripts.md)
* [{#T}](../../compute/operations/images-with-pre-installed-software/get-list.md)
* [{#T}](../../compute/concepts/vm-platforms.md)
* [{#T}](../../compute/concepts/performance-levels.md)
