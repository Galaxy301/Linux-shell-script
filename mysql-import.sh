#!/bin/bash

# 函数：输出日志信息
log() {
    echo "[`date '+%Y-%m-%d %H:%M:%S'`] $@"
}

# 函数：导入数据库
import_database() {
    local db_host="$1"
    local db_port="$2"
    local db_user="$3"
    local db_password="$4"
    local db_name="$5"
    local sql_file="$6"

    log "开始导入数据库 $db_name 从文件 $sql_file"

    start_time=$(date +%s)

    # 创建数据库
    # mysql -h $db_host -P $db_port -u $db_user -p$db_password -e "CREATE DATABASE IF NOT EXISTS $db_name"
    mysql -h $db_host -P $db_port -u $db_user -p$db_password -e "CREATE DATABASE IF NOT EXISTS $db_name CHARACTER SET utf8 COLLATE utf8_general_ci;"
    if [ $? -ne 0 ]; then
        log "创建数据库 $db_name 失败"
        return 1
    fi

    # 导入数据
    mysql -h $db_host -P $db_port -u $db_user -p$db_password $db_name < "$sql_file"
    if [ $? -eq 0 ]; then
        end_time=$(date +%s)
        duration=$((end_time - start_time))
        log "数据库 $db_name 从文件 $sql_file 导入成功，耗时 ${duration} 秒"
    else
        log "数据库 $db_name 从文件 $sql_file 导入失败"
        return 1
    fi
}

# 主程序
main() {
    local db_host="192.168.146.133"
    local db_user="root"
    local db_password="Gjxx@1q2w3e"
    local db_port=3306

    # 要导入的数据库文件列表
    local sql_files=("nrvsp.sql")

    for sql_file in "${sql_files[@]}"; do
#        db_name="${sql_file%.sql}"  # 提取数据库名
         db_name=bb
        import_database "$db_host" "$db_port" "$db_user" "$db_password" "$db_name" "$sql_file"
        if [ $? -ne 0 ]; then
            log "导入数据库 $db_name 失败"
            # 可以添加逻辑处理失败情况的代码
        fi
    done
}

# 执行主程序
main
