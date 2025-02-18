---
title: Getting started with the {{ yandex-cloud }} SDK
description: Explore the features of the {{ yandex-cloud }} SDK
sourcePath: en/sdk/sdk/quickstart.md
---

# Getting started with the {{ yandex-cloud }} SDK

[{{ yandex-cloud }} SDK](./overview.md) is a set of development tools for interfacing with cloud infrastructure.

To illustrate some of the SDK features, we will walk you through creating a {{ compute-full-name }} [VM](../../compute/concepts/vm.md) step by step.

To get started with the {{ yandex-cloud }} SDK:
1. [Get your cloud ready](#before-begin).
    1. [Create a service account](#create-sa).
    1. [Prepare the {{ yandex-cloud }} CLI](#prepare-cli).
    1. [Get the source data](#get-source-data).
1. [Configure the environment](#prepare-project).
1. [Create a configuration file](#create-config).
1. [Prepare the script code](#prepare-code).
1. [Run the script to create a VM](#run-code).

If you no longer need the resources you created, [delete them](#clear-out).

See also [SDK use cases](#examples).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of supporting a VM created with the SDK includes:
* Fee for VM computing resources (see [{{ compute-full-name }}](../../compute/pricing.md#prices-instance-resources) pricing).
* Fee for VM disks (see [{{ compute-full-name }}](../../compute/pricing.md#prices-storage) pricing).
* Fee for using a dynamic external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).

### Create a service account {#create-sa}

1. [Create](../../iam/operations/sa/create.md) a service account.
1. [Assign](../../organization/operations/add-role.md) [roles](../../iam/concepts/access-control/roles.md) to the service account based on the services you want to manage with the {{ yandex-cloud }} SDK.

    In this tutorial, you will need the [compute.admin](../../compute/security/index.md#compute-admin) role to create a VM.

### Prepare the {{ yandex-cloud }} CLI {#prepare-cli}

1. [Install](../../cli/operations/install-cli.md) the {{ yandex-cloud }} CLI.
1. [Authenticate](../../cli/operations/authentication/service-account) in the {{ yandex-cloud }} CLI as a service account.

    Using the {{ yandex-cloud }} CLI, you will get an [IAM token](../../iam/concepts/authorization/iam-token.md) to authenticate your service account in {{ yandex-cloud }}. This method is more secure than storing authentication data in code or a separate file.

### Get the source data {#get-source-data}

1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder within which to work with services using the {{ yandex-cloud }} SDK.
1. [Select](../../compute/operations/images-with-pre-installed-software/get-list.md) a suitable image for your VM. Save the [image family](../../compute/concepts/image.md#family) ID, e.g., `ubuntu-2204-lts`.
1. [Create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a pair of SSH keys to [connect to your VM](../../compute/operations/vm-connect/ssh.md). 

## Prepare your working directory {#prepare-project}

{% list tabs group=instructions %}

- Node.js {#nodejs}

    1. In the terminal, check the Node.js version using this command: 

        ```bash
        node -v
        ```

        The {{ yandex-cloud }} SDK supports Node.js version 12 and higher. If Node.js is not installed or you need a newer version, select the appropriate installation option from the [Node.js website](https://nodejs.org/en/download/package-manager).
    1. Clone the [repository containing the {{ yandex-cloud }} SDK examples for Node.js](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-node-js.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-node-js.git
        ```

    1. {% include [change-directory](../../_includes/sdk/compute/create-instance/change-directory.md) %}

        ```bash
        cd yc-sdk-quickstart-node-js && npm i
        ```

- Go {#go}

    1. In the terminal, check the Go version using this command: 

        ```bash
        go version
        ```

        If Go is not installed, select the appropriate installation option from the [Go website](https://go.dev/doc/install).
    1. Clone the [repository containing the {{ yandex-cloud }} SDK examples for Go](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-go.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-go.git
        ```

    1. {% include [change-directory](../../_includes/sdk/compute/create-instance/change-directory.md) %}

        ```bash
        cd yc-sdk-quickstart-go && go tidy
        ```
    
- Python {#python}

    1. In the terminal, check the Python version using this command for Linux and macOS: 

        ```bash
        python3 --version
        ```

        or Windows:

        ```bash
        python --version
        ```
        
        If Python is not installed, select the appropriate installation option from the [Python website](https://www.python.org/downloads).
    1. Clone the [repository containing the {{ yandex-cloud }} SDK examples for Python](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-python.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-python.git
        ```

    1. {% include [change-directory](../../_includes/sdk/compute/create-instance/change-directory.md) %}

        ```bash
        cd yc-sdk-quickstart-python && pip install yandexcloud
        ```

- Java {#java}

    1. In the terminal, check the Java version using this command: 

        ```bash
        java --version
        ```

        If Java is not installed, select the appropriate installation option from the [Oracle website](https://www.oracle.com/java/technologies/downloads/).
    1. Additionally, install [Apache Maven](https://maven.apache.org/install.html) to build your project.
    1. Clone the [repository containing the {{ yandex-cloud }} SDK examples for Java](https://github.com/yandex-cloud-examples/yc-sdk-quickstart-java.git):

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-sdk-quickstart-java.git
        ```

    1. Got to your cloned repository:

        ```bash
        cd yc-sdk-quickstart-java
        ```


{% endlist %}

## Set up a configuration file {#create-config}

{% list tabs group=instructions %}

- Node.js {#nodejs}

    {% include [open-and-set-config](../../_includes/sdk/compute/create-instance/open-and-set-config.md) %}

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

- Go {#go}

    {% include [open-and-set-config](../../_includes/sdk/compute/create-instance/open-and-set-config.md) %}

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

- Python {#python}

    {% include [open-and-set-config](../../_includes/sdk/compute/create-instance/open-and-set-config.md) %}

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}

- Java {#java}

    Open the `config.json` file in the `src/main/resources/config` directory. It already has a basic VM configuration installed, and you need to specify `folder_id` and `subnet_id`. You can also set your custom parameters for other fields:

    {% include [instance-json-config](../../_includes/sdk/compute/basic-instance-config-json.md) %}


{% endlist %}

## Run the script to create a VM {#run-code}

The project is already configured to create a VM with console commands. See comments in the code to learn more about the steps involved in creating a VM.

{% list tabs group=instructions %}

- Node.js {#nodejs}

    Run the `index.js` file using this command:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    node index.js   
    ```

    {% include [running-process-description](../../_includes/sdk/compute/create-instance/run-code-part.md) %}

- Go {#go}

    Run the `main.go` file using this command:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    go run main.go
    ```

    {% include [running-process-description](../../_includes/sdk/compute/create-instance/run-code-part.md) %}

- Python {#python}

    Run the `script.py` file using this command:

    ```bash
    IAM_TOKEN=$(yc iam create-token) \
    SSH_PUBLIC_KEY_PATH=./key.pub \
    python script.py
    ```

    {% include [running-process-description](../../_includes/sdk/compute/create-instance/env-vars-descr.md) %}

    The script runs in stages:

    * **Running the script to create a VM**. If the script finds no data format errors, you will see the following message:
    
      ```text
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, compute compute.api.cloud.yandex.net:443
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, compute compute.api.cloud.yandex.net:443
      INFO:root:Creating initiated
      ```

    * **Sending data to the server for validation**. If all data is correct, you will see the following message:

      ```text
      INFO:root:Running Yandex.Cloud operation. ID: fv45g3nfq0bn********. Description: Create instance. Created at: 2024-12-19 15:52:59. Created by: ajeutahec4**********. Meta: instance_id: "fv4bi87d50**********".
      INFO:yandexcloud._channels:Using endpoints from configuration, IAM iam.api.cloud.yandex.net:443, operation operation.api.cloud.yandex.net:443
      ```

      {% include [what-is-op-id](../../_includes/sdk/compute/operation-id.md) %}
      
      {% include [info-by-op-id](../../_includes/sdk/compute/get-info-by-op-id.md) %}
    
    * **Operation result**. After creating a VM, you will get its details:

      ```text
      INFO:root:Done Yandex.Cloud operation. ID: fv45g3nfq0bn********. Response: id: "fv42jgaq946dm8ibkjl6"
      folder_id: "b1g5hnqtug**********"
      created_at {
          seconds: 1734614895
      }
      name: "computer"
      zone_id: "ru-central1-d"
      platform_id: "standard-v3"
      resources {
          memory: 2147483648
          cores: 2
          core_fraction: 100
      }
      status: RUNNING
      metadata_options {
          gce_http_endpoint: ENABLED
          aws_v1_http_endpoint: ENABLED
          gce_http_token: ENABLED
          aws_v1_http_token: DISABLED
      }
      boot_disk {
          mode: READ_WRITE
          device_name: "fv4sd8kkspslntd0dpvn"
          auto_delete: true
          disk_id: "fv4sd8kkspslntd0dpvn"
      }
      network_interfaces {
          index: "0"
          mac_address: "d0:0d:29:c1:5a:49"
          subnet_id: "fl8b5ou7m8sihjbftcfk"
          primary_v4_address {
              address: "192.168.0.3"
              one_to_one_nat {
              address: "51.250.34.207"
              ip_version: IPV4
              }
          }
      }
      serial_port_settings {
          ssh_authorization: OS_LOGIN
      }
      gpu_settings {}
      fqdn: "fv42jgaq946dm8ibkjl6.auto.internal"
      scheduling_policy {}
      network_settings {
          type: STANDARD
      }
      placement_policy {}
      hardware_generation {
          legacy_features {
              pci_topology: PCI_TOPOLOGY_V1
          }
      }.
      WARNING: All log messages before absl::InitializeLog() is called are written to STDERR
      E0000 00:00:1734614936.026768 4332467 init.cc:229] grpc_wait_for_shutdown_with_timeout() timed out.
      ```

- Java {#java}

    1. Build your project using this command:

        ```bash
        mvn clean package
        ```
    
    1. In the root directory of the project, run the code using this command:

        ```bash
        IAM_TOKEN=$(yc iam create-token) \
        SSH_PUBLIC_KEY_PATH=key.pub \
        java -jar target/java-sdk-examples-2.6.4-jar-with-dependencies.jar  
        ```

        {% include [running-process-description](../../_includes/sdk/compute/create-instance/run-code-part.md) %}


{% endlist %}

{% include [check-by-label](../../_includes/sdk/compute/check-by-label.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) your VM from {{ compute-name }}.
 
# Examples of working with the SDK {#examples}

* [Node.js](https://github.com/yandex-cloud/nodejs-sdk/tree/master/examples)
* [Go](https://github.com/yandex-cloud/go-sdk/tree/master/examples)
* [Python](https://github.com/yandex-cloud/python-sdk/tree/master/examples)
* [Java](https://github.com/yandex-cloud/java-sdk/tree/master/java-sdk-examples)
* [.NET](https://github.com/yandex-cloud/dotnet-sdk/tree/master/Example)

## See also {#see-also}

[{#T}](../../compute/operations/vm-connect/ssh.md)