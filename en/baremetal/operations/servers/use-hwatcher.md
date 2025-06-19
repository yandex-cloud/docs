---
title: How to analyze the status of {{ baremetal-name }} server disks
description: Follow this guide to use the HW Watcher utility to generate a status report for the server, its disks, and peripherals.
---

# Analyzing the status of {{ baremetal-name }} server disks using HW Watcher

If you encounter disk read/write errors, disk or [RAID](https://en.wikipedia.org/wiki/RAID) array failures while using with the {{ baremetal-name }} [server](../../concepts/servers.md), you can run [server diagnostics](../../concepts/smart-disk-analysis.md) to identify the source of the problem and generate a [report]({{ link-console-support }}/tickets/create) for support.

{% note info %}

You can only use `HW Watcher` on [Linux](https://en.wikipedia.org/wiki/Linux) servers.

{% endnote %}

## Generate a report {#generate-report}

To generate a system status report using `HW Watcher`:

1. Connect to a Linux server over SSH by running the following command in the terminal:

    ```bash
    ssh root@<server_public_IP_address>
    ```
1. Download `HW Watcher`:

    ```bash
    wget https://{{ s3-storage-host }}/baremetal/support/hwcheck
    ```
1. Add the root user permissions to run the downloaded executable file:

    ```bash
    chmod u+x hwcheck
    ```
1. Run the downloaded utility:

    ```bash
    ./hwcheck
    ```

    As a result, the report files will be saved to an archive:

    ```text
    ...
    Save data to archive: hwcheck_my-sample-server-_2025-05-27_20-31-04.tgz
    ```
1. To view status reports for individual server disks, unpack the archive by specifying its name:

    ```bash
    tar -xvzf <file_name_with_report_archive>
    ```
1. In the `drive` directory, see the list of disk status report files:

    ```
    ls ./drive/ -l
    ```

    Result:

    ```text
    total 24
    -rw-r--r-- 1 root root 8957 May 27 20:31 sda-smartctl
    -rw-r--r-- 1 root root 8957 May 27 20:31 sdb-smartctl
    ```
1. Look up the contents of the report file for the disk of interest. The disk device ID is specified in the file name:

    ```bash
    cat ./drive/sda-smartctl
    ```

    Among other things, a table of the disk's [SMART](https://en.wikipedia.org/wiki/Self-Monitoring,_Analysis_and_Reporting_Technology) attribute values will be displayed:

    ```text
    ...
    SMART Attributes Data Structure revision number: 1
    Vendor Specific SMART Attributes with Thresholds:
    ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
      5 Reallocated_Sector_Ct   PO--CK   100   100   010    -    0
      9 Power_On_Hours          -O--CK   086   086   000    -    67715
     12 Power_Cycle_Count       -O--CK   099   099   000    -    108
    177 Wear_Leveling_Count     PO--C-   062   062   005    -    1182
    179 Used_Rsvd_Blk_Cnt_Tot   PO--C-   100   100   010    -    0
    180 Unused_Rsvd_Blk_Cnt_Tot PO--C-   100   100   010    -    17618
    181 Program_Fail_Cnt_Total  -O--CK   100   100   000    -    0
    182 Erase_Fail_Count_Total  -O--CK   100   100   000    -    0
    183 Runtime_Bad_Block       PO--C-   100   100   010    -    0
    184 End-to-End_Error        PO--CK   100   100   097    -    0
    187 Reported_Uncorrect      -O--CK   100   100   000    -    0
    190 Airflow_Temperature_Cel -O--CK   074   049   000    -    26
    195 Hardware_ECC_Recovered  -O-RC-   200   200   000    -    0
    199 UDMA_CRC_Error_Count    -OSRCK   100   100   000    -    0
    202 Unknown_SSD_Attribute   PO--CK   100   100   010    -    0
    235 Unknown_Attribute       -O--C-   099   099   000    -    68
    241 Total_LBAs_Written      -O--CK   099   099   000    -    2179265164499
                                ||||||_ K auto-keep
                                |||||__ C event count
                                ||||___ R error rate
                                |||____ S speed/performance
                                ||_____ O updated online
                                |______ P prefailure warning
    ...
    ``` 

    You can either [analyze](../../concepts/smart-disk-analysis.md) the results yourself or [contact](#report-issue) support for assistance.

## Send a report to support {#report-issue}

To send the resulting report to support:

1. Copy the report from the server to your local computer by running this command in the local computer terminal:

    ```bash
    scp root@<server_public_IP_address>:/root/<file_name_with_report_archive> ./
    ```

    This will save the report file to the current directory on your local computer.
1. [Create]({{ link-console-support }}/tickets/create) a request to support.

    In your request, describe the issue with the server in detail and attach the saved archive with the report.

#### See also {#see-also}

* [{#T}](../../concepts/smart-disk-analysis.md)
* [{#T}](./switch-raid-member.md)