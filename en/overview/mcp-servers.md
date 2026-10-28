---
title: '{{ yandex-cloud }} MCP servers for AI agents and IDEs'
description: 'Connect {{ yandex-cloud }} MCP servers to your AI agents, assistants, and IDEs: manage infrastructure, Serverless resources, and data using the Model Context Protocol.'
keywords:
  - MCP Yandex Cloud
  - Yandex Cloud MCP Servers
  - AI agent
  - AI assistant
  - Model Context Protocol Yandex Cloud
  - MCP server for cloud management
  - vibe coding
  - VibeDevOps
  - connecting Yandex Cloud to Cursor
  - connecting Yandex Cloud to Claude Code
  - Yandex Cloud CLI for agents
  - yc mcp
  - npm @yandex-cloud/mcp
  - Toolkit MCP server
  - Functions MCP server
  - Serverless Containers MCP server
  - API Gateway MCP server
  - Workflows MCP server
  - Data Catalog MCP server
  - IAM token for MCP
  - Streamable HTTP MCP
---

# {{ yandex-cloud }} MCP servers for AI agents and IDEs


[Model Context Protocol](https://modelcontextprotocol.io/docs/getting-started/intro) (MCP) is an open standard for connecting AI applications to external systems. External systems fall into three categories:


* Data sources, e.g., databases or file storages.
* Tools, such as APIs or scripts.
* Workflows, e.g., automated scripts.

Without MCP, any individual pair of AI applications and external systems would require a separate integration. MCP provides a unified interface that allows any MCP client to access external tools in a standardized way.
{{ yandex-cloud }} features a number of specialized MCP servers for managing cloud infrastructure, serverless resources, and data. With the help of these servers, AI agents can:

* Create VMs.
* Deploy functions and containers.
* Configure triggers and workflows.
* Search for metadata within a data catalog.
* Access {{ yandex-cloud }} and web search.

## Available MCP servers {#available-servers}

#|
||
**Category** | **MCP server** | **Description**
||
||
Infrastructure
|
[Toolkit MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/toolkit-mcp-server/README.md)
|
Deploys simple apps using [{{ compute-full-name }}](../compute/index.yaml), [{{ vpc-full-name }}](../vpc/index.yaml), [{{ iam-full-name }}](../iam/index.yaml), [{{ objstorage-full-name }}](../storage/index.yaml), and [{{ ydb-full-name }}](../ydb/index.yaml)
||
||
Search and knowledge
|
[Documentation MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/documentation-mcp-server/README.md)
|
Provides real-time access to official {{ yandex-cloud }} documentation via [generative search](mcp-doc-server.md)
||
||
Search and knowledge
|
[Search MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/search-mcp-server/README.md)
|
Performs classic and generative web search using [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/concepts/)
||
||
Serverless
|
[Functions MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/functions-mcp-server/README.md)
|
Creates and deploys [{{ sf-full-name }}](../functions/index.yaml) functions, manages their versions, tags, and scaling policies
||
||
Serverless
|
[Serverless Containers MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/containers-mcp-server/README.md)
|
Manages [{{ serverless-containers-full-name }}](../serverless-containers/index.yaml) containers: deploys revisions, configures scaling, and works with image registries
||
||
Serverless
|
[Triggers MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/triggers-mcp-server/README.md)
|
Creates function and container triggers activated by timer or events in other services
||
||
Serverless
|
[Workflows MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/workflows-mcp-server/README.md)
|
Creates and executes [{{ sw-full-name }}]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow) workflows described in the YAML specification and manages their execution schedule
||
||
Serverless
|
[API Gateway MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/apigateway-mcp-server/README.md)
|
Manages [{{ api-gw-full-name }}](../api-gateway/index.yaml) gateways: OpenAPI specifications, custom domains, and WebSocket connections
||
||
Serverless
|
[MCP Gateway MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/mcpgateway-mcp-server/README.md)
|
Creates MCP gateways and sets up tools for calling functions, containers, HTTP endpoints, and workflows
||
||
Data
|
[Data Catalog Consumer MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/datacatalog-consumer-mcp-server/README.md)
|
Allows searching for tables, views, and queries, as well as build lineage graphs in [{{ data-catalog-full-name }}](../metadata-hub/index.yaml).
||
|#

