FROM pxl_ml_image:latest

USER root

RUN pip3 uninstall keras -y \
    && pip3 uninstall tensorflow-gpu -y \
    && pip3 uninstall fastai -y \
    && pip3 install tensorflow-gpu==2.6.2 keras==2.6.0

RUN pip3 install nltk==3.6.5

RUN set -x \
    && apt-get update \
    && apt-get --with-new-pkgs upgrade -y \
    && apt-get install python3-tk -y

RUN pip3 install tk==0.1.0

USER user

CMD sudo service ssh start && /bin/bash
