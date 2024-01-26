# Exchanging files with a Linux VM

To exchange files with a Linux VM, we recommend using the [SCP](https://ru.wikipedia.org/wiki/SCP) and [SFTP](https://ru.wikipedia.org/wiki/SFTP) protocols.

Both protocols tunnel TCP connections via [SSH](https://ru.wikipedia.org/wiki/SSH) when transferring files, which ensures the same security and authentication level as that of SSH.

Files are transferred using the same key pair as the one used for [connecting to a Linux VM over SSH](ssh.md).

## Exchanging files via SCP {#scp}

To transfer a file named `file1` from a local directory to a folder on the VM, run this command:

```bash
scp file1 <username>@<VM_IP_address>:<absolute_path_to_VM_folder>
```

To copy the file under a different name, specify a new file name in the destination address. For example, to save `file1` to a remote folder as `file1.txt`, run this command:

```bash
scp file1 <username>@<VM_IP_address>:<absolute_path_to_VM_folder>/file1.txt
```

To copy the entire directory contents, place the `-r` key before the directory name:

```bash
scp -r <local_directory> <username>@<VM_IP_address>:<absolute_path_to_VM_folder>
```

To change the file exchange direction, specify the remote address before the local one. For example, to download a file named `file2.txt` to your local computer, run this command:

```bash
scp <username>@server_ip:<absolute_path_to_VM_folder>/file2.txt <local_directory>
```

## Exchanging files via SFTP {#sftp}

To use SFTP tools, establish a connection to a remote VM: To do this, run the following command:

```bash
sftp <username>@<VM_IP_address>
```

This command will switch the terminal to interactive mode on the remote server. Go to the destination folder on the remote VM by running this command:

```bash
cd <absolute_path_to_VM_folder>
```

To upload a file from your local computer to the selected folder on the remote VM, run this command:

```bash
put <path_to_file_on_local_computer>
```

To download a file from a remote VM, run the command below:

```bash
get <path_to_file_on_VM>
```

To copy the entire directory, use the `-r` key in the `put` and `get` commands. For example, to copy all files from a local directory to a remote VM, run this command:

```bash
put -r <path_to_directory_on_local_computer>
```

{% note info %}

To copy files, the user must have write permissions for the folder on the destination server.

{% endnote %}

## Exchanging files using client applications

You can use the following client applications to exchange files:

* [WinSCP](https://winscp.net/eng/docs/introduction) with SCP and SFTP support
* [Filezilla](https://filezilla-project.org) with SFTP support

