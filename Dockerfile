FROM node:14.18.0-alpine
# FROM node:lts-alpine

WORKDIR /app

# 配置alpine国内镜像加速
# RUN sed -i "s@http://dl-cdn.alpinelinux.org/@https://repo.huaweicloud.com/@g" /etc/apk/repositories

# 配置时区
RUN apk update && apk add bash tzdata \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装tzdata,默认的alpine基础镜像不包含时区组件，安装后可通过TZ环境变量配置时区
# RUN apk add --no-cache tzdata

# 设置时区为中国东八区，这里的配置可以被docker-compose.yml或docker run时指定的时区覆盖
ENV TZ="Asia/Shanghai"

# 安装开发期依赖
# COPY package.json ./package.json
# RUN npm install
# # 构建项目
# COPY . .
# RUN npm run build
# # 删除开发期依赖
# RUN rm -rf node_modules && rm package-lock.json
# # 安装生产环境依赖
# RUN npm install --production

# 安装开发期依赖
COPY package.json ./package.json
RUN npm install --production
# 构建项目
COPY . .

# 如果端口更换，这边可以更新一下
EXPOSE 7001

CMD ["npm", "run", "docker"]
