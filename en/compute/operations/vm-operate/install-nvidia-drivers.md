# Installing NVIDIA drivers

To enable compatibility with [GPU](../../concepts/gpus.md), make sure that NVIDIA drivers are installed on the VM. You can install the drivers either [when preparing the image](../image-create/custom-image.md) or from inside the VM after it is created.

To install the drivers:

{% list tabs %}

- Tesla® V100

  1. Go to the [form](https://www.nvidia.com/download/index.aspx) page.
  1. Select Data Center / Tesla in the **Product type** field.
  1. Select V-Series in the **Product series** field.
  1. Select Tesla V100 in the **Product family** field.
  1. Select the OS in the **Operating system** field.
  1. Specify other settings according to your OS and driver requirements.
  1. Click **Search**. The appropriate driver page opens.
  1. Click **Download now**.

- Ampere® A100

  1. Go to the [form](https://www.nvidia.com/download/index.aspx) page.
  1. Select Data Center / Tesla in the **Product type** field.
  1. Select A-Series in the **Product series** field.
  1. Select NVIDIA A100 in the **Product family** field.
  1. Select the OS in the **Operating system** field.
  1. Specify other settings according to your OS and driver requirements.
  1. Click **Search**. The appropriate driver page opens.
  1. Click **Download now**.

{% endlist %}

Run the downloaded installer and follow the instructions.

