FROM node:10-buster as build
RUN mkdir /tmp/brouter-web
WORKDIR /tmp/brouter-web
COPY . .
RUN yarn install
RUN yarn run build

FROM nginx:alpine
COPY --from=build /tmp/brouter-web/index.html /usr/share/nginx/html
COPY --from=build /tmp/brouter-web/config.js /usr/share/nginx/html
COPY --from=build /tmp/brouter-web/keys.js /usr/share/nginx/html
COPY --from=build /tmp/brouter-web/profiles/ /usr/share/nginx/html/brouter-profiles/
COPY --from=build /tmp/brouter-web/dist /usr/share/nginx/html/dist
VOLUME [ "/usr/share/nginx/html" ]
