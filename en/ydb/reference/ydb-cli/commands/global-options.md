---
sourcePath: en/ydb/overlay/reference/ydb-cli/commands/global-options.md
---
# Global parameters

Using the {{ ydb-short-name }} CLI global command parameters, you can specify the endpoint, DB, output details, authorization method, profile, and get help and license information.

| Parameter name | Parameter description |
| --- | --- |
| `-?`, `-h`, `--help` | Output the command help. |
| `-e`, `--endpoint` `[PROTOCOL://]HOST[:PORT]` | Required parameter. The endpoint for the connection.<br/><ul><li>`PROTOCOL`: Connection protocol. Possible values: `grpc` and `grpcs`. Default value is `grpcs`.</li><li>`HOST` is the IP or [FQDN](https://ru.wikipedia.org/wiki/FQDN) of the host.</li><li>`PORT`: Connection port. Default value is `2135`.</li></ul>How to find the endpoint value:<ol><li>This option.</li><li>The profile specified in the `--profile` option.</li><li>Active profile.</li></ol>Example of a value: `grpcs://ydb.serverless.yandexcloud.net:2135`. |
| `-d`, `--database` `PATH` | Required parameter. The database path.<br/>How to find the DB path value:<ol><li>This option.</li><li>The profile specified in the `--profile` option.</li><li>Active profile.</li></ol>Example of a value: `/ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e`. |
| `-v`, `--verbose` | Details of the command output.<br/>Default value is `0`. |
| `--ca-file` `PATH` | The path of the root PEM certificate for the TSL connection. If this option is not set, the default certificate is used. |
| `--iam-token-file` `PATH` | Use an [IAM token](https://cloud.yandex.com/docs/iam/concepts/authorization/iam-token) for authorization and specify the token file path. Important: The IAM token lifetime is 12 hours.<br/>How to find the path:<ol><li>This option.</li><li>The profile specified in the `--profile` option.</li><li>Environment variable `IAM_TOKEN`.</li><li>Active profile.</li></ol> |
| `--yc-token-file` `PATH` | Use an [OAuth token](https://cloud.yandex.com/docs/iam/concepts/authorization/oauth-token) to authenticate and obtain an IAM token, specify the path to the file with the OAuth token.<br/>How to find the path:<ol><li>This option.</li><li>The profile specified in the `--profile` option.</li><li>Environment variable `YC_TOKEN`.</li><li>Active profile.</li></ol> |
| `--use-metadata-credentials` | Use the IAM token obtained from a [metadata service](https://cloud.yandex.com/docs/compute/operations/vm-connect/auth-inside-vm) when working from a VM in {{ yandex-cloud }}.<br/>How to find it:<ol><li>This option.</li><li>The profile specified in the `--profile` option.</li><li>Environment variable `USE_METADATA_CREDENTIALS`. To use the metadata service, set the variable value to `1`.</li><li>Active profile.</li></ol> |
| `--sa-key-file` `PATH` | Use for authentication the [authorized access key]( https://cloud.yandex.com/docs/iam/concepts/authorization/key) of the service account and specify the path of the file with the key.<br/>How to find the path:<ol><li>This option.</li><li>The profile specified in the `--profile` option.</li><li>Environment variable `SA_KEY_FILE`.</li><li>Active profile.</li></ol> |
| `--iam-endpoint` `STR` | IAM service endpoint. The default value is `"iam.api.cloud.yandex.net"`. |
| `--profile` `Name` | The name of the profile to execute the command. |
| `--license` | Show the license. |
| `--credits` | Show licenses of third-party products. |
