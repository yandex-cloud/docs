[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Registry](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > artifact > Overview

# yc cloud-registry v0 artifact

Manage artifacts

#### Command Usage

Syntax:

`yc cloud-registry v0 artifact <group|command>`

#### Command Tree

- [yc cloud-registry v0 artifact add-access-binding](add-access-binding.md) — Add access binding for the specified artifact

- [yc cloud-registry v0 artifact delete](delete.md) — Delete the specified registry artifact

- [yc cloud-registry v0 artifact get](get.md) — Get information about the artifact

- [yc cloud-registry v0 artifact get-by-path](get-by-path.md) — Get information about the artifact by path

- [yc cloud-registry v0 artifact list](list.md) — List artifacts with filtering by kind, registry kind/type, node path

- [yc cloud-registry v0 artifact list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified artifact

- [yc cloud-registry v0 artifact remove-access-binding](remove-access-binding.md) — Remove access binding for the specified artifact

- [yc cloud-registry v0 artifact set-access-bindings](set-access-bindings.md) — Set access bindings for the specified artifact

- [yc cloud-registry v0 artifact upsert](upsert.md) — Upserts a folder at the specified path within the registry

- [yc cloud-registry v0 artifact scanner](scanner/index.md) — Scan artifacts for vulnerabilities and view scan results

  - [yc cloud-registry v0 artifact scanner get-last-scan-result](scanner/get-last-scan-result.md) — Get the last scan result for an artifact.

  - [yc cloud-registry v0 artifact scanner get-scan-result](scanner/get-scan-result.md) — Get information about a scan result.

  - [yc cloud-registry v0 artifact scanner list-scan-results](scanner/list-scan-results.md) — List scan results for an artifact.

  - [yc cloud-registry v0 artifact scanner list-vulnerabilities](scanner/list-vulnerabilities.md) — List vulnerabilities found in a scan result.

  - [yc cloud-registry v0 artifact scanner scan](scanner/scan.md) — Scan an artifact for vulnerabilities.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#