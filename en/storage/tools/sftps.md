# Docker container for mounting an {{ objstorage-name }} bucket to an (S)FTP(S) server

To access a [bucket](../concepts/bucket.md) over FTP, [FTPS](https://{{ lang }}.wikipedia.org/wiki/FTPS), or [SFTP](https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol), you can deploy the server using a public Docker container provided by {{ objstorage-name }}.

A Docker container implements links between the {{ objstorage-name }} [GeeseFS](geesefs.md) FUSE client and servers: [vsftpd](https://security.appspot.com/vsftpd.html) for FTP and FTPS and sftp-server (part of [OpenSSH](https://www.openssh.com/)) for SFTP.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#install}

1. [Install Docker](https://docs.docker.com/get-docker/).
1. [Get authenticated in {{ container-registry-full-name }}](../../container-registry/operations/authentication.md).
1. Pull a Docker container:

   ```bash
   docker pull {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
   ```

1. Create a [folder](../concepts/object.md#folder) named `secrets` to store FTP server user data and bucket mounting settings:

   ```bash
   mkdir secrets
   ```

1. In the `secrets` folder:
   * Create a file named `credentials`:

     ```text
     [default]
     aws_access_key_id = <key_ID>
     aws_secret_access_key = <key_contents>
     ```

     Where:
     * `aws_access_key_id`: ID of the static access key obtained [when getting started](#before-you-begin).
     * `aws_secret_access_key`: Contents of the static access key.
   * If you are going to use SFTP, create a file named `authorized_keys` with a public SSH key:

     ```text
     ssh-ed25519 AAAAB3Nz.....BdZoeQ==
     ```

     
     To learn how to create an SSH key pair, see the [{{ compute-name }} documentation](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).


   * If you are going to use FTPS, add the `ftp.pem` TLS certificate and its `ftp.key` to the folder. For example, for testing purposes, you can issue a self-signed certificate:

     ```bash
     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout secrets/ftp.key -out secrets/ftp.pem
     ```
    
    
    {% include [tls-support-alert](../../_includes/storage/tls-support-alert.md) %}


1. Create an `env.list` file with environment variables for the Docker container:

   ```text
   <variable_name>=<variable_value>
   ...
   ```

   Supported variables:
   * `S3_BUCKET`: Bucket name or path to its folder to mount to the FTP server, in `<bucket_name>:<folder_path>` format. This is a required variable.
   * `SFTP`: Enables the use of SFTP. The default value is `YES`.
   * `FTP`: Enables the use of FTP. The default value is `NO`.
   * `FTP_USER`: Username to connect to the server. The default value is `s3`.
   * `FTP_PASS`: User password to connect to the server. By default, a random password is generated and displayed in Docker container logs.
   * `FTP_PASV_ENABLE`: Enables passive FTP connection mode. The default value is `YES`.
   * `FTP_PASV_MIN_PORT`: Start of the port range for passive mode. The default value is `21100`.
   * `FTP_PASV_MAX_PORT`: End of the port range for passive mode. The default value is `21100`.
   * `FTP_PASV_ADDRESS`: Server IP address or its domain name (if the `FTP_PASV_ADDR_RESOLVE` option is selected) for passive mode. By default, the IP address specified in the Docker container's route table (the `ip route show` command) is used as the default route target IP address (specified in a `default via <IP_address> ...` string).
   * `FTP_PASV_ADDR_RESOLVE`: Allows specifying the server domain name instead of its IP address in the `FTP_PASV_ADDRESS` variable. The default value is `YES`.
   * `FTP_PASV_PROMISCUOUS`: Disables client IP address mapping for passive mode, i.e., you can open a managing connection from one client address, while a connection for data exchange, from another. The default value is `NO`. We do not recommend disabling this check.
   * `FTP_PORT_PROMISCUOUS`: Disables client IP address mapping for active mode, i.e., when a managing connection is established, a client can specify another client's address in the `PORT` command. The default value is `NO`. We do not recommend disabling this check.
   * `FTP_SSL_ENABLE`: Enables the use of FTPS (over TLS 1.x) instead of FTP:
     * `YES` (default): FTPS is enabled but optional. Clients can establish non-secure FTP connections to the server.
     * `FORCE`: FTPS is enabled and required. Clients can only establish secure FTPS connections to the server.
     * `NO`: FTPS is disabled.
   * `FTP_RSA_CERT_FILE`: Path to the TLS certificate inside the Docker container. The default value is `/secrets/ftp.pem`.
   * `FTP_RSA_PRIVATE_KEY_FILE`: Path to the private key of the TLS certificate inside the Docker container. The default value is `/secrets/ftp.key`.
1. Run the Docker container:

   {% list tabs group=protocols %}

   - SFTP {#sftp}
    
      ```bash
      docker run -d -it \
        --cap-add SYS_ADMIN \
        --device /dev/fuse \
        --security-opt apparmor:unconfined \
        --env-file env.list \
        -v <full_path_to_secrets_folder>:/secrets \
        -p 1022:22 \
        --name ftp \
        {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
      ```

     The server will accept connections on port 1022.

   - FTP(S) {#ftp}

     ```bash
     docker run -d -it \
       --cap-add SYS_ADMIN \
       --device /dev/fuse \
       --security-opt apparmor:unconfined \
       --env-file env.list \
       -v <full_path_to_secrets_folder>:/secrets \
       --expose 21 \
       -p 1021:21 \
       --expose 21100 \
       -p 21100:21100 \
       --name ftp \
       {{ objstorage-sftps-gateway-uri }}:{{ objstorage-sftps-gateway-version }}
     ```

     The server will accept connections on port 1021. Also, port 21100 is open for passive mode (the `FTP_PASV_ENABLE` variable); if you are not using this mode, the `--expose 21100` and `-p 21100:21100` options are not required.

   {% endlist %}

1. Connect to the server:

   {% list tabs group=protocols %}

   - SFTP {#sftp}
    
      ```bash
      sudo sftp -i <path_to_private_SSH_key> -P 1022 s3@localhost
      ```

      After a successful connection, you will have access to a console for interfacing with the SFTP server.

   - FTP {#ftp}

     ```bash
     ftp -P 1021 s3@localhost
     ```

     After a successful connection, you will have access to a console for interfacing with the FTP server.

   {% endlist %}

## Specifics of uploading files to a bucket {#uploading-files}

The GeeseFS client that is part of a Docker container works with files asynchronously. It caches new files and uploads them to a bucket after a while. If an FTP server connection is broken between these two points of time, uploaded files may be lost either partially or completely.

To ensure data integrity when establishing SFTP connections, use the `fsync@openssh.com` extension so that file uploads are considered successful only after the `fsync` system call. For example, for the sftp client that is part of OpenSSH, the extension is enabled with the `-f` flag: `sftp -f <server_address>`. Waiting for `fsync` calls slows down operations with files.
