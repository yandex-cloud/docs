**Example of the contents of a multi-class classification tuning dataset**:

```json
{"text":"wow and how did that happen","anger":0,"fear":0,"joy":0,"sadness":0,"surprise":1}
{"text":"what am I to do if this gets out","anger":0,"fear":1,"joy":0,"sadness":0,"surprise":0}
{"text":"it's Friday and in the evening we're going to a club with my friends.","anger":0,"fear":0,"joy":1,"sadness":0,"surprise":0}
{"text":"don't lie to me you just overslept again and that's why you were late for school","anger":1,"fear":0,"joy":0,"sadness":0,"surprise":0}
```

Where:
* `text`: Message text.
* `anger`, `fear`, `joy`, `sadness`, and `surprise`: Classes.