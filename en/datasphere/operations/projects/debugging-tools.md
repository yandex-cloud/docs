---
title: How to resolve issues in a {{ ml-platform-full-name }} project
---

# Troubleshooting

Errors occurring in {{ ml-platform-name }} projects may require you to reset the installed packages and computations or change your project settings. For most of these tasks, you will need the `{{ roles-datasphere-project-developer }}` [role](../../security/index.md#roles-list) or higher. To resize the project storage, you need the `{{ roles-datasphere-project-editor }}` role or higher.

If you are having project access issues, try these steps:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.common.more }}**.
1. Click **{{ ui-key.yc-ui-datasphere.project-page.debugging-tools-key-value }}** in the list that opens and select the required action:
   * **{{ ui-key.yc-ui-datasphere.common.factory-reset }}**: Resetting the interpreter state and deleting all installed libraries. This will not affect your notebook codes, cell outputs, and all project resources. This option can be helpful in case of invalid libraries or full storage.
   * **{{ ui-key.yc-ui-datasphere.project-page.debugging-tools.reset-jupyter-workspace.title }}**: Closing all open files and notebooks. Corrupted files and notebooks may prevent {{ jlab }}Lab from working properly.
   * **{{ ui-key.yc-ui-datasphere.project-page.debugging-tools.clear-all-output.title }}**: Clearing all cell outputs of open notebooks. Excessive cell output may negatively impact {{ jlab }}Lab performance and slow down your browser.
   * **{{ ui-key.yc-ui-datasphere.project-page.change-project-disk-size }}**: Resizing the project storage. The project will be stopped. This will fix the errors caused by full storage.
   * **{{ ui-key.yc-ui-datasphere.project-page.stop-ide-title }}**: Stopping all computations, closing open notebooks, and shutting down the VM. This can be helpful when the project gets stuck for unknown reasons, or if you need to stop running calculations.
