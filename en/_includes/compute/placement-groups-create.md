* [Spread placement](../../compute/concepts/placement-groups.md#spread):

   ```bash
   yc compute placement-group create \
     --spread-strategy \
     --name <placement_group_name>
   ```

   Where:

   * `--spread-strategy`: Shows that the spread placement strategy is selected.
   * `--name`: Placement group name.

* [Partition placement](../../compute/concepts/placement-groups.md#partition):

   ```bash
   yc compute placement-group create \
     --partitions <partition_count> \
     --name <placement_group_name>
   ```

   Where:

   * `--partitions`: Shows that the partition placement strategy is selected with the number of partitions specified: from `1` to `5`.
   * `--name`: Placement group name.
