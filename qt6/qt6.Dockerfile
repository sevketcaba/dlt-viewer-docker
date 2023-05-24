FROM sevketcaba/qt6-dev:linux-desktop-base-6.5.0

RUN apt-get update
RUN apt-get install -y -q \
    uuid-dev \
    openjdk-8-jdk

ARG QT=6.5.0
ARG QT_MODULES="qtserialport"
ARG QT_HOST=linux
ARG QT_TARGET=desktop
ARG QT_ARCH=gcc_64

RUN aqt install-qt --outputdir /opt/qt ${QT_HOST} ${QT_TARGET} ${QT} ${QT_ARCH} -m ${QT_MODULES} --noarchives

WORKDIR /project
RUN git clone https://github.com/COVESA/dlt-viewer.git
WORKDIR /project/dlt-viewer/plugin
RUN git clone -b qt6 https://github.com/sevketcaba/DLT-Message-Analyzer.git
RUN echo '\nadd_subdirectory(DLT-Message-Analyzer/dltmessageanalyzerplugin/src)\n' >> ./CMakeLists.txt

WORKDIR /project/dlt-viewer
RUN mkdir build
WORKDIR /project/dlt-viewer/build

RUN cmake ..
RUN make -j8

CMD /project/dlt-viewer/build/bin/dlt-viewer

