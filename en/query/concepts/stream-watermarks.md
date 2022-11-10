# Watermark

`Watermark` is a mechanism that is alternative to standard [`HOP` mode](stream-processing-windows.md#) and that lets you specify different policies for waiting for lagging data.

Standard `HOP` mode only closes processing windows once new data arrives. This means that new data "advances" processing. If data stops arriving, there will be no more output.

If watermarks are used, processing is not based on incoming data. Instead, a watermark defines special criteria that show that there is no need to wait for more data to arrive and processing windows can be closed.

## What is a watermark?

The concept of watermarks was introduced in a series of [Streaming 102](https://www.oreilly.com/radar/the-world-beyond-batch-streaming-102/) posts by Tyler Akendau.

Batch processing is always a balance between the completeness of data being processed and how fast the results can be obtained: if you want them to be as accurate as possible, wait until all data arrives. If speed is critical, it's not required to wait for some of late data. This lets you get the results faster, but they will be less accurate.

With watermarks, you can define a variety of criteria to indicate that you can stop waiting for more input data and start data processing. The right watermark mode lets you get correct results without using special `retraction` mechanisms for refining the data transferred.

Basically, watermarks indicate that there can be no more input data with a value of time less than the watermark time and all calculations can be made with a value of event time less than the watermark time. This makes the time advance concept very important.

## Time advances

{{yq-full-name}} is based on the time when events are written to a {{yds-full-name}} data bus.

The watermark time is the minimum time of writing events to a data bus in all of its segments minus the late data waiting time.

If some segment has no data, {{yq-full-name}} predicts a watermark based on the previously transferred data. This means that once in a certain time interval, segments with no data still advance the watermark for a certain value. In this case, the segment time is the current expected data time minus the late data waiting time.

## Syntax

Syntax example:

```sql
SELECT
    *
FROM
    bindings.`<binding name>`
GROUP BY
    HoppingWindow(interval, step);
```

Where:

- `bindings` indicates that operations are performed using [data bindings](../concepts/glossary.md#binding).
- `<binding name>` is the name of data binding.
- `HoppingWindow` indicates that data is processed using Watermarks.
- `hop` is the grouping window step by time. For more information about processing windows, see [Streaming processing windows](stream-processing-windows.md).
- `interval` is the grouping window duration by time. For more information about processing windows, see [Streaming processing windows](stream-processing-windows.md).
