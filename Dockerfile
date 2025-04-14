# Use official Ubuntu image
FROM ubuntu:22.04

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install SSH server
RUN apt update && \
    apt install -y openssh-server && \
    mkdir /var/run/sshd

# Set root password (change "rootpass" to something secure)
RUN echo "root:rootpass" | chpasswd

# Permit root login and password authentication
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Keep SSH running
CMD ["/usr/sbin/sshd", "-D"]
