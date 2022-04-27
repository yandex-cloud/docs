# Connection

Поле-дискриминатор: `kind`


Подключение к базе данных.


## CHYTConnection

`kind`:`ch_over_yt`


 Поле | Тип | Описание
------|-----|----------
`raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
`cache_ttl_sec` | **int** * |
`cluster` | **str** * |
`clique_alias` | **str** * |
## CHYTUserAuthConnection

`kind`:`ch_over_yt_user_auth`


 Поле | Тип | Описание
------|-----|----------
`raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
`cache_ttl_sec` | **int** * |
`cluster` | **str** * |
`clique_alias` | **str** * |
## ClickHouseConnection

`kind`:`clickhouse`


 Поле | Тип | Описание
------|-----|----------
`raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
`cache_ttl_sec` | **int** * |
`host` | **str** * |
`port` | **int** * |
`username` | **str** * |
`secure` | **bool** * |
## PostgresConnection

`kind`:`postgres`


 Поле | Тип | Описание
------|-----|----------
`raw_sql_level` | **enum/str[`off` / `subselect` / `dashsql`]** * |
`cache_ttl_sec` | **int** * |
`host` | **str** * |
`port` | **int** * |
`username` | **str** * |
`database_name` | **str** * |
