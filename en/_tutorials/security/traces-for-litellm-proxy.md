# Integrating LiteLLM Proxy with {{ ai-studio-full-name }} and {{ traces-name }}

[LiteLLM Proxy](https://openai.com/api/) is a proxy server that enables access to LLM providers through a single interface compatible with the [OpenAI API](https://docs.litellm.ai/docs/providers/litellm_proxy).

LiteLLM Proxy simplifies multi-model workflows by providing centralized application access management, rate limiting, cost tracking, and trace generation for request analysis.

You can monitor your requests using [{{ traces-name }}](../../monium/traces/index.md), a distributed tracing system. A trace aggregates data about individual operations, such as their sequence, duration, and errors.

Traces help you:

* Identify the exact step, service, or application component where an error or latency occurs.
* Analyze prompts, responses, and token spend. For example, you can view the exact context provided to the model, generation time, and prompt/response token counts.

Integrating LiteLLM Proxy with the tracing system allows you to collect this data on the proxy side: you do not need to add telemetry code to your application. 

In this tutorial, you will deploy LiteLLM Proxy and configure trace export to {{ traces-name }} via [OpenTelemetry v2](https://docs.litellm.ai/docs/observability/opentelemetry_v2). You will then run a test application simulating a conversation with the DeepSeek V4 Flash [model]({{ link-docs-ai }}ai-studio/concepts/generation/models) in [{{ ai-studio-full-name }}]({{ link-docs-ai }}) through LiteLLM Proxy and analyze the captured traces.

{% include [traces-for-litellm-proxy](../../_mermaid/other/monium/traces-for-litellm-proxy.md) %}

## Required paid resources {#paid-resources}

The solution support costs include:

* VM computing resources and a disk (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Public IP address and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Text generation (see [{{ ai-studio-full-name }} pricing]({{ link-docs-ai }}ai-studio/pricing)).
* Trace logging to {{ traces-name }} (see [{{ monium-full-name }} pricing](../../monium/pricing.md)).

## Steps to follow {#procedure}

1. [Get your cloud ready](#before-you-begin).
1. [Deploy and configure the LiteLLM Proxy instance](#deploy-litellm-proxy).
1. [Send requests to the model and check the traces](#test-integration).

If you deployed this solution only for testing, you can [delete the created resources](#clear-out) after completing the tutorial.

## Getting started {#before-you-begin}


Sign up for {{ yandex-cloud }} and create a [billing account](../../billing/concepts/billing-account.md):

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create a new account.
1. On the [{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }}) page, make sure you have a billing account linked and it has the `ACTIVE` or `TRIAL_ACTIVE` [status](../../billing/concepts/billing-account-statuses.md). If you do not have a billing account, [create one](../../billing/quickstart/index.md) and [link](../../billing/operations/pin-cloud.md) a cloud to it.

If you have an active billing account, you can create or select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for your infrastructure on the [cloud page]({{ link-console-cloud }}).



### Set up your environment {#prepare}

[Create](../../compute/operations/vm-create/create-linux-vm.md) a VM from the [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin) public image.

{% note warning %}

When creating the VM, specify at least 4 GB of RAM.

{% endnote %}


### Create API keys {#create-api-keys}

Create two [service accounts](../../iam/concepts/users/service-accounts.md) with [API keys](../../iam/concepts/authorization/api-key.md) (one per service) so LiteLLM Proxy can access {{ ai-studio-full-name }} and send traces to {{ traces-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. Create a service account to enable LiteLLM Proxy to access {{ ai-studio-full-name }}:

      1. In the [management console]({{ link-console-main }}), select the folder where you are going to create your infrastructure.
      1. [Navigate]({{ link-console-main }}/link/iam) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. In the window that opens, enter the service account name: `litellm-ai-studio-sa`.
      1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_roles }}** field, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select [role]({{ link-docs-ai }}ai-studio/security/#languageModels-user) `ai.languageModels.user`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Create an API key for LiteLLM Proxy access to {{ ai-studio-full-name }}:

      1. In the list of service accounts, select `litellm-ai-studio-sa`.
      1. At the top of the page, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** → **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
      1. In the window that opens, select a [scope](*key_scope_definition) `yc.ai.languageModels.execute` and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Save the secret part of the API key. You will not be able to view it again after closing the dialog window.
  1. Create a service account and API key to enable LiteLLM Proxy to access {{ monium-full-name }}. Specify the following properties:

      * Service account name: `litellm-monium-sa`.
      * [Role](../../monium/security/index.md#monium-traces-writer): `monium.traces.writer`.
      * API key scope: `yc.monium.traces.write`.

{% endlist %}


## Deploy and configure the LiteLLM Proxy instance {#deploy-litellm-proxy}

To deploy LiteLLM Proxy on the [VM you created](#prepare), install Docker, prepare the configuration files, and start the container:

1. Connect to the VM [over SSH](../../compute/operations/vm-connect/ssh.md) or [via {{ oslogin }}](../../compute/operations/vm-connect/os-login.md) depending on the connection method you selected when creating your resources.
1. Install and configure Docker:

    1. Install the required dependencies:

        ```bash
        sudo apt update
        sudo apt install ca-certificates curl gnupg
        ```
    1. Install the Docker [GPG](https://www.gnupg.org/) key:

        ```bash
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        ```
    1. Add the Docker repository to your `apt` package sources:

        ```bash
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        ```
    1. Install Docker:

        ```bash
        sudo apt update
        sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        ```
    1. Add the current user to the `docker` group and open a new shell to apply the changes:

        ```bash
        sudo usermod -aG docker $USER
        newgrp docker
        ```
    1. Make sure Docker is installed and operational:

        ```bash
        docker run hello-world
        ```

        Result:

        ```text
        Unable to find image 'hello-world:latest' locally
        latest: Pulling from library/hello-world
        4f55086f7dd0: Pull complete 
        d5e71e642bf5: Download complete 
        Digest: sha256:5e23090353324d887c48ad5e5c56d294eab81588df9605b07d1afe89********
        Status: Downloaded newer image for hello-world:latest

        Hello from Docker!
        This message shows that your installation appears to be working correctly.
        ...
        ```
1. In your home directory, create a project directory for Docker Compose and navigate into it:

    ```bash
    mkdir ~/litellm-proxy && cd ~/litellm-proxy
    ```
1. Create the required configuration files for the project:

    ```bash
    touch .env
    touch config.yaml
    touch docker-compose.yaml
    ```
1. In a text editor, open the `.env` file:

    ```bash
    nano .env
    ```
1. Add the following environment variables to the `.env` file:

    ```text
    YANDEX_AI_STUDIO_API_KEY=<ai_studio_key_secret_part>
    MONIUM_API_KEY=<monium_key_secret_part>
    MONIUM_PROJECT=folder__<folder_ID>
    LITELLM_MASTER_KEY=sk-local-litellm
    ```

    Where:

    * `YANDEX_AI_STUDIO_API_KEY`: Secret part of the API key for the `litellm-ai-studio-sa` service account.
    * `MONIUM_API_KEY`: Secret part of the API key for the `litellm-monium-sa` service account.
    * `MONIUM_PROJECT`: {{ monium-name }} project ID. It consists of the `folder__` prefix followed by your folder ID where the VM and service accounts were created. Here is an example: `folder__b1gt6g8ht345********`.
    * `LITELLM_MASTER_KEY`: Key that applications use to access LiteLLM Proxy. You define it in the `.env` file so the proxy can authenticate incoming requests. For this tutorial, keep the `sk-local-litellm` value. This value is used in the code of the `agent_example.py` test application you will create in the next step.

        {% note tip %}

        For production environments, run `openssl rand -hex 32` to generate a random string and prepend it with `sk-`.

        If you updated `LITELLM_MASTER_KEY` in the `.env` file after starting the container, recreate the container by running `docker compose up -d --force-recreate`. If using a custom key, make sure to set the exact same value in the `LITELLM_PROXY_KEY` environment variable in your terminal before running the `agent_example.py` test application:

        ```bash
        export LITELLM_PROXY_KEY='<key_from_env_file>'
        ```

        The `openai` library inside the test application automatically attaches this key to the `Authorization` header using the `Bearer` scheme. The header value must match the key configured for the proxy in `.env`.

        {% endnote %}

1. In a text editor, open the `config.yaml` file:

    ```bash
    nano config.yaml
    ```
1. Add the following configuration to the `config.yaml` file:

    ```yaml
    # LiteLLM proxy: Yandex AI Studio (OpenAI-compatible) → traces to {{ monium-full-name }}.
    # Model URI: gpt://<folder_ID>/deepseek-v4-flash

    model_list:
      - model_name: deepseek-v4-flash
        litellm_params:
          model: openai/gpt://<folder_ID>/deepseek-v4-flash
          api_base: https://{{ api-host-llm }}/v1
          api_key: os.environ/YANDEX_AI_STUDIO_API_KEY

    litellm_settings:
      drop_params: true
      set_verbose: false
      # Both this callback and LITELLM_OTEL_V2=true are required.
      callbacks:
        - otel

    general_settings:
      master_key: os.environ/LITELLM_MASTER_KEY
    ```

    Where `model` is the model ID in LiteLLM: the `openai/` prefix and the {{ ai-studio-full-name }} model URI containing your [folder ID](../../resource-manager/operations/folder/get-id.md). Here is an example: `openai/gpt://b1gt6g8ht345********/deepseek-v4-flash`.

    The `os.environ/` prefix indicates that the parameter value should be retrieved from the respective environment variable.
1. In a text editor, open the `docker-compose.yaml` file:

    ```bash
    nano docker-compose.yaml
    ```
1. Add the Docker Compose project configuration into the `docker-compose.yaml` file:

    ```yaml
    services:
      litellm:
        image: docker.litellm.ai/berriai/litellm:main-latest
        container_name: litellm-proxy
        restart: unless-stopped
        # Host network: on this class of host net.ipv4.ip_forward=0 and bridge NAT drops connections.
        network_mode: host
        volumes:
          - ./config.yaml:/app/config.yaml:ro
        environment:
          - LITELLM_OTEL_V2=true
          - OTEL_EXPORTER=otlp_http
          - OTEL_ENDPOINT=https://{{ api-host-monium }}/otlp
          - OTEL_SERVICE_NAME=litellm-proxy
          - OTEL_ENVIRONMENT_NAME=local
          - OTEL_HEADERS=Authorization=Api-Key ${MONIUM_API_KEY:?MONIUM_API_KEY},x-monium-project=${MONIUM_PROJECT:?MONIUM_PROJECT},x-monium-cluster=${MONIUM_CLUSTER:-default},x-monium-service=litellm-proxy
          - OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=span_only
          - YANDEX_AI_STUDIO_API_KEY=${YANDEX_AI_STUDIO_API_KEY:?YANDEX_AI_STUDIO_API_KEY}
          - LITELLM_MASTER_KEY=${LITELLM_MASTER_KEY:-sk-local-litellm}
        command:
          - --config
          - /app/config.yaml
          - --port
          - "4000"
          - --host
          - "0.0.0.0"
    ```

    Configuration parameters:

    * `environment`: Environment variables:

        * `OTEL_EXPORTER=otlp_http`: Configures trace delivery via OTLP over HTTP.
        * `OTEL_ENDPOINT=https://{{ api-host-monium }}/otlp`: Sets the base endpoint address. LiteLLM Proxy appends `/v1/traces` to it and sends traces to `https://{{ api-host-monium }}/otlp/v1/traces`.
        * `x-monium-service=litellm-proxy`: Name to assign to the service in the {{ monium-name }} UI.
        * `OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=span_only`: Enables capturing model request and response text inside [spans](*span_definition).
    * `network_mode: host`: Runs the container in the host's network.

        This allows the container to access {{ ai-studio-full-name }} and {{ monium-full-name }} even if IP packet forwarding is disabled on the host (`net.ipv4.ip_forward = 0`). LiteLLM Proxy listens for incoming connections on VM port `4000`.
1. Run the container:

    ```bash
    docker compose up -d
    ```

    Result:

    ```text
    [+] up 27/27
    ✔ Image docker.litellm.ai/berriai/litellm:main-latest Pulled                                                      82.4s
    ✔ Container litellm-proxy                             Started                                                     43.1s
    ```
1. To check that LiteLLM Proxy is ready to accept requests, run this command in the VM terminal:

    ```bash
    for _ in $(seq 1 30); do
      curl -sf http://127.0.0.1:4000/health/liveliness >/dev/null && echo "proxy is up" && break
      sleep 1
    done
    ```

    Result:

    ```text
    proxy is up
    ```

## Send requests to the model and check the traces {#test-integration}

To test trace delivery, create and run a test application on the same VM where LiteLLM Proxy is running. The application will route requests to the model through the proxy, which in turn will send the traces to {{ traces-name }}. You can then find these traces in {{ monium-name }} to review the request details.

### Create and run a test application {#run-sample-application}

The Python-based test application simulates a customer conversation with a support agent. It uses the `openai` library to send requests to the model via LiteLLM Proxy. Install this library inside a dedicated virtual environment to isolate the application dependencies.

To create and run the application:

1. Navigate to the `~/litellm-proxy` directory you created when deploying LiteLLM Proxy on the VM:

    ```bash
    cd ~/litellm-proxy
    ```
1. Install Python and the `venv` module for virtual environment management:

    ```bash
    sudo apt install python3 python3.12-venv
    ```
1. Create and activate the `litellm-venv` virtual environment:

    ```bash
    python3 -m venv ~/litellm-venv
    source ~/litellm-venv/bin/activate
    ```
1. Install the `openai` library:

    ```bash
    pip install 'openai==2.54.0'
    ```
1. Create and open the `agent_example.py` test application file in a text editor:

    ```bash
    touch agent_example.py
    nano agent_example.py
    ```
1. Add this code to the `agent_example.py` file:

    {% cut "Application code" %}

    {% include [api-key-scope](../_tutorials_includes/traces-for-litellm-proxy-app-code.md) %}

    {% endcut %}

    Through LiteLLM Proxy, the application sends five customer messages to the model one by one: a question about delivery, an order status check, a question on return policy, a refund request, and a final message with two questions, one regarding warranty and password reset.

    To prepare a response, the model can request a tool call: a local knowledge base search, an order status check, or a refund transaction. The application processes this tool call and sends the results back to the model through the proxy in the next request. Order checks and refunds are simulated in the app code.

    The number of requests depends on which tools the model calls. For example, during an order status check, the first request allows the model to select the tool, while the second one returns the tool results so the model can generate a response for the customer. LiteLLM Proxy generates a unique trace for each request and routes it to {{ traces-name }}. The application itself does not send any telemetry data.

1. Run the test app:

    ```bash
    python3 agent_example.py
    ```

    Result:

    ```text
    Customer Support Agent (LiteLLM proxy demo)
    ============================================================
    Proxy model: deepseek-v4-flash
    Turns: 5
    ...
    [1/5] You: Hi! I need express shipping info for an order I'm about to place.
      [tool] search_knowledge_base -> Express shipping takes 2-3 business days and costs $12.99
    Agent: Great news! Here's the express shipping information:
    ...
    ...
    Demo finished.
    ```

### Find and view traces in {{ monium-name }} {#check-traces}

To find the traces generated by the test application:

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. [Navigate]({{ link-monium }}) to {{ monium-name }}.
  1. In the left-hand panel, select ![cube](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.llm-monitoring.title }}**.
  1. Use the timeline selector at the top of the screen to choose the period when you ran the test application.
  1. Click the ![code](../../_assets/console-icons/code.svg) icon in the top-right corner of the query bar and enter the following filter:

      ```text
      {project = "folder__<folder_ID>", service = "litellm-proxy"}
      ```

      Where `<folder_id>` is the [ID of the folder](../../resource-manager/operations/folder/get-id.md) where you [created](#create-api-keys) the service accounts.
  1. Click **{{ ui-key.yacloud_monitoring.llm-tracing.search.actions.execute }}**.

{% endlist %}

The search results will display the traces generated by your test application. To view all operations within a trace, click its row and select **Show full trace**.

The expanded trace will display these spans:

* `POST /v1/chat/completions`: HTTP request to LiteLLM Proxy.
* `POST /v1/chat/completions`: LiteLLM Proxy access key verification.
* `chat gpt://<folder_ID>/deepseek-v4-flash`: Model call. This span contains the model name, input and output token counts, and message text.

If the model requests tool calls, the model span logs their names (`search_knowledge_base`, `get_order_status`, or `process_refund`) and arguments.

The application stores the conversation history and appends it to each new request, causing the context size to increase in subsequent traces.

For more information on viewing traces, see [{#T}](../../monium/traces/llm/traces.md).


### Troubleshooting {#troubleshooting}

#|
|| **Issue** | **Solution** ||
|| Connection error (`Error: Connection error`) |
* During the final step of the [LiteLLM Proxy deployment](#deploy-litellm-proxy), wait for the `proxy is up` message.
* Make sure VM port `4000` is available.
||
|| {{ ai-studio-full-name }} returns HTTP code `401` or `403` |
* Check that the `YANDEX_AI_STUDIO_API_KEY` variable contains only the key, without `Bearer`, `Api-Key`, or any extra characters.
* Check `config.yaml` configurations:

    * `model` (the model ID in LiteLLM): `openai/gpt://<folder_ID>/deepseek-v4-flash`
    * `api_base` (address): `https://{{ api-host-llm }}/v1`
||
|| The test application runs successfully, but traces do not appear in {{ monium-name }} |
Make sure that:

* The `MONIUM_PROJECT` value has this format: `folder__<folder_ID>` (with two underscores).
* The `Authorization` header in `docker-compose.yaml` contains a literal space between `Api-Key` and the key (not `%20`).
* The `litellm-monium-sa` service account holds the `monium.traces.writer` role for the folder defined in `MONIUM_PROJECT`.
* The service account API key scope is set to `yc.monium.traces.write`.
* The filter in the {{ monium-name }} UI is [set](#check-traces) to `{project = "folder__<folder_id>", service = "litellm-proxy"}` and the selected time range covers the exact period when you ran the test application.
||
|| No container network connection (`Connection reset`) |
Run the `sysctl net.ipv4.ip_forward` command.

If it returns `net.ipv4.ip_forward = 0`, keep the `network_mode: host` line in `docker-compose.yaml`.

After you make the changes, run `docker compose up -d --force-recreate`.
||
|| Spans do not contain message text | Check that the `docker-compose.yaml` file includes the `OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=span_only` environment variable.

After you make the changes, run `docker compose up -d --force-recreate`. ||
|#

## How to delete the resources you created {#clear-out}

If you deployed this solution for testing purposes only, you can delete the resources after completing this tutorial to stop paying for them:

1. [Delete the LiteLLM Proxy VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the disk](../../compute/operations/disk-control/delete.md) if it was not deleted along with the VM.
1. [Delete the static public IP address](../../vpc/operations/address-delete.md) if you reserved one for the VM.

Delete the `litellm-ai-studio-sa` and `litellm-monium-sa` service accounts if you no longer need them.


[*key_scope_definition]: {% include [api-key-scope](../../_popups/iam/api-key-scope.md) %}

[*span_definition]: {% include [span-definition](../../_popups/monium/span-definition.md) %}
