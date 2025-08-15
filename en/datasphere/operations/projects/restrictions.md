---
title: Setting project limits
description: Follow this guide to set consumption limits for a project.
---

# Setting project limits

In {{ ml-platform-name }}, you can set consumption limits for your project, measured in [units](../../pricing.md#unit).

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab and click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.project-page.settings.limits }}** under **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Specify the **{{ ui-key.yc-ui-datasphere.edit-project-page.balance }}**, i.e., the total number of units available for the project. After you run computations, the project balance will start reducing by the number of units required for the selected [configuration](../../concepts/configurations.md) to operate until one of the following conditions is met:
   * The balance becomes zero or less. In this case, all running computations will stop with a warning that the project balance is insufficient.
   * The time specified in the **{{ ui-key.yc-ui-datasphere.common.general }}** section expires.
   * You stop the VM manually.

1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### See also {#see-also}

* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
