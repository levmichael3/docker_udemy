FROM node:alpine as builder

# install node modules
WORKDIR   /app

ENV       PATH=/app/node_modules/.bin:$PATH

ADD       package.json /app/package.json
RUN       npm install  --ignore-scripts --unsafe-perm

COPY      . /app
RUN       npm run build

##################

FROM nginx

COPY --from=docbuilder /app/build /usr/share/nginx/html
