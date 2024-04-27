# Creating a VM from a public DSVM image

Create a DSVM [VM](../../concepts/vm.md) using {{ compute-name }} from the {{ yandex-cloud }} management console and connect to it over SSH.

## Getting started {#before-you-begin}

{% include [before-you-begin-linux](../../../_includes/compute/before-you-begin-linux.md) %}

## Creating a VM from a public DSVM image {#create-dsvm}

{% include [create-instance-via-console-dsvm](../../_includes_service/create-instance-via-console-dsvm.md) %}

## Connecting to VMs over SSH {#first-login}

You can connect to a VM over SSH once it is started (i.e., has the `RUNNING` status). You can use the `ssh` utility in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

Read more about SSH connections in the [Connecting to a VM](../../quickstart/quick-create-linux.md#connect-to-vm) section.

When connected, in the welcome message, you will see the commands to activate the environment and run [Jupyter Notebook](http://jupyter.org/index.html) and [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/):

```
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
