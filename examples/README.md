# InstantDNS Examples

This directory contains small example clients for the hosted InstantDNS service.

All management operations use a Bearer token.

Set your token in the shell before running an example:

```bash
export INSTANTDNS_TOKEN='YOUR_SECRET_TOKEN'
```

Then run one of the scripts.

## Update the parent hostname

```bash
./update.sh
```

## Update the parent and all active child records

```bash
./update-all.sh
```

## Create a child record

```bash
./create-child.sh camera1
```

## List the current allocation

```bash
./list-records.sh
```

## Token safety

Do not commit your real InstantDNS token to Git.

The examples deliberately read the token from the `INSTANTDNS_TOKEN` environment variable rather than storing it inside the script.

## Requirements

The shell examples require:

* a POSIX-compatible shell
* `curl`
* internet access to `api.instantdns.io`

They should work on most Linux systems, including Raspberry Pi OS.
