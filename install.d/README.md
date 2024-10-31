```bash
$ vagrant up --provider=libvirt
Bringing machine 'default' up with 'libvirt' provider...
Vagrant could not detect VirtualBox! Make sure VirtualBox is properly installed.
Vagrant uses the `VBoxManage` binary that ships with VirtualBox, and requires
this to be available on the PATH. If VirtualBox is installed, please find the
`VBoxManage` binary and add it to the PATH environmental variable.
```

To list the installed plugins:

```bash
$ vagrant plugin list
```

The solution is to remove the `vagrant-disksize` plugin:

```bash
$ vagrant plugin uninstall vagrant-disksize
```

---

```bash
$ vagrant up
Bringing machine 'default' up with 'libvirt' provider...
Name `test_default` of domain about to create is already taken. Please try to run
`vagrant up` command again.
```

There is already a virtual machine with that name.  Run the following:

```bash
$ sudo virsh list --all
 Id   Name           State
 -------------------------------
 -    debian11       shut off
 -    test_default   shut off

```

And, remove it:

```bash
$ sudo virsh undefine test_default
Domain 'test_default' has been undefined
```

---

If getting the error:

> It appears your machine doesn't support NFS, or there is not an
> adapter to enable NFS on this machine for Vagrant. Please verify
> that `nfsd` is installed on your machine, and try again. If you're
> on Windows, NFS isn't supported. If the problem persists, please
> contact Vagrant support.

Then run the following:

```bash
sudo apt-get install nfs-kernel-server
```

---

```bash
$ vagrant up
The provider 'libvirt' could not be found, but was requested to
back the machine 'default'. Please use a provider that exists.

Vagrant knows about the following providers: hyperv, docker, virtualbox
```

Install the `vagrant-libvirt` plugin:

```bash
$ vagrant plugin install vagrant-libvirt
```

