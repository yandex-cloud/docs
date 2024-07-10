# Embedding public objects

You can embed [published](../concepts/datalens-public.md) dashboards and charts into a website or app using an `iframe`.


You can configure the features and appearance of the objects being embedded through these parameters:

* `_autoupdate`: Sets the [auto-update](../dashboard/settings.md#auto-update) time for dashboards and charts in seconds. By default, these are not updated automatically. The feature only works for the active browser tab. Objects due for auto-update on inactive tabs will be auto-updated when the tab becomes active again. The minimum values are:

   * 30 seconds for dashboards
   * 15 seconds for charts

* `_embedded`: Hides the navigation panel. To activate the parameter, set to `1`.
* `_no_controls`: Hides the ![image](../../_assets/console-icons/ellipsis.svg) menu for charts. To activate the parameter, set to `1`.
* `_theme`: Specifies the object's appearance. The possible values are:

   * `light`: Light theme.
   * `dark`: Dark theme.

* `_no_scroll`: Disables vertical scrolling on dashboards. To activate the parameter, set to `1`.
* `_lang`: For charts, defines the language for the menu that opens when you click ![image](../../_assets/console-icons/ellipsis.svg). The possible values are `ru` or `en`. 
* `_opened_info`: Displays dashboard [description](../dashboard/settings.md#message-settings) as you open a dashboard, if provided. To activate the parameter, set to `1`.

Provide the parameters in `<parameter_name>=<value>` format. For example, to set the auto-update time to 50 seconds, specify: `_autoupdate=50`.

The parameter is added to the object address after the question mark (`?`). To send multiple parameters, list them separated by `&`, e.g.:


```html
<iframe frameborder="0" src="https://datalens.yandex/bdzix********?_embedded=1&_no_controls=1&_lang=ru&_theme=dark&_autoupdate=50"></iframe>
```

Here are examples of public embedded charts and dashboards:

* KinoPoisk: Public statistics on [movie ratings](https://www.kinopoisk.ru/votes/) and [filmography ratings](https://www.kinopoisk.ru/name/37859/) of actors.
* [Yandex Direct Audience](https://yandex.com/adv/products/platforms): Yandex research result.
* [Catalog of schools with assigned houses](https://gradstat.ru/): Urban data service for parents.

## Getting the embed code {#get-code}

To get the embed code with a preset dashboard or chart design:

1. [Publish](#how-to-publish) your dashboard or chart.
1. Open the dashboard or chart using the public link provided to you.
1. Click ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) in the top-right corner and select ![image](../../_assets/console-icons/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design parameters.

## Filtering embedded charts {#filtering-embedded-charts}

You can apply filtering to embedded charts. To do this, provide the filtering parameters in the chart link.

To set up filtering:

1. Add a chart and selector to the dashboard.
1. [Publish](#how-to-publish) the dashboard.
1. Set the required selector values.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the chart on the dashboard and select ![image](../../_assets/console-icons/code.svg) **Embed code**.
1. In the window that opens, set up the menu language, theme, and appearance. On the right of the window, copy the link or embed code with the preset design and filter parameters.

The filter parameters will be added to the chart URL after `?`. When providing multiple parameters, they will be separated by `&` (ampersand).

```
<iframe frameborder="0" src="https://datalens.yandex/z2uxl5pbztkep?shopid_vj2j=sp-15&shopid_vj2j=sp-18&shopid_vj2j=sp-20&_embedded=1&_no_controls=1&_theme=light&_lang=ru" width="100%" height="400px"></iframe>
```

#### See also: {#see-also}

* [{#T}](../security/private-embedded-objects.md)


