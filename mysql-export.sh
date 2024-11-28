#!/bin/bash

# 定义MySQL连接参数
DB_HOST="192.168.146.133"
DB_USER="root"
DB_PASSWORD="Gjxx@1q2w3e"
DB_PORT=3306

# 要迁移的数据库列表，可以根据需要添加或修改
DATABASES=("nrvsp")

# 迁移数据库函数
migrate_databases() {
    for db in "${DATABASES[@]}"; do
        echo "开始迁移数据库 $db"
        start_time=$(date +%s)
        mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD $db > "${db}.sql"
        if [ $? -eq 0 ]; then
            end_time=$(date +%s)
            duration=$((end_time - start_time))
            echo "数据库 $db 迁移成功，文件名为 ${db}.sql，耗时 ${duration} 秒"
        else
            echo "数据库 $db 迁移失败"
        fi
    done
}

# 调用迁移函数
migrate_databases
