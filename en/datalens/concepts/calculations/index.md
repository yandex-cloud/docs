# Calculated fields

A calculated field is an additional [data field](../dataset/index.md#field) with values calculated using a formula.
You can use calculated fields to create new dimensions and measures.
The data source remains unchanged.

To write formulas, you can use existing dataset fields, [parameters](../parameters.md), constants, and [functions](#functions).

You can [create](#how-to-create-calculated-field) calculated fields in the dataset or wizard interface:

* Calculated fields from a dataset are available in all charts above this dataset.
* Calculated fields from the wizard are only available for saved charts.

## Calculated fields in datasets {#dataset}

You can add new fields to a dataset field list.

When creating a formula, you can use any dataset field, including the calculated fields that you created earlier. 

After creating a calculated field and saving the dataset, the field becomes available to all the charts and dashboard [selectors](../dashboard.md#selector) based on that dataset.
To hide fields in the wizard, enable the **Don't display** option when creating them.

Calculated fields are marked with ![image](../../../_assets/datalens/formula-dataset.svg).

## Calculated fields in charts {#chart}

You can add new fields when creating and editing charts in the wizard:

* In the list of fields from a dataset.
* In the visualization section.

When creating a formula, you can use any dataset field, including the calculated fields that you created earlier. 

If a field is created in a chart, it isn't available to dashboard selectors and other charts.

Calculated fields are marked with ![image](../../../_assets/datalens/formula-dataset.svg).

{% note warning %}

In [multi-dataset charts](../chart/index.md#multi-dataset-charts), calculated fields are not applicable to fields from multiple datasets.

{% endnote %}

## Functions {#functions}

Functions are the principal components used for creating formulas. You can use them to perform various operations on data fields.

The list of available functions depends on the data source. For more information, see [{#T}](../../function-ref/availability.md).

{% note warning %}

Avoid calculation loops: in a formula, you can't use a field that uses the same formula to calculate its own value.

{% endnote %}


### Notation format {#entry-format}

Write formulas that meet the following requirements:

1. Function arguments are specified in parentheses. For example, `YEAR([DATE1])`. Multiple arguments are separated by a comma.
1. Field names are given in square brackets. For example, `[CustomerID]`.
1. Make sure to enter the values of fields and constants in a valid [format](../dataset/index.md#data-types). For example, use a dot as the decimal separator: `0.123`.

{% note info %}

* Field name syntax is case-sensitive. For example, if a formula uses `[NAME]`, and a dataset contains only `[Name]`, the formula field will be highlighted in red.
* Function syntax is not case-sensitive. For instance, `count` and `COUNT` will perform the same operation.

{% endnote %}

Reference information on format, types of arguments accepted, and returned function values is available in the formula editor interface.
To do this, click **Reference** in the add field interface.

## How to create a calculated field {#how-to-create-calculated-field}

You can create calculated fields in the dataset or wizard interface.

{% list tabs %}

- Datasets

   {% include [datalens-create-calculated-field-in-dataset](../../../_includes/datalens/operations/datalens-create-calculated-field-in-dataset.md) %}

- Wizard

   1. Open the [wizard]({{ link-datalens-main }}/wizard).
   1. Select the dataset to create a chart in.
   1. In the left part of the screen, click **![image](../../../_assets/plus-sign.svg)** above the list of dataset fields.
   1. Enter the required formula.
   1. Click **Create**. The field appears in the list of fields. You can use it as your chart's data source.

{% endlist %}

#### See also {#see-also}
- [{#T}](../../operations/dataset/create-field.md)
- [{#T}](../../operations/dataset/manage-row-level-security.md)
