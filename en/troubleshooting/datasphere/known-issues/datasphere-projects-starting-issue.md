# Fixing project startup errors in DataSphere

## Issue description {#issue-description}
You couldn't start up a project in Yandex DataSphere.

Possible errors:
- When opening a project page, you see the message: `Web page at yds.yandexcloud.net/tambour/folder-id/project-id it's temporarily unavailable`.
- You are seeing the project loading indicator for a long time.
- You see `Error 503`.
- You see the `Deadline Exceeded` message.
- When opening a cluster, you see a blank page.

You have this issue in all your DataSphere projects.

{% note info %}

It can take up to ten minutes to load large-scale DataSphere projects including multiple files. If your project includes many files and third-party modules, give time for them to load.

To track your browser network activity when your project is loading, use the **Network** tab in your browser's [developer tools](../../../support/create-har.md).

{% endnote %}

## Solution

When opening a project in the IDE, DataSphere redirects your request to an internal host running `JupyterLab`. Modern browsers may block such website behavior if you use more advanced privacy tools, including incognito mode.

To open a project in the IDE, turn off the blocking settings:
- `Chrome`: Allow using third-party cookies.
- `Safari`: Disable `Website tracking`: Use `Prevent cross-site tracking` under `Preferences` ⟶ `Privacy`.
- `Yandex Browser`: Allow third-party cookies for DataSphere in the browser settings under `Sites` ⟶ `Advanced site settings`.

Check also the [current consumption level](https://console.cloud.yandex.com/cloud?section=quotas) in your cloud. If you exceed your DataSphere quotas, you might have issues at project startup.