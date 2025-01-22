# Resolving the error: Unrecognized configuration parameter "stats_temp_directory"



## Issue description {#issue-description}

When executing the `SHOW stats_temp_directory` request, you see this error in the PostgreSQL cluster logs: `unrecognized configuration parameter "stats_temp_directory"`.

## Solution {#issue-resolution}

This behavior is [expected in PostgreSQL version 15](https://git.postgresql.org/gitweb/?p=postgresql.git;a=commit;h=6f0cf87872ab2fd4a81249ca9d6299b9b1a52277), and you can ignore these errors.

## If the issue persists {#if-issue-still-persists}

If, for any reason, your {{ mpg-full-name }} cluster continues to operate improperly, [create a request for technical support]({{ link-console-support }}).

In your request, specify the ID of the problem cluster and briefly describe the issue.
