# Fixing project startup errors in {{ ml-platform-name }}


## Issue description {#issue-description}

You cannot start up a project in {{ ml-platform-full-name }}.

The possible errors include:

* When opening a project page, you get this message: `Web page at yds.yandexcloud.net/tambour/folder-id/project-id is temporarily not available`.
* The project loading icon appears on the screen for a long while.
* You get `Error 503`.
* You see the `Deadline Exceeded` message.
* When opening a cluster, you see a blank page.
 
You may have this issue with all your {{ ml-platform-short-name }} projects.

{% note info %}

It can take up to ten minutes to load large-scale {{ ml-platform-short-name }} projects containing multiple files. If your project includes many files and third-party modules, wait for them to load. 

To track your browser network activity when your project is loading, use the **Network** tab in your browser's developer tools. To display the developer tools panel on any page in your browser, press `F12`.

{% endnote %}

## Solution {#issue-resolution}

When opening a project in an IDE, {{ ml-platform-short-name }} redirects your request to its own host with {{ jlab }}Lab. Modern browsers may block such website behavior if you use more advanced privacy tools, including incognito mode. 

To open a project in an IDE, disable the blocking settings:

* **Chrome**: Allow using third-party cookies.
* **Safari**: Disable **Website tracking** by selecting **Prevent cross-site tracking** under **Preferences** ⟶ **Privacy**.
* **Yandex Browser**: Allow using third-party cookies for {{ ml-platform-short-name }} in the browser settings under **Sites** ⟶ **Advanced site settings**.

You may also want to check the [current consumption level]({{ link-console-quotas }}) for your cloud. If you exceeded your {{ ml-platform-short-name }} quotas, you may have issues when starting up projects.
