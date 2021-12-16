---
editable: false
---

# EndpointService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |

## Calls EndpointService {#calls}

## Get {#Get}



**rpc Get ([GetEndpointRequest](#GetEndpointRequest)) returns ([Endpoint](#Endpoint))**

### GetEndpointRequest {#GetEndpointRequest}

Field | Description
--- | ---
endpoint_id | **string**<br> 


### Endpoint {#Endpoint}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
settings | **[EndpointSettings](#EndpointSettings)**<br> 


### EndpointSettings {#EndpointSettings}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./#endpoint)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./#endpoint)**<br> 


### MysqlSource {#MysqlSource}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret)**<br>Password <br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig)**<br> 


### TLSConfig {#TLSConfig}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>


### PostgresSource {#PostgresSource}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret1)**<br>Password <br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
slot_byte_lag_limit | **int64**<br>Maximum WAL size for the replication slot <br>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default. 
service_schema | **string**<br>Database schema for service table <br>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder). 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode1}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig1)**<br> 


### TLSConfig {#TLSConfig1}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret1}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><ul/>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><ul/>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><ul/>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><ul/>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><ul/>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><ul/>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><ul/>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><ul/>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><ul/>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><ul/>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><ul/>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><ul/>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><ul/>


### MysqlTarget {#MysqlTarget}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection1)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret2)**<br>Password <br>Password for database access. 
sql_mode | **string**<br>sql_mode <br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 


### MysqlConnection {#MysqlConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql1)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode2)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode2}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig2)**<br> 


### TLSConfig {#TLSConfig2}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret2}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresTarget {#PostgresTarget}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection1)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret3)**<br>Password <br>Password for database access. 


### PostgresConnection {#PostgresConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres1)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode3)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode3}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig3)**<br> 


### TLSConfig {#TLSConfig3}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret3}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


## List {#List}



**rpc List ([ListEndpointsRequest](#ListEndpointsRequest)) returns ([ListEndpointsResponse](#ListEndpointsResponse))**

### ListEndpointsRequest {#ListEndpointsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Identifier of the folder containing the endpoints to be listed. 
page_size | **int64**<br>The maximum number of endpoints to be sent in the response message. If the folder contains more endpoints than page_size, next_page_token will be included in the response message. Include it into the subsequent ListEndpointRequest to fetch the next page. Defaults to 100 if not specified. The maximum allowed value for this field is 100. 
page_token | **string**<br>Opaque value identifying the endpoints page to be fetched. Should be empty in the first ListEndpointsRequest. Subsequent request should have this field filled with the next_page_token from the previous ListEndpointsResponse. 


### ListEndpointsResponse {#ListEndpointsResponse}

Field | Description
--- | ---
endpoints[] | **[Endpoint](#Endpoint1)**<br>The list of endpoints. If there are more endpoints in the folder, then next_page_token is a non-empty string to be included into the subsequent ListEndpointsRequest to fetch the next endpoints page. 
next_page_token | **string**<br>Opaque value identifying the next endpoints page. This field is empty if there are no more endpoints in the folder. Otherwise it is non-empty and should be included in the subsequent ListEndpointsRequest to fetch the next endpoints page. 


### Endpoint {#Endpoint1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
settings | **[EndpointSettings](#EndpointSettings1)**<br> 


### EndpointSettings {#EndpointSettings1}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./#endpoint)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./#endpoint)**<br> 


### MysqlSource {#MysqlSource1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection2)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret4)**<br>Password <br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings1)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection2}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql2)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql2}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode4)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode4}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig4)**<br> 


### TLSConfig {#TLSConfig4}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret4}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings1}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>


### PostgresSource {#PostgresSource1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection2)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret5)**<br>Password <br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
slot_byte_lag_limit | **int64**<br>Maximum WAL size for the replication slot <br>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default. 
service_schema | **string**<br>Database schema for service table <br>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder). 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings1)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection2}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres2)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres2}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode5)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode5}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig5)**<br> 


### TLSConfig {#TLSConfig5}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret5}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings1}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><ul/>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><ul/>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><ul/>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><ul/>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><ul/>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><ul/>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><ul/>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><ul/>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><ul/>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><ul/>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><ul/>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><ul/>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><ul/>


### MysqlTarget {#MysqlTarget1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection3)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret6)**<br>Password <br>Password for database access. 
sql_mode | **string**<br>sql_mode <br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 


### MysqlConnection {#MysqlConnection3}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql3)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql3}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode6)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode6}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig6)**<br> 


### TLSConfig {#TLSConfig6}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret6}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresTarget {#PostgresTarget1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection3)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret7)**<br>Password <br>Password for database access. 


