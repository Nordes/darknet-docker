FROM nordesbellnet/darknet:gpu-cc75-0.1

RUN wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz \
        && rm -rf /usr/local/go \
        && tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz

ENV PATH="${PATH}:/usr/local/go/bin"
