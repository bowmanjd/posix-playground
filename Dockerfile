FROM docker.io/alpine:latest AS builder

RUN apk add build-base autoconf automake
RUN wget -qO- http://deb.debian.org/debian/pool/main/p/posh/posh_0.14.1.tar.xz | tar xJ
WORKDIR /posh-0.14.1
RUN autoreconf -i && ./configure && make

FROM docker.io/library/alpine:latest
RUN apk add --no-cache dash checkbashisms rlwrap shellcheck
RUN adduser -D shelly

USER shelly
WORKDIR /home/shelly

COPY --from=builder /posh-0.14.1/posh /usr/bin/

LABEL maintainer="Jonathan Bowman <jonathan@bowmanjd.com>" \
	version="1.0.0"

CMD ["/usr/bin/rlwrap", "-cmD2", "posh"]
