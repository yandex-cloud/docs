---
title: How to resolve issues in a project in {{ ml-platform-full-name }}
---

# Troubleshooting

Errors occurring in {{ ml-platform-name }} projects may require you to reset the installed packages and computations or to change project settings. For most of these tasks, you will need a [role](../../security/index.md#roles-list) no lower than `{{ roles-datasphere-project-developer }}`. To resize the project storage, you need a role no lower than `{{ roles-datasphere-project-editor }}`.

The following actions might help if you are unable to enter a project:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.common.more }}**.
1. Click **{{ ui-key.yc-ui-datasphere.project-page.debugging-tools-key-value }}** in the list that opens and select the required task:
   * **{{ ui-key.yc-ui-datasphere.common.factory-reset }}**: Resetting the interpreter state and deleting all installed libraries. Notebook codes, cell outputs, and all project resources will be saved. Helps when incorrect libraries are installed or the storage is full.
   * **{{ ui-key.yc-ui-datasphere.project-page.debugging-tools.reset-jupyter-workspace.title }}**: Closing all open files and notebooks. Incorrect files and notebooks may prevent {{ jlab }}Lab from working properly.
   * **{{ ui-key.yc-ui-datasphere.project-page.debugging-tools.clear-all-output.title }}**: Clearing all cell outputs of open notebooks. Excessive cell output may prevent {{ jlab }}Lab from working properly and slow down the browser.
   * **{{ ui-key.yc-ui-datasphere.project-page.change-project-disk-size }}**: Resizing the project storage. The project will be stopped. This will fix the errors caused by full storage.
   * **{{ ui-key.yc-ui-datasphere.project-page.stop-ide-title }}**: Stopping all computations, closing open notebooks and shutting down the VM. Helps when the project gets stuck for unknown reasons, or if you need to stop running calculations.
