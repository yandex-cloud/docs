1. Скачайте последнюю версию deb-пакета:

    ```bash
    ubuntu_name="<версия_ОС>" \
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
    bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
    ```

    Где `ubuntu_name` — версия операционной системы:

      * `ubuntu-14.04-trusty`
      * `ubuntu-16.04-xenial`
      * `ubuntu-18.04-bionic`
      * `ubuntu-20.04-focal`
      * `ubuntu-22.04-jammy` (начиная с версии `23.03.02`)
      * `ubuntu-24.04-noble`

    Также вы можете скачать определенную версию {{ unified-agent-short-name }}. Для этого посмотрите все доступные версии и укажите нужную вместо значения `latest-version`:

    ```(bash)
    curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
    ```

1. Посмотрите версию скачанного deb-пакета с помощью команды `ls`.
1. Выполните команду:

    ```bash
    sudo dpkg -i yandex-unified-agent_<версия>_amd64.deb
    ```

    Где `<версия>` — версия скачанного deb-пакета, например `24.12.01`.