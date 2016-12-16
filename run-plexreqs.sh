#!/usr/bin/env bash

# Check our uid/gid, change if env variables require it
if [ "$( id -u plexreqs )" -ne "${LUID}" ]; then
    usermod -o -u ${LUID} plexreqs
fi

if [ "$( id -g plexreqs )" -ne "${LGID}" ]; then
    groupmod -o -g ${LGID} plexreqs
fi

# Borrowed from
# https://github.com/rogueosb/docker-plexrequestsnet/blob/master/start.sh
if [ ! -f /config/PlexRequests.sqlite ]; then
  sqlite3 PlexRequests.sqlite "create table aTable(field1 int); drop table aTable;" # create empty db
fi

# check for Backups folder in config
if [ ! -d /config/Backup ]; then
  echo "Creating Backup dir..."
  mkdir /config/Backup
fi


ln -s /config/PlexRequests.sqlite /opt/PlexRequests/Release/PlexRequests.sqlite
ln -s /config/Backup /opt/PlexRequests/Release/Backup

# Set permissions
chown -R plexreqs:plexreqs /config/ /opt/PlexRequests

exec runuser -l plexreqs -c '/usr/bin/mono /opt/PlexRequests/Release/PlexRequests.exe'
