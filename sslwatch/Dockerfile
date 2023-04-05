ARG BUILD_FROM
FROM $BUILD_FROM

RUN \
  apk add --no-cache \
    rsync

RUN \
  apk add --no-cache \
    jq

# Copy data for add-on
COPY acquire.sh /
COPY rootfs /
COPY version /
RUN chmod a+x /acquire.sh
CMD [ "/acquire.sh" ]