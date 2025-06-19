* `FLAGS`: Attribute flags set by the disk manufacturer characterizing the attribute type:

    * `P` (`prefailure warning`): When these attributes reach their thresholds, the disk needs to be replaced.
    * `O` (`updated online`): These attributes are updated when built-in SMART tests are performed online and offline.
    * `S` (`speed/performance`): These attributes characterize disk performance.
    * `R` (`error rate`): These attributes reflect disk error counter values​.
    * `C` (`event count`): These attributes reflect event counter values.
    * `K` (`auto-keep`): Auto-keep attributes.
* `VALUE`: Current attribute value.
* `WORST`: Worst attribute value throughout the disk's lifetime.
* `THRESH`: The attribute's minimum threshold value for the disk to be considered in critical condition and prone to failure.
* `FAIL`: State signaling that the attribute has exceeded the `THRESH` value.
* `RAW_VALUE`: Absolute value of the attribute.

If any of the table attributes with the `P` flag (`prefailure warning`) has `FAILING_NOW` in the `FAIL` field, the disk's service life has expired and you need to replace it.