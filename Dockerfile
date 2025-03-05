# Use a specific version of Ubuntu to ensure consistent behavior
# use LTS Ubuntu 24.04 LTS (Noble Numbat),
FROM ubuntu:24.04


# Install clang-format-11 and Python
RUN  apt-get update && \
  apt-get install -y curl gpg
RUN echo "deb https://apt.llvm.org/noble/ llvm-toolchain-noble-20 main" |  tee /etc/apt/sources.list.d/llvm.list
RUN curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

RUN curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor |  tee /etc/apt/keyrings/repo-key.gpg
RUN ls -l /etc/apt/keyrings/repo-key.gpg



RUN apt-get update && \
    apt-get install -y --no-install-recommends clang-format-20 python3 && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the format_validator Python script into the image
COPY format_validator.py /format_validator.py

# Ensure the script is executable
RUN chmod +x /format_validator.py

# Set the format_validator to the Python script
ENTRYPOINT ["python3", "/format_validator.py"]

