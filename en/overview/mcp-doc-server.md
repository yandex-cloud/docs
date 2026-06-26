---
title: Documentation MCP server for AI assistants, agents, and IDEs
description: Configure an MCP server to expose {{ yandex-cloud }} documentation to AI assistants, agents, and IDEs such as Cursor, Claude Code, OpenAI Codex, Zoo Code, and other MCP clients.
keywords:
  - AI agent
  - AI assistant
  - LLM
  - neural network
  - vibe coding
  - docs in IDE
  - up-to-date guides for AI
  - Yandex Cloud Markdown guides
  - md-doc
  - MCP server for Yandex Cloud docs
  - Yandex Cloud Documentation MCP Server
  - MCP guides for Yandex Cloud
  - Yandex Cloud guides in AI tools
  - Yandex Cloud guides for neural networks
  - how to connect Yandex Cloud docs to Cursor
  - how to connect Yandex Cloud docs to Claude Code
  - how to connect Yandex Cloud docs to Codex
  - Configuring Yandex Cloud MCP server
  - mcpServers Yandex Cloud configuration
  - connecting Yandex Cloud docs to AI assistant
  - Yandex Cloud docs MCP Cursor
  - Yandex Cloud documentation MCP Claude Code
  - Yandex Cloud MCP OpenAI Codex
  - MCP server for Yandex Cloud SourceCraft Code Assistant
  - Zoo Code Yandex Cloud MCP
  - documentation_generative_search
  - docs.mcp.cloud.yandex.net
  - Streamable HTTP MCP
  - generative search across docs
  - Model Context Protocol Yandex Cloud
  - MCP server without authorization
---

# {{ yandex-cloud }} guides in AI tools

## Documentation in Markdown format {#doc-markdown}

{{ yandex-cloud }} provides its complete documentation in Markdown format, allowing you to use it as context for AI tools in IDEs such as [Cursor](https://cursor.com), Visual Studio Code with [GitHub Copilot](https://docs.github.com/ru/copilot), [Continue](https://www.continue.dev/), [Cline](https://cline.bot/), and other assistants. This ensures your models generate responses based on up-to-date information, utilizing correct service names, CLI and API parameters, and accurate configuration examples.

Docs in Markdown format are available at:
[https://md-docs.website.yandexcloud.net/](https://md-docs.website.yandexcloud.net/)

## MCP server for searching though {{ yandex-cloud }} documentation {#yc-docs-search-mcp}

[{{ yandex-cloud }} Documentation MCP server](https://sourcecraft.dev/yandex-cloud/mcp/browse/servers/documentation-mcp-server/README.md) provides real-time access to official {{ yandex-cloud }} documentation through generative search. Connecting this server equips your AI assistants with the `documentation_generative_search` tool.

You can add this MCP server to any IDE that supports MCP. The server operates without authorization or tokens.

### Connection {#connect}

The {{ yandex-cloud }} Documentation MCP server is available via Streamable HTTP transport at:

```text
https://docs.mcp.cloud.yandex.net/mcp
```

### Configuration {#config}

MCP server configuration example:

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "type": "streamableHttp",
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

Where:

* `type`: Streamable HTTP transport. The possible values are:
  * `streamableHttp`: In CamelCase format.
  * `streamable-http`: In kebab-case format.
  * `http`: Simplified option for clients that support streaming by default.

## Connection examples for popular IDEs {#ide-examples}

{% list tabs %}

- {{ ca-full-name }}

  {{ ca-full-name }} supports configuration at two levels: global and project. For remote servers, {{ ca-name }} uses the Streamable HTTP transport, where the `type` field must be set to `streamable-http`. For more information, see [this {{ ca-name }} guide]({{ link-src-docs }}/code-assistant/operations/agent/mcp/overview).

  You can edit both global and project-specific MCP configuration files directly from the MCP settings menu in {{ ca-name }}:
  
  1. Click ![image](../_assets/console-icons/ellipsis.svg) in the chat's top panel and select MCP servers.
  1. Select the appropriate option:
      * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP**: Opens the global file named `mcp_settings.json`.
      * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP**: Opens the project file named `.codeassistant/mcp.json`. If there is no such file, {{ ca-name }} will create it automatically.

  1. Add the following configuration to the file:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-documentation": {
           "type": "streamable-http",
           "url": "https://docs.mcp.cloud.yandex.net/mcp"
         }
       }
     }
     ```

  1. Save the file.

- Claude Code

  [Claude Code](https://claude.com) supports configuration at two levels: global and project. For remote servers, Claude Code uses HTTP transport. Read more in [this Claude Code guide](https://docs.claude.com/en/docs/claude-code/mcp?utm_source=openai).

  {% list tabs %}
  
  - Project-level connection

    1. Open the `.mcp.json` file in the project root.

    1. Add the following configuration to the file:

       * Via HTTP transport:

         ```bash
         claude mcp add --transport http yandex-cloud-documentation \
           --scope project \
           https://docs.mcp.cloud.yandex.net/mcp
         ```

       * Via JSON configuration:

         ```json
         {
           "mcpServers": {
             "yandex-cloud-documentation": {
               "type": "http",
               "url": "https://docs.mcp.cloud.yandex.net/mcp"
             }
           }
         }
         ```

    1. Save the file.

  - User-level connection

    1. Open the `~/.mcp.json` file in you home directory.

    1. Add the following configuration to the file:

       * Via HTTP transport:

         ```bash
         claude mcp add --transport http yandex-cloud-documentation \
           --scope user \
           https://docs.mcp.cloud.yandex.net/mcp
         ```

       * Via JSON configuration:

         ```json
         {
           "mcpServers": {
             "yandex-cloud-documentation": {
               "type": "http",
               "url": "https://docs.mcp.cloud.yandex.net/mcp"
             }
           }
         }
         ```

    1. Save the file.

  {% endlist %}
  
  Check the connection in one of the following ways:
  
  * Terminal:

    ```bash
    claude mcp get yandex-cloud-documentation
    ```

  * Claude Code UI:

    ```text
    /mcp
    ```

- Cursor

  Cursor supports MCP servers via the `mcp.json` file. You can apply the configuration globally or for a specific project. For more information, see [this Cursor guide](https://cursor.com/docs/mcp).

  1. Create the file:

     * In the project root to apply the configuration to a specific project:

       ```text
       .cursor/mcp.json
       ```

     * In your home directory to apply the configuration globally:

       ```text
       ~/.cursor/mcp.json
       ```

  1. Add the following configuration to the file:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-documentation": {
           "type": "streamableHttp",
           "url": "https://docs.mcp.cloud.yandex.net/mcp"
         }
       }
     }
     ```

  1. Save the file and restart Cursor or refresh the list of MCP servers in the settings.

