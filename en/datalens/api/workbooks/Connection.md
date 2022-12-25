# Connection

Discriminator field: `kind`


Connecting to a database.


## CHYTConnection

`kind`:`ch_over_yt`


| Field | Type | Description |
------|-----|----------
| `raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
| `cache_ttl_sec` | **int** * |
| `cluster` | **str** * |
| `clique_alias` | **str** * |
## CHYTUserAuthConnection

`kind`:`ch_over_yt_user_auth`


| Field | Type | Description |
------|-----|----------
| `raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
| `cache_ttl_sec` | **int** * |
| `cluster` | **str** * |
| `clique_alias` | **str** * |
## ClickHouseConnection

`kind`:`clickhouse`


| Field | Type | Description |
------|-----|----------
| `raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
| `cache_ttl_sec` | **int** * |
| `host` | **str** * |
| `port` | **int** * |
| `username` | **str** * |
| `secure` | **bool** * |
## PostgresConnection

`kind`:`postgres`


| Field | Type | Description |
------|-----|----------
| `raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
| `cache_ttl_sec` | **int** * |
| `host` | **str** * |
| `port` | **int** * |
| `username` | **str** * |
| `database_name` | **str** * |
