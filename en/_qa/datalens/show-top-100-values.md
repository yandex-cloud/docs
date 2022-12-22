### How do I display only the top 10 values in the chart?

1. Create a new field with the `rank([name of the field by which the TOP N is collected])` or `rank_dense` formula.
1. Add this field to the chart filters and specify the `≤ N` filtering condition.

