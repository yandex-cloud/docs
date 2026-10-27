---
title: How to set up a reference tab for AI on a dashboard in {{ datalens-full-name }}
description: In this article, you will learn about the AI ​​reference tab on your dashboard in {{ datalens-full-name }} and how to configure it.
---

# Reference tab for AI on a dashboard in {{ datalens-full-name }}

In the dashboard tab settings, you can select a reference tab for [Neuroanalyst](../../dashboard/insights.md). It will use it as a template when building charts. While you can select any dashboard tab, Neuroanalyst's performance will effectively depend on your selection.

When selecting a reference tab, please follow these recommendations:

* On the tab, place [wizard charts](../../concepts/chart/dataset-based-charts.md) that describe your dataset in various aspects and answer different questions.
* In the descriptions of your dashboard charts or widgets, provide examples of questions they help answer.
* Instead of tab selectors, use filters in charts to make your charts answer more specific questions.
* Employ charts based on a single dataset.
* Use relevant field descriptions in the dataset.

If there is a single tab on the dashboard, it automatically becomes a reference one, and the setting for selecting this tab is not shown.

To specify a reference tab for Neuroanalyst:

1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
1. In the top-right corner, click **Edit**.
1. Click ![image](../../../_assets/console-icons/gear.svg) at the top of the screen. The settings window will open on the right.
1. In the Neuroanalyst settings section, find the **Reference tab** parameter and select the tab. Neuroanalyst will treat the charts on this tab as the reference method for data visualization. You can [hide](./dashboard-hide-tabs.md) the reference tab in the dashboard settings. The **Reference tab** parameter is shown for dashboards with more than one tab. If there is a single tab, it is the reference tab by default.
1. In the top-right corner, click **Save**.

