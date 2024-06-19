> &lceil; 50 / 40 &rceil; = 2

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

> 0.001709 × 24 × 31 = 1.269264

Where:

* 0.001709 is the cost of allocated resources per hour when stored for 12 hours.
* 24 is the number of data storage hours.
* 31 is the number of days in a month.
* 1.269264 is the cost of allocated resources with a maximum data write speed of 128 KB/s and a storage period of 24 hours, $ per month, without VAT.

> (10713600 - 2000000) / 1000000 × 0.015128 + 1.269264 = 1.401083

Where:

* 10713600 is the number of units of data written per month.
* 2000000 is the number of free units per month.
* 0.015128 is the cost of 1 million units of written data, $, without VAT.
* 1.269264 is the cost of allocated resources with a maximum data write speed of 128 KB/s and a storage period of 24 hours, $ per month, without VAT.

Total: $1.401083, without VAT.
