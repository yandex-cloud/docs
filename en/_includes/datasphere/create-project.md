To create a project:

1. In the [management console]({{ link-console-main }}) open the **{{ ml-platform-name }}** section in the folder where you want to create your project.
1. Go to the **Projects** tab.
1. Click **Create project**.
1. Enter the **Name** of the project.
1. (optional) Enter the **Description** of the project.
1. (optional) Configure **Advanced settings**:
   * Select a **Service account** or [create](../../iam/operations/sa/create.md) a new one.
   * Select a **Subnet**.
      To ensure that your project can use online resources, [enable NAT](../../vpc/operations/enable-nat.md) for the selected subnet.

      {% include [subnet-create](../../_includes/subnet-create.md) %}

   * Select a **{{ dataproc-name }} cluster**.
      The cluster must be on the same network as your project.
1. Click **Create**.

To start working with {{ jlab }}Lab, open the created project:
1. Click the row of the project you need.

Or:

1. Click ![image](../../_assets/datalens/horizontal-ellipsis.svg) next to the project.
1. Choose **Open**.

   {% include [include](project-opening-delay.md) %}