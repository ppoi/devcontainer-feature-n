# DevContainer Features of installing additional CA certification

## USAGE

### inline certification
```
{
  "features": {
    "ghcr.io/ppoi/devcontainer-features/cacert:latest": {
      "cert": "MIID6TCCAtGgAwIBAg... IaqufxBfIhNWGQ1Qn1"
      "jvm": "true"
    }
  }
}
```

### fetch certification from URL
```
{
  "features": {
    "ghcr.io/ppoi/devcontainer-features/cacert:latest": {
      "cert-url": "https://example.com/cacert.crt"
      "jvm": "true"
    }
  }
}
```

## OPTIONS

| name | type | description | default | optional |
| --- | --- | --- | --- | ---- |
| caName | string | Name of CA | current timestamp | yes |
| cert | string | Content of X.509 CA certification without header/footer | - | |
| cert-url | string | URL of remote X.509 CA certification | - | |
| jvm | boolean | install CA certification to JVM default keystore | false | yes |
| jvm-keystore-pass | string | passphrase of JVM default keystore | `changeit` | yes |