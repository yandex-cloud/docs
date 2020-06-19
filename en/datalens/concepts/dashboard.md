# Dashboards

_Dashboards_ are pages or sets of pages that contain widgets. They let you group charts in one place and add explanatory text and titles.
You can create new dashboard pages using the **tab** element.

{{ datalens-short-name }} allows you to display the dashboard in full-screen mode. This mode hides part of the interface elements and expands the widget area on the screen.

On the mobile version of the dashboard, {{ datalens-short-name }} displays the charts one after another using the following sorting rule: left-to-right, top-to-bottom.

## Widgets {#widget}

_Widgets_ are dashboard elements. You can create links between selector and chart widgets.

{{ datalens-full-name }} offers the following types of widgets:

- [Chart](#chart)
- [Selector](#selector)
- [Text](#text)
- [Title](#title)

### Charts {#chart}

Visualization as a table or chart.
You can place charts anywhere on a dashboard and change their size.
Charts can be linked to selectors.

For more information about charts, see [{#T}](chart.md).

### Selector {#selector}

A widget for managing one or more charts. Works within a single dashboard tab.

For more information, see [{#T}](#link).

### Text {#text}

A widget represented as text. It lets you place things like a set of links or explanatory captions on a dashboard. The [Markdown markup language](https://ru.wikipedia.org/wiki/Markdown) is supported.

### Title {#title}

A widget represented as a heading. It lets you differentiate charts by meaning and divide them into groups within a single dashboard page.

## Link {#link}

Links determine how a selector affects one or more charts. By default, selectors affect charts created within a single dataset. Selectors and charts based on different datasets can also be linked manually.

You can choose a dataset field as the link or create your own field where you manually set the selector values.

## Publishing dashboards {#public-access}

You can grant any internet user access to a dashboard using [{{ datalens-public }}](datalens-public.md). This dashboard becomes public and any user can view it without authorization.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Access management {#access-management}

You can configure dashboard permissions. For more information, see [{#T}](../security/index.md).

