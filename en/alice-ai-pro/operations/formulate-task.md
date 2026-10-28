---
title: How to set tasks
description: Formulate clear prompts and refine the result iteratively with {{ alice-ai-pro-name.t }}.
---

# How to set tasks

You do not need to learn special commands to work with {{ alice-ai-pro-name.t }}. Simply describe your task using plain, everyday language.

{% include [task-formulation-basics](../../_includes/alice-ai-pro/task-formulation-basics.md) %}

## Start with the outcome {#outcome}

Begin by describing the result you would like to get. For a complex task, add details: explain what you want the result to include and who it is intended for.

For example, instead of `Write an email`, provide a detailed prompt:

> Write an email to a customer explaining that their delivery date has changed. The customer must understand the new date and the reason why it has changed. Keep the tone of voice neutral and friendly.

In most cases, describing the target result is enough. Do not break the task into steps unless the specific sequence of actions is critical.

## Develop a plan first {#plan}

For large or ambiguous tasks, enable **Planning mode**. In this mode, {{ alice-ai-pro-name.i }} will ask clarifying questions and draft a step-by-step plan before it proceeds with the task itself.

1. In the message input field, type `/`.
1. Select **Planning mode**.
1. Describe your task.
1. Answer the follow-up questions by choosing a suggested option or typing your own.
1. Review the generated plan.

To return to a regular chat, type `/` again and disable **Planning mode**. Then ask {{ alice-ai-pro-name.v }} to proceed with the approved plan.

Do not confuse the planning mode with the [model’s operating mode](../concepts/models.md). The planning mode creates a structured roadmap for a task, while the operating mode defines the depth of model analysis.

## Provide source information {#context}

Include the specific facts and assets the model should rely on. Attach files if the relevant information lives in a document, table, or image. If there are multiple files, explain how each one should be used.

Do not assume {{ alice-ai-pro-name.i }} knows your organization's internal rules, agreements, or naming conventions. Include this context in your prompt or your project files.

If you want the response to rely solely on the provided materials, state this explicitly. You can also ask the model to flag any missing information rather than filling in the gaps with assumptions.

## Specify result requirements {#requirements}

Only include requirements that directly impact the output. For example:

- Target audience and tone of voice.
- Text length or number of options.
- Information that must be kept unchanged.
- Format: list, table, letter, plan, or file.
- Whether to cite sources or highlight assumptions.

If an important requirement arises later, mention it in the same chat. You do not need to repeat your entire original prompt.

## Refine the result iteratively {#iterate}

After receiving the initial response, describe exactly what must be changed. For example: `Write a shorter introduction of just two sentences, but keep the dates and the participant list`.

To continue working on the same task, use your current chat: {{ alice-ai-pro-name.i }} remembers the context of previous messages. For a new, unrelated task, start a new chat so that earlier materials and requirements do not affect the new response.

## Check the result {#verify}

Always verify critical facts, calculations, dates, and decisions before actually using them. If the result must rely on external sources, ask for reference links. Download or save the final files intended for use outside the chat.

## Prompt template {#template}

For a large or complex task, you can use a template:

```text
Task: what you need to accomplish or generate.
Source information: the specific context or files to use.
Requirements: specific criteria to take into account and details to preserve.
Result: format, length, and target audience.
```

Only fill out the sections you need. For a simple task, a sentence or two is usually enough.

#### Useful links {#see-also}

- [{#T}](../quickstart.md)
- [{#T}](chats.md)
- [{#T}](../concepts/models.md)
- [{#T}](../concepts/permissions.md)
