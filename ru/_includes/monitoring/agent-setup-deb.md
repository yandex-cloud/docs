1. Скачайте последнюю версию deb-пакета:

    ```bash
    ubuntu_name="<версия_ОС>" \
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
    bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
    ```

    Где `ubuntu_name` — версия операционной системы:

    * `ubuntu-16.04-xenial`
    * `ubuntu-18.04-bionic`
    * `ubuntu-20.04-focal`
    * `ubuntu-22.04-jammy` (начиная с версии `23.03.02`)
    * `ubuntu-24.04-noble`

    {% note info %}

    При установке {{ unified-agent-short-name }} на Debian 9 поддерживаются deb-пакеты только для `ubuntu-16.04-xenial` и ниже, на Debian 10 — для `ubuntu-18.04-bionic` и ниже.

    {% endnote %}

    Также вы можете скачать определенную версию {{ unified-agent-short-name }}. Для этого посмотрите список доступных версий и укажите нужную вместо значения `latest-version`:

    ```bash
    curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
    ```

1. Посмотрите версию скачанного deb-пакета с помощью команды `ls`.

    Результат:

    ```bash
    yandex-unified-agent_<версия>_amd64.deb
    ```

    Где `<версия>` — версия скачанного deb-пакета, например `24.12.01`.

1. Для установки скачанного deb-пакета выполните команду:

    ```bash
    sudo dpkg -i yandex-unified-agent_<версия>_amd64.deb
    ```

1. {% include [agent-is-run](agent-is-run.md) %}