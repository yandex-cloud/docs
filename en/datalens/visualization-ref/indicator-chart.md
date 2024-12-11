# Indicator ![](../../_assets/datalens/indicator.svg)

An indicator reflects the value of a single key measure. It is used when a dashboard contains values that need to be monitored on a regular basis to understand the overall situation. These can be the number of incidents for the past day, plan performance, or a YoY increase in sales. Indicators are most often placed at the top or on the right side of a dashboard. Make sure there are no more than six indicators per screen so that they do not lose their urgency or confuse users. Using indicators of different sizes, you can build a hierarchy of the various metrics according to significance.

![indicator-chart](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart.png)

You can set up the size and color of an indicator.

![indicator-chart-red](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart-red.png)

{% cut "Source table" %}

Year |	Sales|	
-----|---------| 
2022|	6M |	
2021|	28M |	
2020|	18M |	
2019|	9M | 
2018|	1M |

{% endcut %}

## Wizard sections {#wizard-sections}

Section<br/> section| Description
----- | ----
Measure  | Measure. One measure that determines the indicator value.
Filters | Dimension or measure. Used as a filter.

## Creating an indicator {#create-diagram}

To create an indicator:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![chart](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize.
1. Select the **Indicator** chart type.
1. Drag a dimension or measure from the dataset to the **Measure** section. The value is displayed as a number.

## Additional settings {#additional-settings}

### Changing indicator size and color {#size-color-setting}

To change indicator size and color:

1. In the **Measure** section, click ![](../../_assets/console-icons/gear.svg).
1. In the **Indicator settings** window, select the size and color and click **Apply**.

### Customizing header display {#indicator-title}

To customize header display:

1. At the top of the screen, click ![image](../../_assets/console-icons/gear.svg) next to the chart type.
1. Select header display options:

   * `Field name`: Show field name in header.
   * `Manually`: Rename header.
   * `Hide`: Hide header.

1. Click **Apply**.

{% cut "Chart settings window" %}

![indicator-chart-settings](../../_assets/datalens/release-notes/preview-disable.png)

{% endcut %}

## Recommendations {#recommendations}

* Use emojis when calculating indicator values to make them more informative.

  ![indicator-chart-emoji](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart-emoji.png)

  This indicator chart uses a calculated field with the following formula: `IF([Average spend]>2200, CONCAT("✔️",STR(ROUND([Average spend]))),CONCAT("🔻",STR(round([Average spend]))))`.

* Describe the context to make it clear what indicators mean.

  ![indicator-chart-context](../../_assets/datalens/visualization-ref/indicator-chart/indicator-chart-context.png)

#### See also {#see-also}

* [{#T}](../operations/dashboard/create.md)
* [{#T}](../operations/dashboard/add-chart.md)
* [{#T}](../operations/dashboard/add-selector.md)