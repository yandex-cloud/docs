# Your cloud resources are running normally, but you see gaps in monitoring charts


## Issue description {#issue-description}

On the monitoring page of your cloud resource, you see gaps and voids in one or more charts; however, your cloud resource operates properly.

## Solution {#issue-resolution}

Gaps in monitoring charts depend on the specifics of chart display for certain cloud resource types. This may be the case if you enabled downsampling in the chart settings. It substantially accelerates rendering of pages that aggregate many monitoring metrics. 

However, if {{ monitoring-name }} receives low values for certain metrics (plotted against the `Y` axis), you may see gaps in the chart lines with enabled downsampling. Such gaps usually do not mean you have issues with the cloud resource.

You can disable downsampling for a chart in {{ monitoring-name }}. To do this, follow these steps:

1. Open the page of your cloud resource and navigate to **{{ ui-key.yacloud.common.monitoring }}**.

1. In the top-right corner of the page, click **{{ ui-key.yacloud_monitoring.dashboard.dash.open-in-monitoring }}**:
   ![image](../../../_assets/troubleshooting/monitoring/open-in-monitoring-highlight.png)

1. Click the button to the right of the chart name:
   ![image](../../../_assets/troubleshooting/monitoring/compass-button-highlight.png)

1. Navigate to the **{{ ui-key.yacloud_monitoring.wizard.tab.downsampling }}** tab and select the **{{ ui-key.yacloud_monitoring.wizard.vis.downsampling.none }}** value for the **{{ ui-key.yacloud_monitoring.channel.field_method }}** field:
   ![image](../../../_assets/troubleshooting/monitoring/disable-thinning.png)
