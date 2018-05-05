const express = require('express');
const app = express();
const PORT = 8888;

app.get('/', (req, res) => {
  res.write(' test volume');
  res.end(` NODE_NEV : ${process.env.NODE_ENV} \n Contanier port : ${PORT}`);
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