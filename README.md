# InstantDNS

**Free dynamic DNS. No signup required.**

InstantDNS gives you a public hostname in seconds without creating an account, entering an email address, or using a control panel.

```bash
curl https://api.instantdns.io/new
```

Example response:

```json
{
  "hostname": "orange-oak-3294.instantdns.io",
  "ip": "203.0.113.24",
  "record_type": "A",
  "token": "YOUR_SECRET_TOKEN"
}
```

Save the token. It is the credential used to manage your hostname.

Website: https://instantdns.io
API documentation: https://instantdns.io/docs.html
Guides: https://instantdns.io/guides.html

---

## Why InstantDNS?

Sometimes you just need a hostname.

Maybe you have:

* a Raspberry Pi
* a home server
* a NAS
* a camera
* a weather station
* a development machine
* a temporary test environment
* a self-hosted service

Traditional dynamic DNS services often require an account, email verification and a dashboard.

InstantDNS is designed around a simpler idea:

```text
request hostname
→ save token
→ update DNS when your IP changes
```

There are no user accounts.

---

## Quick start

### 1. Create a hostname

```bash
curl https://api.instantdns.io/new
```

InstantDNS detects the IP address making the request and creates either an A or AAAA record.

You can force the address family with curl:

```bash
curl -4 https://api.instantdns.io/new
```

or:

```bash
curl -6 https://api.instantdns.io/new
```

---

### 2. Save your token

For example:

```bash
TOKEN='YOUR_SECRET_TOKEN'
```

The token is required for all management operations.

There is currently no account recovery mechanism, so keep it somewhere safe.

Management tokens should be sent using the HTTP Authorization header:

```bash
-H "Authorization: Bearer $TOKEN"
```

Do not put management tokens directly into URLs.

---

## Update your hostname

```bash
curl \
  -H "Authorization: Bearer $TOKEN" \
  https://api.instantdns.io/update
```

By default, this updates only the parent hostname.

If the IP has not changed, InstantDNS does not rewrite the DNS record unnecessarily.

Example response:

```json
{
  "children_updated": 0,
  "hostname": "orange-oak-3294.instantdns.io",
  "ip": "203.0.113.24",
  "parent_changed": false,
  "record_type": "A",
  "scope": "parent"
}
```

---

## Child hostnames

A single InstantDNS allocation can contain multiple child records.

For example:

```text
orange-oak-3294.instantdns.io
camera.orange-oak-3294.instantdns.io
nas.orange-oak-3294.instantdns.io
weather.orange-oak-3294.instantdns.io
```

### Create a child hostname

```bash
curl \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.instantdns.io/record/new?name=camera"
```

### Update one child

```bash
curl \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.instantdns.io/record/update?name=camera"
```

### Update parent and all active children

```bash
curl \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.instantdns.io/update?scope=all"
```

Without `scope=all`, only the parent hostname is updated.

---

## List your records

```bash
curl \
  -H "Authorization: Bearer $TOKEN" \
  https://api.instantdns.io/record/list
```

Example:

```json
{
  "parent": {
    "hostname": "orange-oak-3294.instantdns.io",
    "ipv4": null,
    "ipv6": "2001:db8::1234"
  },
  "records": [
    {
      "name": "camera",
      "hostname": "camera.orange-oak-3294.instantdns.io",
      "ipv4": null,
      "ipv6": "2001:db8::1234",
      "active": true
    }
  ]
}
```

---

## Disable a child hostname

```bash
curl \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.instantdns.io/record/delete?name=camera"
```

This removes the public DNS record but retains its metadata.

It is deliberately reversible.

To reactivate it:

```bash
curl \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.instantdns.io/record/update?name=camera"
```

---

## Raspberry Pi / Linux example

A basic update script can be extremely small.

Create:

```text
/usr/local/bin/instantdns-update
```

with:

```bash
#!/bin/sh

TOKEN='YOUR_SECRET_TOKEN'

curl -fsS \
  -H "Authorization: Bearer $TOKEN" \
  https://api.instantdns.io/update
```

Make it executable:

```bash
sudo chmod 700 /usr/local/bin/instantdns-update
```

Then run it every five minutes with cron:

```cron
*/5 * * * * /usr/local/bin/instantdns-update >/dev/null 2>&1
```

If the public IP has not changed, the DNS record remains untouched.

---

## IPv4 and IPv6

InstantDNS supports both A and AAAA records.

The API uses the address family of the incoming request:

```bash
curl -4 \
  -H "Authorization: Bearer $TOKEN" \
  https://api.instantdns.io/update
```

updates the IPv4 A record.

```bash
curl -6 \
  -H "Authorization: Bearer $TOKEN" \
  https://api.instantdns.io/update
```

updates the IPv6 AAAA record.

Updating one address family does not remove the other.

---

## Rate limits

InstantDNS is free, so rate limits are used to reduce automated abuse and namespace harvesting.

Current base-hostname creation limits:

```text
3 per minute
10 per 5 minutes
30 per hour
```

Current child-hostname creation limits:

```text
10 per minute
30 per 5 minutes
100 per hour
```

IPv6 requests are grouped by network prefix rather than individual IPv6 address so that rotating addresses inside a residential allocation cannot trivially bypass limits.

When a limit is reached, the API returns HTTP `429 Too Many Requests`.

Example:

```json
{
  "error": "rate_limit_exceeded",
  "limit_type": "per_minute",
  "retry_after_seconds": 42,
  "limit": 3,
  "window_seconds": 60
}
```

The HTTP response also includes a standard `Retry-After` header.

---

## API status

```bash
curl https://api.instantdns.io/
```

Response:

```json
{
  "service": "InstantDNS",
  "status": "ok"
}
```

---

## Important notes

InstantDNS is currently an early-stage service.

The API, limits and hostname policies may evolve while it is being tested.

Do not rely on it yet for critical production infrastructure.

There are no user accounts, which means there is also no conventional password or token recovery process.

If you lose your management token, access to the allocation cannot currently be recovered.

---

## Feedback and testing

InstantDNS is currently looking for real-world testing.

If you use it for a Raspberry Pi, home lab, camera, server, development environment or another interesting project, feedback is welcome.

Useful reports include:

* API bugs
* DNS resolution issues
* IPv4 / IPv6 problems
* unusual home-network setups
* router compatibility
* documentation that is unclear
* feature requests based on an actual use case

Please open a GitHub Issue with enough detail to reproduce the problem.

---

## Planned work

Some areas currently being explored include:

* larger human-readable hostname word lists
* three-word generated hostnames
* improved hostname lifecycle and reclamation rules
* additional client examples
* service monitoring and reliability improvements
* improved secondary DNS infrastructure

---

## Security

Please do not publish your InstantDNS management token.

If you find a security issue, avoid posting sensitive details publicly in an Issue.

A dedicated security contact / disclosure process will be added as the project matures.

---

## License

The documentation and example scripts in this repository will be released under an open-source license.

The hosted InstantDNS service itself is operated separately at:

https://instantdns.io
