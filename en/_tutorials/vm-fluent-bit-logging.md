The [Fluent Bit](https://fluentbit.io/) log processor lets you transfer logs from [VM instances](../compute/concepts/vm.md) to [{{ cloud-logging-full-name }}](../logging/). The [Fluent Bit plugin for Yandex Cloud Logging](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) module is used to transfer logs.

To set up transfer of logs:

1. [Create a systemd service that generates logs](#systemd).
1. [Install and configure Fluent Bit](#install-fluent-bit).
1. [Enable the plugin](#connect-plugin).

## Before you start {#before-you-begin}

1. [Create a service account](../iam/operations/sa/create.md) with the `logging.writer` role for the folder.
1. [Create a VM instance](../compute/operations/vm-create/create-linux-vm.md) from the public Linux image. In the VM settings, specify the service account that you created in the previous step.
1. [Connect to the VM instance](../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.
1. On the VM instance, install:
    * [Go version 1.17 or higher](https://go.dev/doc/install):
        ```bash
        wget https://go.dev/dl/go1.17.6.linux-amd64.tar.gz
        tar -xzf go1.17.6.linux-amd64.tar.gz
        export PATH=$PWD/go/bin:$PATH
        ```
    * Git:
        ```bash
        sudo apt install git
        ```

## Create a systemd service that generates logs {#systemd}

1. Create a directory:
    ```bash
    sudo mkdir /usr/local/bin/logtest
    sudo chown $USER /usr/local/bin/logtest
    cd /usr/local/bin/logtest
    ```
1. Create the `logtest.py` file:
    ```py
    import logging
    import random
    import sys
    import time
    
    from systemdlogging.toolbox import check_for_systemd
    from systemdlogging.toolbox import SystemdFormatter
    from systemdlogging.toolbox import SystemdHandler
    
    # You can replace the next few lines with the 'systemdlogging.toolbox.init_systemd_logging` call
    # This is a demo code
    
    # Check if systemd is available
    systemd_ok = check_for_systemd()
    
    if systemd_ok:
        handler = SystemdHandler()
        # syslog_id: The value to be used in the SYSLOG_IDENTIFIER field
        handler.syslog_id = ''
        handler.setFormatter(SystemdFormatter())
    
        # Get an instance of the logger object
        logger = logging.getLogger()
        logger.addHandler(handler)
    
    else:
        logger = logging.getLogger(__name__)
        # Output logs to STDOUT
        handler = logging.StreamHandler(stream=sys.stdout)
        handler.setFormatter(logging.Formatter(
            '[%(levelname)s] %(code)d %(message)s'
        ))
        logger.addHandler(handler)
    
    # Configure the default logging level (optional)
    logger.setLevel(logging.DEBUG)
    
    # Generate URL-like values
    PATHS = [
        '/',
        '/admin',
        '/hello',
        '/docs',
    ]
    
    PARAMS = [
        'foo',
        'bar',
        'query',
        'search',
        None
    ]
    
    
    def fake_url():
        path = random.choice(PATHS)
        param = random.choice(PARAMS)
        if param:
            val = random.randint(0, 100)
            param += '=%s' % val
        code = random.choices([200, 400, 404, 500], weights=[10, 2, 2, 1])[0]
        return '?'.join(filter(None, [path, param])), code
    
    
    if __name__ == '__main__':
        while True:
            # Create a pair including a code and URL value
            path, code = fake_url()
            # If the code is 200, write the log record with the Info level
            # Cloud Logging uses the textual value of the logging level, so in `context', pass
            # the additional value of 'SEVERITY`
            # It will end up in journald so you can use the yc-logging plugin to read it
            if code == 200:
                logger.info(
                    'Path: %s',
                    path,
                    extra={"code": code, "context": {"SEVERITY": "info"}},
                )
            # Otherwise, with the Error level
            else:
                logger.error(
                    'Error: %s',
                    path,
                    extra={"code": code, "context": {"SEVERITY": "error"}},
                )
    
            # Wait 1 second to avoid log clogging
            time.sleep(1)
    ```
1. Create a virtual environment and install the necessary dependencies:
    ```bash
    sudo apt install python3-pip python3.8-venv
    python3 -m venv venv
    source venv/bin/activate
    pip3 install systemd-logging
    ```
1. Create a `logtest.sh` file:
    ```sh
    #!/bin/bash
    
    SCRIPT_PATH=$(dirname "$(realpath "$0")")
    . "$SCRIPT_PATH/venv/bin/activate"
    python "$SCRIPT_PATH/logtest.py"
    ```
1. `systemd` will call `logtest.sh` to run the service, so make the file executable:
    ```bash
    chmod +x logtest.sh
    ```
1. Create the `logtest.service` file:
    ```
    [Unit]
    Description=Sample to show logging from a Python application to systemd
    After=network.target
    
    [Service]
    Type=simple
    ExecStart=/usr/local/bin/logtest/logtest.sh
    Restart=on-abort
    
    [Install]
    WantedBy=multi-user.target
    ```
1. Create a symbolic link for `logtest.service`:
    ```bash
    sudo ln -s "$(pwd)/logtest.service" /etc/systemd/system/logtest.service
    ```
1. Restart `systemd`:
    ```bash
    sudo systemctl daemon-reload
    ```
1. View the status of `logtest.service`:
    ```bash
    systemctl status logtest.service
    ```

    Result:
    ```bash
    ● logtest.service - Sample to show logging from a Python application to systemd
     Loaded: loaded (/etc/systemd/system/logtest.service; linked; vendor preset: enabled)
     Active: inactive (dead)
    ```
1. Start `logtest.service`:
    ```bash
    sudo systemctl start logtest.service
    ```
1. Recheck the `logtest.service` status, it should be active now:
    ```bash
    systemctl status logtest.service
    ```

    Result:
    ```bash
    ● logtest.service - Sample to show logging from a Python application to systemd
         Loaded: loaded (/etc/systemd/system/logtest.service; linked; vendor preset: enabled)
         Active: active (running) since Wed 2022-02-02 18:49:03 UTC; 13h ago
       Main PID: 6550 (logtest.sh)
          Tasks: 2 (limit: 2311)
         Memory: 8.5M
         CGroup: /system.slice/logtest.service
                 ├─6550 /bin/bash /usr/local/bin/logtest/logtest.sh
                 └─6568 python /usr/local/bin/logtest/logtest.py
    ```

## Install and configure Fluent Bit {#install-fluent-bit}

1. Add the GPG key that you used to sign packages in the Fluent Bit repository:
    ```bash
    wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -
    ```
1. Add the following lines to the `/etc/apt/sources.list` file:
    ```bash
    deb https://packages.fluentbit.io/ubuntu/focal focal main
    ```
1. Update the `apt` indexes:
    ```bash
    sudo apt-get update
    ```
1. Install the `td-agent-bit` package:
    ```bash
    sudo apt-get install td-agent-bit
    ```
1. Start `td-agent-bit`:
    ```bash
    sudo systemctl start td-agent-bit
    ```
1. Recheck the `td-agent-bit` service status, it should be active:
    ```bash
    systemctl status td-agent-bit
    ```

    Result:
    ```bash
    ● td-agent-bit.service - TD Agent Bit
         Loaded: loaded (/lib/systemd/system/td-agent-bit.service; disabled; vendor preset: enabled)
         Active: active (running) since Wed 2022-02-02 12:09:11 UTC; 56s ago
       Main PID: 7365 (td-agent-bit)
          Tasks: 3 (limit: 2311)
         Memory: 4.9M
         CGroup: /system.slice/td-agent-bit.service
                 └─7365 /opt/td-agent-bit/bin/td-agent-bit -c /etc/td-agent-bit/td-agent-bit.conf
    ```

## Enable the plugin {#connect-plugin}

1. Clone the repository with the plugin code:
    ```bash
    git clone https://github.com/yandex-cloud/fluent-bit-plugin-yandex.git
    ```
1. Compile the `yc-logging.so` library:
    ```bash
    cd fluent-bit-plugin-yandex/
    export fluent_bit_version=1.8.6
    export plugin_version=dev
    CGO_ENABLED=1 go build     -buildmode=c-shared \
      -o ./yc-logging.so \
      -ldflags "-X main.PluginVersion=${plugin_version}" \
      -ldflags "-X main.FluentBitVersion=${fluent_bit_version}"
    ```
1. Copy the `yc-logging.so` library:
    ```bash
    sudo cp yc-logging.so /usr/lib/td-agent-bit/yc-logging.so
    ```
1. To the `/etc/td-agent-bit/plugins.conf` file with plugin settings, add the path to the `yc-logging.so` library:
    ```
    [PLUGINS]
        Path /usr/lib/td-agent-bit/yc-logging.so
    ```
1. To the `/etc/td-agent-bit/td-agent-bit.conf` file, add the `td-agent-bit` service settings:
    ```
    [INPUT]
        Name  systemd
        Tag   host.*
        Systemd_Filter  _SYSTEMD_UNIT=logtest.service
    
    [OUTPUT]
        Name            yc-logging
        Match           *
        resource_type   logtest
        folder_id       <folder_ID>
        message_key     MESSAGE
        level_key       SEVERITY
        default_level   WARN
        authorization   instance-service-account
    ```

    In the `folder_id` field, specify the [ID of the folder](../resource-manager/operations/folder/get-id.md) to the [default log group](../logging/concepts/log-group.md) of which the logs will be transmitted.
1. Restart the `td-agent-bit` service:
    ```bash
    sudo systemctl restart td-agent-bit
    ```

## View the logs {#read-logs}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder that you specified in the `td-agent-bit` service settings.
    1. Open **{{ cloud-logging-name }}**.
    1. Click the **Groups** tab.
    1. Click on the line with the `default` log group.
    1. Click the **Logs** tab.
    1. The page that opens will show the log group records.

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    To view records in the log group, run the command:
    ```
    yc logging read --folder-id=<folder_ID>
    ```

    * `--folder-id`: The folder ID that is specified in the `td-agent-bit` service settings.

- API

    You can view the entries in a log group using the API [read](../logging/api-ref/grpc/log_reading_service.md) method.

{% endlist %}

## Delete the created resources {#delete-resources}

If you no longer need these resources, delete them:

1. [Delete the VM](../compute/operations/vm-control/vm-delete.md).
1. [Delete the log group](../logging/operations/delete-group.md).

