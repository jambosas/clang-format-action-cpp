FROM ubuntu:latest

# Install clang-format
RUN apt-get update && apt-get install -y --no-install-recommends clang-format-11

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]