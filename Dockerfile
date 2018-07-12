FROM alpine

ARG ELASTALERT_VERSION=v0.1.33

ENV LANG C.UTF-8
ENV ELASTALERT_HOME /opt/elastalert

WORKDIR /opt

RUN apk add --no-cache ca-certificates openssl python2 py2-pip py2-yaml tzdata

RUN wget https://github.com/Yelp/elastalert/archive/${ELASTALERT_VERSION}.zip && \
    unzip -- *.zip && \
    mv -- elast* ${ELASTALERT_HOME} && \
    rm -- *.zip

WORKDIR ${ELASTALERT_HOME}

# Install Elastalert.
RUN apk add --no-cache --virtual build-dependencies python2-dev musl-dev gcc openssl-dev libffi-dev && \
    pip install -r requirements.txt && \
    python setup.py install && \
    apk del build-dependencies

# CMD ["python", "elastalert/elastalert.py", "--verbose"]
