# Set project limits

In {{ ml-platform-name }}, you can set up consumption limits for a project. Project consumption thresholds are set in [units](../../pricing.md#unit).

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **Settings** tab and click **Edit**.
1. Set one or more project computation limits:

   * **Project balance**: The total number of units available for the project. Each execution of a cell will reduce the balance by the number of units that is needed to perform one second of computations in the selected [configuration](../../concepts/configurations.md). You can run cells as long as the balance is positive. If the balance drops below or equals zero during computations in one of the cells, all running computations are stopped and a warning saying that the project balance is insufficient is shown.

   * **Per cell**: How many units a single cell can spend in a project. If a cell exceeds the set limit during computations, it is stopped.

   * **Units per hour**: How many units per hour a project can spend. A check is performed when the computations are started; if the [price per hour](../../pricing.md#prices) for the selected configuration exceeds the set value, the cell will not start. If the current project consumption per hour exceeds this value during computations in a cell, all cells with active computations are stopped.

   * **Period of inactivity**: How soon the cells with a CPU or GPU load less than 1% will stop running (the default value is `Never`).

1. Click **Save**.

#### See also {#see-also}

* [{#T}](install-dependencies.md).
* [{#T}](control-compute-resources.md).
