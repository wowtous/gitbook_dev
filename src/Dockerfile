FROM ubuntu:14.04
MAINTAINER Darebeat <fengwei2010@126.com>

# 映射文件
ADD ./sources.list /etc/apt/sources.list
ADD lib/wisdom /opt/wisdom
COPY run.sh /opt/run.sh
COPY ./node-v0.12.6-linux-x64.tar.gz /opt/
RUN chmod a+x /opt/run.sh

# 安装环境
RUN apt-get update && \
    apt-get install libssl-dev curl nginx git openssh-server -y

# 配置 ssh
RUN mkdir -p /var/run/sshd && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 安装node
RUN tar zxf /opt/node-v0.12.6-linux-x64.tar.gz -C /opt && mv /opt/node-v0.12.6-linux-x64 /opt/node && rm -rf /opt/node-v0.12.6-linux-x64.tar.gz

# 安装gitbook-cli
RUN cd /opt/node/lib && /opt/node/bin/npm install gitbook-cli && \
    cd /opt/node/bin && ln -sf ./lib/node_modules/gitbook-cli/bin/gitbook.js && \
    cd /usr/local/bin && ln -sf /opt/node/bin/* .

# 复制或克隆项目并且build,build 结束删除原项目
RUN cd /opt/wisdom && gitbook build . /usr/share/nginx/html && rm -rf /opt/wisdom

# 设置root ssh远程登录密码为docker
RUN echo 'root:gitbook_dev' | chpasswd

# 开放端口
EXPOSE 22 80 443

CMD ["/opt/run.sh"]
