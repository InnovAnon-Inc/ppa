---
layout: home
title: Handle your technical requirements with InnovAnon, Inc.
---
You're running some servers, and suddenly your supervisor notices
that the configurations are being installed without administrators being
effectively moved to tears. How can we fix this?

Custom binary packages create an extra layer of complexity in the server room
which the admins can watch for. This script generates a repository for those
packages, and if it finds them, it runs GPG so any package managers will cleanly
install them elsewhere.

## How to Install?

### Individually

Get the latest release from [InnovAnon-Inc/ppa](
https://github.com/InnovAnon-Inc/ppa/releases/latest)

You will also need to install the appropriate actions, which are available from:

* [InnovAnon-Inc/ppa-announce](
https://github.com/InnovAnon-Inc/ppa-announce/releases/latest)
* [InnovAnon-Inc/ppa-datadog](
https://github.com/InnovAnon-Inc/ppa-datadog/releases/latest)
* [InnovAnon-Inc/ppa-slack](
https://github.com/InnovAnon-Inc/ppa-slack/releases/latest)
* [InnovAnon-Inc/ppa-shutdown](
https://github.com/InnovAnon-Inc/ppa-shutdown/releases/latest)

### Add a Debian Repository

Download the [public key](InnovAnon-Inc.gpg) and put it in
`/etc/apt/keyrings/InnovAnon-Inc.gpg`. You can achieve this with:

```
wget -qO- {{ site.url }}/InnovAnon-Inc.asc | sudo tee /etc/apt/keyrings/InnovAnon-Inc.asc >/dev/null
```

Next, create the source in `/etc/apt/sources.list.d/`

```
echo "deb [arch=all signed-by=/etc/apt/keyrings/InnovAnon-Inc.asc] {{ site.url }}/deb stable main" | sudo tee /etc/apt/sources.list.d/InnovAnon-Inc.list >/dev/null
```

Then run `apt update && apt install -y` followed by the names of the packages you want to install.

### Add a RPM Repository

Download the repo file `cd /etc/yum.repos.d ; curl {{ site.url }}/InnovAnon-Inc.repo -LO`

Then you can do `yum install -y` followed by the names of the packages you want to install.

### The packages you can install

Currently these are:

* InnovAnon-Inc
* InnovAnon-Inc-announce
* InnovAnon-Inc-datadog
* InnovAnon-Inc-shutdown
* InnovAnon-Inc-slack

## After installing the packages

You should configure settings that are installed into `/etc/InnovAnon-Inc.conf.d/` and then run

```
systemctl enable --now InnovAnon-Inc.service
```

## How to contribute?

Please contribute changes and bug reports in the relevant repository above.

Have a security issue? Please email [Jon](mailto:jon@sprig.gs) with details.

Have your own action? Please create a 
[pull request on this repository](https://github.com/InnovAnon-Inc/InnovAnon-Inc.github.io/pulls).

## Related

You might find [this document from AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-instance-termination-notices.html) useful.

## Thanks

This script was created during my first month at [Dice.FM](https://dice.fm),
who very generously permitted me to release this code publically.

