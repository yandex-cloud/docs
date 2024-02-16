# Setting project limits

{% include [serverless-deprecation-note](../../../_includes/datasphere/serverless-deprecation-note.md) %}

In {{ ml-platform-name }}, you can set up consumption limits for a project. Project consumption thresholds are set in [units](../../pricing.md#unit).

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab and click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}** in the **{{ ui-key.yc-ui-datasphere.project-page.settings.limits }}** section.
1. Set one or more project computation limits:

   * **{{ ui-key.yc-ui-datasphere.edit-project-page.balance }}**: Total number of units available for the project. Each cell execution will reduce the balance by the number of units that is needed to perform one second of computations in the selected [configuration](../../concepts/configurations.md). You can run cells as long as the balance is positive. If the balance drops to zero or lower during computations in one of the cells, all running computations will stop and a warning will appear, saying that the project balance is insufficient.

   * **{{ ui-key.yc-ui-datasphere.edit-project-page.per-cell }}**: How many units a single cell can spend in a project. If a cell exceeds the set limit during computations, it will be stopped.

   * **{{ ui-key.yc-ui-datasphere.edit-project-page.per-time }}**: How many units per hour a project can spend. A check is performed when the computations are started; if the [price per hour](../../pricing.md#prices) for the selected configuration exceeds the set value, the cell will not start. If the current project consumption per hour exceeds this value during computations in a cell, all cells with active computations are stopped.

1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

Under [{{ ui-key.yc-ui-datasphere.common.general }}](update.md), you can specify the **{{ ui-key.yc-ui-datasphere.edit-project-page.period-of-inactivity }}** parameter to indicate how soon the cells with CPU or GPU loads less than 1% stop running (the default value is `{{ ui-key.yc-ui-datasphere.common.never }}`).

#### See also {#see-also}

* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