## Connection {#connection}

{{ yandex-cloud }} MCP servers support two connection methods: locally via the [`npm client`](https://www.npmjs.com/) (stdio transport) with automatic authentication, and remotely via [Streamable HTTP](https://modelcontextprotocol.io/specification/2025-06-18/basic/transports#streamable-http).

### Prerequisites {#prerequisites}

To connect a {{ yandex-cloud }} MCP server, you need:

* {{ yandex-cloud }} role for the specific service, such as `editor` or `functions.admin`. For a full list of roles, see the [Server configurations](#server-configs) table.
* Node.js version 18.0.0 or higher, if connecting via the `npm` client.
* [{{ yandex-cloud }} CLI](../cli/quickstart.md). This is optional, required only for authentication via a CLI profile.

### NPM client (stdio) {#npm-client}

The [@yandex-cloud/mcp](https://www.npmjs.com/package/@yandex-cloud/mcp) `npm` client starts the MCP server locally and handles authentication in {{ yandex-cloud }} in one of the following ways:

* OAuth: Authentication via the browser without additional flags. It is used by default.
* OAuth with explicit account selection: `-S <user_or_service_account_ID>` or `-u <email>` parameter.
* Authentication via {{ yandex-cloud }} CLI: `-p <profile>` parameter uses a pre-configured [CLI profile](../cli/quickstart.md#initialize). This method requires the {{ yandex-cloud }} CLI to be installed.
* Without authentication: `--no-auth` parameter. This is suitable only for servers that do not require authorization (e.g., the Documentation MCP server).

Configuration example:

```json
{
  "mcpServers": {
    "yandex-cloud-toolkit": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y", "@yandex-cloud/mcp",
        "-s", "toolkit"
      ]
    }
  }
}
```

Where:

* `-s, --server`: Name of the MCP server, e.g., `toolkit`, `search`, or `functions`. For a full list of server names, see [Server configurations](#server-configs).
* `-r, --region <REGION>`: {{ yandex-cloud }} region for OAuth authentication. It can be either `ru` or `kz`. The default value is `ru`.
* `-H, --header <Key:Value>`: Additional header for each MCP server tool call. You can specify this parameter multiple times, e.g., to provide a `Folder-Id`.

### Streamable HTTP {#streamable-http}

To connect via Streamable HTTP, use an [IAM token](../iam/concepts/authorization/iam-token.md), which you can obtain using the {{ yandex-cloud }} CLI:

```bash
yc iam create-token
```

To authenticate as a [service account](../iam/concepts/users/service-accounts.md):

```bash
yc iam create-token --impersonate-service-account-id <service_account_ID>
```

{% note info %}

IAM tokens are valid for a maximum of {{ iam-token-lifetime }}. After it expires, you need to reissue the token.

{% endnote %}

Configuration example:

```json
{
  "mcpServers": {
    "yandex-cloud-toolkit": {
      "type": "streamableHttp",
      "url": "https://toolkit.mcp.cloud.yandex.net/mcp",
      "headers": {
        "Authorization": "Bearer <IAM_token>"
      }
    }
  }
}
```

## Server configurations {#server-configs}

Parameters for connecting MCP servers:

#|
||
**MCP server** | **Server name for an `npm` client (`-s`)** | **URL for Streamable HTTP** | **Required role**
||
||
Toolkit
|
`toolkit`
|
`https://toolkit.mcp.cloud.yandex.net/mcp`
|
`editor` or `compute.admin`
||
||
Documentation
|
`docs`
|
`https://docs.mcp.cloud.yandex.net/mcp`
|
Not required
||
||
Search
|
`search`
|
`https://search.mcp.cloud.yandex.net/mcp`
|
[`search-api.webSearch.user`](../iam/roles-reference.md#search-api-webSearch-user)
||
||
Functions
|
`functions`
|
`https://functions.mcp.cloud.yandex.net/mcp`
|
`editor` or [`functions.admin`](../functions/security/index.md#functions-admin)
||
||
Serverless Containers
|
`containers`
|
`https://containers.mcp.cloud.yandex.net/mcp`
|
`editor` or [`serverless-containers.admin`](../serverless-containers/security/index.md#serverless-containers-admin)
||
||
Triggers
|
`triggers`
|
`https://triggers.mcp.cloud.yandex.net/mcp`
|
`editor` or [`functions.admin`](../functions/security/index.md#functions-admin)
||
||
Workflows
|
`workflows`
|
`https://workflows.mcp.cloud.yandex.net/mcp`
|
`editor` or `serverless.workflows.admin`
||
||
API Gateway
|
`apigateway`
|
`https://apigateway.mcp.cloud.yandex.net/mcp`
|
`editor` or [`api-gateway.admin`](../api-gateway/security/index.md#api-gateway-admin)
||
||
MCP Gateway
|
`mcpgateway`
|
`https://mcpgateway.mcp.cloud.yandex.net/mcp`
|
`editor` or `serverless.mcpGateways.admin`
||
||
Data Catalog Consumer
|
`datacatalog-consumer`
|
`https://datacatalog-consumer.mcp.cloud.yandex.net/mcp`
|
[`data-catalog.viewer`](../metadata-hub/security/data-catalog-roles.md#data-catalog-viewer)
||
|#

For servers that access catalog resources (Toolkit, Search, Functions, Serverless Containers, Triggers, Workflows, API Gateway, MCP Gateway), you can provide default values via headers:

* `Cloud-Id`: Cloud ID for the `cloud_id` field in MCP server tools.
* `Folder-Id`: Folder ID for the `folder_id` field in MCP server tools.

Here is an example for the `npm` client:

```bash
npx @yandex-cloud/mcp -s toolkit -H "Folder-Id:<folder_ID>"
```

## Connection examples {#examples}

Connect an MCP server [manually](#ide-examples) or [using an AI agent](#connect-via-agent).

### Connecting via an AI agent {#connect-via-agent}

To configure and connect an MCP server, instruct your AI agent as follows:

```text
Connect the {{ yandex-cloud }} MCP server via `npx @yandex-cloud/mcp -s <server_name>`.
```

Where `<server_name>` is the **Server name for `npm` client (`-s`)** column value from the [table](#server-configs).

The AI agent will locate the configuration file and add the MCP server settings to it. To do this, it needs access to the file system and terminal.

### Connecting popular IDEs {#ide-examples}

Below is an example of connecting the Toolkit MCP server via the `npm` client. To connect another server, replace the `toolkit` server name in the `-s` parameter with a different name from [this table](#server-configs). If using Streamable HTTP, also replace the server [URL](#server-configs).

{% list tabs %}

- {{ ca-full-name }}

  {{ ca-full-name }} supports configuration at two levels: global and project. For more information, see [this {{ ca-name }} guide]({{ link-src-docs }}/code-assistant/operations/agent/mcp/overview).

  1. Click ![image](../_assets/console-icons/ellipsis.svg) in the chat's top panel and select MCP servers.
  1. Select the appropriate option:
      * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP**: Opens the global file named `mcp_settings.json`.
      * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP**: Opens the project file named `.codeassistant/mcp.json`. If there is no such file, {{ ca-name }} will create it automatically.
  1. Add the following configuration to the file:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Save the file.

- Claude Code

  [Claude Code](https://claude.com) supports configuration at two levels: global and project. Read more in [this Claude Code guide](https://docs.claude.com/en/docs/claude-code/mcp?utm_source=openai).

  1. Open the `.mcp.json` file in the project root (for project configuration) or `~/.mcp.json` in the home directory (for global configuration).
  1. Add the following configuration to the file:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Save the file.

  Test the connection:

  ```bash
  claude mcp get yandex-cloud-toolkit
  ```

- Cursor

  Cursor supports MCP servers via the `mcp.json` file. For more information, see [this Cursor guide](https://cursor.com/docs/mcp).

  1. Create the `.cursor/mcp.json` file in the project root (for project configuration) or `~/.cursor/mcp.json` in the home directory (for global configuration).
  1. Add the following configuration to the file:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Save the file and restart Cursor or refresh the list of MCP servers in the settings.

- OpenAI Codex

  [Codex](https://github.com/openai/codex) configures MCP servers in the `~/.codex/config.toml` file. For more information, see [this Codex guide](https://mintlify.wiki/openai/codex/configuration/mcp-servers).

  1. Open the `~/.codex/config.toml` file.
  1. Add the following configuration to the file:

     ```toml
     [mcp_servers.yandex-cloud-toolkit]
     command = "npx"
     args = ["-y", "@yandex-cloud/mcp", "-s", "toolkit"]
     ```

  1. Save the file and restart Codex.

- Zoo Code

  Zoo Code supports configuration at two levels: global and project. Read more in [this Zoo Code guide](https://docs.zoocode.dev/features/mcp/overview).

  1. Click ![image](../_assets/console-icons/gear.svg) in the chat's top panel.
  1. In the left-hand panel, select ![image](../_assets/layout-split-rows-dots.svg) **MCP Servers**.
  1. Select the appropriate option:
     * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP**: Opens the global file named `mcp_settings.json`.
     * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP**: Opens the project file named `.roo/mcp.json`. If there is no such file, Zoo Code will create it automatically.
  1. Add the following configuration to the file:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-toolkit": {
           "type": "stdio",
           "command": "npx",
           "args": [
             "-y", "@yandex-cloud/mcp",
             "-s", "toolkit"
           ]
         }
       }
     }
     ```

  1. Save the file.

{% endlist %}

## {{ yandex-cloud }} CLI as an alternative for agents {#cli-for-agents}

An AI agent with terminal access can manage {{ yandex-cloud }} resources directly via the [{{ yandex-cloud }} CLI](../cli/quickstart.md) without connecting an MCP server. This is helpful when the agent needs commands that are not yet available among the MCP server tools, or when the terminal is already the agent's primary tool.

To enable your agent to use the CLI:

1. [Install](../cli/quickstart.md#install) the {{ yandex-cloud }} CLI in the environment where the agent is running.
1. [Create a profile](../cli/quickstart.md#initialize). Log in as a user or [service account](../cli/operations/authentication/service-account.md).
1. Add the `--format json` parameter to CLI commands so the agent can deliver structured output, like this:

   ```bash
   yc compute instance list --format json
   ```

The roles required for specific CLI operations match the corresponding MCP server roles. For a full list of roles, see the [Server configurations](#server-configs) table.

## Testing {#testing}

Once the MCP server is connected, ask the AI agent to call one of the server tools.

Prompt examples:

> Deploy a VM in {{ yandex-cloud }} with a public IP address.

> Search the {{ yandex-cloud }} docs for instructions on how to configure a {{ TF }} provider.

> Create an {{ objstorage-name }} bucket for a static website.

If the connection is working properly, the AI agent will call the relevant MCP server tool and return you the operation result.

#### Useful links {#see-also}

* [Yandex Cloud MCP repository on GitHub](https://github.com/yandex-cloud/mcp)
* [@yandex-cloud/mcp package in npm](https://www.npmjs.com/package/@yandex-cloud/mcp)
* [{#T}](mcp-doc-server.md)


* [{#T}](../iam/concepts/authorization/iam-token.md)
* [{#T}](../cli/quickstart.md)
* [Recommended {{ ca-name }} MCP servers]({{ link-src-docs }}/code-assistant/operations/agent/mcp/recommended-mcp-servers)
