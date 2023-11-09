---
title: "How to reset the interpreter state"
description: "Follow this guide to reset the interpreter state."
---

# Resetting the interpreter state

{{ ml-platform-name }} only [saves the interpreter state](../../concepts/save-state.md) in {{ ds }} mode.

{% note alert %}

This action resets all results and clears the state of variables.

{% endnote %}

{% list tabs %}

- {{ ds }}

   To reset the interpreter state:

   1. In the top panel of the project window, click **Kernel**.
   1. In the menu that opens, click **Reset Variables in Kernel State**.

{% endlist %}

#### What's next {#what-is-next}

* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
* [{#T}](export.md)
