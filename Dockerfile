FROM  alpine:latest
LABEL author="Titor <foolsecret@163.com>"

WORKDIR /
#
# 系统底层初始化
# 安装系统更新 和 anp 所需的其他功能模块
# 配置 Nginx 默认的运行时文件
# 初始化 WEB 默认目录
#
COPY  ./shell  .
RUN   sh  ./sys_init.sh \
          ./nginx_init.sh \
          ./www_init.sh

#
# 为 WEB 添加默认页面
#
WORKDIR /root/www/
COPY ./pages/  .

#
# Nginx 配置
#
WORKDIR /etc/nginx/conf.d/
COPY  ./nginx/default.conf  .

# 挂载 www 目录
VOLUME    /root/www/

# 对外暴露 80 服务器端口
EXPOSE    80

# 启动命令
ENTRYPOINT ["/cmd.sh"]