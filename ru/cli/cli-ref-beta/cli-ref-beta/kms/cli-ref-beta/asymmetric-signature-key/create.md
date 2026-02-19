---
editable: false
noIndex: true
---

# yc beta kms asymmetric-signature-key create

control plane
Creates an asymmetric KMS key in the specified folder.

#### Command Usage

Syntax:

`yc beta kms asymmetric-signature-key create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--deletion-protection` | Flag that inhibits deletion of the symmetric KMS key ||
|| `--description` | `string`

Description of the key. ||
|| `--folder-id` | `string`

ID of the folder to create a asymmetric KMS key in. ||
|| `--labels` | `map<string><string>`

Custom labels for the asymmetric KMS key as 'key:value' pairs. Maximum 64 per key. For example, '"project": "mvp"' or '"source": "dictionary"'. ||
|| `--name` | `string`

Name of the key. ||
|| `--signature-algorithm` | `enum`

Asymmetric signature algorithm. Possible Values: 'rsa-2048-sign-pss-sha-256', 'rsa-2048-sign-pss-sha-384', 'rsa-2048-sign-pss-sha-512', 'rsa-3072-sign-pss-sha-256', 'rsa-3072-sign-pss-sha-384', 'rsa-3072-sign-pss-sha-512', 'rsa-4096-sign-pss-sha-256', 'rsa-4096-sign-pss-sha-384', 'rsa-4096-sign-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256' ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#