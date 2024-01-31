* For transfers in the {{ dt-status-copy }} status, any changes to the data schema (`ALTER`) on the source or target will interrupt the transfer.

* For transfers in the {{ dt-status-repl }} status, you can change the data schema on the source. All `ALTER` operations recorded in the binary log (binlog) on the source will be automatically applied to the target. This process takes some time, so the transfer may slow down.
