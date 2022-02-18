# Importing and exporting data

The {{ ydb-short-name }} CLI supports exporting and importing data to {{ objstorage-full-name }} storage.

You can import and export both a DB folder with all nested objects and an individual table.

## Exporting data {#export}

View a description of the command to export data:

```bash
{{ ydb-cli }} export s3 --help
```

Subcommand parameters:

| Parameter name | Parameter description | Required |
| --- | --- | :---: |
| `--s3-endpoint` | Service endpoint. | Yes |
| `--bucket` | The name of the bucket to save exported objects to. | Yes |
| `-?`<br/>`-h`<br/>`--help` | Output the command help. | No |
| `--client-timeout` | Client side operation timeout, ms. | No |
| `--operation-timeout` | Server side operation timeout, ms. | No |

  --cancel-after ms         Operation lifetime, after which the operation is canceled
  --scheme SCHEME           S3 endpoint scheme (default: "https")
  --storage-class STORAGE_CLASS
                            S3 storage class
                              Available options:
                                - NOT_SET
                                - STANDARD
                                - REDUCED_REDUNDANCY
                                - STANDARD_IA
                                - ONEZONE_IA
                                - INTELLIGENT_TIERING
                                - GLACIER
                                - DEEP_ARCHIVE
                                - OUTPOSTS
                                - UNKNOWN (default: "NOT_SET")
  --access-key STRING       Access key id
                              Search order:
                                1. This option
                                2. "AWS_ACCESS_KEY_ID" environment variable
                                3. "aws_access_key_id" key in "~/.aws/credentials" file
  --secret-key STRING       Secret key
                              Search order:
                                1. This option
                                2. "AWS_SECRET_ACCESS_KEY" environment variable
                                3. "aws_secret_access_key" key in "~/.aws/credentials" file
  --item PROPERTY=VALUE,... [At least one] Item specification
                              Possible property names:
                                Destination (aliases: destination, dst, d)
                                  [Required] S3 object key prefix
                                Source (aliases: source, src, s)
                                  [Required] Database path to a directory or a table to be exported
  --exclude STRING          Pattern (PCRE) for paths excluded from export operation
  --description STRING      Textual description of export operation
  --retries NUM             Number of retries (default: 10)
  --json                    (Deprecated, will be removed soon. Use --format instead) Output in json format
  --format STRING           Output format. Available options:
                              pretty
                                Human readable output
                              proto-json-base64
                                Output result protobuf in json format, binary st

{{ ydb-cli }} export s3 --s3-endpoint storage.yandexcloud.net --bucket ydb-backup --item d=ydb256,s=/ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e

┌────────────────────────────────────────┬───────┬─────────┬───────────┬──────────────────────────────────┬────────────┐
| id                                     | ready | status  | progress  | endpoint                         | bucket     |
├────────────────────────────────────────┼───────┼─────────┼───────────┼──────────────────────────────────┼────────────┤
| ydb://export/6?id=1125900422193164&kin | false | SUCCESS | Preparing | https://storage.yandexcloud.net/ | ydb-backup |
| d=s3                                   |       |         |           |                                  |            |
├╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴╴┴╴╴╴╴╴╴╴╴╴╴╴╴┤
| StorageClass: NOT_SET                                                                                                |
| Items:                                                                                                               |
|   - source: /ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/episodes                                          |
|     destination: ydb256/episodes                                                                                     |
|   - source: /ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/seasons                                           |
|     destination: ydb256/seasons                                                                                      |
|   - source: /ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/series                                            |
|     destination: ydb256/series                                                                                       |
| Description:                                                                                                         |
| Number of retries: 10                                                                                                |
└────────────────────────────────────────────────────────

## Importing data {#import}

View a description of the command to import data:

```bash
{{ ydb-cli }} import s3 --help
```
