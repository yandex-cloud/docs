---
title: '{{ translate-full-name }}. Questions and answers'
description: How do I get the logs of my activity in {{ translate-full-name }}? Find the answer to this and other questions in this article.
---

# {{ translate-name }} general questions

{% include [logs](../../_qa/logs.md) %}

#### Can I mark a fragment of text as not to be translated? {#notranslate}

Yes, when translating text in `HTML` format, a fragment of text can be excluded from translation using the `translate="no"` attribute on the container element:

```html
This is <span translate="no">untranslated</span> text.
```
