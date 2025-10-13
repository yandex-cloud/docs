---
title: '{{ sd-full-name }} AI assistant'
description: The {{ sd-full-name }} AI assistant is a source of recommendations on how to set up your {{ yandex-cloud }} services for security and make sure your infrastructure complies with security requirements.
---

# {{ sd-name }} AI assistant

{% include [preview-by-request](../../_includes/note-preview-by-request.md) %}

The {{ sd-name }} AI assistant is a source of recommendations on how to set up your {{ yandex-cloud }} services for security and make sure your infrastructure complies with security requirements. The AI assistant is built around a fine-tuned {{ yagpt-name }} [model](../../ai-studio/concepts/generation/models.md) and draws information from the internal knowledge base and {{ yandex-cloud }} [documentation](../../index.yaml).

## Integration with alerts

You can run the AI analysis on the [alert](./alerts.md) page. The AI assistant will help you fix your configuration issue with due regard for the alert's context and parameters. In addition to its recommendations, the AI assistant will prepare a summary and explain the substance of the alert.

#### See also {#see-also}

* [{#T}](./alerts.md)