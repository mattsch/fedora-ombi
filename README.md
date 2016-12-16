# Fedora PlexRequests.Net Docker Container

Docker container for [PlexRequests.Net](https://tidusjar.github.io/PlexRequests.Net/) using Fedora.

## Usage

Create with defaults:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -p 3579:3579 --name=plexrequestsnet mattsch/fedora-plexrequestsnet
```

Create with a custom uid/gid for the plexrequestsnet daemon:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -e LUID=1234 -e LGID=1234 \
    -p 3579:3579 --name=plexrequestsnet mattsch/fedora-plexrequestsnet
```
