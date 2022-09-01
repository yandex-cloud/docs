To set up project [budget](../../datasphere-ui-preview/concepts/budget.md):

1. Open the {{ ml-platform-name }} [homepage]({{ link-datasphere-main }}).
1. On the **Budgets** tab, click ![image](../../_assets/plus-sign.svg) **Create**.
1. In the **Creating a budget** window:
   * Enter the budget name. Naming requirements:

      {% include [name-format](../name-format.md) %}

   * Enter a description for the budget (optional).
   * Select the cloud and folder that you have access to.

      Learn more about the [resource hierarchy in {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md).
1. Click **Create**.
1. Link the created budget to your project:
   * On the **Recent projects** tab, select the project.
   * Under **Billing**, click **Bind budget**.
   * In the **Link budget** window, select the created budget.
   * Click **Save**.