### PostgresConnection {#PostgresConnection3}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres3)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres3}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode7)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode7}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig7)**<br> 


### TLSConfig {#TLSConfig7}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret7}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


## Create {#Create}



**rpc Create ([CreateEndpointRequest](#CreateEndpointRequest)) returns ([operation.Operation](#Operation))**

### CreateEndpointRequest {#CreateEndpointRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
settings | **[EndpointSettings](#EndpointSettings2)**<br> 


### EndpointSettings {#EndpointSettings2}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./#endpoint)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./#endpoint)**<br> 


### MysqlSource {#MysqlSource2}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection4)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret8)**<br>Password <br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings2)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection4}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql4)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql4}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode8)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode8}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig8)**<br> 


### TLSConfig {#TLSConfig8}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret8}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings2}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>


### PostgresSource {#PostgresSource2}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection4)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret9)**<br>Password <br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
slot_byte_lag_limit | **int64**<br>Maximum WAL size for the replication slot <br>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default. 
service_schema | **string**<br>Database schema for service table <br>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder). 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings2)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection4}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres4)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres4}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode9)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode9}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig9)**<br> 


### TLSConfig {#TLSConfig9}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret9}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings2}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><ul/>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><ul/>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><ul/>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><ul/>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><ul/>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><ul/>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><ul/>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><ul/>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><ul/>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><ul/>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><ul/>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><ul/>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><ul/>


### MysqlTarget {#MysqlTarget2}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection5)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret10)**<br>Password <br>Password for database access. 
sql_mode | **string**<br>sql_mode <br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 


### MysqlConnection {#MysqlConnection5}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql5)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql5}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode10)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode10}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig10)**<br> 


### TLSConfig {#TLSConfig10}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret10}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresTarget {#PostgresTarget2}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection5)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret11)**<br>Password <br>Password for database access. 


### PostgresConnection {#PostgresConnection5}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres5)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres5}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode11)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode11}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig11)**<br> 


### TLSConfig {#TLSConfig11}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret11}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


## Update {#Update}



**rpc Update ([UpdateEndpointRequest](#UpdateEndpointRequest)) returns ([operation.Operation](#Operation1))**

### UpdateEndpointRequest {#UpdateEndpointRequest}

Field | Description
--- | ---
endpoint_id | **string**<br>Identifier of the endpoint to be updated. 
name | **string**<br>The new endpoint name. Must be unique within the folder. 
description | **string**<br>The new description for the endpoint. 
labels | **map<string,string>**<br> 
settings | **[EndpointSettings](#EndpointSettings3)**<br>The new endpoint name. Must be unique within the folder. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask specifying endpoint fields to be updated. Semantics for this field is described here: https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask The only exception is that if the repeated field is specified in the mask, then the new value replaces the old one instead of being appended to the old one. 


### EndpointSettings {#EndpointSettings3}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./#endpoint)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./#endpoint)**<br> 


### MysqlSource {#MysqlSource3}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection6)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret12)**<br>Password <br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings3)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection6}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql6)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql6}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode12)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode12}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig12)**<br> 


### TLSConfig {#TLSConfig12}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret12}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings3}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>


### PostgresSource {#PostgresSource3}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection6)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret13)**<br>Password <br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Can contain regular expression. 
slot_byte_lag_limit | **int64**<br>Maximum WAL size for the replication slot <br>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default. 
service_schema | **string**<br>Database schema for service table <br>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder). 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings3)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection6}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres6)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres6}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode13)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode13}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig13)**<br> 


### TLSConfig {#TLSConfig13}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret13}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings3}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><ul/>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><ul/>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><ul/>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><ul/>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><ul/>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><ul/>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><ul/>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><ul/>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><ul/>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><ul/>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><ul/>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><ul/>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><ul/>


### MysqlTarget {#MysqlTarget3}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection7)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret14)**<br>Password <br>Password for database access. 
sql_mode | **string**<br>sql_mode <br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 


### MysqlConnection {#MysqlConnection7}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql7)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql7}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode14)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode14}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig14)**<br> 


### TLSConfig {#TLSConfig14}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret14}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresTarget {#PostgresTarget3}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection7)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret15)**<br>Password <br>Password for database access. 


### PostgresConnection {#PostgresConnection7}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres7)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres7}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode15)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode15}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig15)**<br> 


### TLSConfig {#TLSConfig15}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret15}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


## Delete {#Delete}



**rpc Delete ([DeleteEndpointRequest](#DeleteEndpointRequest)) returns ([operation.Operation](#Operation2))**

### DeleteEndpointRequest {#DeleteEndpointRequest}

Field | Description
--- | ---
endpoint_id | **string**<br> 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


