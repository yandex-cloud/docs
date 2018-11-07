# Creating a VM from a public DSVM image

To create a VM:

1. Open the folder where the VM will be created.
1. Click **Create resource**.
1. Select **Virtual machine**.
1. In the **Name** field, enter the VM name.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to locate the VM in.
1. Select a public DSVM [image](../images-with-pre-installed-software/get-list.md).
1. In the **Computing resources** section, select the [type of core usage](../../concepts/vm-types.md) (partial or full), specify the necessary number of vCPUs, and the amount of RAM.
1. In the **Network settings** section, select the subnet to connect the VM to when creating it.
1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file. You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.
1. Click **Create VM**.

[!INCLUDE [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md)]

## Connecting to a DSVM via SSH {#first-login}

[!INCLUDE [vm-connect-ssh](../../../_includes/vm-connect-ssh.md)]

In the welcome message, you will see the commands for activating an environment and running [Jupyter Notebook](http://jupyter.org/index.html) and [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/):

```
#####################################################################
Welcome to Yandex Data Science Virtual Machine
...

Please use one of the following commands to activate
the environment with the framework of your choice:
    for Python2 ______________________ source activate py27
    for Python3 ______________________ source activate py36

...

To run public Jupyter notebook execute:
    jupyter notebook --ip=* --no-browser

To run public JupyterLab execute:
    jupyter lab --ip=* --no-browser

Description and help:
    https://cloud.yandex.ru/docs/compute/operations/dsvm/

#####################################################################
```
