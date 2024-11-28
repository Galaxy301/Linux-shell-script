#!/bin/bash
echo -------- $(date) -------- | tee -a pwd.log

# 获取以 xx.xx 开头的 IP 地址的最后一位，此处以192.168为例
ip_last_octet=$(hostname -I | tr ' ' '\n' | grep '^192\.168' | awk -F '.' '{print $NF}')

# 生成基于年月的密码并添加 IP 最后一位
ym=$(date +%y%m)
mm=Gjxx@${ym}SdWyC${ip_last_octet}

# 为 root 用户更改密码
if [[ -n "$ip_last_octet" ]]; then
  echo $mm | passwd --stdin root | tee -a pwd.log
else
  echo "未找到以 192.168 开头的有效 IP 地址，密码未修改。" | tee -a pwd.log
fi
echo 当前密码设置为：$mm
