---
title: Dashboards in Yandex DataLens
description: 'Dashboard in Yandex DataLens — a page or a set of pages on which widgets are located. Allows you to collect charts in one place, add explanatory captions and titles to them. New dashboard pages can be created using the tab element. DataLens allows you to display your dashboard in full screen mode.'
---

# Dashboards in Yandex DataLens

_Dashboards_ are pages or sets of pages that contain widgets. They let you group charts in one place and add explanatory text and titles.
You can create new dashboard pages using the **tab** element.

## Display modes {#display-modes}

{{ datalens-short-name }} lets you display the dashboard in full-screen mode. This mode hides part of the interface elements and expands the widget area on the screen.

On the mobile version of the dashboard, {{ datalens-short-name }} displays the charts one after another using the following sorting rule: left-to-right, top-to-bottom.

## Widgets {#widget}

_Widgets_ are dashboard elements. You can create links between selector and chart widgets.

{{ datalens-full-name }} offers the following types of widgets:

- [Chart](#chart)
- [Selector](#selector)
- [Text](#text)
- [Title](#title)

### Chart {#chart}

Visualization as a table or chart.
You can place charts anywhere on a dashboard and change their size.
Charts can be linked to selectors.

For more information about charts, see [{#T}](chart.md).

### Selector {#selector}

A filter that affects query results on its linked widgets. To add a selector to a dashboard, go to [{#T}](../operations/dashboard/add-selector.md).
The selector can be linked to a chart or another selector. For more information, see [Link](#link).
A selector works within a single dashboard tab.

### Text {#text}

A widget represented as text. It lets you place things like a set of links or explanatory captions on a dashboard. The [Markdown markup language](https://en.wikipedia.org/wiki/Markdown) is supported.
For more information about Markdown markup, see [{#T}](markdown.md).

### Title {#title}

A widget represented as a heading. It lets you differentiate charts by meaning and divide them into groups within a single dashboard page.

## Link {#link}

Links determine how a selector affects one or more charts or other selectors. By default, selectors are linked with charts created within a single dataset. Selectors and charts based on different datasets can also be linked manually.

You can choose an existing dataset field as the link or create your own field where you manually set the selector values.

You can use links to filter the values of selectors and charts. For example, if you select a country in the first selector on the dashboard, the second selector limits the list of cities (and vice versa).

The link type determines how values in selectors and charts are filtered. The type is set in the links window in dashboard edit mode.
You can use the following types of links for a pair of widgets:

* **Link**, for widgets that mutually affect each other.
* **Incoming link**, when a widget is affected by a widget.
* **Outgoing link**, when a widget affects another widget.
* **Ignore**, for widgets that mutually ignore each other.
* **No link**, for widgets from different datasets or widgets that can't be linked.

{% note warning %}

You can't create a link with [{#T}](#text) and [{#T}](#title) widgets.

{% endnote %}

Some widgets can't affect other widgets. Possible types of links between widgets are shown in the table:

| Affects/Affected | Selector | Charts |
| ----- | ----- | ----- |
| **Selector** | Link<br/>Incoming link<br/>Outgoing link<br/>Ignore | Outgoing link<br/>Ignore |
| **Chart** | Incoming link<br/>Ignore | — |

{% if audience != "internal" %}

## Publishing dashboards {#public-access}

You can grant any internet user access to a dashboard using [{{ datalens-public }}](datalens-public.md). This dashboard becomes public and any user can view it without authorization.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

{% endif %}

{% if audience == "internal" %}

## Using parameters and limitations {#parameters}

In the dashboard settings section, you can set the parameters to use. For each parameter, specify a key and value. Currently, there are some reserved keys that can't be used (see discussion in this [ticket](https://st.yandex-team.ru/CHARTS-3122)):

* `tab`
* `state`
* `mode`
* `focus`
* `grid`
* `scale`
* `tz`
* `timezone`
* `date`
* `datetime`

Parameters with these keys are ignored and not saved. The saved dashboard parameters are inserted into all widgets (including charts and selectors) once they are uploaded.

You can also specify parameter values in dashboard links. These values will be prioritized. For example, if the dashboard settings have the `region` parameter set to `RU` and the dashboard link indicates `?region=KZ`, the `KZ` value is inserted into widgets.

Links can only use parameters that are set in the dashboard settings. Otherwise, they are ignored. For example, if a link contains `?product=Furniture`, while the dashboard settings have no `product` parameter (not even with a null value), this parameter is ignored.

The following limitations apply when using parameters:

- Dashboard parameters are applied to widgets anyway. This may lead to errors in data requests.

- Parameters can't be used when creating links. To create a link, you can add a manual selector with the appropriate parameter key, set links using this selector by the desired parameters, and then delete it. The ability to configure links between dashboard parameters and charts will be implemented in this [ticket](https://st.yandex-team.ru/CHARTS-3118).

- Parameter keys such as `region` or `product` are identifiers like `6c13d915-32f4-4a51-adef-1dc39bcac36d` and `36fed430-4bfd-11e9-95cb-53c8ddf502cd`. IDs like that should be specified as keys when setting parameters are used in wizards. You can only get IDs from requests on the Network tab in your browser's developer tools. The ability to copy the ID from a dataset will be then added in this [ticket](https://st.yandex-team.ru/CHARTS-3186). After implementing the [ticket](https://st.yandex-team.ru/YCDESIGN-871), you'll be able to get the ID by selecting a dataset and parameter.

- Charts used in wizards can also accept and apply parameters in the form of a heading: both as `region` and `6c13d915-32f4-4a51-adef-1dc39bcac36d`. This behavior is considered incorrect and is not currently handled on the dashboard side (in particular in links). It may change in the future (see the discussion in this [ticket](https://st.yandex-team.ru/CHARTS-2905)).

{% endif %}

## Access management {#access-management}

You can configure dashboard permissions. {% if audience != "internal" %} For more information, see [{#T}](../security/index.md). {% endif %}

