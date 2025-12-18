# Fixing the `KernelNotResponding: The kernel died unexpectedly` error



## Issue description {#issue-description}

When working with CSV files, you get this error:
```
KernelNotResponding: The kernel died unexpectedly
```

## Solution {#issue-resolution}

Try reading the first several dozen lines from a CSV file. Use [`pandas.read_csv`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html) and specify the additional `nrows` parameter to determine the number of rows in `nrows` format. You can also read only the columns you need from the CSV file: `index_col` or `names`.

After loading the fragment, you can set the *footprint* in RAM [as follows](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.memory_usage.html): `df.memory_usage(deep=True).sum()`. This will help you define the node configuration.

For more information about the RAM amount per configuration, see our [guide](../../../datasphere/concepts/configurations.md).

{% note info %}

{{ ml-platform-name }} can access configurations g1.1 and higher upon [switching to paid consumption and topping up the account by at least 500 rubles](../../../datasphere/concepts/limits.md).

After switching to paid consumption, any active grants will be applied first towards payment for resources. We will only start debiting your account after your [grant balance is used up or has expired](../../../billing/payment/billing-cycle-individual.md).

{% endnote %}