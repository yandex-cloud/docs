# {{ mmy-full-name }} revision history

## 20.04.2022 {#20.04.2022}

* You can now change the `max_sp_recursion_depth` setting that defines the maximum number of recursive invocations of a stored procedure. Defaults to `0`, meaning that recursive invocations are completely disabled. The maximum value is `255`. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

## 13.04.2022 {#13.04.2022}

* You can now manage the settings of the performance diagnostics service. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Updated the master failover mechanism: you can no longer switch to a replica that is lagging far behind or change the master if there is no quorum. The maximum lag for a replica is set by the `mdb_priority_choice_max_lag` setting.

## 01.04.2022 {#01.04.2022}

* You can now change the `innodb_strict_mode` setting.
* You can now change the `max_digest_length` setting. The setting applies when restarting a cluster.
* You can now set a priority for selecting a master host if the master changes. {{ tag-con }} {{ tag-cli }}
