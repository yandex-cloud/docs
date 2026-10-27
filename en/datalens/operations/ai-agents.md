---
title: Using {{ datalens-full-name }} with AI agents
description: In this article, you will learn how to start using AI agents in {{ datalens-name }}.
---

# Using {{ datalens-full-name }} with AI agents

You can use AI agents to work with {{ datalens-name }}. These include [Claude Code](https://claude.com/claude-code), [Codex](https://developers.openai.com/codex), [OpenCode](https://opencode.ai), and more. To do this, you need to connect {{ datalens-name }} to an AI agent using an [MCP server](../concepts/ai-agents.md#mcp) or [Python SDK](../concepts/ai-agents.md#sdk) and install [skills](../concepts/ai-agents.md#skills).


## Getting started {#before-you-begin}

* Make sure you have access to [{{ yandex-cloud }}]({{ link-console-main }}) and [{{ datalens-name }}]({{ link-datalens-main }}).
* Prepare the object in {{ datalens-name }} the AI agent will use: create a [workbook](../workbooks-collections/index.md) or select an existing one. To test the [chart](../concepts/chart/index.md) creation scenario, your workbook must contain an accessible [dataset](../dataset/index.md).
* Make sure you have the permissions to edit this workbook and the objects the AI agent will use.


{% note info %}

We do not recommend using both MCP and SDK for the same task.

{% endnote %}


## Connect {{ datalens-name }} to the AI agent {#connect-agent}

To connect {{ datalens-name }} to your AI agent, add your MCP server to the AI agent, or install [datalens-sdk](https://pypi.org/project/datalens-sdk/), a type-safe Python SDK for the {{ datalens-name }} API.

{% list tabs group="instructions" %}

- Claude Code {#claude-code}

  Add the server by running this command:

  ```bash
  claude mcp add datalens \
    --env DATALENS_ORG_ID=<organization_ID> \
    -- npx -y @datalens-tech/mcp@latest
  ```

  Alternatively, describe the server in the `.mcp.json` file in the project's root folder to make this configuration general for the command:

  ```json
  {
    "mcpServers": {
      "datalens": {
        "command": "npx",
        "args": ["-y", "@datalens-tech/mcp@latest"],
        "env": {
          "DATALENS_ORG_ID": "<organization_ID>"
        }
      }
    }
  }
  ```

  The same configuration format is used in Claude Desktop in the `claude_desktop_config.json` file.

- Codex {#codex}

  Add this section to the `~/.codex/config.toml` file:

  ```toml
  [mcp_servers.datalens]
  command = "npx"
  args = ["-y", "@datalens-tech/mcp@latest"]

  [mcp_servers.datalens.env]
  DATALENS_ORG_ID = "<organization_ID>"
  ```

- OpenCode {#opencode}

  Add the `mcp` section to the `opencode.json` file:

  ```json
  {
    "$schema": "https://opencode.ai/config.json",
    "mcp": {
      "datalens": {
        "type": "local",
        "command": ["npx", "-y", "@datalens-tech/mcp@latest"],
        "environment": {
          "DATALENS_ORG_ID": "<organization_ID>"
        }
      }
    }
  }
  ```

  {% note tip %}

  We recommend using `npx` for running Node.js, as the package is downloaded on demand and does not require installation. Alternatives include a local build from the [repository](https://github.com/datalens-tech/datalens-mcp) or global installation using `npm install -g @datalens-tech/mcp` and the `datalens-mcp` command.

  {% endnote %}

- Python SDK {#sdk}

  Run this command:

  ```bash
  pip install datalens-sdk
  ```

  **Example**

  This example assumes that the user uses an active {{ yandex-cloud }} CLI profile and refreshes IAM tokens themselves:

  ```python
  from datalens_sdk import {{ datalens-name }}ClientYC

  with {{ datalens-name }}ClientYC() as client:
      dataset = client.get.dataset(by_id="<dataset_ID>")
      print(dataset.name)
  ```

  Main features:

  * `client.get`: Downloading objects, such as datasets, charts, dashboards, workbooks, and collections.
  * `transfer_enabled`: Type-safe fluent builders to create objects.
  * Operations on objects: `.rename()`, `.update()`, `.delete()`.
  * Exporting objects' JSON shots to files and creating objects from shots (`client.raw`).
  * Exporting a dashboard together with its dependencies, i.e., charts and datasets.

  Authorization methods:

  * {{ yandex-cloud }} CLI profile (default).
  * Service account key, static IAM token.

  {% note warning %}

  The SDK is currently at the alpha version stage (0.x): until release 1.0, minor versions may include incompatible updates. Therefore, we recommend using the SDK together with the `datalens-sdk` skill for working with AI agents.

  {% endnote %}

{% endlist %}

{% note info %}

The MCP server and SDK support static authorization with a ready-made IAM token. Therefore, you can use AI agents when the {{ yandex-cloud }} CLI is not accessible, e.g., in an isolated runtime. The IAM token lifetime is 12 hours. You should refresh it yourself.

{% endnote %}


## Install skills {#install-skills}

Install `datalens-skills` for your AI agent to consider the {{ datalens-name }} object model and select task-appropriate tools.

{% list tabs group="instructions" %}

- Universal method {#npx}

  The `skills` CLI detects installed AI agents automatically.

  Run the following commands:

  ```bash
  npx skills add datalens-tech/datalens-skills --skill datalens
  npx skills add datalens-tech/datalens-skills --skill datalens-sdk
  ```

  {% note tip %}

  Use these flags:

  * `--agent '*'`: Install all detected AI agents.
  * `-g`: Globally for all projects.
  * `--list`: Show the list of available skills.

  {% endnote %}

- Claude Code {#claude-code}

  The repository works as a plugin marketplace.

  Run the following commands:

  ```text
  /plugin marketplace add datalens-tech/datalens-skills
  /plugin install datalens-skills@datalens
  ```

- Codex {#codex}

  1. Install the CLI version 0.142.0 or higher.
  1. Run these installation commands:

      ```bash
      codex plugin marketplace add datalens-tech/datalens-skills
      codex plugin add datalens-skills@datalens
      ```

      When installed using a plugin, skill names are prefixed, e.g., `datalens-skills:datalens-sdk`. 

- Manually {#manual}

  Copy the relevant folders from `skills/` to the folder scanned by the AI agent:

  | AI agent | In projects | Globally |
  | --- | --- | --- |
  | Claude Code | `.claude/skills/`   | `~/.claude/skills/` |
  | Codex       | `.agents/skills/`   | `~/.agents/skills/` |
  | OpenCode    | `.opencode/skills/` | `~/.config/opencode/skills/` |

  {% note tip %}

  The `.agents/skills/` folder is vendor-neutral: both Codex and OpenCode can read it. OpenCode can also read `.claude/skills/`; therefore, one installation is often enough for multiple AI agents.

  {% endnote %}

{% endlist %}


## Send your request {#send-request}

After connecting {{ datalens-name }} to the AI agent and installing the skills, write a natural language task and specify the IDs of the objects to use.

1. Run a new AI agent session.
1. Send your request via the AI agent.


### Common scenarios {#examples}

Below you can find examples of requests to an AI agent with installed skills and an MCP server.

* **Dependency audit**

    Request:

    ```text
    Find all charts and dashboards that use <dataset_ID>.
    ```

    Result: The AI agent will call the navigation commands and Relations API via the MCP.

* **Content cloning**

    Request:

    ```text
    Clone <dashboard_ID> with all its charts and datasets
    to <workbook_ID>.
    ```

    Result: The AI agent will write an SDK script with dependency export.

* **Creating from scratch**

    Request:

    ```text
    Connect to the database, create a dataset with a calculated field for the margin,
    and build a dashboard with sales by region.
    ```

    Result: The AI agent will create the following chain: connection → dataset → charts → dashboard.

* **Bulk changes**

    An SDK task: a loop for objects with typed updates.

    Request:

    ```text
    In all the workbook's datasets, rename the _revenue_ field to _Revenue_.
    ```

    Result: The AI agent will rename the specified fields.

* **AI report**

    Request:

    ```text
    Create an HTML report on the quarter results and publish it in {{ datalens-name }}.
    ```

    Result: The `datalens-html-pages` skill will let the agent create, validate, and publish a page.


## Useful links {#see-also}

* [{#T}](../concepts/ai-agents.md)
* [{#T}](../operations/api-start.md)
* [@datalens-tech/mcp MCP server](https://github.com/datalens-tech/datalens-mcp)
* [npm](https://www.npmjs.com/package/@datalens-tech/mcp)
* [datalens-skills collection](https://github.com/datalens-tech/datalens-skills)
* [Python SDK datalens-sdk](https://pypi.org/project/datalens-sdk/)
* [Agent Skills standard](https://agentskills.io)
* [Model Context Protocol](https://modelcontextprotocol.io)