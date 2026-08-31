# Working with the Public API


{{ datalens-name }} provides a public API, [https://api.datalens.tech](https://api.datalens.tech), to automate operations with dashboards, charts, datasets, and connections.

The {{ datalens-name }} Public API offers methods similar to those used in the {{ datalens-name }} web interface. This API is described using the OpenAPI specification and authenticated via Yandex Cloud IAM tokens.

When using the API, please be aware of the [limits](../concepts/limits.md#datalens-api-limits) in place.

To use the API, you need an [IAM token]({{ link-docs }}/iam/operations/iam-token/create) and an [organization ID](../settings/index.md#service-settings).

For example, substitute your `<IAM_TOKEN>`, `<ORG_ID>`, and `<ENTRY_ID>` values into the following request to get a list of all objects related to the entity:

```bash
curl -X 'POST' \
  'https://api.datalens.tech/rpc/getEntriesRelations' \
  -H 'accept: application/json' \
  -H 'x-dl-api-version: 1' \
  -H 'Authorization: Bearer <IAM_TOKEN>' \
  -H 'x-dl-org-id: <ORG_ID>' \
  -H 'Content-Type: application/json' \
  -d '{
  "entryIds": [
    "<ENTRY_ID>"
  ]
}'
```




## MCP server {#mcp-server}

The {{ datalens-name }} [MCP server](https://www.npmjs.com/package/@datalens-tech/mcp) provides LLM agents with access to the public API.


The server uses the MCP protocol via stdio. Add it to the MCP client configuration using one of the following methods:

* **Via npx (recommended)**. Run this request for npx to download the published package, no manual installation or compilation required:

  ```bash
  {
    "mcpServers": {
      "datalens": {
        "command": "npx",
        "args": ["-y", "@datalens-tech/mcp@latest"],
        "env": {
          "DATALENS_ORG_ID": "<org-id>"
        }
      }
    }
  }
  ```

* **Using global installation**. Install the package once, then use the `datalens-mcp` command:

  ```bash
  npm install -g @datalens-tech/mcp
  ```

  ```bash
  {
    "mcpServers": {
      "datalens": {
        "command": "datalens-mcp",
        "env": {
          "DATALENS_ORG_ID": "<org-id>"
        }
      }
    }
  }
  ```

* **From a local build**. Use this option if you cloned the repository. Compile it first:

  ```bash
  npm ci
  npm run build
  ```

  Then point the client to the compiled file:

  ```bash
  {
    "mcpServers": {
      "datalens": {
        "command": "node",
        "args": ["/absolute/path/to/datalens-mcp/dist/index.js"],
        "env": {
          "DATALENS_ORG_ID": "<org-id>"
        }
      }
    }
  }
  ```

Where `DATALENS_ORG_ID` is your organization's ID.

By default, the server runs `yc iam create-token` to get an IAM token.

{% include [cli-install](../../_includes/cli-install.md) %}

Additional `yc` settings:

* `DATALENS_YC_PROFILE`: Use a specific `yc` profile instead of the active one.
* `DATALENS_YC_BIN`: Full path to the `yc` binary file if not located in `PATH`.


If you cannot run `yc` (e.g., in an isolated environment), you can manage the IAM token yourself: install `DATALENS_YC_STATIC_AUTH=1` and put the token in `DATALENS_API_AUTH_HEADER="Bearer <iam-token>"`. The value will be sent on each request, unmodified, and `yc` will never be called.

{% note info %}

IAM tokens expire in 12 hours. With this approach, it is up to you to update `DATALENS_API_AUTH_HEADER` and restart the server before the token expires.

{% endnote %}


### Environment requirements {#requirements}

To run an MCP server alongside an agent or MCP client, make sure your environment meets these prerequisites:


* [Node.js](https://nodejs.org/) version 18 or higher.
* `npm` and `npx`, accessible via `PATH` (usually bundled with Node.js).
* [`yc` CLI]({{ link-docs }}/cli/quickstart) if using the recommended authorization method via {{ yandex-cloud }}. When authorizing with a `yc` static token, the CLI is not required.


### Use cases {#example}

* Use cases on [GitHub](https://github.com/datalens-tech/datalens-mcp/blob/HEAD/.env.example)

