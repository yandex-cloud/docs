# Read and write operations

There are some technical restrictions on reads and writes that apply to [disks](disk.md) and [file storages](filesystem.md). The restrictions apply both to the entire disk or storage and to each individual disk space allocation unit. The allocation unit size depends on the [disk or storage type](../concepts/limits.md#compute-limits-disks).

The maximum read and write operation parameters are as follows:
* Maximum IOPS: Maximum number of read and write operations per second.
* Maximum bandwidth: Total number of bytes that can be read or written per second.

The actual IOPS value depends on the disk or storage configuration, total bandwidth, and the size of the request in bytes. The provided IOPS value is calculated using the following formula:

![image](../../_assets/compute/iops.svg)

Where:
* _Max. IOPS_: [Maximum IOPS value](../concepts/limits.md#limits-disks) for the disk or storage.
* _Max. bandwidth_: [Maximum bandwidth value](../concepts/limits.md#limits-disks) for the disk or storage.

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. The total number of read and write operations per second is determined by this formula:

![image](../../_assets/compute/max-iops.svg)

Where:
* ![image](../../_assets/compute/alpha.svg) is the share of write operations out of the total number of read and write operations per second. Possible values: &alpha;&isin;[0,1].
* _WriteIOPS_: IOPS write value obtained using the formula for the actual IOPS value.
* _ReadIOPS_: IOPS read value obtained using the formula for the actual IOPS value.

For more information about maximum possible IOPS and bandwidth values, see [Quotas and limits](../concepts/limits.md#limits-disks).

{% note warning %}

VMs with [vCPU performance level](performance-levels.md) below 100% may operate at lower speed with network drives.

{% include [vcpu-perfomance-disks](../../_includes/compute/vcpu-perfomance-disks.md) %}

{% endnote %}


## Disk and file storage performance {#performance}

The maximum IOPS values are achieved when performing reads and writes that are 4 KB in size. Network SSDs and file storage have much higher IOPS for read operations and process requests faster than HDDs.

For maximum bandwidth, we recommend 4 MB reads and writes.

Disk or storage performance depends on its size: with more allocation units, you get higher IOPS and bandwidth values.

For smaller HDDs, there is a performance boosting mechanism in place for them to operate on a par with 1 TB disks during peak load periods. By operating at the [basic performance level](../concepts/limits.md#compute-limits-disks) for 12 hours, a smaller HDD accumulates credits for operations. These will be automatically spent when the load increases, e.g., when the VM starts. Small HDDs can be boosted for about 30 minutes a day. Credits for operations can be spent either all at once or by small intervals. This feature is not available for HDD storages.

### Testing disk performance {#test-performance}

You can test the performance of your network disks with [fio](https://fio.readthedocs.io/en/latest/fio_doc.html) (Flexible I/O Tester):

1. [Attach](../operations/vm-control/vm-attach-disk.md) the disk to the VM.
1. Install [fio](https://fio.readthedocs.io/en/latest/fio_doc.html) on your VM instance.

    Sample command for Ubuntu:

    ```bash
    sudo apt-get update && sudo apt-get install fio -y
    ```

1. Start `fio` and run the following:

    ```bash
    sudo fio \
    --name=<job_name>
    --filename=<path_to_mount_point>/testfile.bin \
    --filesize=1G \
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

    * `--name`: Random job name.
    * `--filename`: Path to the mount point of the disk whose performance you want to test.

        {% note alert %}

        When testing write operations, do not use disk ID (e.g., `/dev/vdb`) as the `--filename` parameter value. This may cause you to lose all data on the disk.

        {% endnote %}

    * `--direct`: Flag that toggles buffering; `0` means buffering is used, `1` means buffering is not used.
    * `--rw`: Load template. The possible values are as follows: 
      * `read`: Sequential reads.
      * `write`: Sequential writes.
      * `rw`: Sequential reads and writes.
      * `randread`: Random reads and writes.
      * `randwrite`: Random writes.
      * `randread`: Random reads.
    * `--bs`: Read and write block size. To get better results, specify a value that is equal to the disk block size or less.
    * `--iodepth`: I/O block depth per `job`.
    * `--runtime`: Test duration in seconds.
    * `--numjobs`: Number of read and write jobs.

### Test examples {#test-examples}

#### Test IOPS for sequential writes {#iops-write-example}

```bash
sudo fio \
--name=readio \
--filename=<path_to_mount_point>/testfile.bin \
--filesize=1G \
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

```yaml
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
--filename=<path_to_mount_point>/testfile.bin \
--filesize=1G \
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

```yaml
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
--filename=<path_to_mount_point>/testfile.bin \
--filesize=1G \
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

```yaml
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
--filename=<path_to_mount_point>/testfile.bin \
--filesize=1G \
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

```yaml
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
--filename=<path_to_mount_point>/testfile.bin \
--filesize=1G \
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

```yaml
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
--filename=<path_to_mount_point>/testfile.bin \
--filesize=1G \
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

```yaml
---
 read: IOPS=17.0k, BW=66.4MiB/s (69.6MB/s)(7966MiB/120006msec)
    slat (usec): min=2, max=114, avg= 9.05, stdev= 5.36
    clat (usec): min=172, max=251507, avg=7519.93, stdev=6463.84
     lat (usec): min=179, max=251511, avg=7529.25, stdev=6464.41
---
```

### Throttling {#throttling}

If a VM exceeds [disk limits](limits.md#compute-limits-disks) at any time, this will trigger throttling.

_Throttling_ is a feature that forcibly limits the performance. When throttled, disk operations are suspended, and the disk operation wait time (`iowait`) is increased. The processes maintaining the operation of [network disks](disk.md) are separated from the user load and run on compute cores from a [separate pool](software-accelerated-network.md#reg-vm), the service cores. Overloading system disks may cause network problems. This is true for both VMs and physical servers.

> For example, let's assume there is a write limit of 300 IPOS. The limit is split into 10 parts and applies once every 100 ms. 300 / 10 = 30 IOPS per write request will be allowed every 100 ms. If you send 30 requests once and then 30 more requests within 100 ms (evenly distributed across the 100 ms interval), this will trigger throttling and only the first 30 requests will be sent. The rest of them will be enqueued and processed within the next 100 ms. If write requests are executed sporadically, throttling may cause significant delays. At times, there will be up to N IOPS of requests within 100 ms.

Disk performance depends on its [size](disk.md#maximum-disk-size). To improve the overall performance of the disk subsystem, use VMs with SSD network storage (`network-ssd`). Every increment of 32 GB increases the number of allocation units and, in turn, the performance.

You can select the storage type only when creating a VM. However, you can [take a disk snapshot](../operations/disk-control/create-snapshot.md) and [create a new VM](../operations/vm-create/create-from-snapshots.md) from such a snapshot with a `network-ssd`.
