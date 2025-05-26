# Running external agents for load testing


You can use {{ load-testing-full-name }} for service load testing with external agents. 

An _external agent_ is a physical or virtual server with a load testing tool and [load generators](../../load-testing/concepts/load-generator.md), which is hosted outside {{ load-testing-name }}.

An external agent operates just as the {{ load-testing-name }} [agent](../../load-testing/concepts/agent.md) in terms of running a load test and viewing its results. For more information, see [{#T}](../../load-testing/quickstart.md).

You can use an external agent for load testing when:
* The test target includes multiple instances, and the total incoming and outgoing traffic from them does not exceed the [{{ load-testing-name }} agent capacity](../../load-testing/concepts/agent.md#benchmark).
* Requests to the test target require significant computing capacity.
* The information security rules require that the agent resides in its own infrastructure.
* {{ compute-name }} VM computing resources are limited.

To run load testing using an external agent:
1. [Get your cloud ready](#before-you-begin).
1. [Set up your infrastructure](#prepare-infrastructure).
1. [Set up your environment](#configure-environment).
1. [Install the external agent](#install-external-agent).
1. [Run the external agent](#run-external-agent).
1. [Create a test](#run-test).
1. [View the testing results](#see-results).

If you no longer need the connected external agent, [delete it](#clear-out) from {{ load-testing-name }}.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} is free of charge.

## Set up your infrastructure {#prepare-infrastructure}

### Set up a service account {#prepare-service-account}

1. [Create](../../iam/operations/sa/create.md) a service account, e.g., `sa-loadtest`, in the folder where you are going to connect the external agent.
1. [Assign](../../iam/operations/roles/grant.md) the `loadtesting.editor` and `loadtesting.generatorClient` [roles](../../load-testing/security/index.md#roles-list) to the service account.
1. [Create](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) authorized keys for the service account.

    Save public and private keys as a single file by clicking **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

### Create a secret with authorized keys {#create-authorized-key-secret}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to connect the external agent.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.

  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret, e.g., `secret-loadtest`.
  1. Under **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:
      * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter a non-secret ID, e.g., `key-loadtest`.
      * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, upload the file with the public and private authorized keys.
  1. Click **{{ ui-key.yacloud.common.create }}**.

      Save the name and key of the secret.

{% endlist %}

## Set up your environment {#configure-environment}

1. [Install and initialize](../../cli/quickstart.md#install) the {{ yandex-cloud }} CLI.
1. [Install](https://www.docker.com/) and run Docker.
1. Authenticate in {{ container-registry-name }} [as a user](../../container-registry/operations/authentication.md#user) or with a [Docker credential helper](../../container-registry/operations/authentication.md#cred-helper).

    Use the endpoint of the [registry](../../container-registry/concepts/registry.md) with external agent [Docker images](../../container-registry/concepts/docker-image.md): `{{ registry }}/yc/`.

## Install the external agent {#install-external-agent}

1. Pull a Docker image with the external agent by running this command:

    ```bash
    docker pull {{ registry }}/yc/ya-lt-agent:latest
    ```

    Result:

    ```text
    latest: Pulling from yc/ya-lt-agent
    df6635ed1257: Pull complete 
    7a51fa4387ba: Pull complete 
    Digest: sha256:fad262e94a8b4021b13336ae31c738ec1e77eb6a8971528429c67d28********
    Status: Downloaded newer image for {{ registry }}/yc/ya-lt-agent:latest
    {{ registry }}/yc/ya-lt-agent:latest
    ```

1. Download the file with the public and private authorized keys from {{ lockbox-short-name }}:

    ```bash
    yc lockbox payload get <secret_name> \
      --key <secret_key> \
      > <file_name>
    ```

    Where:
    * `<secret_name>`: Name of the secret with the authorized keys, e.g., `secret-loadtest`.
    * `<secret_key>`: Non-secret ID of the secret with the authorized keys, e.g., `key-loadtest`.
    * `<file_name>`: Name of the file the authorized keys are saved to, e.g., `secret-key.json`.

    {% note warning %}

    In Windows, use **CMD** to run the above command. If you use **PowerShell**, the file will have incorrect encoding. Make sure the encoding of the downloaded file is `UTF-8`.
    
    {% endnote %}
    
1. Create a configuration file for the external agent, e.g., `config.yaml`, and paste the following parameters into it:

    ```text
    client_workdir: '/var/lib/tank_agent/client'
    tankapi_host: localhost
    tankapi_port: 8083
    load_testing_host: 'loadtesting.{{ api-host }}'
    load_testing_port: '443'
    logging_host: 'ingester.logging.yandexcloud.net'
    logging_port: '443'
    object_storage_url: 'https://{{ s3-storage-host }}'
    storage_file: '/tmp/yandex-tank/storage.data'
    iam_token_service_url: 'iam.{{ api-host }}:443'
    agent_id_file: '/run/agentid'
    private_key: '/run/sa_key.json'

    agent_name: <external_agent_name>
    folder_id: <folder_ID>
    ```

    Where:
    * `agent_name`: External agent name, e.g., `external-agent`.
    * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where you are going to connect the external agent.

## Run the external agent {#run-external-agent}

1. To run a Docker container with the external agent, run the following command in the terminal:

    ```bash
    docker run \
      -it \
      --mount type=bind,source=<path_to_file_with_authorized_keys>,target=/run/sa_key.json \
      --mount type=bind,source=<path_to_configuration_file>,target=/run/config.yaml \
      --env LOADTESTING_AGENT_CONFIG=/run/config.yaml \
      {{ registry }}/yc/ya-lt-agent:latest
    ```

    Where:
    * `<path_to_file_with_authorized_keys>`: Absolute path to the file with the authorized keys, e.g., `/home/user/secret-key.json`.
    * `<path_to_configuration_file>`: Absolute path to the configuration file, e.g., `/home/user/config.yaml`.

    You can also specify the external agent configuration using the environment variables for different Docker containers.

    {% cut "Example of running an external agent with environment variables" %}

    ```bash
    docker run \
      -it \
      --mount type=bind,source=<path_to_file_with_authorized_keys_in_host_OS>,target=/run/sa_key.json \
      --env LOADTESTING_AGENT_CONFIG=<path_to_configuration_file_in_container> \
      --env LOADTESTING_AGENT_NAME='<external_agent_name>' \
      --env LOADTESTING_FOLDER_ID='<folder_ID>' \
      --env LOADTESTING_SA_KEY_FILE=<path_to_file_with_authorized_keys_in_container> \
      {{ registry }}/yc/ya-lt-agent:latest
    ```

    Where:
    * `LOADTESTING_AGENT_CONFIG`: Required parameter that indicates the path to the configuration file of the external agent in the container.
    * `LOADTESTING_AGENT_NAME`: External agent name.
    * `LOADTESTING_FOLDER_ID`: Folder ID.
    * `LOADTESTING_SA_KEY_FILE`: Path to the file with the authorized keys in the container.

    You can use the following environment variables instead of the authorized key file:
    * `LOADTESTING_SA_ID`: Service account ID.
    * `LOADTESTING_SA_KEY_ID`: ID of the service account authorized key.
    * `LOADTESTING_SA_KEY_PAYLOAD`: Value of the service account private authorized key.

    External agents are authorized using a [JWT](../../iam/operations/iam-token/create-for-sa.md#via-jwt).

    {% endcut %}

    Each time the Docker container is run, the external agent gets a new ID in {{ load-testing-name }}. You can keep the same ID between container runs, e.g., to link testing results to a specific agent. To do this, use a Docker volume to store a file with the external agent ID (the `agent_id_file` parameter in the agent configuration file). The volume data is stored independently of the Docker container: if you stop and delete the container, both the volume and the container data will remain intact.

    {% cut "Example of running an external agent with a constant ID" %}

    Create a Docker volume, e.g., `external_agent_1_volume`:

    ```bash
    docker volume create external_agent_1_volume
    ```

    Run the external agent with a mounted volume:

    ```bash
    docker run \
      -it \
      --mount source=external_agent_1_volume,target=/run \
      --mount type=bind,source=<path_to_file_with_authorized_keys>,target=/run/sa_key.json \
      --mount type=bind,source=<path_to_configuration_file>,target=/run/config.yaml \
      --env LOADTESTING_AGENT_CONFIG=/run/config.yaml \
      {{ registry }}/yc/ya-lt-agent:latest
    ```

    {% endcut %}

1. Check that the external agent is available in {{ load-testing-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. In the left-hand panel, go to the ![operations](../../_assets/mdb/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab.

      1. Make sure the **Register an agent** operation completed successfully.
      1. In the left-hand panel, go to the ![agents](../../_assets/load-testing/agent.svg) **{{ ui-key.yacloud.load-testing.label_agents-list }}** tab.
      1. Make sure the external agent, e.g., `external-agent`, has the `Ready for test` status.

    {% endlist %}

## Create a test {#run-test}

[Run](../../load-testing/quickstart.md#run-test) a load test. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** field, select an external agent, e.g., `external-agent`.


## View the testing results {#see-results}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, go to the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.
  1. Choose the previously created test and view its results. 

{% endlist %}

## How to delete the resources you created {#clear-out}

To delete the external agent from {{ load-testing-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, go to the ![agents](../../_assets/load-testing/agent.svg) **{{ ui-key.yacloud.load-testing.label_agents-list }}** tab.
  1. Next to the agent to delete, click ![options](../../_assets/options.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}

### See also

* [{#T}](../../load-testing/tutorials/loadtesting-multiply.md)