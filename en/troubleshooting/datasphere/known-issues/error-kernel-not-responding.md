# Resolving the "KernelNotResponding: The kernel died unexpectedly" error



## Issue description {#issue-description}

When working with CSV files, you see this error:
```
KernelNotResponding: The kernel died unexpectedly
```

## Solution {#issue-resolution}

Try reading the first several dozen lines from a CSV file. Use [`pandas.read_csv`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html) and specify the additional `nrows` parameter to determine the number of necessary rows in the `nrows` format.

You can also read only relevant columns from the CSV file: `index_col` or `names`.

After loading the fragment, you can set the footprint in RAM [like this](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.memory_usage.html): `df.memory_usage(deep=True).sum()`. This will help you define the relevant node configuration.

For details about the RAM amount per configuration, see our [documentation](../../../datasphere/concepts/configurations).

{% note info %}

Access to configurations starting from `g1.1` becomes available to {{ ml-platform-name }} on [switching to paid usage and topping up the account by at least 500 rubles](../../../datasphere/concepts/limits).

After switching to paid usage, any active grants will be applied first towards payment for resources. We will only start debiting your account after the [grant is used up or has expired](../../../billing/payment/billing-cycle-individual).

{% endnote %}

