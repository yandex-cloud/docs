# Structure and description of YDB CLI commands

Get information about all available YDB CLI commands or get a detailed description of a specific command.

## Getting information about all YDB CLI commands {#all}

To get a list of all available YDB CLI commands with a brief description of each of them, run the command:

```bash
{{ ydb-cli }} --help
```

Command results:

```bash
YDB client

Usage: ydb [options...] <subcommand>

Subcommands:
ydb
├─ discovery                Discovery service operations
│  ├─ list                  List endpoints
│  └─ whoami                Who am I?
├─ export                   Export service operations
│  └─ s3                    Create export to S3
├─ operation                Operation service operations
│  ├─ cancel                Start cancellation of a long-running operation
│  ├─ forget                Forget long-running operation
│  ├─ get                   Check status for a given operation
│  └─ list                  List operations of specified kind
├─ scheme                   Scheme service operations
│  ├─ describe              Show information about object at given object
│  ├─ ls                    Show information about objects inside given directory
│  ├─ mkdir                 Make directory
│  ├─ permissions           Modify permissions
│  │  ├─ chown              Change owner
│  │  ├─ clear              Clear permissions
│  │  ├─ grant              Grant permission (aliases: add)
│  │  ├─ revoke             Revoke permission (aliases: remove)
│  │  └─ set                Set permissions
│  └─ rmdir                 Remove directory
├─ scripting                Scripting service operations
│  └─ yql                   Execute YQL script
├─ table                    Table service operations
│  ├─ attribute             Attribute operations (aliases: attr)
│  │  ├─ add                Add attributes to the specified table
│  │  └─ drop               Drop attributes from the specified table
│  ├─ drop                  Drop a table
│  ├─ index                 Index operations
│  │  ├─ add                Add index in to the specified table
│  │  │  └─ global          Add global index. The command returns operation
│  │  └─ drop               Drop index from the specified table
│  ├─ query                 Query operations
│  │  ├─ execute            Execute query (aliases: exec)
│  │  └─ explain            Explain query
│  ├─ readtable             Stream read table
│  └─ ttl                   Ttl operations
│     ├─ drop               Drop ttl settings from the specified table
│     └─ set                Set ttl settings for the specified table
├─ tools                    YDB tools service
│  ├─ copy                  Copy table(s)
│  ├─ dump                  Dump specified database directory or table into local directory
│  └─ restore               Restore database from local dump into specified directory
├─ update                   Update current YDB CLI binary if there is a newer version available
└─ version                  Print Yandex.Cloud YDB CLI version


Options:
  {-?|-h|--help}        print usage
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                        [Required] Endpoint to connect. Protocols: grpc, grpcs (Default: grpcs).
  {-d|--database} PATH  [Required] Database to work with
  {-v|--verbose}        Increase verbosity of operations (default: 0)
  --ca-file PATH        Path to a file containing the PEM encoding of the server root certificates for tls connections.
                        If this parameter is empty, the default roots will be used.
  --iam-token-file PATH IAM token file
                          For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
                          Token search order:
                            1. This option
                            2. "IAM_TOKEN" environment variable
  --yc-token-file PATH  YC token file. It should contain OAuth token of a Yandex Passport user to get IAM token with.
                          For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
                          Token search order:
                            1. This option
                            2. "YC_TOKEN" environment variable
  --use-metadata-credentials
                        Use metadata service on a virtual machine to get credentials
                          For more info go to: cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
                          Definition priority:
                            1. This option
                            2. "USE_METADATA_CREDENTIALS" environment variable (default: 0)
  --sa-key-file PATH    Security account key file
                          For more info go to: cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
                          Definition priority:
                            1. This option
                            2. "SA_KEY_FILE" environment variable
```

## Getting detailed information about a specific YDB CLI command {#one}

You can also get a more detailed description for any of the commands with a list of available parameters:

```bash
$ {{ ydb-cli }} discovery whoami --help
```

There are two types of passed parameters:

* Global: Parameters specified in the "root", that is, after `{{ ydb-cli }}`.
* Options of the command itself are specified at the end.

Command results:

```bash
Usage: ydb [global options...] discovery whoami [options...]

Description: Who am I?

Global options:
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                            [Required] Endpoint to connect. Protocols: grpc, grpcs (Default: grpcs).
  {-d|--database} PATH      [Required] Database to work with
  {-v|--verbose}            Increase verbosity of operations (default: 0)
  --ca-file PATH            Path to a file containing the PEM encoding of the server root certificates for tls connections.
                            If this parameter is empty, the default roots will be used.
  --iam-token-file PATH     IAM token file
                              For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
                              Token search order:
                                1. This option
                                2. "IAM_TOKEN" environment variable
  --yc-token-file PATH      YC token file. It should contain OAuth token of a Yandex Passport user to get IAM token with.
                              For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
                              Token search order:
                                1. This option
                                2. "YC_TOKEN" environment variable
  --use-metadata-credentials
                            Use metadata service on a virtual machine to get credentials
                              For more info go to: cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
                              Definition priority:
                                1. This option
                                2. "USE_METADATA_CREDENTIALS" environment variable
                            Default: 0
  --sa-key-file PATH        Security account key file
                              For more info go to: cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
                              Definition priority:
                                1. This option
                                2. "SA_KEY_FILE" environment variable

Options:
  {-?|-h|--help}      print usage
  --client-timeout ms Operation client timeout
  {-g|--groups}       With groups (default: 0)
```

