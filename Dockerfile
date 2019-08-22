FROM nginx:1.17
RUN rm -f /etc/nginx/conf.d/nginx.conf
COPY nginx.conf.template /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html
WORKDIR /app
COPY entrypoint.sh .
ENTRYPOINT ["/app/entrypoint.sh"]
