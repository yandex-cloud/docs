---
title: Analysis of {{ baremetal-full-name }} server disk status
description: If you encounter disk read/write errors, disk or RAID array failures while using a {{ baremetal-full-name }} server, you can run server diagnostics to identify the source of the problem and generate a report for support.
---

# Analysis of {{ baremetal-full-name }} server disk status

[{{ baremetal-full-name }} servers](./servers.md) are equipped with [disks](./disks/disk-types.md) that can have some usage history. This is a normal practice for server hardware: disks are designed for years of continuous operation, and their performance does not decrease in the process. While long use itself does not constitute a reason for disk replacement, the actual disk state does.

Each disk added to the service undergoes a required load testing. Untested disks are never used.

## Disk health diagnostics {#diagnostics}

If you encounter disk read/write errors or disk or [RAID](./disks/raid.md) array failures and suspect a disk malfunction while working with a {{ baremetal-name }} server, you can check the disk health in several ways.

{% note tip %}

To ensure protection from data loss, [configure](../operations/backup-baremetal.md) backup creation on your server using [{{ backup-full-name }}](../../backup/index.yaml).

{% endnote %}

### SMART {#smart}

[SMART](https://en.wikipedia.org/wiki/Self-Monitoring,_Analysis_and_Reporting_Technology) (self-monitoring, analysis, and reporting technology) is a built-in self-diagnostics system used in every modern disk: [HDD](./disks/disk-types.md#hdd), [SSD](./disks/disk-types.md#ssd), and [NVMe](./disks/disk-types.md#nvme). During its use, the disk continuously measures various indicators and collects statistics that you can read using external monitoring tools. To read these data, use standard utilities.

The key principle of SMART data interpretation is that the counter's dynamics and its attribute switching to `FAILING_NOW` provides much more insight than any specific counter value. An attribute switch means that the disk itself sends signals that the built-in recovery mechanisms are depleted.

For NVMe storages, `percentage_used` is another monitored attribute that stands for the degree of the disk's [NAND](https://en.wikipedia.org/wiki/Flash_memory#Distinction_between_NOR_and_NAND_flash) memory deterioration.

### HWCheck {#hwcheck}

_HWCheck_ is a utility for server hardware diagnostics. It automatically collects SMART metrics from all disks, analyzes them by internal criteria, and generates a disk health report in an easy-to-read format, so you do not need to interpret raw SMART data manually.

You can [run](../operations/servers/use-hwatcher.md) server diagnostics to identify the source of the issue and generate a report for support.

{% include [hwcheck-only-on-linux](../../_includes/baremetal/hwcheck-only-on-linux.md) %}

Information on server disk status is saved in the report’s `drive` directory, and reports for each of the server’s disks are saved in separate files. A report on the disk’s SMART attribute values is formatted as a table:

{% list tabs group=disks %}

- HDDs {#net-hdd}

  ```text
  ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
    1 Raw_Read_Error_Rate     POSR--   083   063   044    -    203094696
    3 Spin_Up_Time            PO----   093   093   000    -    0
    4 Start_Stop_Count        -O--CK   100   100   020    -    224
    5 Reallocated_Sector_Ct   PO--CK   100   100   036    -    0
    7 Seek_Error_Rate         POSR--   084   060   030    -    293695131
    9 Power_On_Hours          -O--CK   074   011   000    -    23513
   10 Spin_Retry_Count        PO--C-   100   100   097    -    0
   12 Power_Cycle_Count       -O--CK   100   100   020    -    225
  184 End-to-End_Error        -O--CK   100   100   099    -    0
  187 Reported_Uncorrect      -O--CK   100   100   000    -    0
  188 Command_Timeout         -O--CK   100   099   000    -    65537
  189 High_Fly_Writes         -O-RCK   093   093   000    -    7
  190 Airflow_Temperature_Cel -O---K   068   051   045    -    32 (Min/Max 31/32)
  191 G-Sense_Error_Rate      -O--CK   100   100   000    -    0
  192 Power-Off_Retract_Count -O--CK   100   100   000    -    187
  193 Load_Cycle_Count        -O--CK   100   100   000    -    1816
  194 Temperature_Celsius     -O---K   032   049   000    -    32 (0 18 0 0 0)
  195 Hardware_ECC_Recovered  -O-RC-   023   003   000    -    203094696
  197 Current_Pending_Sector  -O--C-   100   100   000    -    0
  198 Offline_Uncorrectable   ----C-   100   100   000    -    0
  199 UDMA_CRC_Error_Count    -OSRCK   200   200   000    -    0
  ```

  Where:

  * `ID#`: Attribute ID.
  * `ATTRIBUTE_NAME`: Attribute name.

      * `Raw_Read_Error_Rate`: Frequency of errors caused by the disk’s hardware when reading data.
      * `Spin_Up_Time`: Disk spin-up time from an idle state to an operational speed. It increases as the disk’s mechanical parts wear out or may indicate problems with the disk’s power supply.
      * `Start_Stop_Count`: Total number of disk start/stop cycles.
      * `Reallocated_Sector_Ct`: Total number of sectors with read/write errors reallocated to the reserve area.
      * `Seek_Error_Rate`: Frequency of magnetic head positioning errors. The more errors you get, the worse is the disk condition. Overheating and external vibrations may affect this parameter.
      * `Power_On_Hours`: Total number of disk power-on hours.
      * `Spin_Retry_Count`: Total number of retry attempts to spin up the disk to its operational speed in cases when the previous attempt failed. If this attribute’s value increases, there are likely to be problems with the disk’s mechanical parts.
      * `Power_Cycle_Count`: Total number of disk power cycles.
      * `End-to-End_Error`: Total number of errors caused by the mismatch in the host and disk parity data transferred though the cache.
      * `Reported_Uncorrect`: Total number of errors that could not be recovered using hardware error correction mechanisms.
      * `Command_Timeout`: Total number of operations interrupted by the disk timeout.
      * `High_Fly_Writes`: Total number of cases detected during write operations where the head was flying higher over the disk surface than the calculated range.
      * `Airflow_Temperature_Cel`: Air temperature inside the disk case.
      * `G-Sense_Error_Rate`: Total number of errors caused by impact loads. 
      * `Power-Off_Retract_Count`: Total number of disk emergency shutdown or power failure cycles.
      * `Load_Cycle_Count`: Total number of cycles when the magnetic head was moved to the parking position.
      * `Temperature_Celsius`: Disk temperature.
      * `Hardware_ECC_Recovered`: Total number of times the disk controller has corrected [ECC](https://en.wikipedia.org/wiki/ECC_memory) errors.
      * `Current_Pending_Sector`: Total number of so-called _suspicious_ sectors that are not yet marked as bad, but their read behavior deviates from stable sectors. If such a sector is successfully read next time, it is removed from suspicious sectors. In case read errors persist, the disk will attempt to restore the sector by reallocating it.
      * `Offline_Uncorrectable`: Total number of _suspicious_ (`Current_Pending_Sector`) sectors the disk could not restore.
      * `UDMA_CRC_Error_Count`: Total number of errors with data transmission via an external interface in UltraDMA mode, e.g., package integrity errors.

  {% include [smart-attribute-field-descs](../../_includes/baremetal/smart-attribute-field-descs.md) %}

- SSDs {#net-ssd}

  ```text
  ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
    5 Reallocated_Sector_Ct   PO--CK   100   100   010    -    0
    9 Power_On_Hours          -O--CK   086   086   000    -    67710
   12 Power_Cycle_Count       -O--CK   099   099   000    -    108
  177 Wear_Leveling_Count     PO--C-   062   062   005    -    1182
  179 Used_Rsvd_Blk_Cnt_Tot   PO--C-   100   100   010    -    0
  180 Unused_Rsvd_Blk_Cnt_Tot PO--C-   100   100   010    -    17618
  181 Program_Fail_Cnt_Total  -O--CK   100   100   000    -    0
  182 Erase_Fail_Count_Total  -O--CK   100   100   000    -    0
  183 Runtime_Bad_Block       PO--C-   100   100   010    -    0
  184 End-to-End_Error        PO--CK   100   100   097    -    0
  187 Reported_Uncorrect      -O--CK   100   100   000    -    0
  190 Airflow_Temperature_Cel -O--CK   073   049   000    -    27
  195 Hardware_ECC_Recovered  -O-RC-   200   200   000    -    0
  199 UDMA_CRC_Error_Count    -OSRCK   100   100   000    -    0
  202 Unknown_SSD_Attribute   PO--CK   100   100   010    -    0
  235 Unknown_Attribute       -O--C-   099   099   000    -    68
  241 Total_LBAs_Written      -O--CK   099   099   000    -    2179262941271
  ```

  Where:

  * `ID#`: Attribute ID.
  * `ATTRIBUTE_NAME`: Attribute name.

      * `Reallocated_Sector_Ct`: Total number of blocks with read/write errors reallocated to the reserve area.
      * `Power_On_Hours`: Total number of disk power-on hours.
      * `Power_Cycle_Count`: Total number of disk power cycles.
      * `Wear_Leveling_Count`: Maximum number of erase operations performed on a single flash memory block.
      * `Used_Rsvd_Blk_Cnt_Tot`: Total number of used flash memory blocks in the reserve area.
      * `Unused_Rsvd_Blk_Cnt_Tot`: Total number of available flash memory blocks in the reserve area.
      * `Program_Fail_Cnt_Total`: Total number of failures when attempting to write data to a flash memory block.
      * `Erase_Fail_Count_Total`: Total number of failures when attempting to erase data from a flash memory block.
      * `Runtime_Bad_Block`: Total number of flash memory blocks with unfixable errors detected over the entire disk operation time.
      * `End-to-End_Error`: Total number of errors caused by the mismatch in the host and disk parity data transferred though the cache.
      * `Reported_Uncorrect`: Total number of errors that could not be recovered using hardware error correction mechanisms.
      * `Airflow_Temperature_Cel`: Air temperature inside the disk case.
      * `Hardware_ECC_Recovered`: Total number of times the disk controller has corrected [ECC](https://en.wikipedia.org/wiki/ECC_memory) errors.
      * `UDMA_CRC_Error_Count`: Total number of errors with data transmission via an external interface in UltraDMA mode, e.g., package integrity errors.
      * `Total_LBAs_Written`: Total number of data blocks written to the disk over its lifespan.
      * `Unknown_SSD_Attribute` and `Unknown_Attribute`: Manufacturer-specific attributes.

  {% include [smart-attribute-field-descs](../../_includes/baremetal/smart-attribute-field-descs.md) %}

{% endlist %}

For more information on how to run `HWCheck`, see [this guide](../operations/servers/use-hwatcher.md).

### Load testing {#load-testing}

SMART reflects the disk health but does not always allow you to detect degradation in performance: a disk with satisfactory SMART metrics may work much slower than expected. Actual performance is checked by load testing, i.e., artificial loads on the disk with measuring actual speed and IOPS metrics. The [fio](https://fio.readthedocs.io/en/latest/fio_doc.html) utility is a convenient tool to run such tests.

{% note info %}

If the disk is part of a [RAID array](./disks/raid.md) or is under active load, the load testing results may be inaccurate.

You can only use `fio` on Linux servers.

{% endnote %}

## Disk replacement {#disk-replacement}

Data center engineers provide replacement for malfunctioning disks free of charge and 24/7.

To learn more about disk replacement in {{ baremetal-name }} servers, see [Replacing a disk in a RAID array](../operations/servers/switch-raid-member.md#request-swap).

#### See also {#see-also}

* [{#T}](../operations/servers/use-hwatcher.md)
* [{#T}](../operations/servers/switch-raid-member.md)
* [{#T}](../operations/backup-baremetal.md)
* [{#T}](./disks/disk-types.md)
* [{#T}](./disks/raid.md)
