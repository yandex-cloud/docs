# Read and write operations

There are technical restrictions on reads and writes that apply to [disks](disk.md) and [file storages](filesystem.md). Such limitations apply to the entire disk or storage and each allocation unit (a unit of disk space allocation). The allocation unit size depends on the [disk or storage type](../concepts/limits.md#compute-limits-disks).

The maximum read and write operation parameters are the following:
* Maximum IOPS: Maximum number of read and write operations per second.
* Maximum bandwidth: Total number of bytes that can be read or written per second.

The actual IOPS value depends on the disk or storage configuration, total bandwidth, and the size of the request in bytes. The provided IOPS value is calculated using the following formula:

![image](../../_assets/compute/iops.svg)

Where:
* _Max IOPS_: [Maximum IOPS](../concepts/limits.md#limits-disks) value for the disk or storage.
* _Max bandwidth_: [Maximum bandwidth value](../concepts/limits.md#limits-disks) for the disk or storage.

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. The total number of read and write operations per second is determined by this formula:

![image](../../_assets/compute/max-iops.svg)

Where:
* ![image](../../_assets/compute/alpha.svg): Share of write operations in the total number of read and write operations per second. Possible values: &alpha;&isin;[0,1].
* _WriteIOPS_: IOPS write value obtained using the formula for the actual IOPS value.
* _ReadIOPS_: IOPS read value obtained using the formula for the actual IOPS value.

For more information about maximum possible IOPS and bandwidth values, see [Quotas and limits](../concepts/limits.md#limits-disks).

## Disk and file storage performance {#performance}

The maximum IOPS values are achieved when performing reads and writes that are 4 KB in size. Network SSDs and file storage have much higher IOPS for read operations and process requests faster than HDDs.

To achieve the maximum possible bandwidth, we recommend performing 4 MB reads and writes.

Disk or storage performance depends on its size: with more allocation units, you get higher IOPS and bandwidth values.

For small HDDs, there is a feature that boosts their performance to that of 1 TB disks for peak loads. When a small disk operates at the [basic performance level](../concepts/limits.md#compute-limits-disks) for 12 hours, it accumulates <q>credits for operations</q>. These are spent automatically when the load increases, e.g., when a VM boots up. Small HDDs can work at increased performance for about 30 minutes a day. <q>Credits for operations</q> can be spent all at once or in small intervals. For HDD storages, this feature is unavailable.

### Testing disk performance {#test-performance}

{% note info %}

We do not recommend testing writes to your `/dev/vda` disk. If you need to test writes to the boot disk, run the `fio` utility with the `--filename=./testfile` and `--filesize=1G` parameters.

{% endnote %}

You can test the performance of your network disks with [fio](https://fio.readthedocs.io/en/latest/fio_doc.html) (Flexible I/O Tester):

1. [Attach](../operations/vm-control/vm-attach-disk.md) a disk to a VM instance.
1. Install [fio](https://fio.readthedocs.io/en/latest/fio_doc.html) on your VM instance.

   Sample command for Ubuntu:

   ```bash
   sudo apt-get update && sudo apt-get install fio -y
   ```

1. Start `fio` and run:

   ```bash
   sudo fio \
   --filename=/dev/vdb \
   --direct=1 \
   --rw=write \
   --bs=4k \
   --ioengine=libaio \
   --iodepth=64 \
   --runtime=120 \
   --numjobs=8 \
   --time_based \
   --group_reporting \
   --eta-newline=1
   ```

   Where:

   * `filename=/dev/vdb`: Name of the disk being tested. To view the disks attached, run the `lsblk` command.
   * `direct`: Flag that toggles buffering (`0` means buffering is used, `1` means it is not used).
   * `rw`: Load template. The possible values include:
      * `read`: Sequential reads.
      * `write`: Sequential writes.
      * `rw`: Sequential reads/writes.
      * `randrw`: Random reads/writes.
      * `randwrite`: Random writes.
      * `randread`: Random reads.
   * `bs`: Read/write block size. To get better results, specify a value that is less than or equal to the disk block size.
   * `iodepth`: I/O block depth per `job`.
   * `runtime`: Test duration in seconds.
   * `numjobs`: Number of read/write jobs.

### Test examples {#test-examples}

#### Test IOPS for sequential writes {#iops-write-example}

```bash
sudo fio \
--name=readio \
--filename=/dev/vdd \
--direct=1 \
--rw=write \
--bs=4k \
--ioengine=libaio \
--iodepth=96 \
--runtime=120 \
--numjobs=4 \
--time_based \
--group_reporting \
--eta-newline=1
```

Result:

```
---
  write: IOPS=39.7k, BW=155MiB/s (162MB/s)(5112MiB/33001msec); 0 zone resets
    slat (usec): min=2, max=19776, avg= 5.25, stdev=47.15
    clat (usec): min=874, max=5035.1k, avg=9677.38, stdev=40976.63
     lat (usec): min=889, max=5035.1k, avg=9682.81, stdev=40976.66
---
```

#### Test IOPS for random writes {#iops-random-write-example}

```bash
sudo fio \
--name=randwrite \
--filename=/dev/vdd \
--direct=1 \
--rw=randwrite \
--bs=4k \
--ioengine=libaio \
--iodepth=96 \
--runtime=120 \
--numjobs=1 \
--time_based \
--group_reporting \
--eta-newline=1
```

Result:

```
---
write: IOPS=9596, BW=37.5MiB/s (39.3MB/s)(4499MiB/120011msec); 0 zone resets
    slat (usec): min=2, max=338, avg= 5.21, stdev= 4.52
    clat (usec): min=680, max=161320, avg=9996.54, stdev=10695.67
     lat (usec): min=698, max=161323, avg=10001.94, stdev=10695.77
---
```

#### Test throughput for sequential writes {#bandwidth-write-example}

```bash
sudo fio \
--name=writebw \
--filename=/dev/vdd \
--direct=1 \
--rw=write \
--bs=4M \
--ioengine=libaio \
--iodepth=32 \
--runtime=120 \
--numjobs=1 \
--time_based \
--group_reporting \
--eta-newline=1
```

Result:

```
---
   write: IOPS=112, BW=449MiB/s (471MB/s)(52.8GiB/120237msec); 0 zone resets
    slat (usec): min=166, max=270963, avg=8814.82, stdev=10995.16
    clat (msec): min=58, max=661, avg=276.06, stdev=28.21
     lat (msec): min=60, max=679, avg=284.88, stdev=27.91
---
```

#### Test IOPS for sequential reads {#iops-read-example}

```bash
sudo fio \
--name=readio \
--filename=/dev/vdd \
--direct=1 \
--rw=read \
--bs=4k \
--ioengine=libaio \
--iodepth=128 \
--runtime=120 \
--numjobs=8 \
--time_based \
--group_reporting \
--eta-newline=1
```

Result:

```
---
  read: IOPS=62.2k, BW=243MiB/s (255MB/s)(28.5GiB/120008msec)
    slat (usec): min=2, max=123901, avg= 6.88, stdev=151.96
    clat (usec): min=859, max=168609, avg=16450.99, stdev=8226.23
     lat (usec): min=877, max=168611, avg=16458.07, stdev=8229.16
---
```

#### Test read throughput {#bandwidth-read-example}

```bash
sudo fio \
--name=readbw \
--filename=/dev/vdd \
--direct=1 \
--rw=read \
--bs=4M \
--ioengine=libaio \
--iodepth=32 \
--runtime=120 \
--numjobs=1 \
--time_based \
--group_reporting \
--eta-newline=1
```

Result:

```
---
  read: IOPS=112, BW=449MiB/s (470MB/s)(52.7GiB/120227msec)
    slat (usec): min=85, max=177850, avg=8878.47, stdev=9824.19
    clat (msec): min=50, max=4898, avg=276.36, stdev=45.16
     lat (msec): min=52, max=4898, avg=285.24, stdev=44.94
---
```

#### Test IOPS for random reads {#iops-random-read-example}

```bash
sudo fio \
--name=randread \
--filename=/dev/vdd \
--direct=1 \
--rw=randread \
--bs=4k \
--ioengine=libaio \
--iodepth=16 \
--runtime=120 \
--numjobs=8 \
--time_based \
--group_reporting \
--eta-newline=1
```

Result:

```
---
 read: IOPS=17.0k, BW=66.4MiB/s (69.6MB/s)(7966MiB/120006msec)
    slat (usec): min=2, max=114, avg= 9.05, stdev= 5.36
    clat (usec): min=172, max=251507, avg=7519.93, stdev=6463.84
     lat (usec): min=179, max=251511, avg=7529.25, stdev=6464.41
---
```

### Throttling {#throttling}

If a VM exceeds [disk limits](limits.md#compute-limits-disks) at any time, this will trigger throttling.

_Throttling_ is a feature that intentionally limits performance. When throttled, disk operations are suspended, and the disk operation wait time (`iowait`) is increased. Since all write and read operations are processed in a single thread (vCPU), overloading system disks may cause network problems. This is true for both VMs and physical servers.

> For example, let's assume there is a write limit of 300 IPOS. The limit is split into 10 parts and applies once every 100 ms. 300 / 10 = 30 IOPS per write request will be allowed every 100 ms. If you send 30 requests once and then 30 more requests within 100 ms (evenly distributed across the 100 ms interval), this will trigger throttling and only the first 30 requests will be sent, while the rest will be queued and processed in the next 100 ms. If write requests are executed sporadically, throttling may cause significant delays. At times, there will be up to N IOPS of requests within 100 ms.

Disk performance depends on its [size](disk.md#maximum-disk-size). To improve the overall performance of the disk subsystem, use VMs with SSD network storage (`network-SSD`). Every increment of 32 GB increases the number of allocation units and, consequently, the performance.

You can select the storage type only when creating a VM. However, you can [make a disk snapshot](../operations/disk-control/create-snapshot.md) and [create a new VM](../operations/vm-create/create-from-snapshots.md) from such a snapshot with a `network-ssd` disk.
