
if [ $# != 1 ] ; then 
DIRECTORY="./";
else
DIRECTORY=$1;
fi

# 安装 laravel 到当前目录
composer create-project laravel/laravel $DIRECTORY  --prefer-dist -vvv --no-dev --repository-url=http://packagist.phpcomposer.com


# 设置目录权限
chmod -R 777 $DIRECTORY/storage $DIRECTORY/bootstrap/cache

# 下载 build 脚本

curl -sS https://raw.githubusercontent.com/zhuayi/compose-laravel/master/build.sh -o $DIRECTORY/build.sh;


# 下载 composer.json
curl -sS https://raw.githubusercontent.com/zhuayi/compose-laravel/master/composer.json -o $DIRECTORY/composer.json;

# 执行 build 脚本, 安装 debug

php artisan vendor:publish --force

sh $DIRECTORY/build.sh debug

php artisan migrate:refresh
php artisan db:seed --class="AdminDataSeeder";
