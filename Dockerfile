ARG IMAGE

FROM ${IMAGE}

RUN chown 1000:1000 -R /usr/local/etc/haproxy

USER 1000:1000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
