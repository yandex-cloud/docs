* [Распределенное размещение](../../compute/concepts/placement-groups.md#spread) (spread):

  ```bash
  yc compute placement-group create \
    --spread-strategy \
    --name <имя_группы_размещения>
  ```

  Где:

  * `--spread-strategy` — выбор стратегии распределенного размещения.
  * `--name` — имя группы размещения.

* [Размещение разделами](../../compute/concepts/placement-groups.md#partition) (partition):

  ```bash
  yc compute placement-group create \
    --partitions <кол-во_разделов> \
    --name <имя_группы_размещения>
  ```

  Где:

  * `--partitions` — выбор стратегии размещения разделами с указанием количества разделов: от `1` до `5`.
  * `--name` — имя группы размещения.
