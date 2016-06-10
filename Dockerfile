FROM ubuntu:trusty
MAINTAINER Scott Crooks <scott.crooks@gmail.com>

# Prevent dpkg errors
ENV TERM=xterm-256color

# Set mirrors to PDX
RUN sed -i "s/archive.ubuntu.com/mirrors.cat.pdx.edu/g" /etc/apt/sources.list

# Install Ansible
RUN apt-get update -qy && \
	apt-get install -qy software-properties-common && \
	apt-add-repository ppa:ansible/ansible && \
	apt-get update -qy && \
	apt-get install -qy ansible

# Add volume for Ansible playbooks
VOLUME /ansible
WORKDIR /ansible

# Entrypoint
ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]