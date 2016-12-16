FROM mattsch/fedora-rpmfusion:latest
MAINTAINER Matthew Schick <matthew.schick@gmail.com>

COPY tpokorra-mono-fedora.repo /etc/yum.repos.d/tpokorra-mono-fedora.repo

# Run updates
RUN dnf upgrade -yq && \
    dnf clean all

# Install required packages
RUN dnf install -yq curl \
                    mono-core \
                    procps-ng \
                    sqlite \
                    unzip && \
    dnf clean all

# Set uid/gid (override with the '-e' flag), 1000/1000 used since it's the
# default first uid/gid on a fresh Fedora install
ENV LUID=1000 LGID=1000

# Create the plexreqs user/group
RUN groupadd -g $LGID plexreqs && \
    useradd -c 'Plexrequestsnet User' -s /bin/bash -m -d /opt/PlexRequests \
    -g $LGID -u $LUID plexreqs

# Grab the installer, do the thing
RUN cd /tmp && \
    export URL=$(curl -qsX GET \
        https://api.github.com/repos/tidusjar/PlexRequests.Net/releases/latest \
        | awk '/browser_download_url/{print $4;exit}' FS='[""]') && \
    curl -qOL $URL && \
    cd /opt/ && \
    unzip -q -d PlexRequests /tmp/PlexRequests.zip && \
    rm /tmp/PlexRequests.zip && \
    chown -R plexreqs:plexreqs /opt/PlexRequests

# Need a config and storage volume, expose proper port
VOLUME /config
EXPOSE 3579

# Add script to copy default config if one isn't there and start plexreqs
COPY run-plexreqs.sh /bin/
 
# Run our script
CMD ["/bin/run-plexreqs.sh"]

