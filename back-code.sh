rm -rf BackendCode.tar.gz
mvn clean
tar --exclude='.idea' \
    --exclude='.git' \
    --exclude='install/env_local' \
    --exclude='BackendCode.tar.gz' \
    --exclude='back-code.sh' \
    --exclude='**/.DS_Store' \
    --exclude='**/target' \
    --exclude='martin.iml' \
    --exclude='martin (5).iml' \
    --exclude='martin-biz/martin-biz-trans' \
    -cvzf BackendCode.tar.gz .
