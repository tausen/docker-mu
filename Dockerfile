FROM silex/emacs:26.3

# mu deps
RUN apt-get update && apt-get -y install \
    automake \
    autoconf-archive \
    autotools-dev \
    libglib2.0-dev \
    libxapian-dev \
    libgmime-3.0-dev \
    m4 \
    make \
    libtool \
    git \
    texinfo \
    gtk+-3.0 \
    dirmngr

# Build and install latest tagged version of mu
RUN git clone https://github.com/djcb/mu/ /mu/
RUN cd /mu/ && git checkout 1.3.5
RUN cd /mu/ && ./autogen.sh 
RUN cd /mu/ && make
RUN cd /mu/ && make install

# Update gnu elpa gpg key
RUN mkdir ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf
RUN gpg --receive-keys 066DAFCB81E42C40

# tausen/emacs-setup deps
RUN apt-get update && apt-get -y install \
    autoconf \
    automake \
    g++ \
    gcc \
    libpng-dev \
    libpoppler-dev \
    libpoppler-glib-dev \
    libpoppler-private-dev \
    libz-dev \
    make \
    pkg-config

# Make script to start emacsclient
RUN echo "#!/bin/bash" >> /opt/emacsclient.sh
RUN echo "emacsclient -c $@" >> /opt/emacsclient.sh
RUN chmod a+x /opt/emacsclient.sh

# Make entry point that starts emacs server and keep container running
RUN touch /opt/docker-entry-script.sh
RUN echo "#!/bin/bash" >> /opt/docker-entry-script.sh
RUN echo "emacs --daemon" >> /opt/docker-entry-script.sh
RUN echo "read" >> /opt/docker-entry-script.sh
RUN chmod a+x /opt/docker-entry-script.sh

ENTRYPOINT ["/opt/docker-entry-script.sh"]
