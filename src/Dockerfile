FROM ubuntu:14.04
MAINTAINER Darebeat <fengwei2010@126.com>

# 环境变量
ENV BOOK_NAME wisdom

# 映射文件
ADD ./sources.list /etc/apt/sources.list
COPY run.sh /opt/run.sh
RUN chmod a+x /opt/run.sh

# 安装环境
RUN apt-get update && \
    apt-get install libssl-dev curl nginx git openssh-server -y

# 配置 ssh
RUN mkdir -p /var/run/sshd && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 安装node
RUN curl -o /opt/node.tar.gz http://oss.npm.taobao.org/dist/node/v4.0.0/node-v4.0.0-linux-x64.tar.gz && \
    tar zxf /opt/node.tar.gz -C /opt && \
    mv /opt/node-v4.0.0-linux-x64 node && \
    cd /usr/local/bin && ln -sf /opt/node/bin/* . && \
    rm -rf /opt/node.tar.gz

# 安装gitbook-cli
RUN /opt/node/bin/npm install gitbook-cli -g && cd /usr/local/bin && ln -sf /opt/node/bin/* .

# 复制或克隆项目并且build,build 结束删除原项目
RUN cd /usr/share/nginx && git clone git@git.coding.net:darebeat/$BOOK_NAME.git && \
    cd $BOOK_NAME && gitbook build . /usr/share/nginx/html && \
    cd .. && rm -rf $BOOK_NAME

# 设置root ssh远程登录密码为docker
RUN echo 'root:gitbook_dev' | chpasswd

# 开放端口
EXPOSE 22 80 443

CMD ["/opt/run.sh"]
