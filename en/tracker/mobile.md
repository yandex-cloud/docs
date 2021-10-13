# {{ tracker-name }} mobile app

You can use the {{ tracker-full-name }} mobile app to manage your issues when you don't have access to a computer. Create issues, change their parameters, and leave comments.

## Installing the app {#install}
The {{ tracker-name }} mobile app is available:

- In [Google Play]({{ mobile-google-link }}) for mobile devices powered by Android 8.0 or newer versions.

- In the [App Store]({{ mobile-apple-link }}) for mobile devices powered by iOS 11.0 or newer versions.

## App features {#features}

With the {{ tracker-name }} mobile app, you can:
 - Create issues.

- Search issues using predefined filters.

- View and edit issue parameters.

- Leave comments.

- View links and create sub-issues.

## Logging in to the app {#login}

{% if audience == "external" %}

[Log in](user/login.md) using your account when you first launch the app:

- To log in using a Yandex email address or your organization's domain, tap **Log in** and enter your username in the format `{{ example-account }}` or `login@example.com`.

  {% note info %}   

  If you don't have an organization yet, it will be created automatically the first time you log in to the app.

  {% endnote %}

- If your company uses a Single Sign-On authentication scheme with [identity federation](enable-tracker.md#federation), click **Log in via SSO**, specify the federation ID, and log in to your corporate account.

{% else %}

When you launch the app for the first time, tap **Log in** and enter your username in the format `login@yandex-team.ru`.

{% endif %}

## Restrictions {#restrictions}

Some {{ tracker-name }} features are not available in the mobile app. To use them, go to the [web version of the service]({{ link-tracker }}).

- [Adding links](user/ticket-links.md) between issues.

- Creating [custom issue filters](user/create-filter.md).

- Creating [projects](manager/projects.md), [components](manager/components.md) and [versions](manager/versions.md).

- Using [agile boards](manager/agile.md) and [dashboards](user/dashboard.md).

- [Creating and configuring queues](manager/create-queue.md).

  This includes setting up [triggers](user/trigger.md), [auto actions](user/autoactions.md) and [macros](manager/create-macroses.md).

{% if audience == "external" %}- [Setting up user access](enable-tracker.md#access) to {{ tracker-name }}.{% endif %}