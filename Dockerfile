FROM ruby

RUN gem install rack

ADD ./ /rackapp/

WORKDIR /rackapp

EXPOSE 3000

CMD ["rackup", "-p", "3000"]
