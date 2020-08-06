# Background

- 平时工作中Linux接触的比较少，想把之前写的批处理改成shell脚本，以便进行学习

# Bash in Action

## 文件文本处理
### rsync同步文件
- 简介：rsync可以跨服务器拷贝资料，拷贝速度比scp快，但是在拷贝小文件时会导致硬盘I/O非常高，不加密
- 增量拷贝：-a选项，等同于-rlptgoD
- 镜像拷贝：-delete选项
- 选择性拷贝：--exclude-from=File，剔除掉File中指定模式的文件和文件夹
- 练习脚本：https://github.com/Charles-Miao/Bash-in-Action/tree/master/SYNCFILES/sync_files.sh
- 参考链接：https://segmentfault.com/a/1190000015669114

### scp同步文件
- 简介：scp可以跨服务器拷贝资料，scp非常不占资源，适合拷贝小文件，加密传输
- 镜像拷贝：无
- 选择性拷贝：结合find命令进行操作

```shell
source_folder=/mnt/c/Users/Charles/Desktop/Bash-in-Action
target_folder=/mnt/e/Bash-in-Action
#若不存在文件夹则创建此文件夹
if [ ! -d $target_folder ]
then
    mkdir $target_folder
fi
#通过修改命令行工具和Shell的默认分隔符来解决文件名中有空格的问题，先保存变量$IFS，再修改$IFS，最后再还原$IFS
MY_SAVEIFS=$IFS
IFS=$'\n'
# -prune -o，是指排除${source_folder}/.git这个目录
# awk -F "/"，是指以"/"为分隔符
for i in `find ${source_folder} -type d -path ${source_folder}/.git -prune -o -print |awk -F"/" '{print $8}'|sort|uniq`
do
    scp -rp ${source_folder}/$i ${target_folder}/$i
done
IFS=$MY_SAVEIFS
```

### cp同步文件
- 简介：cp只是在本机进行拷贝不能跨服务器

### 删除过期文件

- 练习脚本：https://github.com/Charles-Miao/Bash-in-Action/tree/master/DELOLDFILE/del_old_files.sh

```shell
# /mnt/e/Bash-in-Action/ 为需要删除的文件目录
# -mtime +1 为大于1天以上（mtime为modify time，指文件修改时间）
# atime为access time，即为文件被读取或者执行的时间
# ctime为change time，文件状态改变时间
# -name "*.*" 为文件名模糊匹配
# -exec 执行
# rm -f {} \; 删除上面匹配到的文件，关于\;的解释可以参考连接：https://qastack.cn/ubuntu/339015/what-does-mean-in-a-linux-command
find /mnt/e/Bash-in-Action/ -mtime +1 -name "*.*" -exec rm -rf {} \;
```

## 磁盘压缩
### 空间检查
- 显示特定目录中，文件大小居前十的目录，https://blog.csdn.net/qq_36588424/article/details/104098675

```shell
#!/bin/bash
# du，查看某个目录的大小
# sort，排序
# sed语法参考：https://man.linuxde.net/sed
# sed '{11,$d}'，删除11行到最后一行
# sed '{=}'，打印当前行号码
# sed '表达式; 表达式'，组合多个表达
# N 追加下一个输入行到模板块后面并在二者间嵌入一个新行，改变当前行号码
# sed 's/要被取代的字串/新的字串/g'，替换命令
# gawk 读取文本行的数据，然后处理并显示数据
CHECK_DIR="/var/log /home"

DATE=$(date '+%m%d%y')

exec >disk_space_$DATE.rpt #对以下所有输出重定向到文件

echo "Top Ten Disk Space Usage"
echo "for $CHECK_DIR Directories"

for DIR_CHECK in $CHECK_DIR
do
 echo ""
 echo "The $DIR_CHECK Directory"
 du -Sh $DIR_CHECK 2>/home//charles/error.txt | #报错信息重定向到文件
 sort -rn| sed '{11,$D;=}'| #取前十名并且标注行号
 sed 'N;s/\n/ /'| #N：提前读取下一行，把换行符去掉
 gawk '{printf $1 ":" "\t" $2 "\t" $3 "\n"}'
done
exit
```

- 定期查询特定目录的空间大小，https://blog.csdn.net/humanking7/article/details/89763372
- 空间、网络流量、新文件监控，https://www.iambigboss.top/post/44021_1_1.html
- 练习脚本：https://github.com/Charles-Miao/Bash-in-Action/tree/master/HDDSPACECHK/hdd_space_check.sh

### 压缩log

- 练习脚本：https://github.com/Charles-Miao/Bash-in-Action/tree/master/LOGCOMPRESS/log_compress.sh

## 网络信息
### 获取网卡的基本信息，并检查网络的连通性

- 获取网卡型号
```shell
lspci | grep Ethernet | cut -f3 -d':' | cut -f1 -d'(' | uniq
```
- 练习脚本：https://github.com/Charles-Miao/Bash-in-Action/tree/master/NETWORK

### 网络进出流量监测

## 系统管理
### 系统信息抓取
### 时间同步

## 性能和进程监控

### CPU和内存使用率
### 服务监控
### 所有进程数量，正在运行的进程数量

## 用户管理

### 登录用户的数量
### passwd checksum检查

## 其他工具应用
### 发送邮件
### FTP传输文件
### SVN自动导出
### 检查SVN


