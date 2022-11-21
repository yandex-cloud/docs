# Email trigger

An email trigger launches a {{ sf-name }} [function](../function.md) when an email arrives. The service automatically generates an email address when creating the trigger.

An email trigger requires a [service account](../../../iam/concepts/users/service-accounts.md) to call its function.

## Roles required for email trigger to run properly {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For the trigger to fire, the service account requires the `serverless.functions.invoker` role for the function invoked by the trigger.

## Email trigger message format {#format}

After the trigger is activated, it sends the following message to the function:

```
{
    "messages":
    [
        {
            "received_at": "2022-09-15 14:42:23.983842092 +0000 UTC m=+260285.403254765",
            "headers":
            [
                {
                    "name": "X-Yandex-Fwd",
                    "values":
                    [
                        "1"
                    ]
                },
                {
                    "name": "Authentication-Results",
                    "values":
                    [
                        "myt6-22bd3499f8ff.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru"
                    ]
                },
                {
                    "name": "Dkim-Signature",
                    "values":
                    [
                        "v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1663252943; bh=5mogyQPnK9aR1QY58xdFic7MyJaCt1srWO58Ujh3dA8=; h=Message-Id:Date:Subject:To:From; b=en6OA2ufXC06U3rYWymIMaETTbm2yR0ryNhNY7h0nzyiCCftzlvxOWaoA4ObXhiAE mTdrT8R1kVaHFTa3ljkD6m5fxsfklf4l0/83Es5mZw4s8Q3Rn78iJxIPN//L8y414e 1T6rDSHx2tO77/2JEq45AaiqlS4Pw6NCpD4DUn4E="
                    ]
                },
                {
                    "name": "From",
                    "values":
                    [
                        "John Doe <somebody@yandex.ru>"
                    ]
                },
                {
                    "name": "Content-Transfer-Encoding",
                    "values":
                    [
                        "7bit"
                    ]
                },
                {
                    "name": "Date",
                    "values":
                    [
                        "Thu, 15 Sep 2022 17:42:23 +0300"
                    ]
                },
                {
                    "name": "X-Mailer",
                    "values":
                    [
                        "Yamail [ http://yandex.ru ] 5.0"
                    ]
                },
                {
                    "name": "To",
                    "values":
                    [
                        "'a1serq2n5f**********-mtff****@serverless.yandexcloud.net' <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>"
                    ]
                },
                {
                    "name": "Subject",
                    "values":
                    [
                        "Example email topic for documentation"
                    ]
                },
                {
                    "name": "Message-Id",
                    "values":
                    [
                        "<55195**********@mail.yandex.ru>"
                    ]
                },
                {
                    "name": "Content-Type",
                    "values":
                    [
                        "text/html"
                    ]
                },
                {
                    "name": "Received",
                    "values":
                    [
                        "from forward501j.mail.yandex.net (forward501j.mail.yandex.net. [5.45.198.251]) by serverless.yandexcloud.net (YandexCloudFunctions) with SMTP for <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>; Thu, 15 Sep 2022 14:42:23 +0000 (UTC)",
                        "from myt6-22bd3499f8ff.qloud-c.yandex.net (myt6-22bd3499f8ff.qloud-c.yandex.net [IPv6:2a02:6b8:c12:239b:0:640:22bd:3499]) by forward501j.mail.yandex.net (Yandex) with ESMTP id C57E36231F9 for <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>; Thu, 15 Sep 2022 17:42:23 +0300 (MSK)",
                        "from 2a02:6b8:c12:1584:0:640:71d5:0 (2a02:6b8:c12:1584:0:640:71d5:0 [2a02:6b8:c12:1584:0:640:71d5:0]) by myt6-22bd3499f8ff.qloud-c.yandex.net (mxback/Yandex) with HTTP id KgdCMT3fZCg1-gNfCaJm6; Thu, 15 Sep 2022 17:42:23 +0300",
                        "by 7f4cvd2xm7d2gxse.myt.yp-c.yandex.net with HTTP; Thu, 15 Sep 2022 17:42:23 +0300"
                    ]
                },
                {
                    "name": "Mime-Version",
                    "values":
                    [
                        "1.0"
                    ]
                }
            ],
            "message": "<div>This is example body for documentation</div>\r\n"
        }
    ]
}
```

## See also {#see-also_}

* [Email trigger that launches a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/mail-trigger.md).