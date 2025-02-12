* [Spread placement](../../compute/concepts/placement-groups.md#spread):

  ```bash
  yc compute placement-group create \
    --spread-strategy \
    --name <placement_group_name>
  ```

  Where:

  * `--spread-strategy`: Shows that spread placement is selected.
  * `--name`: Placement group name.

* [Partition placement](../../compute/concepts/placement-groups.md#partition):

  ```bash
  yc compute placement-group create \
    --partitions <number_of_partitions> \
    --name <placement_group_name>
  ```

  Where:

  * `--partitions`: Shows that partition placement is selected, indicating the number of partitions from `1` to `5`.
  * `--name`: Placement group name.
