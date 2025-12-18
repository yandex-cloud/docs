# Fixing the `ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT - Inconsistent aggregation among operands` error



## Issue description {#issue-description}

When validating a formula, you see this error:
```
ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT - Inconsistent aggregation among operands
```

## Solution {#issue-resolution}

This error occurs when you try to use both aggregated and non-aggregated expressions as arguments of the same function or as operands of the same operator. 

{{ datalens-full-name }} does not support using aggregated and non-aggregated values in the same expression, so you cannot use measures and dimensions together. The dataset and wizard highlight measures in blue and dimensions in green.

For more details, see [this guide](../../../datalens/troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-AGG-INCONSISTENT.md).

{% note info %}

When validating data and formulas in a dataset, {{ datalens-full-name }} may process a large amount of data, so we recommend additionally monitoring the consistency of your data and formulas.

{% endnote %}
