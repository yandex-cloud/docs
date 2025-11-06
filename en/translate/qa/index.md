---
title: '{{ translate-full-name }}. FAQ'
description: How to get my activity logs in {{ translate-full-name }}? Find the answer to this and other questions in this article.
---

# {{ translate-name }} general questions

{% include [logs](../../_qa/logs.md) %}

#### Can I mark a text fragment that does not need translation? {#notranslate}

Yes, when translating an `HTML` text, you can exclude a text fragment from translation using the container element's `translate="no"` attribute:

```html
This text is <span translate="no">not translated</span>.
```
