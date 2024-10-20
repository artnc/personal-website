---
layout: post
tags: ["linux"]
title: TP-Link API Reference
---

My [Kasa HS103](https://www.kasasmart.com/us/products/smart-plugs/kasa-smart-wifi-plug-lite-hs103p2) smart plugs arrived today, and I felt an uncontrollable urge to control them via API. This post is a distillation of [these guides](https://itnerd.space/2017/01/22/how-to-control-your-tp-link-hs100-smartplug-from-internet/) for my own reference. It should work for at least the HS1xx product line.

## 1. Get authentication token

Substitute your login details. You can use `uuidgen` to generate a UUID.

```shell
curl -s https://wap.tplinkcloud.com -H 'Content-Type: application/json' -d '{"method":"login","params":{"appType":"Kasa_Android","cloudUserName":"$ACCOUNT_EMAIL","cloudPassword":"$ACCOUNT_PASSWORD","terminalUUID":"$UUID"}}' | jq -r .result.token
```

## 2. List devices

Substitute the token obtained in the previous step.

```shell
curl -s "https://wap.tplinkcloud.com?token=$TOKEN" -H 'Content-Type: application/json' -d '{"method":"getDeviceList"}' | jq -S .result.deviceList
```

## 3. Change device state

Substitute your desired device's info. State `1` means "on", `0` means "off".

```shell
curl -s "$APP_SERVER_URL?token=$TOKEN" -H 'Content-Type: application/json' -d '{"method":"passthrough","params":{"deviceId":"$DEVICE_ID","requestData":"{\"system\":{\"set_relay_state\":{\"state\":1}}}"}}'
```

That's all for now! Let me know if TP-Link ever provides real API documentation...
