# Resolving the "Unauthenticated" error



## Issue description {#issue-description}

When trying to access {{ ydb-full-name }} from a local machine, you see the `Unauthenticated` error.

## Solution {#issue-resolution}

You can [authenticate using an IAM-token or a service account token](../../../compute/operations/vm-connect/auth-inside-vm#auth-inside-vm). You can view code examples [here](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/service-account-credentials) and [there](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/access-token-credentials).

{% note info %}

Example of working with `YDB Python SDK`:

1. Create a folder, for example, `ydb` and navigate to it via PowerShell/Bash: `cd ydb`. Run subsequent commands in the terminal from this folder.
2. Create an authorized key for the service account:
   `yc iam key create --service-account-id <id_SA> --output token.json`. The `token.json` key will be created in the `ydb` folder.
3. Next, check that the key is operable: `ydb --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 --database /ru-central1/b1gb4.../etn0fu... --sa-key-file token.json   discovery whoami`. The response should be: `User SID: ajei6s...@as`: this means that the connection has been established.
4. Clone the example from GitHub: `git clone https://github.com/ydb-platform/ydb-python-sdk.git`. It will be saved in the current `ydb` folder for convenience.
5. Install the library: `python -m pip install iso8601`.
6. Add the location of this file to the `SA_KEY_FILE` environment variable:
   - Linux: `export SA_KEY_FILE=~/ydb/token.json`
   - Windows: `$SA_KEY_FILE="C:\Users\<user>\ydb\token.json"`
7. Run the script: `python ydb-python-sdk/examples/basic_example_v1/ -e grpcs://ydb.serverless.yandexcloud.net:2135 -d /ru-central1/b1gb4.../etn0fu...`.

{% endnote %}