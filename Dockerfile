FROM ruby:3.2.2

RUN apt-get update && apt-get install -y apt-transport-https git curl postgresql-client

ENV installDir=/home/collectibles

RUN mkdir -p $installDir
WORKDIR $installDir

COPY Gemfile $installDir
COPY Gemfile.lock $installDir

RUN gem update --system
RUN gem install bundler:2.4.14
RUN bundle install --jobs $(nproc)
