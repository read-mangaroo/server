FROM beardedeagle/alpine-phoenix-builder:1.11.3 AS build
WORKDIR /app
RUN mix local.hex --force && \
    mix local.rebar --force
ENV MIX_ENV=prod
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile
COPY lib lib
COPY rel rel
RUN mix do compile, release

FROM alpine:3.13 AS app
RUN apk add --no-cache openssl ncurses-libs
WORKDIR /app
EXPOSE 4000
RUN chown nobody:nobody /app
USER nobody:nobody
COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/mangaroo ./
ENV HOME=/app
CMD ["bin/mangaroo", "start"]
