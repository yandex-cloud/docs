### Time shift in DATETIME data type when transferring to {{ CH }} {#timeshift}

Time is shifted because the source endpoint uses the UTC+0 time zone for `DATETIME` data. For more information, see [{#T}](../../../../data-transfer/operations/endpoint/source/mysql.md#known-limitations).

**Solution:** Apply the appropriate time zone at the target level manually.
