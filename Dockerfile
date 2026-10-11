FROM richardchesterwood/k8s-fleetman-webapp-angular:release2
ARG BUILD_NUMBER=dev
RUN sed -i "s#Fleet Management System R2#Fleet Management - build ${BUILD_NUMBER}#" /usr/share/nginx/html/*.js && \
    echo "build ${BUILD_NUMBER}" > /usr/share/nginx/html/version.txt
