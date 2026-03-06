* **{{ ui-key.yacloud.gitlab.field_task-minInstances }}**: Number of workers that are always running and ready to execute jobs. Default value: `1`; minimum: `0`; maximum: `10`.
* **{{ ui-key.yacloud.gitlab.field_max-workers }}**: Maximum number of workers that can be created to execute jobs. Default value: `3`; minimum: `1`; maximum: `30`. The maximum number of workers cannot be less than the minimum number.
* **{{ ui-key.yacloud.gitlab.field_idle-time-minutes }}**: Maximum idle time after which the additionally created worker will be deleted. Default value: `10`; minimum: `0`.
* **{{ ui-key.yacloud.gitlab.field_max-use-count }}**: Maximum number of jobs after which the worker will be deleted. Default value: `100`; minimum: `0`.
* **{{ ui-key.yacloud.gitlab.field_capacity-per-instance }}**: Number of parallel jobs per worker. Default value: `1`; minimum: `0`.
