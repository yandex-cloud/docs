[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [managed-postgresql](../index.md) > [performance-diagnostics](index.md) > list-raw-sessions

# yc managed-postgresql performance-diagnostics list-raw-sessions

List raw PostgreSQL session states for the specified time range. The text format displays the default Performance Diagnostics columns. Use `--format json` or `--format yaml` to output all fields.

#### Command Usage

Syntax:

`yc managed-postgresql performance-diagnostics list-raw-sessions [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

PostgreSQL cluster id. ||
|| `--cluster-name` | `string`

PostgreSQL cluster name. ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--from-time` | `timestamp`

Start timestamp for the request. Format: RFC-3339, HH:MM:SS, or a moment of time relative to the current time. ||
|| `--to-time` | `timestamp`

End timestamp for the request. Format: RFC-3339, HH:MM:SS, or a moment of time relative to the current time. ||
|| `--extended-filter` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Filter session states by a field, value, and comparison operator. Can be specified multiple times; filters are combined using AND.

Possible property names:

- `field-name`: Session field to compare. Values: 'session-time', 'session-host', 'session-pid', 'session-database', 'session-user', 'session-application-name', 'session-backend-start', 'session-xact-start', 'session-query-start', 'session-state-change', 'session-wait-event-type', 'session-wait-event', 'session-state', 'session-query', 'session-backend-type', 'session-client-addr', 'session-client-hostname', 'session-client-port', 'session-backend-xid', 'session-backend-xmin', 'session-query-id', 'session-blocking-pids', 'session-role', 'session-blocked-by-modes', 'session-wait-locktype', 'session-wait-mode', 'session-wait-relation', 'session-transaction-age'

- `value`: Value to compare the session field with. For 'in' and 'not-in', enclose a comma-separated list in brackets.

- `operator`: Comparison operator. If unspecified, equality is used. Values: 'equal', 'not-equal', 'greather-then', 'greather-then-or-equal', 'less-then', 'less-then-or-equal', 'in', 'not-in', 'like' ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#