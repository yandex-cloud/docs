1. [Connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the server over SSH.
1. Create a new user named `kuma`:

    ```bash
    sudo useradd kuma
    ```

1. Create the `kuma` user's home directory:

    ```bash
    sudo mkdir /home/kuma
    ```

1. Create a file with a static access key and grant permissions for it to the `kuma` user:

    ```bash
    sudo bash -c 'echo <access_key_ID>:<secret_access_key> > /home/kuma/.passwd-s3fs'
    sudo chmod 600 /home/kuma/.passwd-s3fs
    sudo chown -R kuma:kuma /home/kuma
    ```

    Where `<access_key_ID>` and `<secret_access_key>` are the previously saved values ​​of the static access key of the `kuma-bucket-sa` service account.

1. Install the [s3fs](https://github.com/s3fs-fuse/s3fs-fuse) package:

    ```bash
    sudo apt install s3fs
    ````

1. Create a directory that will serve as a mount point for the bucket and grant permissions for it to the `kuma` user:

    ```bash
    sudo mkdir /var/log/yandex-cloud/
    sudo chown kuma:kuma /var/log/yandex-cloud/
    ```

1. Mount the bucket you created earlier by specifying its name:

    ```bash
    sudo s3fs <bucket_name> /var/log/yandex-cloud \
      -o passwd_file=/home/kuma/.passwd-s3fs \
      -o url=https://{{ s3-storage-host }} \
      -o use_path_request_style \
      -o uid=$(id -u kuma) \
      -o gid=$(id -g kuma)
    ```

    You can configure automatic mounting of the bucket at operating system start-up by opening the `/etc/fstab` file (`sudo nano /etc/fstab` command) and adding the following line to it:

    ```text
    s3fs#<bucket_name> /var/log/yandex-cloud fuse _netdev,uid=<kuma_uid>,gid=<kuma_gid>,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/kuma/.passwd-s3fs 0 0
    ```

    Where:

    * `<bucket_name>`: Name of the bucket you created earlier, e.g., `my-audit-logs-for-kuma`.
    * `<kuma_uid>`: `kuma` user ID in the VM operating system.
    * `<kuma_gid>`: `kuma` user group ID in the VM operating system.

        To learn `<kuma_uid>` and `<kuma_gid>`, run the `id kuma` command in the terminal.

1. Make certain that the bucket is mounted:

    ```bash
    sudo ls /var/log/yandex-cloud/
    ```

    If everything is configured correctly, the command will return the current contents of the audit event bucket.

The {{ yandex-cloud }} event transfer setup is complete. The events will reside in [JSON](https://{{ lang }}.wikipedia.org/wiki/JSON) files located at:

```text
/var/log/yandex-cloud/{audit_trail_id}/{year}/{month}/{day}/*.json
```