1. Upload the product logo in SVG format.

1. Select product categories.

1. In the **Plan** field, select the service plan that you created or create a new one.

1. In the **Compute image** field, click **Add**. In the window that opens, find your folder and select the image.

1. Fill in the product information in Russian and English:

   * **Name**: The name of your product.
   * **Short description**: A brief description.
   * **Description**: A detailed description of your product: what problems it addresses, its key characteristics, features, and advantages over similar products. Be specific and avoid advertising cliches.
   * **Product installation**: Step-by-step instructions on how to get started with your product. Specify what to pay attention to when deploying your product and what difficulties users may face.
   * **Support**: Your contact details if there are any questions or something goes wrong while using the product.
   * **Use examples**: A list of examples of how your product can be used. Give links to available use cases (if any).

1. Add useful links in Russian and English.

1. If necessary, specify the OS name and version. This section is filled out automatically based on the parameters of the basic image of the operating system.

1. Under **Product packages**, list the software and versions included in the product.

1. Under **Required resources**:

    * Set the VM configuration requirements for your software to run:

      1. Click on the plus sign icon on the right.

      1. Select an option for:
         * **CPU share**.
         * **Platforms**.
         * **GPU**.
         * **Network**.
         * **Roles**.
         To remove a parameter, click ![image](../../_assets/cross.svg) next to the name. The **CPU**, **RAM**, and **Disk size** parameters are required and can't be removed.

    * For the parameters:
      * **Platforms**: Select all the platforms on which the VM can be deployed.
      * **Roles**: Select the required roles. If you specify the service account role, the user will be prompted to link a service account with this role to the VM when it is deployed.
      * **Network**: Specify the maximum available number of network interfaces for VMs based on your product. By default, one network interface is available.
    * For the other parameters in the **Minimum** field, specify the value that guarantees your software will run on the deployed VM. The user can't start a VM with the parameters below those specified. If necessary, fill in the fields:
      * **Maximum**: The maximum parameter value. The user can't start a VM with parameters above those specified.
      * **Recommended value**: The optimal value for your software to run on the VM.

1. Under **Terms of service**, add links to license agreements.

   For each link, fill in the following fields:
   * **Header (ru)**: The name of the product (or license agreement) in Russian.
   * **Header (en)**: The name of the product (or license agreement) in English.
   * **Type**: The type of the license agreement:
       * For the main product: Additional terms of service.
       * For software from other vendors included in the product: Additional terms of service by third parties.
   * **URL**: A link to the license agreement.

1. Click **Create**.