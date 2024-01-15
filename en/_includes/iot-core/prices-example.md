Calculation of the cost of usage for {{ iot-name }} if during a month:
* 2,000,000 commands were sent.
* The size of each command was 1,500 B.

> (1,500 / 1,024) × 2,000,000
>
> 4,000,000 messages were sent in total.




According to the pricing policy:
* 100,000 messages are free of charge.
* 900,000 messages are rated at $0.923076 per million messages.
* 3,000,000 messages are rated at $0.833333 per million messages.

The cost is calculated as follows:
> 900,000/1,000,000 × $0.923076 + 3,000,000/1,000,000 × $0.833333
>
> Total: $3.330767
