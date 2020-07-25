# Bash in Action


## 仓库的背景


- 平时工作中Linux接触的比较少，想把之前写的批处理改成shell脚本，以便进行学习
---
## Shell教程

### 第一个Shell脚本

- echo read

### Shell变量

- 变量

```shell
your_name="charles"
echo $your_name
echo ${your_name}
```

- 使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变

```shell
readonly your_name
```

- 删除变量，unset 命令不能删除只读变量

```shell
unset your_name
```

- 局部变量、环境变量、shell变量

### Shell特殊变量

- $0	当前脚本的文件名
- $n	传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是$1，第二个参数是$2。
- $#	传递给脚本或函数的参数个数。
- $*	传递给脚本或函数的所有参数。
- $@	传递给脚本或函数的所有参数。被双引号(" ")包含时，与 $* 稍有不同，下面将会讲到。
- $?	上个命令的退出状态，或函数的返回值。
- $$	当前 Shell 进程 ID。对于 Shell 脚本，就是这些脚本所在的进程 ID。

### Shell替换

- 下面的转义字符都可以用在 echo 中
```shell
\|反斜杠
\a	警报，响铃
\b	退格（删除键）
\f	换页(FF)，将当前位置移到下页开头
\n	换行
\r	回车
\t	水平制表符（tab 键）
\v	垂直制表符
可以使用 echo 命令的 -E 选项禁止转义，默认也是不转义的；使用 -n 选项可以禁止插入换行符
```

- 命令替换，command 注意是反引号，不是单引号，这个键位于 Esc 键下方

```shell
DATE=`date`
echo "Date is $DATE"
```

- 变量替换

```shell
${var}	变量本来的值
${var:-word}	如果变量 var 为空或已被删除(unset)，那么返回 word，但不改变 var 的值
${var:=word}	如果变量 var 为空或已被删除(unset)，那么返回 word，并将 var 的值设置为 word。
${var:?message}	如果变量 var 为空或已被删除(unset)，那么将消息 message 送到标 准错误输出，可以用来检测变量 var 是否可以被正常赋值。若此替换出现在 Shell 脚本中，那么脚本将停止运行。
${var:+word}	如果变量 var 被定义，那么返回 word，但不改变 var 的值。
```

### Shell运算符

```shell
#!/bin/bash

val=`expr 2 + 2`
echo "Total value : $val"
```

- 算数运算符

```shell
+	加法	`expr $a + $b` 结果为 30。
-	减法	`expr $a - $b` 结果为 10。
*	乘法	`expr $a \* $b` 结果为  200。
/	除法	`expr $b / $a` 结果为 2。
%	取余	`expr $b % $a` 结果为 0。
=	赋值	a=$b 将把变量 b 的值赋给 a。
==	相等。用于比较两个数字，相同则返回 true。	[ $a == $b ] 返回 false。
!=	不相等。用于比较两个数字，不相同则返回 true。	[ $a != $b ] 返回 true。
```

- 关系运算符

```shell
-eq	检测两个数是否相等，相等返回 true。	[ $a -eq $b ] 返回 true。
-ne	检测两个数是否相等，不相等返回 true。	[ $a -ne $b ] 返回 true。
-gt	检测左边的数是否大于右边的，如果是，则返回 true。	[ $a -gt $b ] 返回 false。
-lt	检测左边的数是否小于右边的，如果是，则返回 true。	[ $a -lt $b ] 返回 true。
-ge	检测左边的数是否大等于右边的，如果是，则返回 true。	[ $a -ge $b ] 返回 false。
-le	检测左边的数是否小于等于右边的，如果是，则返回 true。	[ $a -le $b ] 返回 true。
```

- 布尔运算符

```shell
!	非运算，表达式为 true 则返回 false，否则返回 true。	[ ! false ] 返回 true。
-o	或运算，有一个表达式为 true 则返回 true。	[ $a -lt 20 -o $b -gt 100 ] 返回 true。
-a	与运算，两个表达式都为 true 才返回 true。	[ $a -lt 20 -a $b -gt 100 ] 返回 false。
```

