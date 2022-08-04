# Plugin for the **IntelliJ** IDE

If you're using an IDE from JetBrains, you can use a [plugin](https://plugins.jetbrains.com/plugin/10549-yandex-tracker-integration) to integrate it with {{ tracker-name }}. The plugin allows you to work with issues directly from the IDE. For more information about the plugin features, see the Help for your IDE: [IntelliJ IDEA](https://www.jetbrains.com/help/idea/managing-tasks-and-context.html), [PhpStorm](https://www.jetbrains.com/help/phpstorm/2017.2/managing-tasks-and-contexts.html), [WebStorm](https://www.jetbrains.com/help/webstorm/managing-tasks-and-context.html), [PyCharm](https://www.jetbrains.com/help/pycharm/managing-tasks-and-context.html), [RubyMine](https://www.jetbrains.com/help/ruby/managing-tasks-and-context.html), [AppCode](https://www.jetbrains.com/help/objc/managing-tasks-and-context.html), [CLion](https://www.jetbrains.com/help/clion/managing-tasks-and-context.html), [GoLand](https://www.jetbrains.com/help/clion/2017.2/managing-tasks-and-contexts.html), [DataGrip](https://www.jetbrains.com/help/idea/managing-tasks-and-context.html), [Rider](https://www.jetbrains.com/help/rider/managing_tasks_and_context.html), [MPS](https://www.jetbrains.com/help/idea/managing-tasks-and-context.html), and [Android Studio](https://www.jetbrains.com/help/idea/managing-tasks-and-context.html).

{% note warning %}

The plugin only allows you to work with issues that you are assigned to.

{% endnote %}

## Installing the plugin {#section_jm1_r4d_kdb}

{% if audience == "external" %}

#### From the repository

1. Open the settings window in IntelliJ: **File** → **Settings**.

1. On the **Plugins** tab, click **Browse Repositories**.

1. In the search bar, enter `Yandex Tracker integration`.

1. Click **Install** on the right of the window.

1. Restart your IDE.

#### From a file

1. Download the plugin from the official [plugin directory](https://plugins.jetbrains.com/plugin/10549-yandex-tracker-integration).

1. Open the settings window in IntelliJ: **File** → **Settings**.

1. On the **Plugins** tab, click **Install plugin from disk**.

1. Specify the location of the archive with the plugin and click **OK**.

1. Restart your IDE.

{% else %}

1. Open the settings window in IntelliJ: **File** → **Settings**.

1. On the **Plugins** tab, click **Browse Repositories**.

1. Click **Manage repositories** and add the address.

    ```
    https://github.yandex-team.ru/pages/devtools/startrek-idea-plugin/updatePlugins.xml
    ```

1. In the search bar, enter `Yandex Tracker integration`.

1. Click **Install** on the right of the window.

1. Restart your IDE.

{% endif %}

## Connecting the plugin to {{ tracker-name }} {#section_vgn_cqd_kdb}

{% if audience == "external" %}

To make the plugin work, link it to your {{ tracker-name }} account:

{% else %}

To make the plugin work, link it to your yandex-team account:

{% endif %}

{% if audience == "external" %}

1. Log in to {{ tracker-name }}.

{% endif %}

1. Launch your IntelliJ IDE and select **Tools** → **Tasks & Contexts** → **Configure Servers**.

1. Click **+** and select **Yandex Tracker**.

1. Click **Authorize** and wait for the browser window to appear.

1. {% if audience == "external" %} Allow the <q>Yandex.Tracker IntelliJ Plugin</q> to access your data on Yandex.{% else %}Allow the <q>Yandex Tracker IntelliJ Plugin</q> to access your yandex-team data.{% endif %}

1. Copy the authentication code.

1. Paste the confirmation code into the **Authentication Code** window in the IDE.

1. Click **OK**.

1. Select the queue that you want to work in.

1. Click **OK**.

