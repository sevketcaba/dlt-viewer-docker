FROM sevketcaba/qt5-dev:linux-desktop-base-5.15.2

RUN apt-get update
RUN apt-get install -y -q \
    uuid-dev \
    openjdk-8-jdk

WORKDIR /project
RUN git clone https://github.com/COVESA/dlt-viewer.git
WORKDIR /project/dlt-viewer/plugin
RUN git clone https://github.com/svlad-90/DLT-Message-Analyzer.git
RUN echo '\nadd_subdirectory(DLT-Message-Analyzer/dltmessageanalyzerplugin/src)\n' >> ./CMakeLists.txt

WORKDIR /project/dlt-viewer
RUN mkdir build
WORKDIR /project/dlt-viewer/build

RUN cmake ..
RUN make -j8

CMD /project/dlt-viewer/build/bin/dlt-viewer