- 字符串运算符

```shell
=	检测两个字符串是否相等，相等返回 true。	[ $a = $b ] 返回 false。
!=	检测两个字符串是否相等，不相等返回 true。	[ $a != $b ] 返回 true。
-z	检测字符串长度是否为0，为0返回 true。	[ -z $a ] 返回 false。
-n	检测字符串长度是否为0，不为0返回 true。	[ -z $a ] 返回 true。
str	检测字符串是否为空，不为空返回 true。	[ $a ] 返回 true。
```

- 文件测试运算符

```shell
-b file	检测文件是否是块设备文件，如果是，则返回 true。	[ -b $file ] 返回 false。
-c file	检测文件是否是字符设备文件，如果是，则返回 true。	[ -b $file ] 返回 false。
-d file	检测文件是否是目录，如果是，则返回 true。	[ -d $file ] 返回 false。
-f file	检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。	[ -f $file ] 返回 true。
-g file	检测文件是否设置了 SGID 位，如果是，则返回 true。	[ -g $file ] 返回 false。
-k file	检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。	[ -k $file ] 返回 false。
-p file	检测文件是否是具名管道，如果是，则返回 true。	[ -p $file ] 返回 false。
-u file	检测文件是否设置了 SUID 位，如果是，则返回 true。	[ -u $file ] 返回 false。
-r file	检测文件是否可读，如果是，则返回 true。	[ -r $file ] 返回 true。
-w file	检测文件是否可写，如果是，则返回 true。	[ -w $file ] 返回 true。
-x file	检测文件是否可执行，如果是，则返回 true。	[ -x $file ] 返回 true。
-s file	检测文件是否为空（文件大小是否大于0），不为空返回 true。	[ -s $file ] 返回 true。
-e file	检测文件（包括目录）是否存在，如果是，则返回 true。	[ -e $file ] 返回 true。
```


### Shell注释

- 以“#”开头的行就是注释，会被解释器忽略。如果在开发过程中，遇到大段的代码需要临时注释起来，过一会儿又取消注释，怎么办呢？每一行加个#符号太费力了，**可以把这一段要注释的代码用一对花括号括起来，定义成一个函数**，没有地方调用这个函数，这块代码就不会执行，达到了和注释一样的效果。

### Shell字符串

