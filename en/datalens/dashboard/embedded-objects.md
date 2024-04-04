# Embedding objects

You can embed [published](../concepts/datalens-public.md) dashboards and charts into a website or app using an `iframe`.


The functionality and appearance of embedded objects can be defined by the transmittable parameters:

* `_autoupdate`: Sets [auto-update](./settings.md#auto-update) time for dashboards and charts in seconds. By default these are not updated automatically. Works only in the active browser tab. If the auto-update time has been reached for an inactive tab, it will take place when the tab becomes active again. Minimum value:

   * 30 seconds for dashboards.
   * 15 seconds for charts.

* `_embedded`: Hides the navigation panel. To enable the parameter, set to `1`.
* `_no_controls`: Hides the ![image](../../_assets/console-icons/ellipsis.svg) menu for charts. To enable the parameter, set to `1`.
* `_theme`: Specifies the object's appearance. The possible values include:

   * `light`: Use the light theme.
   * `dark`: Use the dark theme.

* `_no_scroll`: Disables vertical scrolling on dashboard. To enable the parameter, set to `1`.
* `_lang`: For charts, defines the language value for the menu that opens when you click ![image](../../_assets/console-icons/ellipsis.svg). Possible values: `ru` or `en`.

The parameter is added to the object address after the question mark `?`. To send multiple parameters, list them separated by `&`, e.g.:


```
<iframe frameborder="0" src="https://datalens.yandex/bdzix********?_embedded=1&_no_controls=1&_lang=ru&_theme=dark"></iframe>
```

