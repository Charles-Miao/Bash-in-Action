# Background

- 平时工作中Linux接触的比较少，想把之前写的批处理改成shell脚本，以便进行学习

# Bash in Action

## 文件文本处理
### rsync同步文件
- 简介：rsync可以跨服务器拷贝资料，拷贝速度比scp快，但是在拷贝小文件时会导致硬盘I/O非常高，不加密
- 增量拷贝：-a选项，等同于-rlptgoD
- 镜像拷贝：-delete选项
- 选择性拷贝：--exclude-from=File，剔除掉File中指定模式的文件和文件夹
- 练习脚本：https://github.com/Charles-Miao/Bash-in-Action/tree/master/rsync/sync_files.sh
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

## 磁盘压缩
### 空间检查
### 压缩和发送

## 网络信息
### 获取网卡的基本信息，并检查网络的连通性
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