- OpenAI Codex

  [Codex](https://github.com/openai/codex) supports remote MCP servers via Streamable HTTP. For such a server, you must specify the `url` field in the configuration. MCP servers are configured in the `~/.codex/config.toml` file. For more information, see [this Codex guide](https://mintlify.wiki/openai/codex/configuration/mcp-servers).

  {% list tabs %}
  
  - Connecting via config.toml
    
    1. Open the `~/.codex/config.toml` file.

    1. Add the following configuration to the file:

       ```toml
       [mcp_servers.yandex-cloud-documentation]
       url = "https://docs.mcp.cloud.yandex.net/mcp"
       enabled = true
       ```

    1. Save the file and restart Codex.

  - Connecting via the CLI

    If your Codex version supports adding remote HTTP MCP servers via the CLI, run this command:

    ```bash
    codex mcp add yandex-cloud-documentation \
      --url https://docs.mcp.cloud.yandex.net/mcp
    ```

  {% endlist %}

- Zoo Code

  Zoo Code supports configuration at two levels: global and project. For remote servers, Zoo Code uses the Streamable HTTP transport, where the `type` field must be set to `streamable-http`. Read more in [this Zoo Code guide](https://docs.zoocode.dev/features/mcp/overview).

  You can edit both global and project-specific MCP configuration files directly from the MCP settings menu in Zoo Code:

  1. Click ![image](../_assets/console-icons/gear.svg) in the chat's top panel.
  1. In the left-hand panel, select ![image](../_assets/layout-split-rows-dots.svg) **MCP Servers**.
  1. Select the appropriate option:
     * ![image](../_assets/console-icons/pencil.svg) **Edit Global MCP**: Opens the global file named `mcp_settings.json`.
     * ![image](../_assets/console-icons/pencil.svg) **Edit Project MCP**: Opens the project file named `.roo/mcp.json`. If there is no such file, Zoo Code will create it automatically.

  1. Add the following configuration to the file:

     ```json
     {
       "mcpServers": {
         "yandex-cloud-documentation": {
           "type": "streamable-http",
           "url": "https://docs.mcp.cloud.yandex.net/mcp"
         }
       }
     }
     ```

  1. Save the file.

{% endlist %}

## Client-agnostic configuration {#universal-config}

If your MCP client supports JSON configuration with `mcpServers`, use one of the below connection options.

### Clients with `streamableHttp` {#camel-case}

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "type": "streamableHttp",
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

### Clients with `streamable-http` {#kebab-case}

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "type": "streamable-http",
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

### Clients with URL-based transport {#url-only}

```json
{
  "mcpServers": {
    "yandex-cloud-documentation": {
      "url": "https://docs.mcp.cloud.yandex.net/mcp"
    }
  }
}
```

## Testing {#testing}

After connecting the server, ask your AI assistant to look up information in the {{ yandex-cloud }} documentation. 

Request examples:

> Use the {{ yandex-cloud }} guides and explain how to install the YC CLI.

> Search the {{ yandex-cloud }} docs for instructions on how to configure a {{ TF }} provider.

If the connection is configured correctly, the AI assistant will call the MCP server tool (`documentation_generative_search`) and return a response based on information retrieved from the {{ yandex-cloud }} documentation.

## External tools {#external-tools}

### Context7 {#context7}

[Context7](https://github.com/upstash/context7) is an MCP server developed by Upstash. It provides AI assistants and code editors with up-to-date guides and code examples for current library versions.

To access the {{ yandex-cloud }} documentation, use [this Context7 repository](https://context7.com/yandex-cloud/docs). For detailed configuration instructions, see [here](https://github.com/upstash/context7#installation).
