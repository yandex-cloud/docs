# Creating a VM from a public DSVM image

In the {{ yandex-cloud }} management console, create a [VM](../../concepts/vm.md) from a DSVM image using {{ compute-name }} and connect to it via SSH.

## Getting started {#before-you-begin}

{% include [before-you-begin-linux](../../../_includes/compute/before-you-begin-linux.md) %}

## Creating a VM from a public DSVM image {#create-dsvm}

{% include [create-instance-via-console-dsvm](../../_includes_service/create-instance-via-console-dsvm.md) %}

## Connecting to a VMs via SSH {#first-login}

You can connect to a VM via SSH once it gets the `RUNNING` status. To do this, use `ssh` in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

For more information about SSH connections, see [Connecting to a VM](../../quickstart/quick-create-linux.md#connect-to-vm).

When connected, you will see a welcome message with the commands to activate the environment and run [Jupyter Notebook](http://jupyter.org/index.html) and [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/):

```text
#####################################################################
Welcome to Yandex Data Science Virtual Machine
Image Build: ...

Please use one of the following commands to activate
the environment with the framework of your choice:
    for Python2 ______________________ source activate py27
    for Python3 ______________________ source activate py36

Packages installed in each environment:
    catboost, xgboost, lightgbm,
    tensorflow, pytorch,
    jupyter, matplotlib,
    numpy, scipy, scikit-learn

To run public {{ jlab }}Lab execute:
    jupyter lab --no-browser

To run public {{ jlab }} notebook execute:
    jupyter notebook --no-browser

Description and help:
    https://yandex.cloud/en/docs/compute/operations/dsvm/

#####################################################################
```