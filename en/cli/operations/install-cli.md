# CLI installation

You can install the CLI in different modes:

- [Interactive CLI installation](#interactive)
- [Non-interactive CLI installation](#non-interactive)

## Interactive CLI installation {#interactive}

{% include [install-cli](../../_includes/cli/install-cli.md) %}

To use the CLI, [create a profile](profile/profile-create.md).

## Non-interactive CLI installation {#non-interactive}

To use the CLI in scripts, you can use flags for running non-interactive installations:

{% list tabs %}

- Bash

    Run the command:

    ```
    $ curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -h
    Usage: install [options...]
    Options:
     -i [INSTALL_DIR]    Installs to specified dir.
     -r [RC_FILE]        Automatically modify RC_FILE with PATH modification and shell completion.
     -n                  Don't modify rc file and don't ask about it.
     -a                  Automatically modify default rc file with PATH modification and shell completion.
     -h                  Prints help.
    ```

    Example of use:

    - Installing the CLI in `/opt/yandex-cloud` without changing `.bashrc`:

        ```
        curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
            bash -s -- -i /opt/yandex-cloud -n
        ```

    - Installing the CLI to the default directory with `completion` and `PATH` added to `.bashrc`:

        ```
        curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
            bash -s -- -a
        ```

{% endlist %}

