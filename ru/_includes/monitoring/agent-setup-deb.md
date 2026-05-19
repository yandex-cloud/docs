1. Скачайте последнюю версию deb-пакета:

    ```bash
    ubuntu_name="<полное_название_версии_ОС>" \
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
    bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
    ```

    Где `ubuntu_name` — идентификатор версии операционной системы в формате `ubuntu-<номер_версии>-<кодовое_имя>`. Указывайте значение точно так, как оно используется в имени каталога пакета:

    * `ubuntu-16.04-xenial`
    * `ubuntu-18.04-bionic`
    * `ubuntu-20.04-focal`
    * `ubuntu-22.04-jammy` (начиная с версии `23.03.02`)
    * `ubuntu-24.04-noble`

    {% note info %}

    При установке {{ unified-agent-short-name }} на Debian 9 поддерживаются deb-пакеты только для `ubuntu-16.04-xenial` и ниже, на Debian 10 — для `ubuntu-18.04-bionic` и ниже.

    {% endnote %}

    Если вы не знаете точное значение `ubuntu_name`, выведите список доступных вариантов для последней версии {{ unified-agent-short-name }}:

    ```bash
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version)
    aws s3 ls s3://yc-unified-agent/releases/${ua_version}/deb/ \
      --endpoint-url https://{{ s3-storage-host }} \
      --no-sign-request | awk '{print $2}' | tr -d '/'
    ```

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