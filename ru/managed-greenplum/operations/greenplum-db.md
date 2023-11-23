---
title: "Как использовать вспомогательные утилиты в {{ mgp-full-name }}"
description: "Следуя данной инструкции, вы сможете использовать вспомогательные утилиты." 
---

# Вспомогательные утилиты

Пакет Greenplum Database 6 содержит [ряд полезных утилит](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/client_tool_guides-tools-ref.html) для работы с базой данных {{ GP }}. В частности:

* [gpfdist](https://gpdb.docs.pivotal.io/6-9/utility_guide/ref/gpfdist.html) — утилита для чтения и записи данных из файлов, расположенных на удаленных серверах. Подробную информацию см. в разделе [{#T}](./external-tables.md#gpfdist).
* [gpload](https://gpdb.docs.pivotal.io/6-9/utility_guide/ref/gpload.html) — утилита для запуска задач, описанных в управляющем YAML-файле.
* [psql](https://gpdb.docs.pivotal.io/6-9/utility_guide/ref/psql.html) — интерфейс командной строки для работы с {{ GP }}.

Чтобы установить Greenplum Database 6 на рабочую или виртуальную машину под управлением OC Ubuntu 22.04 или Ubuntu 20.04:

1. Скачайте deb-пакеты, необходимые для установки Greenplum Database 6, из бакета {{ objstorage-full-name }} при помощи скрипта:

    {% list tabs %}

    - Ubuntu 22.04

        ```bash
        curl {{ s3-storage-host }}/greenplum-jammy-packages/install.sh | sudo bash
        ```

        Если вы хотите ознакомится со списком скачиваемых deb-пакетов, скачайте [файл скрипта](http://{{ s3-storage-host }}/greenplum-jammy-packages/install.sh).

    - Ubuntu 20.04

        ```bash
        curl {{ s3-storage-host }}/greenplum-focal-packages/install.sh | sudo bash
        ```

        Если вы хотите ознакомится со списком скачиваемых deb-пакетов, скачайте [файл скрипта](http://{{ s3-storage-host }}/greenplum-focal-packages/install.sh).

    {% endlist %}

1. Установите скачанные пакеты:

    ```bash
    sudo apt update && \
    sudo apt install /tmp/gp-packages/*.deb
    ```

1. Удалите временные файлы:

    ```bash
    sudo rm -rf /tmp/gp-packages
    ```

1. Добавьте переменные окружения в `~/.bashrc`:

    ```bash
    echo "export GPHOME=/opt/greenplum-db-6" >> ~/.bashrc && \
    echo "source \$GPHOME/greenplum_path.sh" >> ~/.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}" >> ~/.bashrc && \
    source ~/.bashrc && \
    echo $GPHOME
    ```

    В список пакетов в файле `install.sh` входят зависимости для интерпретатора Python 2, который необходим для работы Greenplum Database 6. Поскольку в ОС Ubuntu 20.04 и старше по умолчанию используется Python 3, необходимо настроить в системе переключение между версиями Python.

1. Добавьте `python2` и `python3` в список альтернатив Python:

    ```bash
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
    ```

1. Переключите активную версию интерпретатора:

    {% note warning %}

    Это действие может повлиять на запуск в системе других программ, использующих Python 3.

    {% endnote %}

    ```bash
    sudo update-alternatives --config python
    ```

    Введите номер строки, соответствующий `python2`, и нажмите **Enter**.

    Убедитесь, что стала активна версия Python 2:

    ```bash
    python --version
    ```

    В дальнейшем, чтобы вернуться к использованию интерпретатора Python 3, повторите команду `sudo update-alternatives --config python` и выберите `python3`.

1. Проверьте работоспособность утилит:

    ```bash
    gpload --version && \
    gpfdist --version && \
    psql --version
    ```

Инструкции по установке утилит на другие операционные системы доступны [на сайте VMware](https://greenplum.docs.pivotal.io/6-19/client_tool_guides/installing.html).


{% note info %}

Скачивание и использование продуктов с сайта VMware не входит в [условия использования {{ mgp-full-name }}]({{ link-cloud-terms-of-use }}) и является предметом отдельного регулирования между клиентом и VMware. Яндекс не несет ответственности за взаимоотношения клиента и VMware, вытекающие из использования клиентом продуктов или услуг VMware.

{% endnote %}

