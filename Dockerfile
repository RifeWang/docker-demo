# 指定基础镜像
FROM node:8.11.1

# MAINTAINER 新版本已经被废弃，用来声明作者信息，使用 LABEL 代替

# LABEL 通过自定义键值对的形式声明此镜像的相关信息，声明后通过 docker inspect 可以看到
LABEL maintainer="rife"
LABEL version="1.0.0"
LABEL description="This is a test image."

# WORKDIR 指定工作目录，若不存在则自动创建，其他指令均会以此作为路径。
WORKDIR /work/myapp/

# ADD <src> <dest>
# 将源文件资源添加到镜像的指定目录中，若是压缩文件会自动在镜像中解压，可以通过 url 指定远程的文件
ADD 'https://github.com/nodejscn/node-api-cn/blob/master/README.md' ./test/

# COPY <src> <dest>
# 同样是复制文件资源，但无法解压，无法通过 url 指定远程文件
# 示例：将本地的当前目录所有文件复制到镜像中 WORKDIR 指定的当前目录 
COPY ./ ./ 

# RUN 构建镜像时执行的命令
RUN npm install

# ARG 指定构建镜像时可传递的参数，与 ENV 配合使用
# 示例：通过 docker build --build-arg NODE_ENV=develop 可灵活指定环境变量
ARG NODE_ENV

# ENV 设置容器运行的环境变量
ENV NODE_ENV=$NODE_ENV

# EXPOSE 暴露容器端口，需要在启动时指定其与宿主机端口的映射
EXPOSE 8888 

# CMD 容器启动后执行的命令，只执行最后声明的那条命令，会被 docker run 命令覆盖
CMD ["npm", "start"]

# ENTRYPOINT 容器启动后执行的命令，只执行最后声明的那条命令，不会被覆盖掉
# 任何 docker run 设置的指令参数或 CMD 指令，都将作为参数追加到 ENTRYPOINT 指令的命令之后。