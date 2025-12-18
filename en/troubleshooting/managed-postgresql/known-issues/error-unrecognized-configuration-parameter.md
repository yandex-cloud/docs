# Fixing the `Unrecognized configuration parameter "stats_temp_directory"` error



## Issue description {#issue-description}

When running the `SHOW stats_temp_directory` query, `unrecognized configuration parameter "stats_temp_directory"` errors occur in {{ PG }} cluster logs.

## Solution {#issue-resolution}

This behavior is [expected in {{ PG }} version 15](https://git.postgresql.org/gitweb/?p=postgresql.git;a=commit;h=6f0cf87872ab2fd4a81249ca9d6299b9b1a52277), and you can ignore these errors.

## If the issue persists {#if-issue-still-persists}

If your {{ mpg-name }} cluster continues to have issues, [create a support ticket]({{ link-console-support }}). When creating a ticket, specify your cluster ID and describe the issue in brief.