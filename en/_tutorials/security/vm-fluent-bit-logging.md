# Transferring logs from a VM to {{ cloud-logging-full-name }}

The [Fluent Bit](https://fluentbit.io/) logging processor allows you to transfer logs from [VM instances](../../compute/concepts/vm.md) to [{{ cloud-logging-full-name }}](../../logging/). To transfer logs, you will use the [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).

To set up log transfer:

1. [Create a `systemd` service that generates logs](#systemd).
1. [Install and configure Fluent Bit](#install-fluent-bit).
1. [Enable the plugin](#connect-plugin).

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `logging.writer` role for the folder.
1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a public [Ubuntu 24.04](/marketplace/products/yc/ubuntu-24-04-lts) image. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the service account you created at the previous step.
1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.
1. Install development packages on the VM:

    ```bash
    sudo apt-get update
    sudo apt-get install -y python3-pip python3-venv python3-systemd git build-essential pkg-config libsystemd-dev golang-go
    ```

    The command installs:
      * **python3-pip**: Python package manager (pip) for creating a `systemd` service that generates logs.
      * **python3-venv**: Module for creating Python virtual environments.
      * **python3-systemd**: Python library for interacting with `systemd`.
      * **git**: Version control system for downloading the Fluent Bit for {{ cloud-logging-full-name }} plugin source code from GitHub.
      * **build-essential**: Software compilers and build tools.
      * **pkg-config**: Utility that fetches compiler and linker flags for libraries.
      * **libsystemd-dev**: Header files and development libraries for `systemd`.
      * **golang-go**: Go (Golang) compiler and tools for building the Fluent Bit plugin.

1. Check the versions of the packages you installed:

    ```bash
    python3 --version
    pip3 --version
    go version
    ```

    You need these versions or higher:

    ```
    Python 3.10
    pip 22.0.2 from /usr/lib/python3/dist-packages/pip (python 3.10)
    go version go1.17.6 linux/amd64
    ```

## Create a `systemd` service that generates logs {#systemd}

1. Create a directory:

    ```bash
    sudo mkdir -p /usr/local/bin/logtest
    sudo chown $USER /usr/local/bin/logtest
    cd /usr/local/bin/logtest
    ```

1. Create a file named `logtest.py`:

    ```python
    import logging
    import random
    import sys
    import time
    from systemd import journal

    # Configuring the logger
    logger = logging.getLogger("logtest")
    journald_handler = journal.JournalHandler(SYSLOG_IDENTIFIER="logtest")
    logger.addHandler(journald_handler)
    logger.setLevel(logging.DEBUG)

    # Generate URL-like values.
    PATHS = [
        "/",
        "/admin",
        "/hello",
        "/docs",
    ]

    PARAMS = [
        "foo",
        "bar",
        "query",
        "search",
        None
    ]

    def fake_url():
        path = random.choice(PATHS)
        param = random.choice(PARAMS)
        if param:
            val = random.randint(0, 100)
            param += "={}".format(val)
        code = random.choices([200, 400, 404, 500], weights=[10, 2, 2, 1])[0]
        return "?".join(filter(None, [path, param])), code

    if __name__ == "__main__":
        while True:
            path, code = fake_url()
            if code == 200:
                logger.info(
                    "Path: {}".format(path),
                    extra={
                        "code": code
                    }
                )
            else:
                logger.error(
                    "Error: {}".format(path),
                    extra={
                        "code": code
                    }
                )
            time.sleep(1)
    ```

1. Create a virtual environment and install the required dependencies:

    ```bash
    python3 -m venv ~/venv
    source ~/venv/bin/activate
    pip install systemd-python
    ```

1. Make the file executable:

    ```bash
    sudo chmod +x /usr/local/bin/logtest/logtest.py
    ```

1. Create a file named `/etc/systemd/system/logtest.service`:

    ```ini
    [Unit]
    Description=Log Test Service
    After=network.target

    [Service]
    ExecStart=/home/$USER/venv/bin/python3 /usr/local/bin/logtest/logtest.py
    Environment=PYTHONPATH=/home/$USER/venv/lib/python3.12/site-packages
    Restart=always
    User=$USER
    StandardOutput=journal
    StandardError=journal

    [Install]
    WantedBy=multi-user.target
    ```

1. Restart `systemd`:

    ```bash
    sudo systemctl daemon-reload
    ```

1. Run and check the service status:

    ```bash
    sudo systemctl start logtest
    sudo systemctl status logtest
    ```

    Result:

    ```
    ● logtest.service - Sample to show logging from a Python application to systemd
         Loaded: loaded (/etc/systemd/system/logtest.service; linked; vendor preset: enabled)
         Active: active (running) since Thu 2024-05-30 12:34:56 UTC; 5s ago
       Main PID: 12345 (logtest.sh)
          Tasks: 2 (limit: 2311)
         Memory: 18.5M
            CPU: 156ms
         CGroup: /system.slice/logtest.service
                 ├─12345 /bin/bash /usr/local/bin/logtest/logtest.sh
                 └─12346 python /usr/local/bin/logtest/logtest.py
    ```

## Install and configure Fluent Bit {#install-fluent-bit}

1. Add the GPG key and Fluent Bit repository:

    ```bash
    wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -
    echo "deb https://packages.fluentbit.io/ubuntu/focal focal main" | sudo tee /etc/apt/sources.list.d/fluent-bit.list
    ```

1. Install Fluent Bit:

    ```bash
    sudo apt-get update
    sudo apt-get install -y fluent-bit
    ```

## Enable the plugin {#connect-plugin}

1. Clone the repository with the plugin:

    ```bash
    git clone https://github.com/yandex-cloud/fluent-bit-plugin-yandex.git
    cd fluent-bit-plugin-yandex
    ```

1. Create and configure the version file:

    ```bash
    cat > versions.sh << 'EOL'
    #!/bin/bash
    export fluent_bit_version=3.0.3
    export golang_version=1.22.2
    export plugin_version=dev
    EOL

    chmod +x versions.sh
    source ./versions.sh
    ```

1. Build the plugin:

    ```bash
    CGO_ENABLED=1 go build -v -buildmode=c-shared -o yc-logging.so yclogging.go
    ```

1. Install the plugin:

    ```bash
    sudo mkdir -p /usr/local/lib/fluent-bit/
    sudo cp yc-logging.so /usr/local/lib/fluent-bit/
    sudo chmod 644 /usr/local/lib/fluent-bit/yc-logging.so
    ```

1. Create a file named `/etc/fluent-bit/plugins.conf`:

    ```ini
    [PLUGINS]
        Path /usr/local/lib/fluent-bit/yc-logging.so
    ```

1. Create a file named `/etc/fluent-bit/fluent-bit.conf`:

    ```ini
    [SERVICE]
        Flush        1
        Daemon       Off
        Log_Level    info
        Parsers_File parsers.conf
        Plugins_File plugins.conf

    [INPUT]
        Name            systemd
        Tag             host.*
        Systemd_Filter  _SYSTEMD_UNIT=logtest.service

    [OUTPUT]
        Name            yc-logging
        Match           *
        resource_type   logtest
        folder_id       <catalog_ID>
        message_key     MESSAGE
        level_key       SEVERITY
        default_level   WARN
        authorization   instance-service-account
    ```

    Where:
    * `folder_id`: ID of the {{ yandex-cloud }} folder whose default log group will receive the logs.
    * `authorization`: Authorization settings. The `instance-service-account` value is used for authorization as the service account specified when creating the VM.
    * `level_key`: Field indicating the logging level.
    * `message_key`: Field with the message text.
    * `default_level`: Default logging level if not specified in the message.

1. Restart Fluent Bit:

    ```bash
    sudo systemctl restart fluent-bit
    ```

## View the logs {#read-logs}

{% list tabs group=instructions %}

- Management console {#console}

    1. Check the status of services:

    ```bash
    sudo systemctl status logtest
    sudo systemctl status fluent-bit
    ```

    Result:

    ```
    ● fluent-bit.service - Fluent Bit
         Loaded: loaded (/lib/systemd/system/fluent-bit.service; disabled; vendor preset: enabled)
         Active: active (running) since Thu 2024-05-30 12:34:56 UTC; 5s ago
           Docs: https://docs.fluentbit.io/manual/
       Main PID: 12347 (fluent-bit)
          Tasks: 4 (limit: 2311)
         Memory: 18.8M
            CPU: 156ms
         CGroup: /system.slice/fluent-bit.service
                 └─12347 /opt/fluent-bit/bin/fluent-bit -c /etc/fluent-bit/fluent-bit.conf
    ```

    1. View the logs:

        ```bash
        # Test service logs
        sudo journalctl -u logtest -n 10 | cat

        # Fluent Bit logs
        sudo journalctl -u fluent-bit -n 20 | cat
        ```

        If everything works correctly:

        1. The status of both services must be `active (running)`.
        1. Test service logs should display these messages:
           * `Path: /admin?query=90` for successful requests.
           * `Error: /docs?bar=44` for failed requests.
        1. Make sure the Fluent Bit logs are error-free.

    1. Check the logs in the management console:

       1. Open the [management console]({{ link-console-main }}).
       1. Navigate to the folder specified in `folder_id`.
       1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
       1. Open the `default` log group.
       1. On the **{{ ui-key.yacloud.common.logs }}** tab, configure filters:
          * `resource_type=logtest` to view test service logs.
          * `timestamp > now()-1h` to view logs for the last hour.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view records in the log group, run this command:

    ```bash
    yc logging read --folder-id=<catalog_ID>
    ```

    Where `--folder-id` is the ID specified in the `fluent-bit` settings.

- API {#api}

    To view log group records, use the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

{% endlist %}

## Troubleshooting {#troubleshooting}

1. File access errors and system issues:
   * Check access permissions for critical files:
  
     ```bash
     ls -l /usr/local/lib/fluent-bit/yc-logging.so
     ls -l /etc/fluent-bit/plugins.conf
     ls -l /etc/fluent-bit/fluent-bit.conf
     ```

     The correct result should look like this:

     ```
     -rwxr-xr-x 1 root root 8123456 May 30 12:34 /usr/local/lib/fluent-bit/yc-logging.so
     -rw-r--r-- 1 root root 123 May 30 12:34 /etc/fluent-bit/plugins.conf
     -rw-r--r-- 1 root root 456 May 30 12:34 /etc/fluent-bit/fluent-bit.conf
     ```

   * Check system logs for errors:

     ```bash
     sudo tail -f /var/log/syslog
     ```

     Example of correct logs:

     ```
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [fluent bit] version=3.0.3
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [storage] ver=1.4.0, type=memory
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [cmetrics] version=0.6.3
     ```

     ```bash
     journalctl -xe
     ```

     Example of correct logs:

     ```
     May 30 12:34:56 vm-name systemd[1]: Started Fluent Bit.
     May 30 12:34:56 vm-name fluent-bit[12347]: Fluent Bit v3.0.3
     May 30 12:34:56 vm-name logtest.sh[12345]: [INFO] 200 Path: /hello?query=42
     ```

1. `Permission denied` error:
   * Check the service account permissions:

     ```bash
     yc iam service-account list
     ```

     The result should display your service account:

     ```
     +----------------------+---------------+
     |          ID          |     NAME      |
     +----------------------+---------------+
     | aje5n27q235g8m3...   | service-acc-1 |
     +----------------------+---------------+
     ```

   * Check the service account roles:

     ```bash
     yc iam service-account get service-acc-1
     ```

     The result should indicate the `logging.writer` role:

     ```
     id: aje5n27q235g8m3...
     folder_id: b1g4c2a3v000000000000
     name: service-acc-1
     roles:
       - logging.writer
     ```

1. Logs do not show up in Cloud Logging:
   * Make sure the `folder_id` in the configuration is correct:

     ```bash
     grep folder_id /etc/fluent-bit/fluent-bit.conf
     ```

     The result should display your `folder_id`:

     ```
     folder_id b1g4c2a3v000000000000
     ```

   * Make sure the yc-logging plugin is loaded correctly:

     ```bash
     sudo systemctl status fluent-bit | grep yc-logging
     ```

     The correct result should be as follows:

     ```
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [output:yc-logging:yc-logging.0] worker #0 started
     ```

1. Log format issues:
   * Check the settings in the configuration:

     ```bash
     grep -A 5 '\[OUTPUT\]' /etc/fluent-bit/fluent-bit.conf
     ```

     The correct result should be as follows:

     ```
     [OUTPUT]
         Name            yc-logging
         Match           *
         resource_type   logtest
         message_key     MESSAGE
         level_key       SEVERITY
     ```

   * Check the log format in `journald`:

     ```bash
     journalctl -u logtest -n 5
     ```

     The correct log format is as follows:

     ```
     May 30 12:34:56 vm-name logtest.sh[12345]: [INFO] 200 Path: /hello?query=42
     May 30 12:34:57 vm-name logtest.sh[12345]: [ERROR] 404 Error: /admin?foo=13
     ```

1. File access errors and system issues:
   * Check access permissions for critical files:
  
     ```bash
     ls -l /usr/local/lib/fluent-bit/yc-logging.so
     ls -l /etc/fluent-bit/plugins.conf
     ls -l /etc/fluent-bit/fluent-bit.conf
     ```

   * Check system logs for errors:

     ```bash
     sudo tail -f /var/log/syslog
     journalctl -xe
     ```

   * Make sure all files have correct access permissions (644 for configuration files, 755 for libraries).

1. `Permission denied` error:
   * Check the service account permissions.
   * Make sure the `logging.writer` role is assigned for the appropriate folder.
   * Make sure the service account token is valid.

1. Logs do not show up in Cloud Logging:
   * Make sure the `folder_id` in the configuration is correct.
   * Make sure the log format matches the expected one.
   * Make sure the yc-logging plugin is loaded correctly:
  
     ```bash
     sudo systemctl status fluent-bit | grep yc-logging
     ```

1. Log format issues:
   * Check the `message_key` and `level_key` settings.
   * Make sure the logs contain the required fields.
   * Check the time format in logs.

## Useful diagnostic commands {#diagnostic-commands}

1. View extended Fluent Bit logs:
   * Real-time log monitoring:

     ```bash
     sudo journalctl -u fluent-bit -n 100 -f
     ```

     Output example:

     ```
     May 30 12:34:56 vm-name fluent-bit[1234]: [info] [engine] started (pid=1234)
     May 30 12:34:56 vm-name fluent-bit[1234]: [info] [storage] version=1.1.6, initializing...
     May 30 12:34:57 vm-name fluent-bit[1234]: [info] [yc-logging] plugin initialized successfully
     ```

1. Checking CPU and memory usage:
   * Monitoring the Fluent Bit process:

     ```
     ps aux | grep fluent-bit
     top -p $(pgrep fluent-bit)
     ```
     
     Example of ps output:
     ```
     fluent  1234  0.5  1.2 256892 12644 ?  Ssl  12:34  0:02 /opt/fluent-bit/bin/fluent-bit -c /etc/fluent-bit/fluent-bit.conf
     ```

1. Monitoring network connections:
   * Checking open ports and connections:

     ```bash
     sudo netstat -tupn | grep fluent-bit
     ```
     
     Output example:
     ```
     tcp  0  0  0.0.0.0:24224  0.0.0.0:*  LISTEN  1234/fluent-bit
     tcp  0  0  10.0.0.2:52431  logging.api.cloud.yandex.net:443  ESTABLISHED  1234/fluent-bit
     ```

1. Verifying plugin loading:
   * Viewing open files of the process:

     ```bash
     sudo lsof -p $(pgrep fluent-bit) | grep yc-logging
     ```
     
     Output example:
     ```
     fluent-bit 1234 fluent-bit  mem REG 8,1 2890144 /usr/local/lib/fluent-bit/yc-logging.so
     ```

1. Checking configuration files:
   * Getting checksums:

     ```
     find /etc/fluent-bit/ -type f -exec md5sum {} \;
     ```
     
     Output example:
     ```
     a1b2c3d4e5f6g7h8 /etc/fluent-bit/fluent-bit.conf
     b2c3d4e5f6g7h8i9 /etc/fluent-bit/plugins.conf
     c3d4e5f6g7h8i9j0 /etc/fluent-bit/parsers.conf
     ```

## Delete the resources you created {#delete-resources}

If you no longer need the resources you created, delete them:

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the log group](../../logging/operations/delete-group.md).