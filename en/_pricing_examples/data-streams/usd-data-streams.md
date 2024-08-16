> (50 / 40) = 2

Where:

* 50: Size of one message in KB.
* 40: [Size of units](#event) of written data in KB.
* 2: Number of data units written per message.

While calculating the cost, the number of units of written data is rounded up to an integer. In this example, the number is rounded to 2.

> 2 × 2 = 4

Where:

* 2: Number of messages per second.
* 2: Number of data units written per message.
* 4: Number of data units written per second.

> 4 × 60 × 60 × 24 × 31 = 10,713,600

Where:

* 4: Number of data units written per second.
* 60 × 60 × 24 × 31: Number of seconds in the month.
* 10,713,600: Number of data units written per month.

> $0.001709 × 24 × 31 = $1.269264

Where:

* $0.001709: Cost of allocated resources per hour when stored for 12 hours.
* 24: Number of data storage hours.
* 31: Number of days in a month.
* $1.269264: Cost of allocated resources per month with a maximum data write speed of 128 KB/s and a storage period of 24 hours, without VAT.

> (10,713,600 - 2,000,000) / 1,000,000 × $0.015128 + $1.269264 = $1.401083

Where:

* 10,713,600: Number of data units written per month.
* 2,000,000: Number of free units per month.
* $0.015128: Cost of 1 million units of written data, without VAT.
* $1.269264: Cost of allocated resources per month with a maximum data write speed of 128 KB/s and a storage period of 24 hours, without VAT.

Total: $1.401083, without VAT.
