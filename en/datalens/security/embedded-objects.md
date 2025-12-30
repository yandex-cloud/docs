# Embedding private objects

You can embed [published](../concepts/datalens-public.md) dashboards and charts into a website or app using `iframe`.


You can configure the features and appearance of the objects being embedded through these parameters:

* `_autoupdate`: Sets the [auto-update](../dashboard/settings.md#auto-update) time for dashboards and charts in seconds. By default, these are not updated automatically. The feature only works for the active browser tab. Objects due for auto-update on inactive tabs will be auto-updated when the tab becomes active again. The minimum values are:

  * 30 seconds for dashboards
  * 15 seconds for charts

* `_embedded`: Hides the navigation panel. To activate the parameter, set it to `1`.
* `_no_controls`: For charts, hides ![image](../../_assets/console-icons/ellipsis.svg). To activate the parameter, set it to `1`.
* `_theme`: Specifies the object's appearance. The possible values are:

  * `light`: Light theme.
  * `dark`: Dark theme.

* `_no_scroll`: Disables vertical scrolling on dashboards. To activate the parameter, set it to `1`.
* `_lang`: For charts, sets the language of the menu that opens when you click ![image](../../_assets/console-icons/ellipsis.svg). Possible values: `ru` and `en`. 
* `_opened_info`: Displays dashboard [description](../dashboard/settings.md#message-settings) (if provided) when you open the dashboard. To activate the parameter, set it to `1`.

Provide the parameters formatted as `<parameter_name>=<value>`. For example, to set the auto-update time to 50 seconds, specify `_autoupdate=50`.

The parameter is added to the object address after the question mark (`?`). To send multiple parameters, list them separated by `&` (ampersand), e.g.:


```html
<iframe frameborder="0" src="https://datalens.yandex/bdzix********?_embedded=1&_no_controls=1&_lang=ru&_theme=dark&_autoupdate=50"></iframe>
```


## Getting the embed code {#get-code}

To get the embed code with a preset dashboard or chart design:

1. [Publish](../concepts/datalens-public.md#how-to-publish) your dashboard or chart.
1. Open the dashboard or chart using the public link provided to you.
1. In the upper-right corner, click ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) and select ![image](../../_assets/console-icons/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design parameters.

## Filtering embedded charts {#filtering-embedded-charts}

You can apply filtering to embedded charts. To do this, provide the filtering parameters in the chart link.

To set up filtering:

1. Add a chart and selector to the dashboard.
1. [Publish](../concepts/datalens-public.md#how-to-publish) the dashboard.
1. Open the dashboard or chart using the public link provided to you.
1. Set the required selector values.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the chart on the dashboard and select ![image](../../_assets/console-icons/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design and filter parameters.

The filter parameters will be added to the chart URL after `?`. When providing multiple parameters, they will be separated by `&` (ampersand).

```html
<iframe frameborder="0" src="https://datalens.yandex/z2uxl5pbztkep?shopid_vj2j=sp-15&shopid_vj2j=sp-18&shopid_vj2j=sp-20&_embedded=1&_no_controls=1&_theme=light&_lang=ru" width="100%" height="400px"></iframe>
```

#### See also: {#see-also}

* [{#T}](../security/private-embedded-objects.md)


