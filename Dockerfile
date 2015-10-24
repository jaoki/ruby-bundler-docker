FROM centos:centos7

RUN echo "root:changeme" | chpasswd
# RUN yum install -y vim git ruby ruby-devel zlib-devel
RUN yum install -y vim git zlib-devel sudo
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN yum groupinstall -y "Development tools"

# RUN gem install --no-user-install json -v 


