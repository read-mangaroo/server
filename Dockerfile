FROM hexpm/elixir:1.11.4-erlang-23.3.1-alpine-3.13.3 AS build
RUN apk add --no-cache build-base npm git python3
WORKDIR /app
RUN mix local.hex --force && \
    mix local.rebar --force
ENV MIX_ENV=prod
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config
COPY config/config.exs config/releases.exs config/$MIX_ENV.exs config/
RUN mix deps.compile
COPY priv priv
COPY lib lib
COPY rel rel
RUN mix do compile, release

FROM alpine:3.13 AS app
RUN apk add --no-cache openssl ncurses-libs
ENV USER="phoenix"
ENV HOME=/home/"${USER}"
ENV APP_DIR="${HOME}/app"
RUN \
  addgroup \
   -g 1000 \
   -S "${USER}" && \
  adduser \
   -s /bin/sh \
   -u 1000 \
   -G "${USER}" \
   -h "${HOME}" \
   -D "${USER}" && \
  su "${USER}" sh -c "mkdir ${APP_DIR}"
USER "${USER}"
WORKDIR "${APP_DIR}"
EXPOSE 4000
COPY --from=build --chown="${USER}":"${USER}" /app/_build/prod/rel/mangaroo ./
ENTRYPOINT ["bin/mangaroo"]
CMD ["start"]
