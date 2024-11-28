#!/bin/bash

# 获取所有带有 'rich rules' 的规则
rules=$(firewall-cmd --list-rich-rules | grep 'rule family="ipv4"')
rule=$(firewall-cmd --list-rich-rules)
# 如果没有任何端口规则，退出脚本
if [ -z "$rule" ]; then
    echo "没有找到任何端口规则。"
    exit 1
fi

# 使用循环删除每个规则
while IFS= read -r rule; do
    firewall-cmd --zone=public --remove-rich-rule="$rule" --permanent >/dev/null
done <<< "$rules"

# 重新加载防火墙设置
firewall-cmd --reload
