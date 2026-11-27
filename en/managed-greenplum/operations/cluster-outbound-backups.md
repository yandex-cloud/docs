---
title: Restoring Greenplum from a WAL-G backup
description: Follow this guide to recover a {{ GP }} cluster's database from a WAL-G backup.
noIndex: true
alternate:
  - href: en/managed-greenplum/operations/cluster-outbound-backups.md
    type: text/markdown
    title: Markdown version
---

# Recovering {{ GP }} from a WAL-G backup

You can restore a {{ mgp-full-name }} cluster's data on user infrastructure from a backup transferred to an S3 bucket through the WAL-G utility.

## Getting started {before-you-begin}

To complete this guide, you will need the following:

1. {{ GP }}: Download the last version from the repository [https://github.com/open-gpdb/gpdb/releases](https://github.com/open-gpdb/gpdb/releases).
1. Virtual infrastructure: Virtual machines are deployed, each with an FQDN assigned.
1. Operating system: An OS from the list of compatible with {{ GP }} (Ubuntu 22.04 recommended) is installed on the nodes.
1. Network access: All cluster nodes have passwordless SSH access for the `gpadmin` user. 
1. WAL-G: Binary [wal-g](https://github.com/wal-g/wal-g/releases/) file is installed on all cluster nodes.
1. Disk space: Free disk space big enough to store unpacked data with the following taken into account:
   * Size of the database itself.
   * Size of the WAL segments to recover.

{% include [key](../../_includes/mdb/decrypt-key.md) %}

## Preparing the environment on the cluster hosts {#prepare-env}

Do this step on all the cluster nodes.

1. Create a directory structure for {{ GP }} data and WAL-G configuration files.

   ```bash
   # Creating a directory for data
   mkdir -p /var/lib/greenplum/data1
   chown gpadmin:gpadmin -R /var/lib/greenplum/

   # Creating a directory for wal-g configuration files
   sudo mkdir -p /etc/wal-g
    ```
1. Set up a WAL-G configuration file Create an `/etc/wal-g/wal-g.yaml` file on each host:

   ```yaml
   # /etc/wal-g/wal-g.yaml
   WALG_COMPRESSION_METHOD: "brotli"
   PGUSER: "gpadmin"
   PGDATABASE: "postgres"
   PGPASSFILE: "/home/gpadmin/.pgpass"
   S3_DISABLE_100_CONTINUE: "true"

   # S3 settings
   AWS_ENDPOINT: "<your_s3_storage>"
   AWS_S3_FORCE_PATH_STYLE: true

   # Encryption
   WALG_PGP_KEY_PATH: "/etc/wal-g/PGP_KEY"

   # Local parameters
   PGHOST: "localhost"
   WALG_GP_LOGS_DIR: "/var/log/wal-g/"

   # Path to backups in the  bucket
   WALE_S3_PREFIX: "s3://<path_in_user's_bucket>"

   # Static access key for access to S3
   AWS_ACCESS_KEY_ID: "<static_key_ID>"
   AWS_SECRET_ACCESS_KEY: "<secret_access_key_value>"
   ```

1. Copy the file of the private PGP key received from {{ mgp-short-name }} into the specified place in the `/etc/wal-g/PGP_KEY` configuration file. Make sure that access permissions are strict (`chmod 600 /etc/wal-g/PGP_KEY`).

1. Check the backup for integrity:
 
   {% include [checkup](../../_includes/mdb/backup-checkup.md) %}

   1. Run the script:

      ```bash
      WAL_G_BIN=wal-g-gp ./s3_test_script.sh /etc/wal-g/wal-g.yaml
      ```
   
      If necessary, specify the directory:

      ```bash
      WAL_G_BIN=wal-g-gp ./s3_test_script.sh /etc/wal-g/wal-g.yaml basebackups_005 # checking the backup's metadata
      WAL_G_BIN=wal-g-gp ./s3_test_script.sh /etc/wal-g/wal-g.yaml segments_005/  # checking the segments
      ```
      
      To check individual segments:

      ```bash
      WAL_G_BIN=wal-g-gp ./s3_test_script.sh /etc/wal-g/wal-g.yaml segments_005/seg0/  # checking segment seg0
      WAL_G_BIN=wal-g-gp ./s3_test_script.sh /etc/wal-g/wal-g.yaml segments_005/seg-1/  # checking the master segment
      WAL_G_BIN=wal-g-gp ./s3_test_script.sh /etc/wal-g/wal-g.yaml segments_005/seg999/  # checking segment seg999 
      ```

      Here is an example of the command output:

      ```bash
      FAIL test/corrupted_file_2.txt.br
      Checked: 2; decoded: 2; raw: 0; failed: 1; unknown:

## Configuring the restoration configuration {#restore-config}

You need this file to understand WAL-G, how to distribute segments among new hosts.

Create the `/etc/wal-g/wal-g-restore-config.yaml` configuration file on the master node (it is enough to have it on one host where you are going to run the `backup-fetch` command, but it is more convenient to have it on all hosts or to provide the file).

Here is an example of the structure (replace `FQDN.example.com` with real addresses of your new virtual machines):
The `data_dir` paths should match those you will have specified in `master_data_directory` or `datadirs` when starting the cluster.

   ```json
   {
       "segments": {
           "-1": {
               "hostname": "MASTER-FQDN.EXAMPLE.COM",
               "port": 5432,
               "data_dir": "/var/lib/greenplum/data1/master/gpseg-1"
           },
           "0": {
               "hostname": "NODE1-FQDN.EXAMPLE.COM",
               "port": 6000,
               "data_dir": "/var/lib/greenplum/data1/primary/gpseg0"
           },
           "1": {
               "hostname": "NODE2-FQDN.EXAMPLE.COM",
               "port": 6001,
               "data_dir": "/var/lib/greenplum/data1/primary/gpseg1"
           }
       }
   }
   ```

Describe all the cluster segments.

# Preparing data directories {#prepare-folder}

Clean up the data directories if there is any data or data left over from previous attempts in them.

Execute on the master node as the `gpadmin` user.

   ```bash
   # Creating base directories
   mkdir -p /var/lib/greenplum/data1
   chown gpadmin:gpadmin -R /var/lib/greenplum/

   # Deleting old data (caution! the action is irreversible)
   # Make sure /home/gpadmin/gpconfigs/cluster contains the list of hosts for gpssh
   gpssh -f /home/gpadmin/gpconfigs/cluster -v -e <<EOF
   rm -rf /var/lib/greenplum/data1/master/gpseg-1
   rm -rf /var/lib/greenplum/data1/primary/gpseg*
   rm -rf /var/lib/greenplum/data1/mirror/gpseg*
   EOF
   ```

## Restoring a database {#restore-db}

Run recovery. Execute on the master node as the `gpadmin` user:

   ```bash
   wal-g backup-fetch \
        LATEST \
        --config /etc/wal-g/wal-g.yaml \
        --restore-config /etc/wal-g/wal-g-restore-config.yaml \
        && echo "Backup extracted - OK"
   ```

   `LATEST` restores the last available backup. You can give a specific backup name (e.g., `base_0000000100000001_...`) which you can take via `wal-g backup-list`. The process can take a lot of time (depends on database size and network speed). Follow the logs in `/var/log/wal-g/`.

## Starting a cluster {#start-cluster}

Once the files are extracted, you should bring the data directories to a working state for the new host name.

1. Update `gp_segment_configuration`

   ```bash
    gpstart -m
    PGOPTIONS='-c gp_session_role=utility' psql
    
    SET allow_system_table_mods=TRUE;
    
    #for mirror:
    DELETE FROM gp_segment_configuration WHERE content=-1 AND role='m';
    
     dbid | content | role | preferred_role | mode | status | port |                      hostname                      |                      address                       |                 datadir
    ------+---------+------+----------------+------+--------+------+----------------------------------------------------+----------------------------------------------------+-----------------------------------------
        1 |      -1 | p    | p              | n    | u      | 5432 | rc1a-kikir00imn9ad658.example.com | rc1a-kikir00imn9ad658.example.com | /var/lib/greenplum/data1/master/gpseg-1
        2 |       0 | m    | m              | s    | u      | 7000 | rc1a-5rv6arelmrk6dg4a.example.com | rc1a-5rv6arelmrk6dg4a.example.com | /var/lib/greenplum/data1/mirror/gpseg0
        3 |       1 | m    | m              | s    | u      | 7001 | rc1a-5rv6arelmrk6dg4a.example.com | rc1a-5rv6arelmrk6dg4a.example.com | /var/lib/greenplum/data1/mirror/gpseg1
        6 |       0 | p    | p              | s    | u      | 6000 | rc1a-njp0qmtv4keaea1g.example.com | rc1a-njp0qmtv4keaea1g.example.com | /var/lib/greenplum/data1/primary/gpseg0
        7 |       1 | p    | p              | s    | u      | 6001 | rc1a-njp0qmtv4keaea1g.example.com | rc1a-njp0qmtv4keaea1g.example.com | /var/lib/greenplum/data1/primary/gpseg1
    
    # master:
    UPDATE gp_segment_configuration 
        SET hostname='FQDN.example.com', 
        address='FQDN.example.com',
        port=6000,
        datadir='/var/lib/greenplum/data1/master/gpseg-1',
        status='u',
        mode='n'
        WHERE content=-1 and role='p';
    
    # for each primary segment:
    UPDATE gp_segment_configuration 
        SET hostname='FQDN.example.com', 
        address='FQDN.example.com', 
        port=6000,
        datadir='/var/lib/greenplum/data1/primary/gpseg0',
        status='u',
        mode='n'
        WHERE content=0 and role='p';
    
    # for each mirror:
    UPDATE gp_segment_configuration 
        SET hostname='FQDN.example.com', 
        address='FQDN.example.com', 
        port=7000,
        datadir='/var/lib/greenplum/data1/mirror/gpseg0',
        status='d',
        mode='n'
        WHERE content=0 and role='m';
      
       
     dbid | content | role | preferred_role | mode | status | port |                      hostname                      |                      address                       |                 datadir
    ------+---------+------+----------------+------+--------+------+----------------------------------------------------+----------------------------------------------------+-----------------------------------------
        1 |      -1 | p    | p              | n    | u      | 5432 | rc1a-kikir00imn9ad658.example.com | rc1a-kikir00imn9ad658.example.com | /var/lib/greenplum/data1/master/gpseg-1
        6 |       0 | p    | p              | n    | u      | 6000 | rc1a-pso773ul1684qlv2.example.com | rc1a-pso773ul1684qlv2.example.com | /var/lib/greenplum/data1/primary/gpseg0
        7 |       1 | p    | p              | n    | u      | 6001 | rc1a-pso773ul1684qlv2.example.com | rc1a-pso773ul1684qlv2.example.com | /var/lib/greenplum/data1/primary/gpseg1
        2 |       0 | m    | m              | n    | d      | 7000 | rc1a-3i4qd1ltdv98gqqh.example.com | rc1a-3i4qd1ltdv98gqqh.example.com | /var/lib/greenplum/data1/primary/gpseg2
        3 |       1 | m    | m              | n    | d      | 7001 | rc1a-3i4qd1ltdv98gqqh.example.com | rc1a-3i4qd1ltdv98gqqh.example.com | /var/lib/greenplum/data1/primary/gpseg3
    
    gpstop -a
    ```

1. Start the cluster:

   ```bash
   service greenplum start
   ```

   Connect to the master:

   ```bash
   psql -u gpadmin -W
   ```

1. See if it works correctly:

   ```sql
   SELECT * FROM mdb_toolkit.can_write();
   ```

   Expected result:

   ```sql
    can_write 
    -----------
         t
   ```

## Restoration of mirrors {#restore-mirror}

If your cluster has mirrors, they should be restored or recreated. Make sure `gp_segment_configuration` states correct FQDNs and paths to mirror data.


Restore the mirrors:

   ```bash
   gprecoverseg -F
   ```

Once `gprecoverseg` ends, use the `gpstate -e` command to check the status. All segments should have the `m` (mirror online) or `p` (primary online, if no mirror is assigned) status.
