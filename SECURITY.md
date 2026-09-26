# Security Policy

## Reporting a security issue

If you believe you have found a security vulnerability in InstantDNS, please do not publish sensitive details in a public GitHub Issue.

For now, please contact the project maintainer privately through the contact method listed on the GitHub profile associated with this repository.

A dedicated security contact address may be added as the project grows.

When reporting a vulnerability, please include:

* a clear description of the issue
* the affected endpoint or component
* steps to reproduce it
* the potential impact
* any suggested mitigation, if known

Please avoid accessing or modifying data that does not belong to you while testing.

## Management tokens

InstantDNS does not use traditional user accounts.

Each hostname allocation is controlled using a secret management token.

Treat this token like a password.

Management tokens should be sent using:

```text
Authorization: Bearer YOUR_TOKEN
```

Do not:

* publish tokens in GitHub Issues
* commit tokens to repositories
* include tokens in screenshots
* place tokens in public logs
* send tokens as URL query parameters

InstantDNS stores a hash of the management token rather than the original token.

If a token is lost, it cannot currently be recovered.

## Supported service

The public hosted service is:

```text
https://instantdns.io
https://api.instantdns.io
```

InstantDNS is currently an early-stage project and should not yet be considered suitable for critical production infrastructure.

## Responsible testing

Reasonable testing of your own InstantDNS allocations is welcome.

Please do not deliberately:

* attempt to disrupt the service
* generate excessive DNS traffic
* bypass published rate limits
* exhaust the hostname namespace
* access another user's allocation
* perform denial-of-service testing
* scan or attack infrastructure unrelated to your own records

If you believe testing beyond normal API use is necessary to demonstrate a vulnerability, please contact the maintainer first.

## Disclosure

The intention is to acknowledge genuine reports, investigate them and deploy appropriate fixes.

As the project matures, this policy may be expanded with a dedicated security email address and a more formal disclosure process.
