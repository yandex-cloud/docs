# Calculable fields

A calculable field is an additional [data field](../dataset/index.md#field) with values calculated using a formula.
You can use calculable fields to create new dimensions and measures.
The data source remains unchanged.

To write formulas, you can use the existing dataset fields, [parameters](../parameters.md), constants, and [functions](#functions).

You can [create](#how-to-create-calculated-field) calculable fields in the dataset or wizard interface:

* Calculable fields from a dataset are available in all charts above this dataset.
* Calculable fields from the wizard are only available for saved charts.

## Calculable fields in datasets {#dataset}

You can add new fields to a dataset field list.

When creating a formula, you can use any dataset field, including the calculable fields you previously created. 

After creating a calculable field and saving the dataset, the field becomes available to all charts and dashboard [selectors](../../dashboard/selector.md) based on that dataset.
To hide fields in the wizard, enable the **Don't display** option when creating them.

Calculable fields are marked with ![image](../../../_assets/console-icons/function.svg).

## Calculable fields in charts {#chart}

You can add new fields when creating and editing charts in the wizard:

* In the list of fields from a dataset.
* In the visualization section.

When creating a formula, you can use any dataset field, including the calculable fields you previously created. 

If a field is created in a chart, it will not be available to dashboard selectors and other charts.

Calculable fields are marked with ![image](../../../_assets/console-icons/function.svg).

{% note warning %}

In [multi-dataset charts](../chart/index.md#multi-dataset-charts), calculable fields are not applicable to fields from multiple datasets.

{% endnote %}

## Functions {#functions}

Functions are the principal components used for creating formulas. You can use them to perform various operations on data fields.

The list of available functions depends on the data source. For more information, see [{#T}](../../function-ref/availability.md).

{% note warning %}

Avoid calculation loops: in a formula, you cannot use a field that uses the same formula to calculate its own value.

{% endnote %}


### Notation format {#entry-format}

Write formulas that meet the following requirements:

1. Specify function arguments in parentheses, e.g., `YEAR([DATE1])`. Separate multiple arguments with commas.
1. Specify field names in square brackets, such as `[CustomerID]`.
1. Make sure to enter the values of fields and constants in a valid [format](../dataset/index.md#data-types). For example, use a period as a decimal separator: `0.123`.

{% note info %}

* Field name syntax is case-sensitive. For example, if a formula uses `[NAME]`, and a dataset contains only `[Name]`, the formula field will be highlighted in red.
* Function syntax is not case-sensitive. For instance, `count` and `COUNT` will perform the same operation.

{% endnote %}

For more information on format, types of accepted arguments, and returned function values, use the **Reference** button when adding a field in the formula editor interface.

## How to create a calculable field {#how-to-create-calculated-field}

You can create calculable fields in the dataset or wizard interface.

{% list tabs %}

- Datasets

   {% include [datalens-create-calculated-field-in-dataset](../../../_includes/datalens/operations/datalens-create-calculated-field-in-dataset.md) %}

- Wizard

   1. Open the [wizard]({{ link-datalens-main }}/wizard).
   1. Select the dataset to create a chart in.
   1. In the left part of the screen, click **![image](../../../_assets/console-icons/plus.svg)** above the list of dataset fields.
   1. Enter the required formula.
   1. Click **Create**. The field will appear in the list of fields. You can use it as your chart data source.

{% endlist %}

#### See also {#see-also}
- [{#T}](../../operations/dataset/create-field.md)
- [{#T}](../../security/row-level-security.md)