- 单引号
- 双引号（优点： 双引号里可以有变量 双引号里可以出现转义字符）
- 字符拼接
- 获取字符串长度，echo ${#string}
- 提取子字符串，echo ${string:1:4}
- 查找子字符串，echo `expr index "$string" is`

### Shell数组

- 定义数组

```shell
array_name=(value0 value1 value2 value3)
#可以不使用连续的下标，而且下标的范围没有限制
array_name[0]=value0
array_name[1]=value1
array_name[5]=value2
```

- 读取数组

```shell
#读取所有元素
${array_name[*]}
${array_name[@]}
```

- 获取数组长度

```shell
# 取得数组元素的个数
length=${#array_name[@]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```

### echo命令

- 显示转义字符
- 显示变量
- 显示换行，\n
- 显示不换行，\c
- 显示命令执行结果，使用反向单引号``

### printf命令

- printf 命令用于格式化输出， 是echo命令的增强版
- printf 不像 echo 那样会自动换行，必须显式添加换行符(\n)
- 功能和用法类似c语言中的printf，如下为不同部分：
```shell
#printf 命令不用加括号
#format-string 可以没有引号，但最好加上，单引号双引号均可。
#参数多于格式控制符(%)时，format-string 可以重用，可以将所有参数都转换。
#arguments 使用空格分隔，不用逗号。
```
- %s代表字符串，默认为NULL，%d代表数字，默认为0。根据 POSIX 标准，浮点格式%e、%E、%f、%g与%G是“不需要被支持”。这是因为 awk 支持浮点预算，且有它自己的 printf 语句。这样 Shell 程序中需要将浮点数值进行格式化的打印时，可使用小型的 awk 程序实现。然而，内建于 bash、ksh93 和 zsh 中的 printf 命令都支持浮点格式

### if else语句

- if ... fi 语句
- if ... else ... fi 语句
- if ... elif ... else ... fi 语句
- test 命令用于检查某个条件是否成立，与方括号([ ])类似

### case esac语句

```shell
echo 'Input a number between 1 to 4'
echo 'Your number is:\c'
read aNum
case $aNum in
    1)  echo 'You select 1'
    ;;
    2)  echo 'You select 2'
    ;;
    3)  echo 'You select 3'
    ;;
    4)  echo 'You select 4'
    ;;
    *)  echo 'You do not select a number between 1 to 4'
    ;;
esac
```

```shell
#!/bin/bash

option="${1}"
case ${option} in
   -f) FILE="${2}"
      echo "File name is $FILE"
      ;;
   -d) DIR="${2}"
      echo "Dir name is $DIR"
      ;;
   *) 
      echo "`basename ${0}`:usage: [-f file] | [-d directory]"
      exit 1 # Command to come out of the program with status 1
      ;;
esac
```

### for循环

### while循环

### until循环

### 跳出循环

### 函数

### 函数参数

### 输入和输出重定向

### 文件包含




---
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

### 程序构建（C、C++等编译型语言）

- 源码的安装一般由3个步骤组成：配置(configure)、编译(make)、安装(make install)

### 程序调试

- GDB是一个由GNU开源组织发布的、UNIX/LINUX操作系统下的、基于命令行的、功能强大的程序调试工具
- pstack跟踪栈空间
- strace分析系统调用
- nm列出目标文件的符号清单
- ogjdump工具用来显示二进制文件的信息，就是以一种可阅读的格式让你更多地了解二进制文件可能带有的附加信息
- readelf和objdump命令提供的功能类似，但是它显示的信息更为具体，并且它不依赖BFD库(BFD库是一个GNU项目，它的目标就是希望通过一种统一的接口来处理不同的目标文件）
- size 查看程序内存占用
- file 文件类型查询
- strings 查询数据中的文本信息（有点意思）
- fuser 显示文件使用者（fuser -m -v /dev/sdb1，查看哪个用户哪个进程占用设备/dev/sdb1）
- xxd 十六进制显示数据
- 通常使用od命令查看特殊格式的文件内容。通过指定该命令的不同选项可以以十进制、八进制、十六进制和ASCII码来显示文件

### 性能优化

- top分析系统瓶颈（%id：空闲CPU时间百分比，如果这个值过低，表明系统CPU存在瓶颈；%wa：等待I/O的CPU时间百分比，如果这个值过高，表明IO存在瓶颈；）
- free、vmstat分析内存瓶颈
- iostat分析IO瓶颈
- pstack和pstrace分析进程调用
- 优化程序代码（二八法则、编完代码，再优化）
- valgrind调试内存泄漏的工具
- OProfile: Linux 平台上的一个功能强大的性能分析工具
- sar比较全面的性能分析工具

## 工具参考篇（包含一些实例）

- gdb 调试利器
- ldd 查看程序依赖库
- lsof 一切皆文件
- ps 进程查看器
- pstack 跟踪进程栈
- strace 跟踪进程中的系统调用
- ipcs 查询进程间通信状态
- top linux下的任务管理器
- free 查询可用内存
- vmstat 监视内存使用情况
- iostat 监视I/O子系统
- sar 找出系统瓶颈的利器
- readelf elf文件格式分析
- objdump 二进制文件分析
- nm 目标文件格式分析
- size 查看程序内存映像大小
- wget 文件下载
- scp 跨机远程拷贝
- crontab 定时任务
---
## 参考链接

- https://github.com/qinjx/30min_guides/blob/master/shell.md
- https://linuxtools-rst.readthedocs.io/zh_CN/latest/index.html
- https://doc.yonyoucloud.com/doc/wiki/project/shell-tutorial/index.html





