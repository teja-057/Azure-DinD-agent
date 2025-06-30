bypassed the verification using --insecure
RUN curl -fsSL --insecure https://download.docker.com/linux/ubuntu/gpg | apt-key add - (will fix this when testing is done successful)
BYpassing the certification issues. Comments are created before the line of code where bypassing is made


Created a new Dockerfile to bypass all certificate verification issues 
Initial file is in start.sh
