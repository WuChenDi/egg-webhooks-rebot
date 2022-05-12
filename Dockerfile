FROM node:14.18.0-alpine

COPY . /app
WORKDIR /app

RUN cd /app && \
    npm i --production && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

CMD ["npm", "start"]