* **{{ ui-key.yacloud.data-streams.label_shards }}** — минимальное и максимальное количество [сегментов поставки данных](../../data-streams/concepts/glossary.md#shard).
* **{{ ui-key.yacloud.data-streams.label_auto-partitioning-mode }}**:

    * `{{ ui-key.yacloud.data-streams.label_auto-partitioning-scale-up }}` — количество сегментов может быть увеличено до указанного максимального количества.
    * `{{ ui-key.yacloud.data-streams.label_auto-partitioning-paused }}` — количество сегментов будет оставаться на текущем уровне.

* **{{ ui-key.yacloud.data-streams.label_auto-partitioning-stabilization-window }}** — период времени в секундах, по истечении которого будет меняться количество сегментов при изменении нагрузки.
* **{{ ui-key.yacloud.data-streams.label_auto-partitioning-up-utilization }}** — порог нагрузки в процентах, при котором количество сегментов будет увеличиваться.