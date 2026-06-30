### Time shift in the DATETIME data type when transferring to {{ CH }} {#timeshift}

A time shift occurs because the source endpoint uses the UTC+0 time zone for `DATETIME` data. For more information, see [{#T}](../../../../data-transfer/operations/endpoint/source/mysql.md#known-limitations).

**Solution:** Manually adjust the time zone at the target level.
