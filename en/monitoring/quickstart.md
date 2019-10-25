# Getting started with {{ monitoring-full-name }}

This guide explains how to create a dashboard and add widgets that displace the status of Yandex.Cloud resources.

{% note info %}

{{ monitoring-full-name }} automatically creates service dashboards with a set of widgets that display the status of your cloud resources.
If you don't have any resources, create them (for example, a VM and a database) to start using the service.

{% endnote %}

## Before you start {#before-beginning}

Get access to {{ monitoring-full-name }} on the [service homepage](https://cloud.yandex.com/services/monitoring).

Once you have access, go to the [service interface](https://monitoring.cloud.yandex.com).

## Create a new dashboard {#create-dashboard}

1. On the service homepage, click **Create dashboard**.
1. Click **Add** in the upper-right corner of the menu and select **Heading**.
1. Enter **Cross-service dashboard** in the text field and select the **Large** size.
1. Click **Add**.
1. Drag the created widget to the appropriate place on the dashboard.

## Add a widget of {{ compute-full-name }} {#add-compute-widget}

1. Click **Add** in the upper-right corner of the menu and select **Saved chart**.
1. Fill in the widget parameters. Pay close attention to the following fields:
    - **Heading**. Sets the name of the widget. It is displayed on top of the widget.
    - **Widget**. Select a widget of the {{ compute-full-name }} service. To do this, go to **All files/service/compute**
and specify the widget.
    - **Description**. Sets the description of the widget. It is displayed at the bottom of the widget.
1. Click **Add**. The widget is displayed on the dashboard.
1. Drag the created widget to the appropriate place on the dashboard.

## Add a widget of {{ managed-clickhouse-full-name }} {#add-clickhouse-widget}

1. Click **Add** in the upper-right corner of the menu and select **Saved chart**.
1. Fill in the widget parameters. Pay close attention to the following fields:
    - **Heading**. Sets the name of the widget. It is displayed on top of the widget.
    - **Widget**. Select a widget of the {{ managed-clickhouse-full-name }} service. To do this, go to **All files/service/managed-clickhouse**
and specify the widget.
    - **Description**. Sets the description of the widget. It is displayed at the bottom of the widget.
1. Click **Add**. The widget is displayed on the dashboard.
1. Drag the created widget to the appropriate place on the dashboard.

## Save the created dashboard {#save-dashboard}

1. Click **Finish** in the top-right corner of the menu.
1. Enter a name for the dashboard and select the directory to save it to.
1. Click **Save**. The dashboard is saved in the specified directory.

You now have a dashboard with widgets that display the state of different Yandex.Cloud service resources.

