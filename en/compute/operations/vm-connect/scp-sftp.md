# Exchanging files with a Linux VM

We recommend using [SCP](https://ru.wikipedia.org/wiki/SCP) and [SFTP](https://ru.wikipedia.org/wiki/SFTP) for exchanging files with a Linux VM.

Both protocols use [SSH](https://ru.wikipedia.org/wiki/SSH) tunneling for TCP connections to encrypt file transfers, delivering the same security and authentication level as SSH.

Files are transferred using the same key pair as the one used for [connecting to a Linux VM via SSH](ssh.md).

## Exchanging files via SCP {#scp}

To transfer a file named `file1` from a local folder to a VM folder, run this command:

```bash
scp file1 <username>@<VM_IP_address>:<absolute_path_to_VM_folder>
```

To copy the file under a different name, specify a new file name in the destination address. For example, to save `file1` to a remote folder as `file1.txt`, run this command:

```bash
scp file1 <username>@<VM_IP_address>:<absolute_path_to_VM_folder>/file1.txt
```

To copy the entire folder contents, use the `-r` key before the folder name:

```bash
scp -r <local_folder> <uername>@<VM_IP_address>:<absolute_path_to_VM_folder>
```

To change the file exchange direction, specify the remote address before the local one. For example, to download a file named `file2.txt` to your local computer, run this command:

```bash
scp <username>@server_ip:<absolute_path_to_VM_folder>/file2.txt <local_folder>
```

## Exchanging files via SFTP {#sftp}

To use SFTP tools, establish a connection to a remote VM. To do this, run the following command:

```bash
sftp <username>@<VM_IP_address>
```

This command will switch the terminal to interactive mode on the remote server. Go to the folder you need on the remote VM by running this command:

```bash
cd <absolute_path_to_VM_folder>
```

To upload a file from your local computer to the selected folder on the remote VM, run this command:

```bash
put <path_to_local_computer_file>
```

To download a file from a remote VM, run this command:

```bash
get <path_to_VM_file>
```

To copy the entire folder, use the `-r` key in the `put` and `get` commands. For example, to copy all files from a local folder to a remote VM, run this command:

```bash
put -r <path_to_local_computer_folder>
```

{% note info %}

To copy files, the user must have write permissions for the folder on the destination server.

{% endnote %}

## Exchanging files using client applications

You can use the following client applications to exchange files:

* [WinSCP](https://winscp.net/eng/docs/introduction) with SCP and SFTP support.
* [Filezilla](https://filezilla-project.org) with SFTP support.

