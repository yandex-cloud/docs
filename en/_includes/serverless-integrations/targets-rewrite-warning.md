{% note warning %}

The existing targets will be completely overwritten by the ones you provide in your request.

{% endnote %}

```bash
yc serverless eventrouter rule update <rule_name_or_ID> \
  --target_1 <parameter_1>=<value_1>,...,<parameter_N>=<value_N> \
  --target_2 <parameter_1>=<value_1>,...,<parameter_N>=<value_N> \
  ...
  --target_N <parameter_1>=<value_1>,...,<parameter_N>=<value_N>
```