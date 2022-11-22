# Set project limits

In {{ ml-platform-name }}, you can set up consumption limits for a project. Consumption thresholds for a project or folder are set in billing [units](../../pricing.md#unit).

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **Settings** tab and click **Edit**.
1. Set one or more project computation limits:

   * **Per cell**: How many units a single cell can spend in a project. If a cell exceeds the set limit during computations, it is stopped.

   * **Units per hour**: How many units per hour a project can spend. A check is performed when the computations are started and if the [price per hour](../../pricing.md#prices) for the selected configuration exceeds the set value, the cell won't start. If the current project consumption per hour exceeds this value during computations in a cell, all cells with active computations are stopped.

   * **Idle time**: How soon the cells with a CPU or GPU load less than 1% will stop running (the default value is `Never`).

1. Click **Save**.

#### See also {#see-also}

* [{#T}](install-dependencies.md).
* [{#T}](control-compute-resources.md).
