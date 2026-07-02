[Документация Yandex Cloud](../../../../index.md) > [Yandex Certificate Manager](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > certificate > Overview

# yc certificate-manager v0 certificate

Manage certificates

#### Command Usage

Syntax:

`yc certificate-manager certificate <command>`

Aliases:

- `certificates`

#### Command Tree

- [yc certificate-manager v0 certificate add-access-binding](add-access-binding.md) — Add access binding for the specified certificate

- [yc certificate-manager v0 certificate content](content.md) — Download content of the specified certificate: chain and private key

- [yc certificate-manager v0 certificate create](create.md) — Create an imported certificate

- [yc certificate-manager v0 certificate delete](delete.md) — Delete the specified certificate

- [yc certificate-manager v0 certificate get](get.md) — Show information about the specified certificate

- [yc certificate-manager v0 certificate list](list.md) — List certificates in the specified folder

- [yc certificate-manager v0 certificate list-access-bindings](list-access-bindings.md) — List access bindings for the specified certificate

- [yc certificate-manager v0 certificate list-operations](list-operations.md) — List operations for the specified certificate

- [yc certificate-manager v0 certificate remove-access-binding](remove-access-binding.md) — Remove access binding for the specified certificate

- [yc certificate-manager v0 certificate request](request.md) — Request a managed certificate

- [yc certificate-manager v0 certificate set-access-bindings](set-access-bindings.md) — Set access bindings for the specified certificate and delete all existing access bindings if there were any

- [yc certificate-manager v0 certificate update](update.md) — Update the specified certificate

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