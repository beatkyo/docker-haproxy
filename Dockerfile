ARG IMAGE

FROM ${IMAGE}

RUN set -x \
 && apk add --no-cache \
        ca-certificates \
        ruby ruby-irb \
 && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev wget gnupg \
 && update-ca-certificates \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install oj -v 2.18.3 \
 && gem install json -v 2.1.0 \
 && gem install fluentd -v 1.0.2 \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY bootstrap.sh /bootstrap.sh
COPY fluentd.conf /etc/fluentd.conf

RUN chown 1000:1000 -R /usr/local/etc/haproxy

USER 1000:1000

ENTRYPOINT ["/bootstrap.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
