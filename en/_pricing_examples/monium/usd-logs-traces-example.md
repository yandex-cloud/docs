Cost of using {{ monium-logs-name }} and {{ traces-name }} for 30 days if writing **500 MB of logs per day** and **300 MB of traces per day**:

> 500 × 30 = 15,000 MB = 15 GB of logs
> 300 × 30 = 9,000 MB = 9 GB of traces
> 15 × $0.03607 + 9 × $0.03607 = $0.54105 + $0.32463 = $0.86568
> 
> Total: $0.87

Where:

* 500: Amount of logs written per day, in MB.
* 300: Amount of traces written per day, in MB.
* 30: Number of days.
* $0.03607: Cost of writing 1 GB of data to {{ monium-logs-name }} or {{ traces-name }}.