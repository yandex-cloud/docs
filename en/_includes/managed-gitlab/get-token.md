To create and configure {{ GLR }} for the entire [{{ GL }} instance](../../managed-gitlab/concepts/index.md#instance), proceed as follows ({{ GL }} admin permissions required):

1. Open {{ GL }}.
1. In the bottom-left corner, click **Admin**.
1. In the left-hand menu, select **CI/CD** → **Runners**.
1. Click **New instance runner** and create a new {{ GLR }}.
1. Save the value of the `Runner authentication token` parameter.

To create and set up {{ GLR }} for a [project]({{ gl.docs }}/ee/user/project/), proceed as follows:

1. Open {{ GL }}.
1. Select a project.
1. In the left-hand menu, select **Settings** → **CI/CD**.
1. Under **Runners**, click **Expand**.
1. Click **New project runner** and create a new {{ GLR }}.
1. Save the value of the `Runner authentication token` parameter.
