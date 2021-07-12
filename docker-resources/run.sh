#!/bin/sh
# Set debug options if required
if [ x"${env_java_debug_enabled}" != x ] && [ "${env_java_debug_enabled}" != "false" ]; then
    java_debug_args="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
fi

exec java $java_debug_args $env_jvm_flags -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 org.springframework.boot.loader.JarLauncher $*