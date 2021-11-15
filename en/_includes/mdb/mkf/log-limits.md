You'll get the full cluster log. The number of log entries that the cluster can return must not exceed 100,000 (100 pages of 1000 entries each).

If the log size exceeds this value or you want to get logs for a specific period of time, pass in the `fromTime` and `toTime` request parameters the timeframes in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format.
