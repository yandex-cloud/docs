# Setting project limits

In {{ ml-platform-name }}, you can set up consumption limits for a project. Project consumption thresholds are set in [units](../../pricing.md#unit).

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab and click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}** in the **{{ ui-key.yc-ui-datasphere.project-page.settings.limits }}** section.
1. Specify the **{{ ui-key.yc-ui-datasphere.edit-project-page.balance }}**, i.e., the total number of units available for the project. After you run computations, the project balance will start reducing by the number of units required for the selected [configuration](../../concepts/configurations.md) to operate until one of the following conditions is met:
   * Balance becomes zero or less. Then, all the computations will stop with the warning of insufficient project balance.
   * The time specified in **{{ ui-key.yc-ui-datasphere.common.general }}** expires.
   * You stop the VM.

1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### See also {#see-also}

* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
