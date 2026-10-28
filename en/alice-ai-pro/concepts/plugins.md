---
title: Plugins, skills, and connectors
description: Learn about the difference between plugins, skills, and connectors in {{ alice-ai-pro-name.p }}.
---

# Plugins, skills, and connectors

Plugins, skills, and connectors extend the {{ alice-ai-pro-name.r }} functionality, but each works differently:

#|
|| **Type** | **Used for** | **Comparison** ||
|| Skill | Tells {{ alice-ai-pro-name.d }} how to perform a recurring or multi-step task. Can comprise instructions, templates, and reference materials. | Instruction or formula. ||
|| Connector | Gives {{ alice-ai-pro-name.d }} tools for working with an external application or data. To connect, you may need to sign in and allow access. | Key to an external application. ||
|| Plugin | Adds ready-made capabilities for specific tasks. Can comprise skills, connectors, or both. | Ready-made work kit. ||
|#

A skill and a connector can work separately. A plugin can combine them into a single ready-made kit.

## Skills {#skills}

A *skill* is a prepared instruction for {{ alice-ai-pro-name.r }}. It describes the timeline and order of actions and what the expected result should be. A skill can comprise templates, examples, and other materials.

For example, a skill can teach {{ alice-ai-pro-name.v }} to generate a report based on a corporate template or review a document per given rules. As such, a skill does not give access to external applications.

{{ alice-ai-pro-name.i }} can select a relevant skill based on the task description. If you prefer to use a specific skill, specify it in your request.

## Connectors {#connectors}

A *connector* integrates {{ alice-ai-pro-name.v }} with an external application. A connector provides {{ alice-ai-pro-name.i }} with access to actions supported by an external application, such as finding a document, reading a task, or creating a record.

A connector may require an authorization. In which case you will sign in to the external application and authorize access. {{ alice-ai-pro-name.i }} will be able to perform only the actions that are available through the connector and allowed to your account.

## Plugins {#plugins}

A *plugin* is a ready-made {{ alice-ai-pro-name.r }} extension. It can add a single skill, multiple related skills, connectors for external applications, or all of these at once.

For example, think of a plugin made to summarize a meeting. It may comprise a skill used to write a summary and a connector to retrieve the record of the meeting from an external application.

The available plugins are set up by the organization administrator. If you need a plugin that is not in the catalog, contact the administrator. For some plugins, you need to link an account or grant access to an external application.

## How they work together {#together}

A single task may require {{ alice-ai-pro-name.d }} to have both a skill and a connector. Here is an example:

1. {{ alice-ai-pro-name.i }} retrieves some data from an external application via a connector.
1. The skill determines how to process the data and what the final result should look like.
1. If the skill and connector are part of the same plugin, the plugin adds both capabilities as a ready-made kit.

## Connection and usage {#connect-and-use}

Open the plugin catalog and select the plugin you need. If the plugin requires connectors, {{ alice-ai-pro-name.i }} will prompt you to connect them right away or the first time you need them.

Before connecting, check what data the connector will gain access to. Your ability to connect or use a plugin, skill, or connector can be restricted by the organization administrator.

Describe the task in the chat and specify which plugin to use. If {{ alice-ai-pro-name.d }} needs additional information or permissions, it will request them when performing the task.

## Use cases {#examples}

Examples of tasks:

- Using a skill to generate a document according to predefined criteria.
- Using a connector to find data in an external application.
- Using a plugin to retrieve data from an external application and process it according to a predefined scenario.

The available scenarios depend on your connected plugins, skills, and connectors.

#### Useful links {#see-also}

- [{#T}](permissions.md)
- [{#T}](../operations/chats.md)
