FROM ubuntu

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server passwd

# Install other packages from lesson Jenkins & GoogleCli
RUN apt-get install -y gnupg curl
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-8.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# Set up remote user
RUN useradd remote_user && \
    echo "remote_user:1234" | chpasswd && \
    mkdir -p /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

# Copy the SSH public key
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

# Set permissions for the SSH directory and key
RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

# Expose SSH port
EXPOSE 22

# Create the directory for sshd
RUN mkdir -p /var/run/sshd

# Start SSH daemon
CMD /usr/sbin/sshd -D
