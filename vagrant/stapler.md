# stapler

## [homepage](http://stapler.kohsuke.org/reference.html)

## enable stapler tracing

- [from here](http://stapler.kohsuke.org/apidocs/org/kohsuke/stapler/Dispatcher.html) see last comment

## enable on Debian

- append to /etc/defaults/jenkins

```bash
JAVA_ARGS="$JAVA_ARGS -Dstapler.trace=true -Dstapler.trace.per-request=true"
#
echo "JAVA_ARGS=\"\$JAVA_ARGS -Dstapler.trace=true -Dstapler.trace.per-request=true\"" >>/etc/default/jenkins
```
