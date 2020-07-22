# Bash in Action


## 仓库的背景


- 平时工作中Linux接触的比较少，想把之前写的批处理改成shell脚本，以便进行学习

## Linux基础

### 帮助命令

- 帮助命令: whatis info man which whereis

### 文件和目录管理

- 创建，删除，拷贝，剪切: mkdir rm (rm -rf file) mv cp
- 目录切换，列出目录: cd pwd ls
- 文件的查询和检索: find locate
- 查看文件内容：cat vi head tail more egrep
- 权限修改: chown chmod
- 管道和重定向: ; | && || > >>
- Ctl-U，删除光标到行首的所有字符,在某些设置下,删除全行
- Ctl-W，删除当前光标到前边的最近一个空格之间的字符

### 文本处理

- find文件查找，正则方式查找-regex，非!，搜索深度-maxdepth，定制搜索-type f 文件/ l 符号链接/ d 目录，按时间搜索-atime访问时间/ -mtime修改时间/ -ctime变化时间，按大小-size，按权限-perm，按用户-user，找到后的后续动作-exec {}
- grep文件搜索，-o 只输出匹配的文本行/ -v 只输出没有匹配的文本行/ -c 统计文件中包含文本的次数/ -n 打印匹配的行号/ -i 搜索时忽略大小写/ -l 只打印文件名/ -R 递归
- xargs命令行参数转换（给命令传递参数的一个过滤器）
- sort排序，-n 按数字进行排序/ -d 按字典序进行排序/ -r 逆序排序
- uniq消除重复行，出现次数，找出重复行
- tr转换或删除文件中的字符，-d删除/ -c求补集/ -s压缩字符，转换大小写等
- cut按列切分文本，排除某列，-d指定定界符
- paste按列拼接文本
- wc统计行和字符的工具
- **sed文本替换利器，利用脚本来处理文本文件**
- **awk是一种处理文本文件的语言，是一个强大的文本分析工具**
- **迭代文件中的行、单词和字符**

### 磁盘管理

- df -h，查看磁盘大小（h是human的意思）
- du -sh，查看目前目录所占空间（-h是人性化显示 s是递归整个目录的大小）
- tar -cvf，打包
- gzip，压缩
- gunzip，解压gz
- bzip2 -d，解压bz2
- tar -z，解压gz文件
- tar -j，解压bz2文件
- tar -J，解压xz文件
- tar -xvf，解包

### 进程管理

- ps -ef，正在运行进程
- pgrep -l，查询进程
- top，实时显示进程信息（P，CPU使用最多；M，内存使用最多）
- lsof（list opened files），作用是列举系统中已经被打开的文件。在linux环境中，任何事物都是文件，设备是文件，目录是文件，甚至sockets也是文件。
- kill PID，杀死进程
- pmap，输出进程内存的状况，可以用来分析线程堆栈

### 性能监控

- sar -u 1 2，CPU使用率
- sar -q 1 2，CPU平均负载
- sar -r 1 2，内存使用状况
- free -m，内存使用量
- sar -W 1 3，查询页面交换
- vmstat，sar替代工具
- watch，持续的监控应用的某个数据变化

### 网络工具

- netstat -a，列出所有端口
- netstat -at，列出所有tcp端口
- netstat -l，列出所有监听的服务状态

```shell
#使用netstat工具查询端口
$netstat -antp | grep 6379
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN      25501/redis-server

$ps 25501
  PID TTY      STAT   TIME COMMAND
25501 ?        Ssl   28:21 ./redis-server ./redis.conf

#查询7902端口现在运行什么程序
#第一步，查询使用该端口的进程的PID；
    $lsof -i:7902
    COMMAND   PID   USER   FD   TYPE    DEVICE SIZE NODE NAME
    WSL     30294 tuapp    4u  IPv4 447684086       TCP 10.6.50.37:tnos-dp (LISTEN)

#查到30294
#使用ps工具查询进程详情：
$ps -fe | grep 30294
tdev5  30294 26160  0 Sep10 ?        01:10:50 tdesl -k 43476
root     22781 22698  0 00:54 pts/20   00:00:00 grep 11554
```
- route -n，查看路由状态
- ping IP
- traceroute IP，前往目标地址的路由路径
- host domain，dns查询
- wget url，镜像下载，-limit-rate下载限速，-o写入日志，-c断电续传
- ssh ID@host
- sftp ID@host
- lftp同步文件夹
- scp localpath ID@host:path，网络复制，上传
- scp -r ID@site:path localpath，网络复制，下载

### 用户管理工具

- useradd -m username，添加用户
- userdel -r username，删除用户
- su username，切换用户
- group
- usermod -G groupName username，添加组
- usermod -g groupName username，变更组
- more /etc/passwd，查看所有用户
- more /etc/group，查看所有组
- chmod，更改权限，rwx=>421
- chown，更改文件拥有者
- /etc/profile /etc/bashrc，全局环境变量设定
- ~/.profile ~/.bashrc，用户目录私有环境变量设定
- bashrc用于交互式non-loginshell，而profile用于交互式login shell

### 系统管理及IPC资源管理

- uname -a，查看linux系统版本
- lsb_release -a，查看linux系统版本
- more /etc/release，查看unix系统版本
- sar -u 5 10，查看CPU使用情况
- cat /proc/cpuinfo，查看CPU信息
- cat /proc/cpuinfo | grep processor | wc -l，查看CPU核数
- cat /proc/meminfo，查看内存信息
- pagesize，内存page大小
- arch，显示架构
- date，显示当前系统时间
- date -s，设置时间
- tzselect，设置时区
- clock -w，强制写入CMOS
- 多进程间通信常用的技术手段包括共享内存、消息队列、信号量等等，Linux系统下自带的ipcs命令是一个极好的工具，可以帮助我们查看当前系统下以上三项的使用情况，从而利于定位多进程通信中出现的通信问题
- ipcs
- ipcs -m，内存资源
- ipcs -q，队列资源
- ipcs -s，信号量资源
- ipcs应用示例：查看IPC资源被谁占用
- ulimit，检测和设置系统资源限制

## Linux工具进阶

### 程序构建

### 程序调试

### 性能优化

## 工具参考篇

## 参考链接

- https://github.com/qinjx/30min_guides/blob/master/shell.md
- https://linuxtools-rst.readthedocs.io/zh_CN/latest/index.html
- https://doc.yonyoucloud.com/doc/wiki/project/shell-tutorial/index.html





