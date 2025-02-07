1. Download the latest deb package:

    ```bash
    ubuntu_name="<OS_version>" \
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
    bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
    ```

    Where `ubuntu_name` is the operating system version.

      * `ubuntu-14.04-trusty`
      * `ubuntu-16.04-xenial`
      * `ubuntu-18.04-bionic`
      * `ubuntu-20.04-focal`
      * `ubuntu-22.04-jammy` (starting with version `23.03.02`)
      * `ubuntu-24.04-noble`

    You can also download a specific {{ unified-agent-short-name }} version. To do this, check the available versions and specify the one you need instead of `latest-version`:

    ```(bash)
    curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
    ```

1. Check the downloaded deb package version using the `ls` command.
1. Run this command:

    ```bash
    sudo dpkg -i yandex-unified-agent_<version>_amd64.deb
    ```

    Where `<version>` is the downloaded deb package version, e.g., `24.12.01`.