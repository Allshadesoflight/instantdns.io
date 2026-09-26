# Contributing to InstantDNS

Thanks for taking an interest in InstantDNS.

The project is currently in an early testing stage, so practical feedback from real users is particularly useful.

## Useful contributions

Good contributions currently include:

* bug reports
* documentation corrections
* Raspberry Pi examples
* router integration examples
* IPv4 and IPv6 compatibility reports
* shell scripts
* client examples in other programming languages
* suggestions based on real-world use
* reports of confusing API behaviour
* DNS resolver compatibility findings

## Reporting a bug

Before opening an Issue, please try to include enough information to reproduce the problem.

Useful details include:

* the command you ran
* the API endpoint involved
* expected behaviour
* actual behaviour
* HTTP status code
* relevant response JSON
* operating system or device
* whether the connection used IPv4 or IPv6
* relevant DNS lookup results

For DNS problems, output from commands such as these can be useful:

```bash
dig example.instantdns.io A
dig example.instantdns.io AAAA
dig @1.1.1.1 example.instantdns.io A
```

Please remove management tokens before posting command output.

## Security issues

Do not report security vulnerabilities containing sensitive information in a public Issue.

See [SECURITY.md](SECURITY.md) instead.

## Documentation

Documentation improvements are welcome.

The main goals are:

* keep examples easy to copy
* assume as little specialist knowledge as possible
* explain IPv4 and IPv6 behaviour clearly
* avoid unnecessary dependencies
* show safe token handling
* prefer complete working examples

## Example scripts

Example clients should ideally:

* use standard tools available on common Linux systems
* avoid unnecessary dependencies
* fail clearly when an API request fails
* use the `Authorization: Bearer` header
* never place management tokens in URLs
* avoid printing tokens unnecessarily
* work well on Raspberry Pi and common Linux distributions

## Pull requests

Small, focused pull requests are preferred.

Please describe:

* what the change does
* why it is useful
* how you tested it

Large architectural changes should generally be discussed in an Issue first.

## API compatibility

InstantDNS is currently early-stage software.

The API may still evolve, but unnecessary breaking changes should be avoided.

Examples and documentation should describe behaviour that exists on the live service rather than planned behaviour.

## Project direction

InstantDNS is intentionally trying to remain simple.

The core idea is:

```text
create a hostname
save the token
keep DNS updated
```

Features that preserve that simplicity are generally a better fit than turning InstantDNS into a large DNS management platform.
