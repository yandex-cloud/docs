---
title: '{{ datalens-full-name }} release notes: December 2025'
description: Check out the {{ datalens-full-name }} release notes for December 2025.
---

# {{ datalens-full-name }} release notes: December 2025

* [Changes in basic features](#base)
* [Fixes and improvements](#fixes)

## Changes in basic features {#base}


* The annual [{{ datalens-short-name }} Fest]({{ link-datalens-main }}/festival), held from December 8 to 16, 2025, presented a series of offline and online activities – videos, live broadcasts, use cases, and contests – for participants to explore the all-new {{ datalens-short-name }} features, including [AI tools](../concepts/neuroanalyst.md), [customization](../settings/appearance.md), on-premises, and migration.
* New works available in [{{ datalens-gallery }}]({{ link-datalens-main }}/gallery). For more information, see the [{{ datalens-short-name }}](https://t.me/YandexDataLens/28631/145412) Telegram chat.
* [Neuroanalyst on your dashboard](../dashboard/insights.md) can now search for insights within an entire dashboard tab. It will analyze your question and dashboard contents, select relevant charts, draw data from them, and come up with the final insight. For context, it uses descriptions of dashboards, charts, datasets, and connections, as well as the data you upload.
  To try it, click **Neuroanalyst** at the top of the dashboard to open the **Neuroanalyst** tab on the right.


* Added the option to add [connection](../operations/connection/add-description.md) and [dataset](../dataset/add-description.md) info.
* Added the following to the [calculated field](../concepts/calculations/index.md) formula editor:

  * [Hash functions](../function-ref/hash-functions.md): `MD5`, `SHA256`, `CITYHASH64` and others.
  * `DB_CALL` [native functions](../function-ref/native-functions.md) for access to database functions. The `DB_CALL` functions allow you to:
    
    * Securely use string and aggregate functions from any databases.
    * Access types not currently supported by {{ datalens-short-name }}.
    * Streamline your workflow and optimize source workloads.

    {% note info %}
    
    Use these native functions for specific point operations {{ datalens-short-name }} does not support yet. For standard operations, e.g., aggregations, math operations, use the built-in {{ datalens-short-name }} functions for better optimization.

    {% endnote %}


* Implemented the option to save a chart as a `PNG` image. To do this:

  1. Open the chart and click ![image](../../_assets/console-icons/ellipsis.svg) → ![icon](../../_assets/console-icons/arrow-down-to-line.svg) **Save as** → **Image** in its top-right corner.

  1. Select resolution:

     * Standard, 800x600.
     * Widescreen, 1600x720.
     * Specify manually.
  
  1. Optionally, enable **Display interface elements**.
  1. Click **Download**.



## Fixes and improvements {#fixes}

* Fixed the issue of incorrectly saved original background when copying a dashboard widget. Earlier, if set to `Basic chart background`, the original widget background would reset to transparent when copying.
* Updated the appearance of the selector and chart setup window.


* Restored the display of `Request-id` and `Trace-Id` in the [private embedding](../security/private-embedded-objects.md) errors.



### Fixes in Neuroanalyst {#neuroanalyst-fixes}

* Now charts save the context of your chat with [Neuroanalyst for creating calculated fields](../concepts/calculations/formulas-helper.md):

  * When changing a formula.
  * When closing the chat.


### Fixes in charts {#chart-fixes}

* Fixed the [pie chart](../visualization-ref/pie-chart.md) colors issue. Now colors are as per your selection in the [dataset field settings](../dataset/create-dataset.md#setup-fields).

