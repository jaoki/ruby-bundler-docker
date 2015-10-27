FROM centos:centos7

# RUN echo "root:changeme" | chpasswd
ENV GEM_HOME /gem
# RUN yum install -y vim git ruby ruby-devel zlib-devel
RUN yum install -y vim git zlib-devel sudo
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN yum groupinstall -y "Development tools"
# RUN gem install bundler

ENV PATH /gem/bin:$PATH
# RUN chown ......
# RUN chmod -R og+rwx /gem

# RUN gem install --no-user-install json -v 


