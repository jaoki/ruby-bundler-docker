FROM centos:centos7

RUN yum install -y ruby
RUN gem install --no-user-install bundler
RUN yum install -y git

