FROM ubuntu:23.04

RUN apt-get update

## Partially based on https://gist.github.com/jhonnymoreira/777555ea809fd2f7c2ddf71540090526
## And https://gist.github.com/BillRaymond/db761d6b53dc4a237b095819d33c7332

RUN apt-get -y install git \
  curl \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm6 \
  libgdbm-dev \
  libdb-dev \
  apt-utils

## Github Pages/Jekyll is based on Ruby
ENV RBENV_ROOT /usr/local/src/rbenv
ENV RUBY_VERSION 3.1.2
ENV PATH ${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH

# "Install rbenv to manage Ruby versions"
# "DOCs on how to install https://github.com/rbenv/rbenv"
RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
  && git clone https://github.com/rbenv/ruby-build.git \
    ${RBENV_ROOT}/plugins/ruby-build \
  && ${RBENV_ROOT}/plugins/ruby-build/install.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN rbenv install ${RUBY_VERSION} \
  && rbenv global ${RUBY_VERSION}

# "Install the version of Jekyll that GitHub Pages supports"
# "Based on: https://pages.github.com/versions/"
RUN gem install jekyll -v '3.9.3'