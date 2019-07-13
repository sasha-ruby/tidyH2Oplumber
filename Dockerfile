FROM rocker/r-base
MAINTAINER Sasha Bogdanovic <sasha@rubyind.com>

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libpq-dev \
  libcurl4-openssl-dev \
  libssh2-1-dev \
  libudunits2-dev \
  libsodium-dev \
  libproj-dev \
  libgdal-dev \
  libssl-dev \
  sudo \
  wget \
  git \
  libv8-dev \
  default-jre \
  && install2.r --error \
    --deps TRUE \
    tidyverse \
    dplyr \
    devtools \
    formatR \
    remotes \
    selectr \
    BiocManager \
    here \
    RCurl \
    jsonlite \
    plumber \
  && Rscript -e 'install.packages("h2o", type = "source", repos = "http://h2o-release.s3.amazonaws.com/h2o/rel-yates/5/R")'

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000, swagger = TRUE)"]
