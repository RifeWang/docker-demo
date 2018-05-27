const express = require('express');
const Redis = require('ioredis');
const redis = new Redis({
    port: 6379,
    host: 'redis'  // --net 自定义网络，使用别名
    // host: 'redis_connection'  // --link [container]:[alias]
    // host: 'localhost'  // --net=container:[container-name] 使用指定容器的网络
});
const app = express();
const PORT = 8888;

app.get('/', async (req, res) => {
    try {
        const r = await redis.incr('count');
        res.write(` count: ${r} \r\n`);

        res.end(` NODE_NEV : ${process.env.NODE_ENV} \n Contanier port : ${PORT}`);
    } catch (error) {
        console.log(error);
    }
});

app.listen(PORT);

/* 
    构建镜像：docker build --build-arg NODE_ENV=develop -t docker-demo .
    启动容器：docker run --name demo -it -p 9999:8888 docker-demo
*/

/* 
    挂载数据卷：docker run 添加 -v <host_dir>:<container_dir>
    连接数据卷容器：docker run 添加 --volumes-from <数据卷容器>
*/

/* 
    自定义网路：docker network create -d bridge my-network
    容器连接到自定义网络：docker run 添加 --net my-network 
        或者等容器启动后：docker network connect [network-name] [container-name]
*/