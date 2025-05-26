# Checking regression metrics for exceeded thresholds using the CLI

For each metric (line) on the [regression dashboard](./regressions.md) charts, you can add a threshold value to flag abnormality when exceeded. In addition to graphical display of areas with exceeded thresholds, you can get regression info using a [CLI command](../../cli/cli-ref/loadtesting/cli-ref/test/check-regression.md). 

This page describes the main use cases for the `yc loadtesting test check-regression` command to check if thresholds are exceeded in regression charts.

## Getting test IDs {#get-test-ids}

Get a list of test IDs with the `yc loadtesting test list` command:

Here is a response example:

```
+----------------------+---------+--------+---------------------+----------+
|          ID          |  NAME   | LABELS |       CREATED       | FINISHED |
+----------------------+---------+--------+---------------------+----------+
| ff6mmyz7s4t2m4****** | test780 |        | 2024-09-29 09:26:56 |          |
+----------------------+---------+--------+---------------------+----------+
```

Use the IDs you get to run the check command.

## Checking all charts of a selected test {#check-test}

If you run the command without additional parameters, it will check for regressions on all the charts in your folder that include the specified test.

Run this command:

```
yc loadtesting test check-regression <test_ID>
```

Here is an example of running the command:

```
yc loadtesting test check-regression ff6mmyz7s4t2m4******

                     Test:   autotest-pandora-line-uripost (id=ff6mmyz7s4t2m4******)

------------------------------------------------------------------------------------
   Charts checked (count):                                                         3
               Thresholds:                                           2 OK / 1 FAILED


   status   value     threshold        fn                           metric      case                                                    chart        dashboard

--------------------------------------------------------------------------------------------------------------------------------------------------------------
       OK       0    value <= 5   percent   Responses: protocol code (5xx)   overall                       all tests: less than 5% 5xx codes    test-dashboard
       OK     100   value >= 90   percent   Responses: protocol code (200)   overall                      all tests: more than 90% 200 codes    test-dashboard
   FAILED      27   value <= 20       q99                          Latency   overall              Response time: autotest-pandora-line-uripost         autotest
        -      18             -       q98                          Latency   overall              Response time: autotest-pandora-line-uripost         autotest
        -     4.3             -       q75                          Latency   overall              Response time: autotest-pandora-line-uripost         autotest
        -    3.39             -       q50                          Latency   overall              Response time: autotest-pandora-line-uripost         autotest
```

## Checking charts on a given dashboard {#check-graphs-from-dashboard}

If you run the command with the `--dashboard-id` parameter, it will only check the charts from the dashboard you specify.

You can find the dashboard ID on the page listing dashboards (the ID column is hidden by default) or in the dashboard page URL.

Run this command:

```
yc loadtesting test check-regression <test_ID> --dashboard-id <dashboard_ID>
```

Here is an example of running the command:

```
yc loadtesting test check-regression ff6mmyz7s4t2m4****** --dashboard-id ff6jqg3mf5xhby******

                     Test:   autotest-pandora-line-uripost (id=ff6mmyz7s4t2m4******)

------------------------------------------------------------------------------------
   Charts checked (count):                                                         2
               Thresholds:                                           2 OK / 0 FAILED


   status   value     threshold        fn                           metric      case                                 chart        dashboard

-------------------------------------------------------------------------------------------------------------------------------------------
       OK       0    value <= 5   percent   Responses: protocol code (5xx)   overall    all tests: less than 5% 5xx codes    test-dashboard
       OK     100   value >= 90   percent   Responses: protocol code (200)   overall   all tests: more than 90% 200 codes    test-dashboard
```

## Checking an individual chart {#check-graph}

If you run the command with the `--dashboard-id` and `--chart-id` parameters, it will only check thresholds for the specified chart.

```
yc loadtesting test check-regression <test_ID> --dashboard-id <dashboard_ID> --chart-id <chart_ID>
```

You can find the dashboard ID on the page listing dashboards (the ID column is hidden by default) or in the dashboard page URL.

To get the chart ID, click ![image](../../_assets/console-icons/chevrons-expand-up-right.svg) next to any of the charts on the dashboard. This will open a separate chart page. You can find the ID at the top of the page and in its URL.

Here is an example of running the command:

```
yc loadtesting test check-regression ff6mmyz7s4t2m4****** --dashboard-id ff6jqg3mf5xhby****** --chart-id 57651054-35af-47ea-a5a8-6a1a8dbe4377

                     Test:   autotest-pandora-line-uripost (id=ff6mmyz7s4t2m4******)

------------------------------------------------------------------------------------
   Charts checked (count):                                                         1
               Thresholds:                                           1 OK / 0 FAILED


   status   value    threshold        fn                           metric      case                                chart        dashboard

-----------------------------------------------------------------------------------------------------------------------------------------
       OK       0   value <= 5   percent   Responses: protocol code (5xx)   overall   all tests: less than 5% 5xx codes    test-dashboard
```