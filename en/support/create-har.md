---
title: Saving browser-server interactions to a HAR file
description: This article explains how to save browser-server interactions to a HAR file.
---

# Saving browser-server interactions to a HAR file

If you encounter an error while using the {{ yandex-cloud }} console, a HAR file can help troubleshoot it. It is a network log of the interaction between a browser and a web page. For {{ yandex-cloud }} specialists to be able to identify the cause of a server malfunction, enable logging and reproduce the error. Save the HAR file and send it to [technical support]({{ link-console-support }}).

{% list tabs group=web_browsers %}

- Yandex Browser {#yandex}

  {% include [create-har-yandex](../_includes/support/create-har-yandex.md) %}

- Google Chrome {#chrome}

  {% include [create-har-chrome](../_includes/support/create-har-chrome.md) %}

- Opera {#opera}

  {% include [create-har-opera](../_includes/support/create-har-opera.md) %}

- Mozilla Firefox {#firefox}

  {% include [create-har-firefox](../_includes/support/create-har-firefox.md) %}

- Microsoft Edge {#edge}

  {% include [create-har-edge](../_includes/support/create-har-edge.md) %}

- Safari {#safari}

  {% include [create-har-safari](../_includes/support/create-har-safari.md) %}

{% endlist %}

{% note alert %}

The HAR file contains cookies of your active session in {{ yandex-cloud }}. For security reasons, we recommend that you [terminate the session]({{ link-auth-logout }}) after sending the file.

{% endnote %}
