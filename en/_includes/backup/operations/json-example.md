```json
{
  "compression": "NORMAL",
  "format": "AUTO",
  "multiVolumeSnapshottingEnabled": true,
  "preserveFileSecuritySettings": true,
  "reattempts": {
    "enabled": true,
    "interval": {
      "type": "SECONDS",
      "count": "30"
    },
    "maxAttempts": "30"
  },
  "silentModeEnabled": true,
  "splitting": {
    "size": "1099511627776"
  },
  "vmSnapshotReattempts": {
    "enabled": true,
    "interval": {
      "type": "MINUTES",
      "count": "5"
    },
    "maxAttempts": "3"
  },
  "vss": {
    "enabled": true,
    "provider": "TARGET_SYSTEM_DEFINED"
  },
  "archive": {
    "name": "'[Machine Name]-[Plan ID]-[Unique ID]A'"
  },
  "performanceWindow": {
  },
  "retention": {
    "rules": [
      {
        "maxCount": "10"
      }
    ],
    "beforeBackup": true
  },
  "scheduling": {
    "backupSets": [
      {
        "time": {
          "weekdays": [
            "MONDAY"
          ],
          "repeatAt": [
            {
              "minute": "5"
            }
          ],
          "type": "WEEKLY"
        }
      }
    ],
    "enabled": true,
    "maxParallelBackups": "2",
    "randMaxDelay": {
      "type": "MINUTES",
      "count": "30"
    },
    "scheme": "ALWAYS_INCREMENTAL",
    "weeklyBackupDay": "MONDAY"
  },
  "cbt": "ENABLE_AND_USE",
  "fastBackupEnabled": true,
  "quiesceSnapshottingEnabled": true
}
```
