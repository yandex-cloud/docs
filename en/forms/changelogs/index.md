# {{ forms-full-name }} revision history for June 2023

- [Form interface updates](#interface-update)
- [Variables in integration settings](#switch-interface)

## Form interface updates {#interface-update}

- Updated the form design. The layout of all elements is now in the same style as [{{ tracker-name }}]({{ link-tracker }}).
- Added support for a dark theme. You can enable it in the browser settings.
- Added support for response auto-saves. If a user closes a form without submitting it, when they reopen the form, the data they entered persist.
- Updated the page for submitting responses to [tests](../tests.md). Now, both test results and a list of correct and incorrect responses are placed on the same page.
- Updated the **Date** question. Added the ability to enter responses using the keyboard.
- Optimized form performance. Now, forms with 100 or more prompts open faster.

### Enabling and disabling the new interface {#switch-interface}

To enable and disable the new interface, open **Settings** → **Advanced** and select **Show form to fill out in new UI**.

![](../../_assets/forms/changelogs2306-ya-team.png =690x598)

You can temporarily switch between the old and new UI. As soon as we add the new interface's compatibility with topics, forms will only open in the new interface.

### Limitations {#interface-limits}

New features are only available if you set a [standard topic for a form](../appearance.md).

## Variables in integration settings {#vars}

Added new [variables](../vars.md) that can be used for [integration with other services](../notifications.md):

* `Link to the form`: Link to the form editing page.
* `Link to the response`: Link to the page with the response to the form.