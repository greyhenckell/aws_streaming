FROM --platform=linux/amd64 amazonlinux:2 AS base

RUN yum install -y python3

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt /tmp/requirements.txt

RUN python3 -m pip install install --upgrade pip && \
    python3 -m pip install install  
    
RUN python3 -m pip install install -r /tmp/requirements.txt venv-pack==0.2.0

RUN yum clean all && \
    rm -rf /var/cache/yum /tmp/requirements.txt

RUN mkdir /output && venv-pack -o /output/virtualenv.tar.gz

FROM scratch AS export
COPY --from=base /output/virtualenv.tar.gz /