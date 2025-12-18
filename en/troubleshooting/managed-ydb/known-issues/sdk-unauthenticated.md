# Fixing the `Unauthenticated` error



## Issue description {#issue-description}

When trying to access {{ ydb-name }} from a local machine, you get the `Unauthenticated` error.

## Solution {#issue-resolution}

You can [get authenticated using an {{ iam-short-name }} token or a service account token](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm). You can see some code examples [here](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/service-account-credentials) or [here](https://github.com/ydb-platform/ydb-python-sdk/tree/main/examples/access-token-credentials).

{% cut "Example of using `YDB Python SDK`" %}

1. Create a folder, e.g., `ydb`, and navigate to it via PowerShell or Bash: `cd ydb`. You will be running all subsequent commands in the terminal from this folder.
1. Create an authorized key for the service account: `yc iam key create --service-account-id <id_CA> --output token.json`. You will get the `token.json` key in the `ydb` folder.

1. Check the key: `ydb --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 --database /{{ region-id }}/b1gb4.../etn0fu... --sa-key-file token.json   discovery whoami`. You should get `User SID: ajei6s...@as` in response. This means the connection has been established.
1. Clone the example from GitHub: `git clone https://github.com/ydb-platform/ydb-python-sdk.git`. It will be saved in the current `ydb` folder for your convenience.
1. Install the `python -m pip install iso8601` library.
1. Add the location of this file to the `YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS` environment variable:
   * Linux: `export YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS=~/ydb/token.json`
   * Microsoft Windows®: `$YDB_SERVICE_ACCOUNT_KEY_FILE_CREDENTIALS="C:\Users\<user>\ydb\token.json"`.
1. Run the script: `python ydb-python-sdk/examples/basic_example_v1/ -e grpcs://ydb.serverless.yandexcloud.net:2135 -d /{{ region-id }}/b1gb4.../etn0fu...`.

{% endcut %}
