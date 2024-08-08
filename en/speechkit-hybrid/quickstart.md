---
title: "How to create a {{ sk-hybrid-name }} demo stand"
description: "Using this guide, you can create applications for speech recognition and synthesis, as well as load testing utilities."
---

# Creating a {{ sk-hybrid-name }} demo stand

{{ sk-hybrid-name }} enables {{ speechkit-full-name }} speech [recognition](stt/testing.md) and [synthesis](tts/testing.md). You can deploy your {{ sk-hybrid-name }} demo stand using {{ yandex-cloud }} services through {{ TF }}. This way, you can test recognition and synthesis applications hosted in Docker containers.

Creating a demo stand involves using two machines:

* Local one (in our example, it is Linux-based).
* Virtual one that meets the {{ sk-hybrid-name }} [system requirements](system-requirements.md). This VM runs Docker containers.

Our demo stand uses the [Cloud Billing](pricing.md#billing) licensing model; this means the info on each request to {{ sk-hybrid-name }} is [sent](architecture.md) to {{ billing-name }}.

To deploy your {{ sk-hybrid-name }} demo stand:

1. [{#T}](#get-started).
1. [{#T}](#prepare).
1. [{#T}](#ssh).
1. [{#T}](#variables).
1. [{#T}](#create-infrastructure).
1. [{#T}](#communication-channel).
1. [{#T}](#stt-and-tts).

In case of errors, use our [debugging guide](quickstart-debugging.md).

## Get started with {{ yandex-cloud }} {#get-started}

1. Sign up for {{ yandex-cloud }}. Signing up is different for individuals and legal entities:

   * [How to sign up as an individual](../getting-started/individuals/registration.md)
   * [How to sign up as a business](../getting-started/legal-entity/registration.md)

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }}.
1. Create a directory in the management console. It will contain your resources:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Create](../iam/operations/sa/create.md) the `sk-hybrid-example` service account.

   The service account allows you to flexibly configure access permissions. For more information about the service account, see [{#T}](../iam/concepts/users/service-accounts.md).

1. [Assign the following roles to the service account](../iam/operations/sa/assign-role-for-sa.md):

   * `compute.editor`: To create the {{ yandex-cloud }} VM.
   * `container-registry.images.puller`: To work with Docker images in the [{{ container-registry-full-name }}](../container-registry/index.yaml) registry.
   * `iam.serviceAccounts.keyAdmin`: To create an [API key](../iam/concepts/authorization/api-key.md) for authorization in {{ billing-name }}.

1. [Create an API key.](../iam/operations/api-key/create.md)

   Save the ID and the secret part of the key. You cannot request them later.

1. [Create a registry](../container-registry/operations/registry/registry-create.md) in {{ container-registry-name }}.
1. Provide the registry ID to the [{{ speechkit-name }} team]({{ link-console-support }}). The required containers and images will appear in your registry.

## Install additional dependencies {#prepare}

On a local machine:

1. [Install the {{ yandex-cloud }} command line interface](../cli/operations/install-cli.md) (YC CLI).
1. [Authenticate your service account](../cli/operations/authentication/service-account.md) via the YC CLI.
1. [Install {{ TF }}](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Prepare a repository with the {{ TF }} configuration {#repository}

On a local machine:

1. Clone the [repository with the {{ TF }} configuration](https://github.com/yandex-cloud-examples/yc-speechkit-hybrid-deployment/) from which the required infrastructure will be deployed:

   ```bash
   git clone git@github.com:yandex-cloud-examples/yc-speechkit-hybrid-deployment.git
   ```

1. In the terminal, go to the cloned repository directory.

## Prepare the SSH keys {#ssh}

You will need the SSH keys for authentication when connecting to the {{ yandex-cloud }} VM. To prepare them, perform the following steps on the local machine:

1. If you do not have a pair containing a public and private SSH key, create one:

   ```bash
   ssh-keygen -t rsa -f $HOME/.ssh/speechkit_hybrid
   ```

   After running this command, you will be prompted to enter the password for the private key. If you do not want to provide a password, click **Enter**.

1. In the directory of the cloned repository, create a symbolic link that points to the public SSH key:

   ```bash
   ln -s ~/.ssh/<key_name>.pub ./keys/ssh-user-id-rsa.pub
   ```

   This command provides the following:

   * `~/.ssh/<key_name>.pub`: File with a public SSH key. If you created the key in the previous step, specify `~/.ssh/speechkit_hybrid.pub`.
   * `./keys/ssh-user-id-rsa.pub`: Symbolic link. The path is relative to the current repository directory.

## Add variables for the {{ TF }} configuration {#variables}

The `terraform.tfvars.template` file is located in the `yc-speechkit-hybrid-deployment` repository directory. It is a {{ TF }} template by which environment variables are set. These variables are provided to the YC CLI and {{ TF }} when running commands.

To set variables for the {{ TF }} configuration, perform the following steps on the local machine:

1. Create a copy of the {{ TF }} template in the `yc-speechkit-hybrid-deployment` repository directory:

   ```bash
   cp ./terraform.tfvars.template ./terraform.tfvars
   ```

1. Specify the variable values in the `terraform.tfvars` file:

   * `CR_REGISTRY_ID`: {{ container-registry-name }} registry ID
   * `BILLING_STATIC_API_KEY`: Secret part of the API key

1. Optionally, add the `NODES_GPU_INTERRUPTIBLE = false` variable.

   The {{ TF }} configuration in the repository assumes creating an [interruptible VM](../compute/concepts/preemptible-vm.md). You can disable interrupting using the `NODES_GPU_INTERRUPTIBLE` variable. Its default value is `true`, and it is specified in the `variables.tf` file in the `yc-speechkit-hybrid-deployment` repository.

## Create an infrastructure using {{ TF }} {#create-infrastructure}

The infrastructure required to work with {{ sk-hybrid-name }} is described in the `networks.tf` and `node-deploy.tf` files in the `yc-speechkit-hybrid-deployment` repository. The `networks.tf` file contains the configuration of the following entities:

* Network
* Subnet
* Internal DNS zone
* Security group

The `node-deploy.tf` file contains the VM and {{ sk-hybrid-name }} configuration.

Read more about entity configuration on the [{{ TF }}]({{ tf-provider-link }}) website and in the relevant {{ yandex-cloud }} service documentation.

To create the infrastructure, perform the following steps on the local machine:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   1. In the terminal, go to the `yc-speechkit-hybrid-deployment` repository directory.
   1. [Get](../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) the `sk-hybrid-example` service account authentication details. You can add the data to environment variables or specify this data in the `main.tf` file, in the `provider "yandex"` section.
   1. [Configure and initialize the {{ TF }} providers](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

      The repository uses the `main.tf` file as a configuration file with provider settings, so there is no need to recreate such a file.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

   1. Create an infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up a permanent communication channel with the {{ yandex-cloud }} server {#communication-channel}

To work according to the Cloud Billing licensing model, ensure network connectivity between the {{ billing-name }} `billing.datasphere.yandexcloud.net:443` node and the VM on which the {{ sk-hybrid-name }} service is deployed. To check the node for availability:

1. On the local machine, get the public IP address of the created VM:

   ```bash
   {{ yc-compute-instance }} list
   ```

   The public address will be needed to connect to the VM.

   Result example:

   ```text
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   |     ID    |              NAME             |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP  |
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   | fhmjvr*** | sk-hybrid-compose-example-*** | {{ region-id }}-a | RUNNING | 158.160.*** | 192.168.***  |
   | ...                                                                                              |
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   ```

   The public address is specified in the `EXTERNAL IP` field.

1. [Connect to the VM over SSH](../compute/operations/vm-connect/ssh.md#vm-connect):

   ```bash
   ssh <username>@<VM_public_IP_address>
   ```

   Where `<username>` is the VM account username.

1. Run this command:

   ```bash
   nc -vz billing.datasphere.yandexcloud.net 443
   ```

   If the node is available over the network, the command will return the following result:

   ```text
   Connection to billing.datasphere.yandexcloud.net 443 port [tcp/https] succeeded!
   ```

## Perform load testing for speech recognition and synthesis {#stt-and-tts}

To check whether the {{ sk-hybrid-name }} test installation is valid and its performance is fine, use Docker containers with the load testing utility for speech recognition and synthesis. These containers are described in the `node-deploy.tf` file, they were created along with the [infrastructure](#create-infrastructure).

To perform load testing:

1. Connect to the VM over SSH.
1. Make sure ports `8080` and `9080` are open to receive client requests:

   ```bash
   telnet <VM_public_address> 8080 && telnet <VM_public_address> 9080
   ```

1. Run speech recognition:

   ```bash
   docker run --rm --name stt-tools \
      --env ENVOY_HOST=<VM_public_address> \
      --env ENVOY_PORT=8080 \
      --env CONNECTIONS=40 \
      {{ registry }}/<registry_ID>/release/tools/stt-tools:0.20
   ```

   In the command, specify the public IP address of the VM and the ID of the previously created {{ container-registry-name }} registry.

   Where:

   * `ENVOY_HOST`: IP address of the recognition service.
   * `ENVOY_PORT`: Port of the recognition service (`8080` by default).
   * `CONNECTIONS`: Number of simultaneously active channels.

1. Run speech synthesis:

   ```bash
   docker run --rm --name tts-tools \
      --network=host \
      --env ENVOY_HOST=<VM_public_address> \
      --env ENVOY_TTS_PORT=9080 \
      --env RPS=20 \
      {{ registry }}/<registry_ID>/release/tools/tts-tools:0.20
   ```

   In the command, specify the public IP address of the VM and the ID of the previously created {{ container-registry-name }} registry.

   Where:

   * `ENVOY_HOST`: IP address of the speech synthesis service.
   * `ENVOY_TTS_PORT`: Port of the speech synthesis service (`9080` by default).
   * `RPS`: Number of speech synthesis requests per second.

1. Wait a few minutes while speech recognition and synthesis are performed.
1. Look at the test results in the container logs:

   * `docker logs stt-tools`: For speech recognition.
   * `docker logs tts-tools`: For speech synthesis.

   Until the `Load finished. Ready to serve requests on 0.0.0.0:17001` line appears in the logs, the speech recognition and synthesis services will not respond to requests. This may take from 2 to 10 minutes.

   Next, the logs will show a message that the [Envoy](architecture.md) component has started listening to port `8080` for speech recognition and port `9080` for speech synthesis. This means {{ sk-hybrid-name }} is running and ready to serve client requests.

1. Optionally, stop load testing.

   During load testing, the `docker run` commands will not respond to the **Ctrl** + **C** interrupt signals. If you want to stop the containers from running, run the following command:

   * `docker stop stt-tools`: For speech recognition.
   * `docker stop tts-tools`: For speech synthesis.
