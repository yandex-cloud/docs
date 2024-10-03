---
editable: false
---

# yc kms asymmetric-signature-key create

Create asymmetric signature key

#### Command Usage

Syntax: 

`yc kms asymmetric-signature-key create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of a asymmetric signature key.|
|`--description`|<b>`string`</b><br/>Description of an asymmetric signature key.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--signature-algorithm`|<b>`string`</b><br/>Specifies asymmetric signature key  algorithm. Values: 'rsa-2048-sign-pss-sha-256', 'rsa-2048-sign-pss-sha-384', 'rsa-2048-sign-pss-sha-512', 'rsa-3072-sign-pss-sha-256', 'rsa-3072-sign-pss-sha-384', 'rsa-3072-sign-pss-sha-512', 'rsa-4096-sign-pss-sha-256', 'rsa-4096-sign-pss-sha-384', 'rsa-4096-sign-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256'|
|`--deletion-protection`|Inhibits deletion of a asymmetric signature key.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
