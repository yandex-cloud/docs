```text
id: cdgkoivuvtey********
name: sample-backup-policy
created_at: "2025-10-06T19:09:31Z"
updated_at: "2025-10-06T19:09:31Z"
enabled: true
settings:
  compression: NORMAL
  format: AUTO
  multi_volume_snapshotting_enabled: true
  reattempts:
    enabled: true
    interval:
      type: SECONDS
      count: "30"
    max_attempts: "30"
  silent_mode_enabled: true
  splitting:
    size: "1099511627776"
  vm_snapshot_reattempts:
    enabled: true
    interval:
      type: MINUTES
      count: "5"
    max_attempts: "3"
  vss:
    enabled: true
    provider: TARGET_SYSTEM_DEFINED
  archive:
    name: '''[Machine Name]-[Plan ID]-[Unique ID]A'''
  performance_window: {}
  retention:
    rules:
      - max_count: "10"
    before_backup: true
  scheduling:
    backup_sets:
      - time:
          weekdays:
            - MONDAY
          repeat_at:
            - minute: "5"
          type: WEEKLY
        type: TYPE_AUTO
    enabled: true
    max_parallel_backups: "2"
    rand_max_delay:
      type: MINUTES
      count: "30"
    scheme: ALWAYS_INCREMENTAL
    weekly_backup_day: MONDAY
  cbt: ENABLE_AND_USE
  fast_backup_enabled: true
  file_filters: {}
  pre_post_commands:
    - cmd: /usr/bin/myapp
      args: -d -rw
      enabled: true
      stop_on_error: true
      type: PRE_COMMAND
      wait: true
      workdir: /etc/myapp/
folder_id: b1gt6g8ht345********
```