# Docker container for mounting an {{ objstorage-name }} bucket to an (S)FTP(S) server

To access a bucket over FTP, [FTPS](https://{{ lang }}.wikipedia.org/wiki/FTPS), or [SFTP](https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol), you can deploy a server using a public Docker container provided by {{ objstorage-name }}.

A container implements links between the {{ objstorage-name }} [GeeseFS](geesefs.md) FUSE client and servers: [vsftpd](https://security.appspot.com/vsftpd.html) for FTP and FTPS, and sftp-server (part of [OpenSSH](https://www.openssh.com/)) for SFTP.

## Before you start {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Installation {#install}

1. [Install Docker](https://docs.docker.com/get-docker/).
1. [Authenticate in {{ container-registry-name }}](../../container-registry/operations/authentication.md).
1. Download a container:

   ```bash
   docker pull {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
   ```

1. Create a folder named `secrets` to store FTP server user data and bucket mounting settings:

   ```bash
   mkdir secrets
   ```

1. In the `secrets` folder:

   * Create a file named `credentials`:

      ```
      [default]
          aws_access_key_id = <key ID>
          aws_secret_access_key = <key contents>
      ```

      Where:

      * `aws_access_key_id`: ID of the static access key obtained [before you started](#before-you-begin).
      * `aws_secret_access_key`: Contents of the static access key.

   * If you're going to use SFTP, create a file named `authorized_keys` with a public SSH key:

      ```
      ssh-rsa AAAAB3Nz.....BdZoeQ==
      ```

      For instructions on how to create an SSH key pair, see the [{{ compute-name }} documentation](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

   * If you're going to use FTPS, add the `ftp.pem` TLS certificate and its `ftp.key` to the folder. For example, for testing purposes, you can issue a self-signed certificate:

      ```bash
      openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout secrets/ftp.key -out secrets/ftp.pem
      ```

1. Create an `env.list` file with environment variables for the container:

   ```
   <variable name>=<variable value>
   ...
   ```

   Supported variables:

   * `S3_BUCKET` is the bucket name or path to its [folder](../concepts/object.md#folder) to be mounted to the FTP server, in `<bucket name>/<folder path>` format. Required variable.
   * `SFTP`: Enables the use of SFTP. By default, `YES`.
   * `FTP`: Enables the use of FTP. By default, `NO`.
   * `FTP_USER`: Username for establishing a server connection. By default, `s3`.
   * `FTP_PASS`: User password for establishing a server connection. By default, a random password is generated, which is displayed in container logs.
   * `FTP_PASV_ENABLE`: Enables passive FTP connection mode. By default, `YES`.
   * `FTP_PASV_MIN_PORT`: Start of the port range for passive mode. By default, `21100`.
   * `FTP_PASV_MAX_PORT`: End of the port range for passive mode. By default, `21100`.
   * `FTP_PASV_ADDRESS`: Server IP address or its domain name (if the `FTP_PASV_ADDR_RESOLVE` option is selected) for passive mode. By default, the IP address specified in the container's route table (the `ip route show` command) is used as the default route target address (a string like `default via <IP address> ...` corresponds to it).
   * `FTP_PASV_ADDR_RESOLVE`: Allows specifying the server domain name instead of its IP address in the `FTP_PASV_ADDRESS` variable. By default, `YES`.
   * `FTP_PASV_PROMISCUOUS`: Disables client IP address mapping for passive mode: a control connection can be opened from one client address and a connection for data exchange from another. By default, `NO`. It's not recommended to disable the check.
   * `FTP_PORT_PROMISCUOUS`: Disables client IP address mapping for active mode: when a control connection is established, a client can specify another client's address in the `PORT` command. By default, `NO`. It's not recommended to disable the check.
   * `FTP_SSL_ENABLE`: Enables the use of FTPS (over TLS 1.x) instead of FTP:

      * `YES` (default): FTPS is enabled but optional. Clients can establish non-secure FTP connections to the server.
      * `FORCE`: FTPS is enabled and required. Clients can only establish secure FTPS connections to the server.
      * `NO`: FTPS is disabled.

   * `FTP_RSA_CERT_FILE`: Path to the TLS certificate inside the container. By default, `/secrets/ftp.pem`.
   * `FTP_RSA_PRIVATE_KEY_FILE`: Path to the private key of the TLS certificate inside the container. By default, `/secrets/ftp.key`.

1. Run the container:

   {% list tabs %}

   - SFTP

      ```bash
      docker run -d -it \
        --cap-add SYS_ADMIN \
        --device /dev/fuse \
        --security-opt apparmor:unconfined \
        --env-file env.list \
        -v <full path to the secrets folder>:/secrets \
        -p 1022:22 \
        --name ftp \
        {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
      ```

      The server will accept connections on port 1022.

   - FTP(S)

      ```bash
      docker run -d -it \
        --cap-add SYS_ADMIN \
        --device /dev/fuse \
        --security-opt apparmor:unconfined \
        --env-file env.list \
        -v <full path to the secrets folder>:/secrets \
        --expose 21 \
        -p 1021:21 \
        --expose 21100 \
        -p 21100:21100 \
        --name ftp \
        {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
      ```

      The server will accept connections on port 1021. In addition, for passive mode (the `FTP_PASV_ENABLE` variable), port 21100 is open: if you don't use this mode, the `--expose 21100` and `-p 21100:21100` options aren't required.

   {% endlist %}

## Specifics of uploading files to a bucket {#uploading-files}

The GeeseFS client that is part of a Docker container works with files asynchronously. It caches new files and uploads them to a bucket after a while. If an FTP server connection is broken between these two points of time, uploaded files may be lost either partially or completely.

To ensure data integrity when establishing SFTP connections, use the `fsync@openssh.com` extension so that file uploads are considered successful only after the `fsync` system call. For example, for the sftp client that is part of OpenSSH, the extension is enabled with the `-f` flag: `sftp -f <server address>`. Waiting for `fsync` calls slows down operations with files.