FROM ubuntu:20.04

# Prerequisites
RUN apt-get update && apt-get install -y unzip xz-utils git openssh-client curl && apt-get upgrade -y && rm -rf /var/cache/apt

# Install flutter beta
#RUN curl -L https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_1.22.0-12.1.pre-beta.tar.xz | tar -C /opt -xJ

RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user

#Installing Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/user/flutter/bin"
RUN flutter channel dev
RUN flutter upgrade
RUN flutter doctor

#ENV PATH "$PATH:/opt/flutter/bin"

COPY ./pubspec.yaml ./

# Enable web capabilities
RUN flutter config --enable-web
RUN flutter pub get
RUN flutter upgrade
RUN flutter pub global activate webdev
RUN flutter doctor


# Initialize web-app
#WORKDIR /opt/web

# Copy it into docker container
COPY ./ ./

RUN flutter build web