#!/bin/bash

# 获取当前防火墙规则中的端口
ports=$(firewall-cmd --list-ports)

# 如果没有任何端口规则，退出脚本
if [ -z "$ports" ]; then
    echo "没有找到任何端口规则。"
    exit 1
fi

# 将端口规则按空格分割为数组
read -r -a ports_array <<< "$ports"

# 循环遍历数组，删除每个端口规则
for port in "${ports_array[@]}"; do
    firewall-cmd --zone=public --remove-port="$port" --permanent >/dev/null
done

# 重新加载防火墙设置
firewall-cmd --reload


