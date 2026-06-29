1. Download the latest deb package version:

    ```bash
    ubuntu_name="<full_OS_version_name>" \
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version)

    curl --silent --remote-name \
    "https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb"
    ```

    Where `ubuntu_name` is the operating system version in `ubuntu-<version_number>-<code_name>` format. Specify the value exactly as it is used in the package folder name:

    * `ubuntu-16.04-xenial`
    * `ubuntu-18.04-bionic`
    * `ubuntu-20.04-focal`
    * `ubuntu-22.04-jammy` (starting with `23.03.02`)
    * `ubuntu-24.04-noble`

    {% note info %}

    When installing {{ unified-agent-short-name }} on Debian 9, only deb packages for `ubuntu-16.04-xenial` and lower are supported; on Debian 10, only packages for `ubuntu-18.04-bionic` and lower are supported.

    {% endnote %}

    If you do not know the exact `ubuntu_name` value, display the list of available options for the latest {{ unified-agent-short-name }} version:

    ```bash
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version)
    aws s3 ls s3://yc-unified-agent/releases/${ua_version}/deb/ \
      --endpoint-url https://{{ s3-storage-host }} \
      --no-sign-request | awk '{print $2}' | tr -d '/'
    ```

    You can also download a specific {{ unified-agent-short-name }} version. Do it by looking up the available versions and specifying the one you need instead of `latest-version`:

    ```bash
    curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
    ```

1. Check the downloaded `deb` package version using the `ls` command.

    Result:

    ```bash
    yandex-unified-agent_<version>_amd64.deb
    ```

    Where `<version>` is the downloaded `deb` package version, e.g., `24.12.01`.

1. To install the downloaded deb package, run this command:

    ```bash
    sudo dpkg -i yandex-unified-agent_<version>_amd64.deb
    ```

1. {% include [agent-is-run](agent-is-run.md) %}