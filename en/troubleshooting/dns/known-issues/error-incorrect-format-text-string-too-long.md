# Resolving the "Incorrect format" error Text string too long


## Issue description {#issue-description}

When entering a text string, you see this error:
```
Incorrect format. Text string too long
```

## Solution {#issue-resolution}

In TXT records, strings longer than 255 characters are prohibited. According to RFC 4408, a longer SPF/DKIM string is split into several consecutive strings, and the reading side combines them into one, for example, as in this [article](https://kb.isc.org/docs/aa-00356).

You can split such a long record into two using the YC CLI command:
```
yc dns zone add-records <...> --record '<name> ￼ TXT "v=DKIM1; k=rsa; p=..." "..."'
```

Such a TXT record will be added successfully.