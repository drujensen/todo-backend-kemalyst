FROM heroku/cedar

RUN mkdir -p /app/user

RUN curl -L https://github.com/crystal-lang/crystal/releases/download/0.15.0/crystal-0.15.0-1-linux-x86_64.tar.gz | tar xvz -C /app/.

RUN curl -Lo /app/crystal-0.15.0-1/bin/shards.gz https://github.com/crystal-lang/shards/releases/download/v0.6.2/shards-0.6.2_linux_x86_64.gz 

RUN cd /app/crystal-0.15.0-1/bin && gunzip shards.gz && chmod 755 shards

ENV PATH /app/crystal-0.15.0-1/bin:$PATH

ADD . /app/user
WORKDIR /app/user

RUN shards update

EXPOSE 8080
CMD ["crystal", "src/app.cr"]
