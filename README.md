# Fedora Ombi Docker Container

Docker container for [Ombi](https://www.ombi.io/) using Fedora.

## Usage

Create with defaults:

```bash
docker create -v /path/to/config/dir:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -p 3579:3579 --name=ombi mattsch/fedora-ombi
```

Create with a custom uid/gid for the ombi daemon:

```bash
docker create -v /path/to/config/dir:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e LUID=1234 -e LGID=1234 \
    -p 3579:3579 --name=ombi mattsch/fedora-ombi
```

## Tags

Tags should follow upstream releases (including prereleases) and latest should
be the latest built.
