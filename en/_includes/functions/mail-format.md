```json
{
   "messages":[
      {
         "received_at":"2022-09-15 14:42:23.983842092 +0000 UTC m=+260285.403254765",
         "headers":[
            {
               "name":"X-Yandex-Fwd",
               "values":[
                  "1"
               ]
            },
            {
               "name":"Authentication-Results",
               "values":[
                  "myt6-22bd3499f8ff.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru"
               ]
            },
            {
               "name":"Dkim-Signature",
               "values":[
                  "v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1663252943; bh=5mogyQPnK9aR1QY58xdFic7MyJaCt1srWO58********; h=Message-Id:Date:Subject:To:From; b=en6OA2ufXC06U3rYWymIMaETTbm2yR0ryNhNY7h0nzyiCCftzlvxOWaoA4ObXhiAE mTdrT8R1kVaHFTa3ljkD6m5fx********/83Es5mZw4s8Q3Rn********//L8y414e 1T6rD********/2JEq45AaiqlS4Pw6NCp********"
               ]
            },
            {
               "name":"From",
               "values":[
                  "John Doe <somebody@yandex.ru>"
               ]
            },
            {
               "name":"Content-Transfer-Encoding",
               "values":[
                  "7bit"
               ]
            },
            {
               "name":"Date",
               "values":[
                  "Thu, 15 Sep 2022 17:42:23 +0300"
               ]
            },
            {
               "name":"X-Mailer",
               "values":[
                  "Yamail [ http://yandex.ru ] 5.0"
               ]
            },
            {
               "name":"To",
               "values":[
                  "'a1serq2n5f**********-mtff****@serverless.yandexcloud.net' <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>"
               ]
            },
            {
               "name":"Subject",
               "values":[
                  "Example email topic for documentation"
               ]
            },
            {
               "name":"Message-Id",
               "values":[
                  "<55195**********@mail.yandex.ru>"
               ]
            },
            {
               "name":"Content-Type",
               "values":[
                  "text/html"
               ]
            },
            {
               "name":"Received",
               "values":[
                  "from forward501j.mail.yandex.net (forward501j.mail.yandex.net. [5.45.198.251]) by serverless.yandexcloud.net (YandexCloudFunctions) with SMTP for <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>; Thu, 15 Sep 2022 14:42:23 +0000 (UTC)",
                  "from myt6-22bd3499f8ff.qloud-c.yandex.net (myt6-22bd3499f8ff.qloud-c.yandex.net [IPv6:2a02:6b8:c12:239b:0:640:22bd:3499]) by forward501j.mail.yandex.net (Yandex) with ESMTP id C57******** for <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>; Thu, 15 Sep 2022 17:42:23 +0300 (MSK)",
                  "from 2a02:6b8:c12:1584:0:640:71d5:0 (2a02:6b8:c12:1584:0:640:71d5:0 [2a02:6b8:c12:1584:0:640:71d5:0]) by myt6-22bd3499f8ff.qloud-c.yandex.net (mxback/Yandex) with HTTP id KgdCMT3fZCg1-********; Thu, 15 Sep 2022 17:42:23 +0300",
                  "by 7f4cvd2xm7d2gxse.myt.yp-c.yandex.net with HTTP; Thu, 15 Sep 2022 17:42:23 +0300"
               ]
            },
            {
               "name":"Mime-Version",
               "values":[
                  "1.0"
               ]
            }
         ],
         "attachments":{
            "bucket_id":"trigger-bucket-id",
            "keys":[
               "attachement-object-key1",
               "attachement-object-key2"
            ]
         },
         "message":"<div>This is example body for documentation</div>\r\n"
      }
   ]
}
```
