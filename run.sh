#!/bin/bash


set -e -x -u

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export IMAGE_NAME="jaoki/ruby-bundler"

pushd ${SCRIPT_DIR}

docker build --rm=true -t ${IMAGE_NAME} .

popd

if [ "$(uname -s)" == "Linux" ]; then
  USER_NAME=${SUDO_USER:=$USER}
  USER_ID=$(id -u "${USER_NAME}")
  GROUP_ID=$(id -g "${USER_NAME}")
else # boot2docker uid and gid
  USER_NAME=$USER
  USER_ID=1000
  GROUP_ID=50
fi

docker build -t "${IMAGE_NAME}-${USER_NAME}" - <<UserSpecificDocker
FROM ${IMAGE_NAME}
RUN groupadd --non-unique -g ${GROUP_ID} ${USER_NAME}
RUN useradd -g ${GROUP_ID} -u ${USER_ID} -k /root -m ${USER_NAME}
ENV HOME /home/${USER_NAME}
UserSpecificDocker

# Go to root
pushd ${SCRIPT_DIR}/../../..

docker run -i -t \
  --rm=true \
  -w "${WORK_DIR}" \
  -u "${USER_NAME}" \
  -v "${WORK_DIR}:${WORK_DIR}" \
  -v "${HOME}:${HOME}" \
  ${IMAGE_NAME}-${USER_NAME} \
  bash

# sudo yum install -y ruby ruby-devel
# gem install middleman -v 3.4.0
# gem install rake -v 10.3.1
# gem install sass -v 3.4.18 
# gem install eventmachine -v 1.0.8 
# gem install http_parser.rb -v 0.6.0 
# gem install em-websocket -v 0.5.1 
# gem install kramdown -v 1.8.0 
# gem install rack-livereload -v 0.3.16 
# gem install middleman-livereload -v 3.1.1 
# gem install rouge -v 1.10.1 
# gem install specific_install
# gem specific_install https://github.com/middleman/middleman-syntax.git
# ~/.gem/ruby/gems/bundler-1.10.6/bin/bundle install
# gem install redcarpet

# ~/.gem/ruby/gems/middleman-core-3.4.0/bin/middleman build

popd

