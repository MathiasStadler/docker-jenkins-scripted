# create ssh sites

## ssh login_check

```txt
http://192.168.178.100:8080/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper/loginCheck
```

## add ssh sites

```txt
http://192.168.178.100:8080/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper/fillCredentialIdItems
```

## ssh_slave via bash

```txt
https://gist.github.com/Evildethow/be4614ba27882d8f4627a972a624d525
```

## craete node with rest

```text
https://support.cloudbees.com/hc/en-us/articles/115003896171-Creating-node-with-the-REST-API
```

## setup ssh for pieplines

```txt
https://medium.com/@weblab_tech/how-to-publish-artifacts-in-jenkins-f021b17fde71
```

## for stabler

- class

```txt
https://github.com/jenkinsci/ssh-plugin/blob/master/src/main/java/org/jvnet/hudson/plugins/CredentialsSSHSite.java
```

- DataBoundConstructor

```txt
public CredentialsSSHSite(final String hostname, final String port, final String credentialId,
final String serverAliveInterval, final String timeout)
```

## thinks

```txt
T 192.168.178.32:59369 -> 192.168.178.100:8080 [AP]
POST /configSubmit HTTP/1.1.
Host: 192.168.178.100:8080.
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0) Gecko/20100101 Firefox/52.0.
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8.
Accept-Language: en-US,en;q=0.5.
Accept-Encoding: gzip, deflate.
Referer: http://192.168.178.100:8080/configure.
Cookie: JSESSIONID.092e9599=node0ll3lfsqdmi156vt21vktr3te1.node0; screenResolution=1600x1200; JSESSIONID.3e8dc83a=node0r0k9hvsomjjl49uoknq426k61.node0; JSESSIONID.05346da0=node01s5h6ax5md7yha791ntkanuay2.node0.
Connection: keep-alive.
Upgrade-Insecure-Requests: 1.
Content-Type: application/x-www-form-urlencoded.
Content-Length: 8727.
```

## notice

```txt
http://192.168.178.100:8080/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper/
```

- output

```txt
404 Not Found

Stapler processed this HTTP request as follows, but couldn't find the resource to consume the request

-> evaluate(<hudson.model.Hudson@3bcf215c> :hudson.model.Hudson,"/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper")
-> evaluate(((StaplerProxy)<hudson.model.Hudson@3bcf215c>).getTarget(),"/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper")
-> evaluate(<hudson.model.Hudson@3bcf215c>.getDescriptorByName("org.jvnet.hudson.plugins.SSHBuildWrapper"),"")
-> evaluate(<org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl@332ed02a> :org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl,"")
-> No matching rule was found on <org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl@332ed02a> for ""

<org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl@332ed02a> has the following URL mappings, in the order of preference:

    If path ends without '/' insert it
    hudson.model.Descriptor.doHelp(...) for url=/help/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.doCheckCredentialId(...) for url=/checkCredentialId/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.doCheckHostname(...) for url=/checkHostname/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.doLoginCheck(...) for url=/loginCheck/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.doFillCredentialIdItems(...) for url=/fillCredentialIdItems/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.doFillSiteNameItems(...) for url=/fillSiteNameItems/...
    TOKEN.groovy for url=/TOKEN
    VIEW.jelly for url=/VIEW
    hudson.model.Descriptor.clazz for url=/clazz/...
    java.lang.Object.getClass() for url=/class/...
    hudson.model.Descriptor.getDescriptorFullUrl() for url=/descriptorFullUrl/...
    hudson.model.Descriptor.getJsonSafeClassName() for url=/jsonSafeClassName/...
    hudson.model.Descriptor.getT() for url=/t/...
    hudson.model.Descriptor.getConfigPage() for url=/configPage/...
    hudson.model.Descriptor.getDescriptorUrl() for url=/descriptorUrl/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.getDisplayName() for url=/displayName/...
    hudson.model.Descriptor.getGlobalConfigPage() for url=/globalConfigPage/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.getHelpFile() for url=/helpFile/...
    hudson.model.Descriptor.getId() for url=/id/...
    hudson.model.Descriptor.getCategory() for url=/category/...
    hudson.model.Descriptor.getKlass() for url=/klass/...
    hudson.model.Descriptor.getCurrentDescriptorByNameUrl() for url=/currentDescriptorByNameUrl/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.getShortName() for url=/shortName/...
    org.jvnet.hudson.plugins.SSHBuildWrapper$DescriptorImpl.getSites() for url=/sites/...
    hudson.model.Descriptor.getGlobalPropertyType(String) for url=/globalPropertyType/TOKEN/...
    hudson.model.Descriptor.getPropertyType(String) for url=/propertyType/TOKEN/...
    hudson.model.Descriptor.getCheckMethod(String) for url=/checkMethod/TOKEN/...
    hudson.model.Descriptor.getHelpFile(String) for url=/helpFile/TOKEN/...
    hudson.model.Descriptor.getCheckUrl(String) for url=/checkUrl/TOKEN/...
```
