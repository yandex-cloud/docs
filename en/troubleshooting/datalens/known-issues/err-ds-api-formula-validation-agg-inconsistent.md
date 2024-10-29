# Resolving the "ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT - Inconsistent aggregation among operands" error


## Issue description {#issue-description}

When validating the formula, you see this error:
```
ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT - Inconsistent aggregation among operands
```

## Solution {#issue-resolution}

This error occurs when you try to use both aggregated and unaggregated expressions as arguments of the same function (or as operands of the same operator).

{{ datalens-full-name }} does not allow using both aggregated and unaggregated values in the same expression. That is, you cannot use measures (displayed in the dataset and in the wizard in blue) and dimensions (displayed in the dataset and in the wizard in green) in the same expression.

For more details, see the [documentation](../../../datalens/troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-AGG-INCONSISTENT).

{% note info %}

When validating data and formulas in the dataset, the service may check a large amount of data. In this context, we recommend additionally tracking the consistency of your data and formulas.

{% endnote %}
