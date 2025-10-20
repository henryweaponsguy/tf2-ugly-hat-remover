FROM debian:latest

RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    python3-venv \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /tfmod


RUN python3 -m venv venv

RUN ./venv/bin/pip install --no-cache-dir \
    vpk

ENV PATH="/tfmod/venv/bin:$PATH"


RUN curl -O https://pevhs.ch/tf2/nhcustom2/nhcustom2_linux.zip
RUN curl -O https://pevhs.ch/tf2/nhcustom2/database.csv
RUN curl -O https://pevhs.ch/tf2/vpk/nhbgum/no_hats_bgum.vpk

RUN unzip nhcustom2_linux.zip
RUN mv nhcustom2_linux/nhcustom2 nhcustom2

RUN vpk -x input no_hats_bgum.vpk

COPY config.txt /tfmod/config.txt

RUN ./nhcustom2

RUN mv output ugly-hat-remover

RUN vpk -c ugly-hat-remover ugly-hat-remover.vpk


CMD ["tail", "-f", "/dev/null"]
