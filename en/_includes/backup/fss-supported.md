#|
|| **File system** | **OS** | **Restrictions** ||
||
**FAT16/32**,
**ext2/ext3/ext4**,
**NTFS**
| Linux, Windows | No limit ||
||
**JFS**,
**ReiserFS3**
| Linux 
|
* You cannot exclude files from a disk backup.
* Fast incremental or differential backup is not supported.
|| 
|| 
**ReiserFS4** | Linux 
|
* You cannot exclude files from a disk backup.
* Fast incremental/differential backup is not supported.
* You cannot resize volumes while restoring. 
|| 
||
**ReFS**,
**XFS**
| Linux, Windows 
|
* You cannot exclude files from a disk backup.
* Fast incremental/differential backup is not supported.
* You cannot resize volumes while restoring. 
||
|| **Linux SWAP**     | Linux | No limit ||
|| **exFAT**          | Linux, Windows 
|
* Only disk/volume backups are supported.
* You cannot exclude files from a backup.
* You cannot restore single files from a backup.
||
|# {wide-content}