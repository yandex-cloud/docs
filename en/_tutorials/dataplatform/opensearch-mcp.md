

Follow this tutorial to set up an MCP connection to an {{ OS }} cluster: enable the built-in MCP server, register tools, and add the server to the client configuration.

{% note info %}

The MCP server is available in {{ OS }} starting from version 3.0.

{% endnote %}

To set up a connection:

1. [Start the MCP server](#enable-mcp).
1. [Register tools](#register-tools).
1. [Prepare a Basic token](#basic-token).
1. [Add the MCP server to the client configuration](#client-config).
1. [Test the connection](#check-connection).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mos-name }} cluster: use of computing resources, storage and backup size (see [{{ mos-name }} pricing](../../managed-opensearch/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. Set up your infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) of your preferred configuration with public access to any host group.

            {% include [public-access](../../_includes/mdb/note-public-access.md) %}

        1. If there are security groups in your cluster, make sure they are configured correctly and allow connections to the [{{ mos-name }} cluster](../../managed-opensearch/operations/connect/index.md#configuring-security-groups).

    - Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [opensearch-mcp.tf](https://github.com/yandex-cloud-examples/yc-opensearch-mcp/blob/main/opensearch-mcp.tf) configuration file to the same working directory. This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * [Security group](../../vpc/concepts/security-groups.md) and rules for connection to a {{ mos-name }} cluster.
            * {{ mos-name }} cluster.

        1. In the `opensearch-mcp.tf` file, specify the following variables:

            * `version`: {{ OS }} version.
            * `admin_password`: {{ OS }} admin password.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. [Install an SSL certificate](../../managed-opensearch/operations/connect/index.md#ssl-certificate).

1. Check the connection to the cluster using [cURL](https://curl.haxx.se/):

    {% include [default-connstring](../../_tutorials/_tutorials_includes/opensearch/check-connection.md) %}

1. Create a separate user for the MCP client.

    You can create an internal user either via {{ OS }} Dashboards or via the Security REST API.

    {% list tabs group=mcp-user-create %}

    - OpenSearch Dashboards {#dashboards}

        1. [Connect](../../managed-opensearch/operations/connect/clients.md#dashboards) to {{ OS }} Dashboards as `admin`.
        1. In the left-hand menu, select **{{ OS }} Plugins** → **Security**.
        1. In the left-hand panel, select **Internal users** and click **Create internal user**.
        1. Enter a username, e.g., `mcp-client`, and password.
        1. Click **Submit**.
        1. Assign the `ml_full_access` role to the user:

            1. In the left-hand panel, select **Roles**.
            1. Open the `ml_full_access` role and go to the **Mapped users** tab.
            1. Click **Manage mapping**, add the `mcp-client` user, and click **Map**.

    - REST API {#rest-api}

        Create an internal user and assign the `ml_full_access` role to them. The example below creates the `mcp-client` user:

        ```bash
        curl \
          --cacert ~/.opensearch/root.crt \
          --user admin:<password> \
          --request PUT \
          --header "Content-Type: application/json" \
          "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_security/api/internalusers/mcp-client" \
          --data '{
            "password": "<user_password>",
            "opendistro_security_roles": [
              "ml_full_access"
            ]
          }'
        ```

        Check that the user was created if you need to:

        ```bash
        curl \
          --cacert ~/.opensearch/root.crt \
          --user admin:<password> \
          --request GET \
          "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_security/api/internalusers/mcp-client"
        ```

    {% endlist %}

    {% note info %}

    If planning to register other tools, create a role with relevant permissions. Learn more about setting up permissions from the [OpenSearch guide on users and roles]({{ os.docs }}/security/access-control/users-roles/) and the [list of supported tools]({{ os.docs }}/ml-commons-plugin/agents-tools/tools/index/).

    {% endnote %}

1. For steps where you edit cluster settings, create roles and users, or register tools, use the `admin` account or another account with enough administrative permissions. To connect the MCP client and create a Basic token, use the `mcp-client` user's credentials.


{% note warning %}

The MCP client gets the same permissions as the user whose credentials are provided in the `Authorization` header. Do not use the `admin` account in the client configuration if it is enough to use a separate user with limited permissions.

{% endnote %}

## Start the MCP server {#enable-mcp}

Run a request to the cluster API:

```bash
curl \
  --cacert ~/.opensearch/root.crt \
  --user admin:<password> \
  --request PUT \
  --header "Content-Type: application/json" \
  "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_cluster/settings" \
  --data '{
    "persistent": {
      "plugins.ml_commons.mcp_server_enabled": true
    }
  }'
```

## Register tools {#register-tools}

After you start the MCP server, register the tools you want to be available to the MCP client.

See the full list of built-in tools in [this OpenSearch guide]({{ os.docs }}/ml-commons-plugin/agents-tools/tools/index/).

For the registration request format, see [this OpenSearch guide]({{ os.docs }}/ml-commons-plugin/api/mcp-server-apis/register-mcp-tools/).

For example, you can register a basic toolkit to view indexes, schema, and search:

```bash
curl \
  --cacert ~/.opensearch/root.crt \
  --user mcp-client:<password> \
  --request POST \
  --header "Content-Type: application/json" \
  "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_ml/mcp/tools/_register" \
  --data '{
    "tools": [
      {
        "name": "ListIndexTool",
        "type": "ListIndexTool",
        "description": "Returns a list of cluster indexes",
        "attributes": {
          "input_schema": {
            "type": "object",
            "properties": {
              "indices": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "description": "List of indexes. Specify [] for all cluster indexes"
              }
            },
            "additionalProperties": false
          }
        }
      },
      {
        "name": "IndexMappingTool",
        "type": "IndexMappingTool",
        "description": "Returns mappings and settings for the specified index",
        "attributes": {
          "input_schema": {
            "type": "object",
            "properties": {
              "index": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "description": "List of indexes"
              }
            },
            "required": [
              "index"
            ],
            "additionalProperties": false
          }
        }
      },
      {
        "name": "SearchIndexTool",
        "type": "SearchIndexTool",
        "description": "Searches through the index using OpenSearch DSL",
        "attributes": {
          "input_schema": {
            "type": "object",
            "properties": {
              "index": {
                "type": "string"
              },
              "query": {
                "type": "string"
              }
            },
            "required": [
              "index",
              "query"
            ],
            "additionalProperties": false
          }
        }
      }
    ]
  }'
```

To make sure the tools were registered, run this request:

```bash
curl \
  --cacert ~/.opensearch/root.crt \
  --user mcp-client:<password> \
  --request GET \
  "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_ml/mcp/tools/_list"
```

If registration was successful, you will get the `tools` array in the response.

## Generate a Basic token {#basic-token}

If the MCP client transmits Basic authentication in the header, generate a token from the username and password of the user you created:

```bash
echo -n 'mcp-client:<password>' | base64
```

Use the resulting value as `<base64-basic-token>`.

## Add the MCP server to the client configuration {#client-config}

All examples below use the following URL:

```text
https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_ml/mcp
```

If the client does not allow you to specify a path to a CA certificate separately, install an [SSL certificate](../../managed-opensearch/operations/connect/index.md#ssl-certificate) to the system certificate storage in advance.

{% list tabs group=mcp_client %}

- OpenCode {#opencode}

    Add the server to the OpenCode configuration:

    ```json
    {
      "opensearch": {
        "enabled": true,
        "type": "remote",
        "url": "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_ml/mcp",
        "headers": {
          "Authorization": "Basic <base64-basic-token>"
        }
      }
    }
    ```

- Claude Code {#claude-code}

    Run this command to add the MCP server:

    ```bash
    claude mcp add --transport http opensearch \
      "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_ml/mcp" \
      --header "Authorization: Basic <base64-basic-token>"
    ```

- FastMCP {#fastmcp}

    Install a package:

    ```bash
    pip3 install fastmcp
    ```

    Connection example:

    ```python
    import asyncio

    import httpx
    from fastmcp import Client

    auth = httpx.BasicAuth(
        username="mcp-client",
        password="<password>",
    )


    async def main():
        async with Client(
            "https://<{{ OS }}_host_address_with_public_access>:{{ port-mos }}/_plugins/_ml/mcp",
            auth=auth,
            verify="/path/to/root.crt",
        ) as client:
            for tool in await client.list_tools():
                print(tool.name)

            result = await client.call_tool("ListIndexTool", {})
            print(result)


    asyncio.run(main())
    ```

- VS Code {#vscode}

    Currently (before OpenSearch 3.7), there are issues connecting to the MCP server directly from VS Code. You can configure an MCP proxy to connect to the MCP server from VS Code by yourself.

{% endlist %}

Once the configuration is saved, restart the MCP client and update its settings if your application requires it.

## Test the connection {#check-connection}

1. Make sure the client has connected to the MCP server without authorization or TLS errors.
1. Make sure the client recognizes the registered tools, e.g., `ListIndexTool`, `IndexMappingTool`, and `SearchIndexTool`.
1. Run a test call of `ListIndexTool` and make sure you get a list of cluster indexes in the response.

For example, for `FastMCP`, you just need to run the script from the previous step. If the connection is configured correctly, the script will:

* Return the list of available tools.
* Call `ListIndexTool`.
* Return cluster indexes info.

If you are using an IDE or a local agent, open the list of MCP servers or tools in the client interface and make sure the `opensearch` server is active.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
