---
title: MCP server templates
description: '{{ mcp-hub-name }} MCP server templates allow you to create MCP servers for AI agents to access services of external {{ yandex-cloud }} partners.'
---

# MCP server templates

{% include [note-preview](../../../_includes/note-preview.md) %}

{{ foundation-models-full-name }} offers some MCP server templates from external {{ yandex-cloud }} partners. You can use these in your AI agents to access these partners' services. To add such an MCP server to {{ mcp-hub-name }}, select the template you need and provide authentication credentials. This will make the server available for connection to your agents.

## Kontur.Focus {#kontur}

The [Kontur.Focus](https://kontur-inc.com/focus) MCP server is designed for screening of counterparties, Russian legal entities and individual entrepreneurs. Use the server to obtain counterparty details, a brief report on their status, and their credibility score against multiple criteria. To search for organizations and individual entrepreneurs, use their TIN. Other parameters, e.g., the director’s name, company’s address, or website, are also supported. To retrive information, the `req`, `search`, `scoring`, and `briefReport` methods are used.

To get an access token, visit the partner’s [website](https://focus.kontur.ru/).

## amoCRM {#amocrm}

The [amoCRM](https://www.amocrm.com/) MCP server enables AI agents to work with information from amoCRM: get information about companies, leads, and contacts from the [CRM](https://en.wikipedia.org/wiki/Customer_relationship_management) system, create and edit data, create notes, view pipelines and issues.

To get access to the CRM, an AI agent must provide authentication credentials to the MCP server:
* Access token in the `X-Auth-Token` header. To get the access token, follow [this guide](https://www.amocrm.ru/developers/content/oauth/step-by-step#get_access_token).
* Account name in the `X-Account-Name` header.

## {{ tracker-full-name }} {#tracker}

The [{{ tracker-full-name }}](https://360.yandex.ru/business/tracker/) MCP server provides an AI agent with full access to issues and other {{ tracker-full-name }} entities. The server supports tools for getting information about an issue, project, portfolio, or goal.

The available tools include:

* Getting issue links.
* Creating an issue, a comment to an issue, or a goal.
* Updating an issue status, issue parameters, or goal parameters.
* Bulk changes to issues, issue statuses, projects, portfolios, and goals.
* Bulk transfer of issues to a different queue.

To get access to {{ tracker-name }}, provide authentication credentials to the MCP server:
* Access token in the `token` header with the `OAuth/Bearer` prefix.
* Organization ID or [cloud organization ID](../../../organization/concepts/organization.md), in the `x-org-id` or `x-cloud-org-id` header, respectively.

For more information on getting authentication credentials, see {{ tracker-full-name }} [guides](https://yandex.ru/support/tracker/ru/concepts/access).

## {{ search-api-full-name }} {#search-api}

The [{{ search-api-full-name }}](../../../search-api/index.yaml) MCP server enables AI agents, such as {{ foundation-models-name }}, Claude, or Cursor, to use the Yandex [API](../../../search-api/api-ref/authentication.md) for internet search and safely find relevant information using {{ search-api-full-name }}.

To get access to {{ search-api-name }}, you need an [API key](../../../iam/concepts/authorization/api-key.md). For more information, visit [this GitHub repository](https://github.com/yandex/yandex-search-mcp-server).

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](../../operations/mcp-servers/create-from-template.md)