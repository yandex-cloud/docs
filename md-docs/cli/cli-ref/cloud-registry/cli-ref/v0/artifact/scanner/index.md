[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник (англ.)](../../../../../index.md) > [cloud-registry](../../../index.md) > [v0](../../index.md) > [artifact](../index.md) > scanner > Overview

# yc cloud-registry v0 artifact scanner

Scan artifacts for vulnerabilities and view scan results

#### Command Usage

Syntax:

`yc cloud-registry artifact scanner <command>`

#### Command Tree

- [yc cloud-registry v0 artifact scanner get-last-scan-result](get-last-scan-result.md) — Get the last scan result for an artifact.

- [yc cloud-registry v0 artifact scanner get-scan-result](get-scan-result.md) — Get information about a scan result.

- [yc cloud-registry v0 artifact scanner list-scan-results](list-scan-results.md) — List scan results for an artifact.

- [yc cloud-registry v0 artifact scanner list-vulnerabilities](list-vulnerabilities.md) — List vulnerabilities found in a scan result.

- [yc cloud-registry v0 artifact scanner scan](scan.md) — Scan an artifact for vulnerabilities.

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