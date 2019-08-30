# build current project + push to s3
# $1 the built file name, can use the branch or feature name
# ex: aws-deploy-s3 13486
# => build 13486.zip
# upload file to s3
function aws-deploy-s3 {
    if [[ -n "$1" ]]; then
        echo "$1";
    else
        echo "Build file name is required";
        return;
    fi

    # use dotnet to build
    dotnet lambda package --configuration Release --framework netcoreapp2.1 --function-runtime dotnetcore2.1 --output-package "$1.zip"

    current_dir=$(basename $PWD);

    # sync to s3
    aws s3 sync . "s3://fmg-shared-s3-ap-northeast-1/builds/$current_dir" --exclude "*" --include "$1.zip"
}

function lambda-build {
    if [[ -n "$1" ]]; then
        echo "$1";
    else
        echo "Build file name is required";
        return;
    fi

    # use dotnet to build
    dotnet lambda package --configuration Release --framework netcoreapp2.1 --function-runtime dotnetcore2.1 --output-package "$1.zip"
}
