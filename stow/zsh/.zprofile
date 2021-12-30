source /home/vlad/.profile

_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true

# >>> JVM installed by coursier >>>
export JAVA_HOME="/home/vlad/.cache/coursier/jvm/amazon-corretto@1.17.0-0.35.1"
export PATH="$PATH:/home/vlad/.cache/coursier/jvm/amazon-corretto@1.17.0-0.35.1/bin"
# <<< JVM installed by coursier <<<
