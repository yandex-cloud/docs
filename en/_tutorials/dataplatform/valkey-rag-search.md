# Using {{ mrd-full-name }} with the Search module and {{ foundation-models-full-name }} models for vector search in a RAG system

RAG (retrieval-augmented generation) is an approach where a language model uses information retrieved from a database to answer a user's query.

This tutorial provides an example of a RAG system that uses [{{ mrd-full-name }}](../../managed-valkey/index.yaml) to store data about people and perform vector search on that data using the [Search](../../managed-valkey/concepts/modules.md#valkey-search) module. [{{ foundation-models-full-name }}]({{ link-docs-ai }}ai-studio/concepts/index.html) models are used to generate an embedding for the search query and a response. {{ mrd-name }} and {{ foundation-models-name }} work together using MCP.

When processing a search query, the system components work together as follows:

1. The {{ foundation-models-full-name }} model receives the user's query and calls an MCP tool to search for data.
1. The MCP tool converts the query into an [embedding]({{ link-docs-ai }}ai-studio/concepts/embeddings.html) using the {{ foundation-models-full-name }} vector representation model and then sends the embedding to {{ mrd-name }}.
1. {{ mrd-name }} runs a vector search using the `Search` module and returns the results to the MCP tool, which then sends them to the language model.
1. The language model analyzes the retrieved data and responds to the user.

This example requires a Unix-like environment and a {{ mrd-name }} cluster running version `9.0` or later.

The source code for the RAG system example is available in the {{ src-name }} [repository]({{ link-src-main }}/valkey/webinar-260624-rag-example).

To set up your RAG system, follow these steps:

1. [Set up your infrastructure](#infra).
1. [Set up a testing environment](#prepare-test-environment).
1. [Prepare your test data and upload them to {{ mrd-name }}](#prepare-test-data).
1. [Test the test data in {{ mrd-name }}](#check-test-data).
1. [Run a search in the RAG system](#test-rag-search).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* {{ mrd-name }} cluster: use of computing resources allocated to hosts, storage and backup size (see [{{ mrd-name }} pricing](../../managed-valkey/pricing.md)).
* AI assistant: number of request and response tokens (see [{{ foundation-models-full-name }} pricing]({{ link-docs-ai }}ai-studio/pricing.html)). You start paying for the assistant as soon as you activate it.
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Set up your infrastructure {#infra}

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Create a cloud network](../../vpc/operations/network-create.md) named `demo-network`.

      When creating a network, three subnets in different availability zones are created automatically.

  1. In `demo-network`, [create a security group](../../vpc/operations/security-group-create.md) named `valkey-sg` for the {{ mrd-name }} cluster and [add](../../vpc/operations/security-group-add-rule.md) the following inbound rule to the group to allow internet access to the cluster:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mrd-tls }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

  1. [Create a {{ mrd-name }}](../../managed-valkey/operations/cluster-create.md) cluster of any suitable configuration with the following settings:

      * **Version**: `9.0` or higher.
      * **Network**: `demo-network`.
      * **Security group**: `valkey-sg`.
      * **TLS support**: Enabled.

      When creating your cluster, enable host public access and add the `Search` module.
    
      {% include [public-access](../../_includes/mdb/note-public-access.md) %}

- Using {{ TF }} {#tf}
  
  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. Download the [valkey-rag-search.tf](https://github.com/yandex-cloud-examples/yc-valkey-mcp-rag-search/blob/main/valkey-rag-search.tf) configuration file to your current working directory. This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnets](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md).
      * {{ mrd-name }} cluster with public access to its hosts and the `Search` module.

        {% include [public-access](../../_includes/mdb/note-public-access.md) %} 

  1. Specify the following in the configuration file:
        
      * `network_name`: Network name.
      * `sg_name`: Security group name.
      * `valkey_cluster_name`: Cluster name.
      * `valkey_password`: Password to access the cluster.

  1. Validate your {{ TF }} configuration using this command:

      ```bash
      terraform validate
      ```

      {{ TF }} will display any configuration errors detected in your files.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}


## Set up a testing environment {#prepare-test-environment}

1. [Install Python](https://www.python.org/) `3.11` or higher.
1. [Install Git](https://git-scm.com/downloads).
1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `sa-ai` and assign the [ai.languageModels.user]({{ link-docs-ai }}ai-studio/security/index.html#languageModels-user) role to it for using {{ foundation-models-full-name }} models.
1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md) for the `sa-ai` service account.
1. [Clone]({{ link-src-docs }}/sourcecraft/operations/repo-clone) the {{ src-name }} repository with the example source code to your local computer:

    ```bash
    git clone https://git@git.sourcecraft.dev/valkey/webinar-260624-rag-example.git
    ```

1. Navigate to the repository directory:
    
    ```bash
    cd webinar-260624-rag-example
    ```

1. Set up the example environment:

    1. Install the dependencies:

        ```bash
        make install
        ```

    1. Activate the virtual environment:

        ```bash
        source .venv/bin/activate
        ```

1. Configure the {{ mrd-name }} and {{ foundation-models-full-name }} access settings:

    1. Use the `.env.example` template to create a file named `.env`:

        ```bash
        cp .env.example .env
        ```

    1. Open the `.env` file in a text editor, such as `vim`:

        ```bash
        vim .env
        ```
    
    1. In the file, specify the following settings:
        
        * **YDS_API_KEY**: API key value.
        * **YDS_FOLDER_ID**: [{{ yandex-cloud }} folder](../../resource-manager/concepts/resources-hierarchy.md#folder) ID you can get with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * **VALKEY_USERNAME**: `default`.
        * **VALKEY_PASSWORD**: Password to access the {{ mrd-name }} cluster.

        Sample file:

        ```text
        # Yandex AI Studio credentials
        # Get an API key: https://yandex.cloud/en/docs/ai-studio/operations/get-api-key
        YDS_API_KEY=AQVN1TpRw9tkjhKtj6R0mRgmHLvMsj84********
        YDS_FOLDER_ID=b1g4unjqq856********
        
        # Valkey auth (leave empty for local unauthenticated Valkey)
        VALKEY_USERNAME=default
        VALKEY_PASSWORD=********
        ```

1. Configure the {{ mrd-name }} cluster's connection settings:

    1. Open the `config.yaml` file in a text editor, such as `vim`:

        ```bash
        vim config.yaml
        ```

    1. Under `valkey`, specify the following:

        * **host**: `c-<cluster_ID>.rw.mdb.yandexcloud.net`.
            
          You can get the cluster ID with the [list of clusters in the folder](../../managed-valkey/operations/cluster-list.md#list-clusters).
        
        * **Port**: `{{ port-mrd-tls }}`.
        * **db**: `0`.
        * **ssl**: `true`.

        Here is an example of the `valkey` section:

        ```yaml
        # Valkey connection settings
        valkey:
          host: "c-c9qlvmr5h2g9********.rw.mdb.yandexcloud.net"
          port: {{ port-mrd-tls }}
          db: 0
          # username + password read from .env: VALKEY_USERNAME, VALKEY_PASSWORD
          # SSL toggle for managed Valkey
          ssl: true
        ```

    In addition to the {{ mrd-name }} cluster's connection settings, the `config.yaml` file also contains settings for the following:
    
    * {{ foundation-models-full-name }} models.
    * Index and vector search in {{ mrd-name }}.
    * MCP server.
    * Orchestrator.
    * Language model's system prompt.
    * Logging.

    To make this example work, you only need to configure the {{ mrd-name }} cluster's connection settings. You can leave the other settings unchanged.


## Prepare your test data and upload it to {{ mrd-name }} {#prepare-test-data}

Run the following commands in the `webinar-260624-rag-example` repository directory:

1. Create a file named `data/people.json` with your test data:

    ```bash
    rag-demo generate -n 10
    ```

    Result:

    ```text
    Wrote 10 people to data/people.json
    ```

1. Upload the test data to {{ mrd-name }}:

    ```bash
    rag-demo index
    ```

    This will create the `idx_people` index for your test data in the {{ mrd-name }} cluster.

    Result:

    ```text
      indexed person 1: Alice Smith
      indexed person 2: John Doe
      indexed person 3: Maria Garcia
      indexed person 4: Wei Zhang
      indexed person 5: James Brown
      indexed person 6: Priya Patel
      indexed person 7: Lars Nilsson
      indexed person 8: Olivia Wilson
      indexed person 9: Hassan Ali
      indexed person 10: Sophie Martin
    Loaded 10 people into index idx_people
    ```


## Test the test data in {{ mrd-name }} {#check-test-data}
    
1. Connect to the {{ mrd-name }} cluster database:

    {% list tabs group=instructions %}

    - Using `valkey-cli` {#with-valkey-cli}
      
      1. Navigate to the directory you want to download the {{ VLK }} distribution to.

      1. Download the correct {{ VLK }} [version](https://github.com/valkey-io/valkey/releases), then build and install it with TLS support:

          ```bash
          wget https://github.com/valkey-io/valkey/archive/refs/tags/<version>.tar.gz && \
          tar -xzvf <version>.tar.gz && \
          cd valkey-<version> && \
          make BUILD_TLS=yes && \
          sudo make install && \
          sudo cp ./src/valkey-cli /usr/bin/
          ```
      
      1. Obtain an SSL certificate:
        
          {% include [unix-certificate](../../_includes/mdb/mvk/unix-certificate.md) %}
          
      1. Connect to the cluster:
          
          * For non-sharded clusters, run this command:

            ```bash
            valkey-cli \
                -h c-<cluster_ID>.rw.{{ dns-zone }} \
                -a <password> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            You can get the cluster ID with the [list of clusters in the folder](../../managed-valkey/operations/cluster-list.md#list-clusters).

          * For sharded clusters, run this command:
          
            ```bash
            valkey-cli \
                -h <FQDN_of_master_host_in_target_shard> \
                -c \
                -a <password> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            To learn how to get a host’s FQDN, see [{#T}](../../managed-valkey/operations/connect/fqdn.md).

    - Using `redis-cli` {#with-redis-cli}

      1. Install `redis-cli`:

          ```bash
          sudo apt update && sudo apt install --yes redis-tools
          ```
            
      1. Obtain an SSL certificate:
        
          {% include [unix-certificate](../../_includes/mdb/mvk/unix-certificate.md) %}

      1. Connect to the cluster:

          * For non-sharded clusters, run this command:

            ```bash
            redis-cli \
                -h c-<cluster_ID>.rw.{{ dns-zone }} \
                -a <password> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            You can get the cluster ID with the [list of clusters in the folder](../../managed-valkey/operations/cluster-list.md#list-clusters).

          * For sharded clusters, run this command:

            ```bash
            redis-cli \
                -h <FQDN_of_master_host_in_target_shard> \
                -c \
                -a <password> \
                -p {{ port-mrd-tls }} \
                --tls \
                --cacert ~/.redis/{{ crt-local-file }}
            ```

            To learn how to get a host’s FQDN, see [{#T}](../../managed-valkey/operations/connect/fqdn.md).

    - Using {{ websql-full-name }} {#with-websql}

      Before connecting, [enable](../../managed-valkey/operations/update.md#change-additional-settings) [{{ websql-full-name }}](../../websql/index.yaml) access in the cluster settings.

      To connect to a database using {{ websql-full-name }}:

      1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
      1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
      1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.overview.label_websql-service }}** tab.
      1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_go-to-websql}}** in the top-right corner of the page.
    
    {% endlist %}
  
1. Get information about the `idx_people` index:

    ```bash
    FT.INFO idx_people
    ```

    Verify the parameter values in the output:
    
    * **num_docs**: `10`.
    * **state**: `ready`.

1. Get a list of keys in the cluster:

    ```bash
    KEYS *
    ```

    Result:

    ```text
    1) "person:1"
    2) "person:2"
    3) "person:3"
    4) "person:4"
    5) "person:5"
    6) "person:9"
    7) "person:id_counter"
    8) "person:6"
    9) "person:7"
    10) "person:8"
    11) "person:10"
    ```

    Where `person:id_counter` is the service key that stores the ID counter value.

1. View the `person:1` key data:

    ```bash
    HGETALL person:1
    ```


## Run a search in the RAG system {#test-rag-search}

Run the following commands in the `webinar-260624-rag-example` repository directory:

1. Run a search for `Who works with Kubernetes?`:

    ```bash
    rag-demo ask "Who works with Kubernetes?"
    ```

    Result:

    ```text
    Lars Nilsson works with Kubernetes. He is a site reliability engineer in Stockholm, Sweden, responsible for keeping large Kubernetes clusters healthy.
    ```

    Along with the model's response, the output shows detailed information on the query execution. To hide this information, specify `console_level: "WARNING"` in the `logging` section of the `config.yaml` file. The output will then include a summary of the query execution and the model's final response.

1. Run a search for `Who is into running?`:

    ```bash
    rag-demo ask "Who is into running?"
    ```

    Result:

    ```text
    Among the people found, **Wei Zhang** (38 years old, Tokyo, Japan) is into running and trains for marathons.
    ```


## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

  [Delete the {{ mrd-name }} cluster](../../managed-valkey/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}