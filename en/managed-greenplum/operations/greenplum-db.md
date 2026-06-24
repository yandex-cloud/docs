---
title: How to use auxiliary utilities in {{ mgp-full-name }}
description: This guide describes how to use auxiliary utilities.
---

# Auxiliary utilities

Greenplum Database 6 features [some useful utilities]({{ gp.docs.broadcom }}/7/greenplum-database/client_tool_guides-tools-ref.html) for working with [{{ GP }} 6]({{ gp.docs.broadcom }}/6/greenplum-database/client_tool_guides-tools-ref.html) and [{{ CB }}](https://cloudberry.apache.org/docs/sys-utilities/) databases. This includes:

* [gpfdist]({{ gp.docs.broadcom }}/6/greenplum-database/utility_guide-ref-gpfdist.html): Utility to read data from and write data to files located on remote servers. For more information, see [{#T}](gpfdist/connect.md).
* [gpload]({{ gp.docs.broadcom }}/6/greenplum-database/utility_guide-ref-gpload.html): Utility to run jobs described in a YAML control file.
* [psql]({{ gp.docs.broadcom }}/6/greenplum-database/utility_guide-ref-psql.html): Command line interface for working with the database.

To install Greenplum Database 6 on your PC or VM running Ubuntu 22.04 or 20.04:

1. Download the deb packages required to install Greenplum Database 6 from a {{ objstorage-full-name }} bucket using the script below:

    {% list tabs group=operating_system %}

    - Ubuntu 22.04 {#ubuntu2204}

        ```bash
        curl storage.yandexcloud.net/greenplum-jammy-packages/install.sh | sudo bash
        ```

        To view the list of downloadable deb packages, download the [script file](http://storage.yandexcloud.net/greenplum-jammy-packages/install.sh).

    - Ubuntu 20.04 {#ubuntu2004}

        ```bash
        curl storage.yandexcloud.net/greenplum-focal-packages/install.sh | sudo bash
        ```

        To view the list of downloadable deb packages, download the [script file](http://storage.yandexcloud.net/greenplum-focal-packages/install.sh).

    {% endlist %}

1. Install the packages you downloaded:

    ```bash
    sudo apt update && \
    sudo apt install /tmp/gp-packages/*.deb
    ```

1. Delete the temporary files:

    ```bash
    sudo rm -rf /tmp/gp-packages
    ```

1. Add these environment variables to `~/.bashrc`:

    ```bash
    echo "export GPHOME=/opt/greenplum-db-6" >> ~/.bashrc && \
    echo "source \$GPHOME/greenplum_path.sh" >> ~/.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}" >> ~/.bashrc && \
    source ~/.bashrc && \
    echo $GPHOME
    ```

    The list of packages in the `install.sh` file includes dependencies for the Python 2 interpreter required to work with Greenplum Database 6. Since Ubuntu 20.04 or higher uses Python 3 by default, set up switching between Python versions in the system.

1. Add `python2` and `python3` to the list of Python alternatives:

    ```bash
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
    ```

1. Switch the active interpreter version:

    {% note warning %}

    This may impact running other software using Python 3 in the system.

    {% endnote %}

    ```bash
    sudo update-alternatives --config python
    ```

    Enter the number of the line corresponding to `python2` and press **Enter**.

    Make sure Python 2 is the active version now:

    ```bash
    python --version
    ```

    To return to the Python 3 interpreter at a later time, rerun the `sudo update-alternatives --config python` command and select `python3`.

1. Test the utilities:

    ```bash
    gpload --version && \
    gpfdist --version && \
    psql --version
    ```

You can find installation guides for other utilities on the [VMware website]({{ gp.docs.broadcom }}/6/greenplum-database/client_tool_guides-installing.html).


{% note info %}

Downloading and using software from the VMware website is not part of the [{{ mgp-full-name }}]({{ link-cloud-terms-of-use }}). Terms of Use and is arranged between the client and VMware separately. Yandex is not responsible for any dealings between VMware and the client arising due to the client's use of VMware products or services.

{% endnote %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}
