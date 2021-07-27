---
title: "Viewing monitoring graphs in Yandex Cloud Functions"
description: "You can see the monitoring graph in Yandex Cloud Functions for the following indicators, such as the number of function calls, the average execution time of the function, the number of errors that occurred while executing the function. To see the graph, open the Cloud Functions section in the catalog with the function, information about which you want to receive. In the list of functions, select the function whose monitoring graphs you want to see."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# View monitoring charts

You can view charts for the following metrics:

- [Number of function invocations](#invocations)
- [Average function execution time](#durations)
- [Number of errors that occurred when running the function](#errors)

## Number of function invocations {#invocations}

To view the chart:

1. Open the **{{ sf-name }}** section in the folder containing the function you want to get information about.

1. Select the function whose monitoring charts you want to view from the list of functions.

1. On the **Overview** page, go to the **Monitoring** tab.

1. Select the period for the chart. You can choose a predefined interval (hour, day, week, month) or enter a custom period in the date fields.

1. The number of function calls is displayed on the **Invocations** chart:

    ![image](../../../_assets/functions/invocations.png)

## Average function execution time {#durations}

To view the chart:

1. Open the **{{ sf-name }}** section in the folder containing the function you want to get information about.

1. Select the function whose monitoring charts you want to view from the list of functions.

1. On the **Overview** page, go to the **Monitoring** tab.

1. Select the period for the chart. You can choose a predefined interval (hour, day, week, month) or enter a custom period in the date fields.

1. The average call time is displayed in the **Durations** chart:

    ![image](../../../_assets/functions/durations.png)

## Number of errors that occurred when executing a function {#errors}

To view the chart:

1. Open the **{{ sf-name }}** section in the folder containing the function you want to get information about.

1. Select the function whose monitoring charts you want to view from the list of functions.

1. On the **Overview** page, go to the **Monitoring** tab.

1. Select the period for the chart. You can choose a predefined interval (hour, day, week, month) or enter a custom period in the date fields.

1. The number of errors that occurred when running the function is shown in the **Errors** chart:

    ![image](../../../_assets/functions/errors.png)

